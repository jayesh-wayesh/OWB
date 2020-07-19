// SIGNER - Account 2 - 0x179b6b1cb6755e31

// Account 1 (0x01cf0e2f2f715450)
// Account 2 (0x179b6b1cb6755e31)
// Account 3 (0xf3fcd2c1a78f5eee)

import PlaygroundBattle from 0xf3fcd2c1a78f5eee
import NonFungibleToken from 0xe03daebed8ca0615

transaction {

    prepare(acct: AuthAccount){

        let collection <- PlaygroundBattle.createEmptyCollection()

        acct.save<@NonFungibleToken.Collection>(<-collection, to: /storage/NFTCollection)

        log("PLayer 2: Collection stored to storage")
        
        acct.link<&{PlaygroundBattle.Powers, NonFungibleToken.CollectionPublic}>(/public/NFTReceiver, target: /storage/NFTCollection)

        log("PLayer 2: Link to collection stored to storage kept in public")
    
    }
}
 