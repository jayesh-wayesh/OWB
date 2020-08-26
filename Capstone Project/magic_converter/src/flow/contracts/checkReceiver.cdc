// check if receiver is setup or not
//import NonFungibleToken, Dappymon from 0x01cf0e2f2f715450
import NonFungibleToken, Dappymon from 0x01

pub fun main(): Bool {

    let nftOwner = getAccount(0x02)

    // Find the public Receiver capability for their Collection
    let capability = nftOwner.getCapability(/public/NFTReceiver)!

    // borrow a reference from the capability
    let receiverRef = capability.borrow<&{Dappymon.CollectionPublic, NonFungibleToken.CollectionPublic}>() ?? nil

    // check if receiver is set up or not
    if (receiverRef != nil){
        log("true")
        return true
    }else{
        log("false")
        return false
    }
}
