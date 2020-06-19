pragma solidity ^0.5.0;

import '../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol';


contract ERC20BatchMintable is ERC20Mintable {

    function mint(address to, uint256 value) public onlyMinter returns (bool) {
        _mint(to, value);
        return true;
    }

    function batchMint(address[] memory to, uint256[] memory value) public onlyMinter returns (bool) {
        require(to.length == value.length, "Recipient and amount list sizes don't match.");
        for (uint i = 0; i < to.length; i++) {
            _mint(to[i], value[i]);
        }
        return true;
    }

}
