import React, { useState, useEffect, useRef } from 'react'
import { ethers } from "ethers"
import '../css/converter.css'

const FIRST_NAMES = ['Herbie', 'Sprinkles', 'Boris', 'Dave', 'Randy', 'Captain']
const LAST_NAMES = ['Starbelly', 'Fisherton', 'McCoy']

export default function NFTCollection(props) {

  const [myCollection, setMyCollection] = useState([])

  useEffect(() => {
    if(props.address){
       ListCreatures()
    }else{
       setMyCollection([])
    }
  },[props.address, props.selectedNftId ])



  const selectNFTwithID = async ( id, position) => {

    // if nft already selected
    if( props.nftSelected ){

      // deselect
      if(id === props.selectedNftId ){
        await props.setNftPosition()
        await props.setNftSelected(false)
        await props.setSelectedNftId(null)

      }else{

        await props.setSelectedNftId(id)
        await props.setNftPosition(position)
      }

    }else{

      await props.setNftPosition(position)
      await props.setNftSelected(true)
      await props.setSelectedNftId(id)
    }
  }


   const ListCreatures = async () => {

     var temp = [];
     var position = 0;

     for (var i = 1; i <= 12; i++) {

       const _id = i
       const pos = position
       const name = "" + FIRST_NAMES[_id % FIRST_NAMES.length] + " " + LAST_NAMES[_id % LAST_NAMES.length]

       const res = await props.writeContracts['Creature'].ownerOf(new ethers.utils.BigNumber( _id.toString() ));
       if(res === props.address){

         temp.push(
           <div className="nft">
             {(_id == props.selectedNftId)
               ?
                <>
                 <div className="nft-frame" id="nft-frame-highlighted"><img className="nft-pic" src ={"https://storage.googleapis.com/opensea-prod.appspot.com/creature/" + _id + ".png"}/></div>
                 <div className="nft-text" id="nft-text-highlighted">{name} #{_id}</div>
                 <div className="nft-btn" id="nft-btn-highlighted" onClick={() => { selectNFTwithID(_id, pos ) }}><span className="nft-btn-txt">Select</span></div>
                </>
               :
                <>
                 <div className="nft-frame" id=""><img className="nft-pic" src ={"https://storage.googleapis.com/opensea-prod.appspot.com/creature/" + _id + ".png"}/></div>
                 <div className="nft-text" id="">{name} #{_id}</div>
                 <div className="nft-btn" id="" onClick={() => { selectNFTwithID(_id, pos ) }}><span className="nft-btn-txt">Select</span></div>
                </>
             }

           </div>
         );

         position = position + 1;
       }
     }

     setMyCollection(myCollection => [...temp]);
   }




   return(
     <div>
       {(props.nftSelected)
         ?
          <div className="nft-collection" id="nft-collection-nft-selected">
            {myCollection}
          </div>
         :
          <div className="nft-collection" id="">
            {myCollection}
          </div>
       }
    </div>
   )

}
