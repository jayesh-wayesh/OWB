import React, {useState, useEffect} from 'react';
import './css/converter.css';
import { useContractLoader } from "./hooks"
import { Account, Address, ProgressBar, NFTCollection, ConverterFrame, Escrow, Header, Topbar } from './components'
import { LoadContracts, FlowAccount, Mint, Display} from "./flow"

export default function App() {


  const [injectedProvider, setInjectedProvider] = useState()
  const writeContracts = useContractLoader(injectedProvider)
  const [ethAddress, setEthAddress] = useState()
  const [nftSelected, setNftSelected] = useState(false)
  const [selectedNftId, setSelectedNftId] = useState()
  const [nftPosition, setNftPosition] = useState()
  const [sentToEscrow, setSentToEscrow] = useState(false)
  const [flowAddress, setFlowAddress] = useState()
  const [flowReceiver, setFlowReceiver] = useState(false)
  const [minting, setMinting] = useState(false)
  const [minted, setMinted] = useState(false)
  const [flowId, setFlowId] = useState()




  return (
      <div>
        <Header/>
        <LoadContracts/>
        <ConverterFrame
          ethAddress={ethAddress}
          nftSelected={nftSelected}
          selectedNftId={selectedNftId}
          sentToEscrow={sentToEscrow}
          flowAddress={flowAddress}
          flowId={flowId}
        />
        <ProgressBar
          ethAddress={ethAddress}
          sentToEscrow={sentToEscrow}
          flowAddress={flowAddress}
          flowId={flowId}
          nftSelected={nftSelected}
        />
        <Escrow
          address={ethAddress}
          nftSelected={nftSelected}
          writeContracts={writeContracts}
          selectedNftId={selectedNftId}
          setSentToEscrow={setSentToEscrow}
          sentToEscrow={sentToEscrow}
        />
        <FlowAccount
          flowAddress={flowAddress}
          setFlowAddress={setFlowAddress}
          sentToEscrow={sentToEscrow}
          flowReceiver={flowReceiver}
          setFlowReceiver={setFlowReceiver}
        />
        <Mint
          flowAddress={flowAddress}
          selectedNftId={selectedNftId}
          minting={minting}
          setMinted={setMinted}
          setMinting={setMinting}
          flowId={flowId}
        />
        <Display
          flowAddress={flowAddress}
          selectedNftId={selectedNftId}
          setFlowId={setFlowId}
          flowId={flowId}
          minted={minted}
        />
        {ethAddress && (!sentToEscrow) &&
         <div>
             <NFTCollection
               address={ethAddress}
               injectedProvider={injectedProvider}
               writeContracts={writeContracts}
               nftSelected={nftSelected}
               setNftSelected={setNftSelected}
               selectedNftId={selectedNftId}
               setSelectedNftId={setSelectedNftId}
               nftPosition={nftPosition}
               setNftPosition={setNftPosition}
             />
          </div>
        }
        <Account
          address={ethAddress}
          setAddress={setEthAddress}
          injectedProvider={injectedProvider}
          setInjectedProvider={setInjectedProvider}
          sentToEscrow={sentToEscrow}
          nftSelected={nftSelected}
        />
        {/*<Topbar/>*/}
      </div>
  );
}
