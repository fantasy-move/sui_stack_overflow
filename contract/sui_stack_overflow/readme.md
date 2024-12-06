# local test
package-id = 0xf49b3dac024a71fe98fd2e9f6b71eb7747d3be41dc6049aa30be2430592ff820

## first call create_stack_overflow

sui client call --package 0xf49b3dac024a71fe98fd2e9f6b71eb7747d3be41dc6049aa30be2430592ff820 --module sui_stack_overflow --function create_stack_overflow

stack_overflow_id:  0x3780946246fb4a7e1d864e265cf756a9a8732773fb95fa4bcf82bea1d086b994

## second  use another account registry blob

sui client call \
--package 0xf49b3dac024a71fe98fd2e9f6b71eb7747d3be41dc6049aa30be2430592ff820 \
--module sui_stack_overflow \
--function regist_blob \
--args 0x3780946246fb4a7e1d864e265cf756a9a8732773fb95fa4bcf82bea1d086b994 001

## split coin
sui client split-coin --coin-id 0x05fc16f1a451c19768a0a9d3aca5289f1d95a25343ec104c3f442c594a9147b6 --amounts 40000000 --gas-budget 5000
## reword
sui client call \
--package 0xf49b3dac024a71fe98fd2e9f6b71eb7747d3be41dc6049aa30be2430592ff820 \
--module sui_stack_overflow \
--function rewordSui \
--args 0x3780946246fb4a7e1d864e265cf756a9a8732773fb95fa4bcf82bea1d086b994 001 0xa098c0fcdc875d1216c6e1ca919ef0237783127bed8fa3d036ce21276e09df59
