# PlaygroundBattle

This is a simple game built using [NFT standards](https://github.com/onflow/flow-nft)


### Description

In this game the contract(PlaygroundBattle) mints 5 NFTs(say pokemons) each to two players. There are 5 rounds in total and in each round i’th pokemon of **player1** 😈 fights with i’th pokemon of **player2** 🦄. The pokemon with more power wins the round. The team who wins the more rounds wins the match.

### Calculating power

Power of each pokemon is calculated using 
- `let block = getCurrentBlock()` 
- `let NFTpower = block.id[ (PlaygroundBattle.totalSupply % UInt64(32)) ]`


### Steps

1) Deploy [demo](demo.cdc) to Account 4
2) Deploy [PlaygroundBattle](PlaygroundBattle.cdc) to Account 3
3) Execute Transaction [SetupPlayer1](SetupPlayer1.cdc) using Account 1
4) Execute Transaction [SetupPlayer2](SetupPlayer2) using Account 2
5) Execute Transaction [GameStarts](GameStarts.cdc) 5 times using Account 3
6) Execute script [Results](Results.cdc)


### TODO

- To include FungibleToken contract also so that both the players need to first submit 10 tokens each to enter. 
- After the match is over winner gets 19 tokens and platform gets 1 token.

### Screenshot
![x.x](results.png)


