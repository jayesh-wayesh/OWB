// SIGNER - Account 3 - 0xf3fcd2c1a78f5eee

// Account 1 (0x01cf0e2f2f715450)
// Account 2 (0x179b6b1cb6755e31)
// Account 3 (0xf3fcd2c1a78f5eee)

import PlaygroundBattle from 0xf3fcd2c1a78f5eee
import NonFungibleToken from 0xe03daebed8ca0615

transaction{

    let minterRef : &PlaygroundBattle.NFTMinter
    
    let receiverRef1 : &{PlaygroundBattle.Powers,NonFungibleToken.CollectionPublic}
    let receiverRef2 : &{PlaygroundBattle.Powers,NonFungibleToken.CollectionPublic}

    prepare(acct: AuthAccount) {

        self.minterRef = acct.borrow<&PlaygroundBattle.NFTMinter>(from: /storage/NFTMinter)!

        self.receiverRef1 = getAccount(0x01cf0e2f2f715450).getCapability(/public/NFTReceiver)!
                                                          .borrow<&{PlaygroundBattle.Powers,NonFungibleToken.CollectionPublic}>()!

        self.receiverRef2 = getAccount(0x179b6b1cb6755e31).getCapability(/public/NFTReceiver)!
                                                          .borrow<&{PlaygroundBattle.Powers,NonFungibleToken.CollectionPublic}>()! 
                                
    }

    execute{

           self.minterRef.mintNFT(recipient: self.receiverRef1)
           self.minterRef.mintNFT(recipient: self.receiverRef2)


            log("NFTs minted and transferred to account 1 and account 2 ")
            // log(self.receiverRef1.getIDs())
            // log(self.receiverRef1.getpowers())
            // log(self.receiverRef2.getIDs())
            // log(self.receiverRef2.getpowers())
    }
}
 