module sui_stack_overflow::core_amm;

use sui_stack_overflow::constants::{get_default_fee,get_fee_base_of_percentage};
use sui::math::{Self, sqrt_u128};


/// get fee from amount
public fun get_fee(amount: u64, fee: u64): u64{
    ((fee as u128) * (amount as u128) / (get_fee_base_of_percentage() as u128) as u64)
}
