// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC721Base.sol";
import "@thirdweb-dev/contracts/extension/PermissionsEnumerable.sol";

contract Contract is ERC721Base, PermissionsEnumerable{

      constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps
    )
        ERC721Base(
            _name,
            _symbol,
            _royaltyRecipient,
            _royaltyBps
        )
    {
        // Giving contract deployer admin role (root privileges)
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    // Mapping to keep data in our contract.
    // Here, the key is the token ID, and the value is the power level for the NFT.
    mapping(uint256 => uint256) public powerLevel;

    function setPowerLevel(uint256 _tokenId, uint256 _powerLevel) external onlyRole(DEFAULT_ADMIN_ROLE) {
    powerLevel[_tokenId] = _powerLevel;
    }

    function mintTo(address _to, string memory _tokenURI) public virtual override {
    // Grab the next token ID being minted using an inherited view.
    uint256 tokenId = nextTokenIdToMint();

    // Here, "super" refers to the base contract.
    // We are saying "run the mintTo method from the base contract".
    super.mintTo(_to, _tokenURI);

    // *then* we can add our custom logic on top:
    powerLevel[tokenId] = tokenId;
    }

}