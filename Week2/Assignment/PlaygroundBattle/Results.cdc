// Account 1 (0x01cf0e2f2f715450)
// Account 2 (0x179b6b1cb6755e31)
// Account 3 (0xf3fcd2c1a78f5eee)

import PlaygroundBattle from 0xf3fcd2c1a78f5eee
import NonFungibleToken from 0xe03daebed8ca0615

pub fun main() {
    
    // Player 1
    let acct1 = getAccount(0x01cf0e2f2f715450)
    let cap1 = acct1.getCapability(/public/NFTReceiver)!
    let ref1 = cap1.borrow< &{PlaygroundBattle.Powers,NonFungibleToken.CollectionPublic} >()!

    // Player 2
    let acct2 = getAccount(0x179b6b1cb6755e31)
    let cap2 = acct2.getCapability(/public/NFTReceiver)!
    let ref2 = cap2.borrow< &{PlaygroundBattle.Powers,NonFungibleToken.CollectionPublic} >()!
    
    let powers1:[UInt8] = ref1.getpowers()
    let powers2:[UInt8] = ref2.getpowers()
    
    var score1:Int = 0
    var score2:Int = 0
    var ScoreBoard:[String] = []



    log("---GAME STARTS---")
    log("😈's team is - ")
    log(powers1)
    log("🦄's team is - ")
    log(powers2)
    


    log("-------------")
    log("Battle starts...")
    var num_rounds = 0
    while num_rounds < 5 {
        if powers1[num_rounds] > powers2[num_rounds] {
            score1 = score1 + 1
            ScoreBoard.append("😈")
        }else if powers1[num_rounds] < powers2[num_rounds] {
            score2 = score2 + 1
            ScoreBoard.append("🦄")
        }else{
            ScoreBoard.append(" ")
        }
        num_rounds = num_rounds + 1
        log(ScoreBoard)
    }
    


    log("Calculating Results.... ")
    if score1 > score2 {
        log("😈 is the winner! ")
    }else if score2 > score1{
        log("🦄 is the winner! ")
    }else {
        log(" IT'S A TIE!!! ")
    }



    log("---GAME ENDS---")

}