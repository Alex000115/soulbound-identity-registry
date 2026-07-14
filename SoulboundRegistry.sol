// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SoulboundRegistry is ERC721, Ownable {
    uint256 public nextTokenId;
    mapping(uint256 => string) private _tokenURIs;

    event SoulIssued(address indexed to, uint256 indexed tokenId, string tokenURI);
    event SoulRevoked(address indexed from, uint256 indexed tokenId);

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) Ownable(msg.sender) {}

    function issueSoul(address _to, string calldata _uri) external onlyOwner returns (uint256) {
        require(_to != address(0), "Cannot issue to zero address");
        
        uint256 tokenId = nextTokenId;
        nextTokenId++;

        _safeMint(_to, tokenId);
        _tokenURIs[tokenId] = _uri;

        emit SoulIssued(_to, tokenId, _uri);
        return tokenId;
    }

    function revokeSoul(uint256 _tokenId) external onlyOwner {
        address owner = ownerOf(_tokenId);
        _burn(_tokenId);
        delete _tokenURIs[_tokenId];

        emit SoulRevoked(owner, _tokenId);
    }

    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        _requireOwned(_tokenId);
        return _tokenURIs[_tokenId];
    }

    // Override transfer functions to enforce Soulbound restrictions
    function transferFrom(address, address, uint256) public pure override {
        revert("SoulboundToken: Transfer locked and restricted");
    }

    function safeTransferFrom(address, address, uint256, bytes memory) public pure override {
        revert("SoulboundToken: Transfer locked and restricted");
    }
}
