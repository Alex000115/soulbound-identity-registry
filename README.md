# Soulbound Identity Registry

An expert-level, gas-optimized implementation of standard non-transferable Soulbound Tokens (SBTs) designed for on-chain identity, credentials, and reputation metrics. This contract strictly overrides the standard ERC721 movement APIs (`transferFrom` and `safeTransferFrom`) to ensure tokens are permanently bound to the receiving wallet address upon issuance, making them ideal for decentralized identities (DIDs).

## Features
- **Strict Non-Transferability:** Overridden core ERC721 logic ensures assets are anchored permanently.
- **Revocation Protocol:** Built-in cryptographic issuing controls allowing authorities to revoke credentials if necessary.
- **Flat Architecture:** Standardized layout containing all necessary traits in a clean root environment.

## Installation

1. Install system project packages:
   ```bash
   npm install
