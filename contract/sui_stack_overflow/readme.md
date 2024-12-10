# local test
package-id = 0x3e495af2185106f61ee6a7905724fb02296b51a76ed9e56fa69ffa031db9ddc9
upgradecap = 0x12f6676468ae3037586aa728ef018d3c2fc52b52c25be080ef90230fecba7488
## first call create_stack_overflow


sui client call \
--package 0x3e495af2185106f61ee6a7905724fb02296b51a76ed9e56fa69ffa031db9ddc9 \
--module sui_stack_overflow \
--function create_stack_overflow

stack_overflow_id:  0xc5c92c270e9d2dd9f5324c6b3d383a0bbe876d30a81d0cef265aaad75c77121d

## second  use another account registry blob

sui client call \
--package 0xe5ce6e34ddf25b952b288f6259b88246f420d6fc5d8b90fa72f668027083527d \
--module sui_stack_overflow \
--function regist_blob \
--args 0xa2701387f9115e2821a19fc6091c5fbfbf95bc5b5a57f52c0e9028fe0b94797f 001

## split coin
sui client split-coin --coin-id 0x05fc16f1a451c19768a0a9d3aca5289f1d95a25343ec104c3f442c594a9147b6 --amounts 40000000 --gas-budget 5000
## reword
sui client call \
--package 0xe5ce6e34ddf25b952b288f6259b88246f420d6fc5d8b90fa72f668027083527d \
--module sui_stack_overflow \
--function rewordSui \
--args 0x1165f8e790f007eb0f1db30e59d16f83d86f6617c83c01c1b6381bd8fddd8277 001 0x14eb739359a0b906ce05d8c82021de29c9f56c594f03241be7b46d02a442f85a

## upgrade contract
sui client upgrade --gas-budget 100000000 --upgrade-capability 0x7ecc41402d02570ef118dd91c9f14d1e99d7efc1c5e0aa44415f5876395d0296

