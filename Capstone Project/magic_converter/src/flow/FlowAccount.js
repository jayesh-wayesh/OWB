import React, { useEffect, useState } from "react";
import * as fcl from "@onflow/fcl";
import setupUser from "./contracts/setupUser.cdc";
import checkReceiver from "./contracts/checkReceiver.cdc";
import { checkReceiverScript, setupUserTx, getUserAddress} from "./utility.js";


fcl.config()
  //.put("challenge.handshake", "https://flow-wallet-testnet.blocto.app/authn")
  .put("challenge.handshake", "http://localhost:8701/flow/authenticate")



export const setupNFTReceiver = async (props) => {

    // check if receiver is set or not
    const response = await checkReceiverScript(checkReceiver)
    console.log("receiver exits: ", response)

    // if not set then request to set receiver
    if(response == false){
        const receiverResponse = await setupUserTx(setupUser)
        console.log("receiver response :", receiverResponse)
    }
}

const func = async (props) =>{

  // if user is logged in setup NFT Receiver if already not there
  if(!props.flowReceiver){
     const res = await setupNFTReceiver(props);
  }

  // set flow address to
  const addr = await getUserAddress()
  props.setFlowAddress(addr)
  props.setFlowReceiver(true)
}


export default function FlowAccount(props){

  const [user, setUser] = useState(null);

  const handleUser = (user) => {
    if (user.cid) {
      setUser(user)
    } else {
      setUser(null)
    }
  };


  useEffect(() => {
      return fcl.currentUser().subscribe(handleUser);
  }, []);


  var userLoggedIn = user && !!user.cid;
  if(userLoggedIn){
      func(props)
  }else{
    props.setFlowAddress();
  }


  return (
    <div>
      {(props.sentToEscrow) && (!props.flowAddress) &&
        <div className="flow-login">
         <div className="flow-login-text">Connect to a Flow wallet</div>
         <div className="flow-login-btn" onClick={() => {fcl.authenticate()}}>
            <span className="flow-login-btn-text">Connect</span>
         </div>
        </div>
      }
    </div>
  );
}
