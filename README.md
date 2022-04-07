# Velamis token contract

Velamis 
### Installation
```sh
# Clone the repo
    git clone https://gitlab.com/merehead/velamis/velamis_token_contracts.git
# Install all dependencies
    npm install
```
### Compile contract
```sh
npx hardhat compile
```
### Test contract
```sh
npx hardhat test
```
### Deploy contract
```sh
npx hardhat run scripts/deploy.js
```
### Modifiers
##### onlyStopper
Executes only by Stopper
##### onlyManager
Executes only by Manager
##### isRunning
Check for the contract running



