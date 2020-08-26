import NonFungibleToken,Dappymon from 0x01
//import NonFungibleToken,Dappymon from 0x01cf0e2f2f715450

transaction{
      
    let minterRef : &Dappymon.NFTMinter
    let receiverRef : &{Dappymon.CollectionPublic,NonFungibleToken.CollectionPublic}
      
    prepare(acct: AuthAccount) {
        self.minterRef = acct.borrow<&Dappymon.NFTMinter>(from: /storage/NFTMinter)!
        self.receiverRef = getAccount(0x02).getCapability(/public/NFTReceiver)!
                                                               .borrow<&{Dappymon.CollectionPublic,NonFungibleToken.CollectionPublic}>()!
    }
      
    execute{
        
        //0x179b6b1cb6755e31
        log(TOKEN_ID)
        log(self.receiverRef)
        self.minterRef.mintNFT(recipient: self.receiverRef, ethTokenId: TOKEN_ID)
        //self.minterRef.mintNFT(recipient: self.receiverRef, ethTokenId: 4)

    }
}
