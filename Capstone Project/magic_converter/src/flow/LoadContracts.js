import React, { useEffect, useState } from "react"
import * as fcl from "@onflow/fcl"

import { createAccount } from "./utils/create-account"
import { deployContract } from "./utils/deploy-code"
import { generateCode } from "./utility.js"

import DappymonCode from "./contracts/Dappymon.cdc"


fcl
  .config()
  .put("PRIVATE_KEY", "5e967c6c6370b4b243d107794f6096cc346415142eacb72ed64ccfee4e4ae8f5")
  .put("SERVICE_ADDRESS","f8d6e0586b0a20c7")
  .put("accessNode.api","http://localhost:8080");



const loadContracts = async (props) => {


    const account = await createAccount()
    console.log("account : ", { account })
    const code = await generateCode(DappymonCode)
    const deployTx = await deployContract(account, code)
    console.log("deploy : ",{ deployTx })
    localStorage.setItem("DappymonContractAddress",account)

}


export default function LoadContracts(){

  //  const addr = localStorage.getItem("DappymonContractAddress")
  //  if(addr == undefined){
  //    loadContracts()
  //    console.log("Contracts Initialized")
  //  }

   const loadFlowContracts = async () => {
     const res = await loadContracts()
     console.log("Contracts initialized on flow : ", res)
   }

    return (
        <div>
          <button style={{bottom:0, leftMargin:400}} onClick={loadFlowContracts}>Load</button>
        </div>
    )

}
