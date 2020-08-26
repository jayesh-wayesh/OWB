import NonFungibleToken,Dappymon from 0x01
//import NonFungibleToken,Dappymon from 0x01cf0e2f2f715450

transaction {

    prepare(acct: AuthAccount) {

        let collection <- Dappymon.createEmptyCollection()

        acct.save<@NonFungibleToken.Collection>(<-collection, to: /storage/NFTCollection)

        log("User: Collection stored to storage")

        acct.link<&{Dappymon.CollectionPublic, NonFungibleToken.CollectionPublic}>(/public/NFTReceiver, target: /storage/NFTCollection)

        log("User: Link to collection stored to storage kept in public")
    }
}
 