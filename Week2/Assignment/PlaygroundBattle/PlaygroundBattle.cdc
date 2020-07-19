// SIGNER - Account 3 - 0xf3fcd2c1a78f5eee

// Account 1 (0x01cf0e2f2f715450)
// Account 2 (0x179b6b1cb6755e31)
// Account 3 (0xf3fcd2c1a78f5eee)
// Account 4 (0xe03daebed8ca0615)

import NonFungibleToken from 0xe03daebed8ca0615

pub contract PlaygroundBattle: NonFungibleToken {

    pub var totalSupply: UInt64

    pub event ContractInitialized()
    pub event Withdraw(id: UInt64, from: Address?)
    pub event Deposit(id: UInt64, to: Address?)


    pub resource NFT: NonFungibleToken.INFT {
        pub let id: UInt64

        pub var power: UInt8

        init(initID: UInt64, power: UInt8) {
            self.id = initID
            self.power = power
        }
    }

    pub resource interface Powers {
        pub fun getpowers(): [UInt8]
    }

    pub resource Collection: Powers, NonFungibleToken.Provider, NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic {
        // dictionary of NFT conforming tokens
        // NFT is a resource type with an `UInt64` ID field
        pub var ownedNFTs: @{UInt64: NonFungibleToken.NFT}
        pub var powers: {UInt64: UInt8}

        init () {
            self.ownedNFTs <- {}
            self.powers = {}
        }

        // withdraw removes an NFT from the collection and moves it to the caller
        pub fun withdraw(withdrawID: UInt64): @NonFungibleToken.NFT {
            let token <- self.ownedNFTs.remove(key: withdrawID) ?? panic("missing NFT")
            self.powers.remove(key: withdrawID)
            emit Withdraw(id: token.id, from: self.owner?.address)

            return <-token
        }

        // deposit takes a NFT and adds it to the collections dictionary
        // and adds the ID to the id array
        pub fun deposit(token: @NonFungibleToken.NFT) {
            let token <- token as! @PlaygroundBattle.NFT
            self.powers[token.id] = token.power
            let id: UInt64 = token.id

            // add the new token to the dictionary which removes the old one
            let oldToken <- self.ownedNFTs[id] <- token

            emit Deposit(id: id, to: self.owner?.address)

            destroy oldToken
        }

        // getIDs returns an array of the IDs that are in the collection
        pub fun getIDs(): [UInt64] {
            return self.ownedNFTs.keys
        }

        pub fun getpowers(): [UInt8] {
            return self.powers.values
        }

        // borrowNFT gets a reference to an NFT in the collection
        // so that the caller can read its metadata and call its methods
        pub fun borrowNFT(id: UInt64): &NonFungibleToken.NFT {
            return &self.ownedNFTs[id] as &NonFungibleToken.NFT
        }


        destroy() {
            destroy self.ownedNFTs
        }
    }

    // public function that anyone can call to create a new empty collection
    pub fun createEmptyCollection(): @NonFungibleToken.Collection {
        return <- create Collection()
    }

    // Resource that an admin or something similar would own to be
    // able to mint new NFTs
    //
	pub resource NFTMinter {

		// mintNFT mints a new NFT with a new ID
		// and deposit it in the recipients collection using their collection reference
		pub fun mintNFT(recipient: &{NonFungibleToken.CollectionPublic}) {

            // calculating power
            let block = getCurrentBlock()
            let NFTpower = block.id[ (PlaygroundBattle.totalSupply % UInt64(32)) ]

			// create a new NFT
			var newNFT <- create NFT(initID: PlaygroundBattle.totalSupply, power: NFTpower)

			// deposit it in the recipient's account using their reference
			recipient.deposit(token: <-newNFT)

            PlaygroundBattle.totalSupply = PlaygroundBattle.totalSupply + UInt64(1)
		}
	}

	init() {
        // Initialize the total supply
        self.totalSupply = 0

        // Create a Collection resource and save it to storage
        let collection <- create Collection()
        self.account.save(<-collection, to: /storage/NFTCollection)

        // create a public capability for the collection
        self.account.link<&{NonFungibleToken.CollectionPublic}>(
            /public/NFTCollection,
            target: /storage/NFTCollection
        )

        // Create a Minter resource and save it to storage
        let minter <- create NFTMinter()
        self.account.save(<-minter, to: /storage/NFTMinter)

        emit ContractInitialized()
	}
}

 