//import NonFungibleToken,Dappymon from 0x01cf0e2f2f715450
import NonFungibleToken,Dappymon from 0x01

pub fun main(): UInt64 {
    //0x02
    //0x179b6b1cb6755e31
    
    let ref = getAccount(0x02)
                      .getCapability(/public/NFTReceiver)!
                      .borrow<&{Dappymon.CollectionPublic,NonFungibleToken.CollectionPublic} >()!
          
    let x = ref.getIDs()

    let len = x.length
    var index = 0
    while index < len {
        if(ref.borrowDappymon(id: x[index]).ethTokenId == UInt64(TOKEN_ID)){
            return ref.borrowDappymon(id: x[index]).id
        }
        index = index + 1
    }

    return 0

}