## Create private test net and account

<pre>
bash> mkdir "${HOME}/eth_private_net"
bash> geth --maxpeers 0 --networkid "10" --nodiscover --datadir "${HOME}/eth_private_net" --olympic console

personal.newAccount();

primary = eth.accounts[0]

# balance is 0
balance = web3.fromWei(eth.getBalance(primary), "ether");

# mine some ether
miner.start(8); admin.sleepBlocks(10); miner.stop();

# I have some ether
balance = web3.fromWei(eth.getBalance(primary), "ether");

# get address
primary

</pre>

## Create contract and register it

<pre>
bash> geth --maxpeers 0 --networkid "10" --nodiscover --datadir "${HOME}/ethereum_test/eth_private_net" --olympic --unlock [account_address] console

primary = eth.accounts[0]

# get stringified source code 
another bash> ./translate.sh house_locker.sol | pbcopy # for mac

contractName = 'HouseLocker';

compiled = eth.compile.solidity(source);

Contract = eth.contract(compiled[contractName].info.abiDefinition);

# register
var contract = Contract.new({from:primary, data: compiled[contractName].code, gas: 300000}, function(e, createdContract){
  if(e) {
    console.error(e, createdContract);
  } else {
    console.log('ok', createdContract);
  }
})

#miner.start(1); admin.sleepBlocks(1); miner.stop(); # for testnet

</pre>

## Test contract

<pre>

# check current tenant user
contract.getTenantUser()

# pay 1 szabo
contract.pay.sendTransaction({from: primary, value: web3.toWei(1, "szabo")})
#miner.start(1); admin.sleepBlocks(1); miner.stop(); # for testnet

# but...
contract.getTenantUser()

# pay 8 szabo
contract.pay.sendTransaction({from: primary, value: web3.toWei(8, "szabo")})
#miner.start(1); admin.sleepBlocks(1); miner.stop(); # for testnet

# check current tenant user
contract.getTenantUser()


# verify payment
contract.verifyAndUpdateTenantUser.sendTransaction({from: primary})
#miner.start(1); admin.sleepBlocks(1); miner.stop(); # for testnet

contract.getTenantUser()


</pre>
