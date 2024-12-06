
/// Module: sui_stack_overflow
module sui_stack_overflow::sui_stack_overflow;

use std::address;
use std::string::String;
// use sui::coin;
use sui::sui::SUI;
use sui::transfer;
// use wal::wal::WAL;
use sui::table;
use sui::table::Table;
use sui::tx_context::{TxContext, sender};
use sui::coin::{Self, Coin,value};
use sui::balance::{Self, Balance, Supply, supply_value};
use sui::object::{Self, UID, ID};
use sui_stack_overflow::constants::{get_default_fee,get_fee_base_of_percentage};
use sui_stack_overflow::core_amm::{get_fee};
// === Errors ===
const EBlobAlreadyExists: u64 = 1;
const EBlobNotExits: u64 = 2;
// const EPoolDoesNotExist: u64 = 2;
// const EPackageVersionNotEnabled: u64 = 3;
// const EVersionNotEnabled: u64 = 4;
// const EVersionAlreadyEnabled: u64 = 5;
// const ECannotDisableCurrentVersion: u64 = 6;

public struct StackOverflow has key, store {
    id: UID,
    owner: address,
    dao_fee: u64,
    blob_map: Table<String, address>, // 存储 blob跟账户映射关系
    user_record: Table<address, UID>, // 发过blob的用户的nft记录
    fee_sui: Balance<SUI>,
    // fee_wal: Balance<WAL>,

}


// 创建
public entry fun create_stack_overflow(ctx: &mut TxContext){
    let address = sender(ctx);
    let dao_fee = get_default_fee();
    let stack_overflow = StackOverflow{
        id: object::new(ctx),
        dao_fee,
        owner: address,
        blob_map: table::new<String, address>(ctx),
        user_record: table::new<address, UID>(ctx),
        fee_sui: balance::zero<SUI>(),
        // fee_wal:balance::zero<WAL>()
    };

    transfer::share_object(stack_overflow)
}

public entry fun regist_blob(stack_overflow: &mut StackOverflow, blob_id: String, ctx: &mut TxContext){
    assert!(!exist_blob(stack_overflow, blob_id), EBlobAlreadyExists);
    table::add(&mut stack_overflow.blob_map, blob_id, sender(ctx))
}

public fun exist_blob(stack_overflow: &StackOverflow, blob_id: String): bool {
    table::contains(&stack_overflow.blob_map, blob_id)
}

public entry fun rewordSui(stack_overflow: &mut StackOverflow,blob_id: String, coin_in:&mut Coin<SUI>, ctx: &mut TxContext){
    // 1.blob must in the blob_map of stack_overflow
    assert!(exist_blob(stack_overflow, blob_id), EBlobNotExits);

    // 2. transfer coin to
    //  2.1 split coin for pay fee
    let total_amount = coin_in.value();
    let fee_amount = get_fee(total_amount, stack_overflow.dao_fee);
    let fee_coin:  Coin<SUI> = coin::split(coin_in, fee_amount, ctx);

    stack_overflow.fee_sui.join(coin::into_balance(fee_coin));
    let owner_address =  table::borrow(&mut stack_overflow.blob_map, blob_id);
    // Transfer the remaining coin to the owner address
    let left_coin = coin::split(coin_in, total_amount - fee_amount, ctx);
    transfer::public_transfer(left_coin, *owner_address);
}
    // transfer(*coin_in, *owner_address);
    /// get fee from amount
public fun get_dao_fee(amount: u64, fee: u64): u64{
    ((fee as u128) * (amount as u128) / (get_fee_base_of_percentage() as u128) as u64)
}











