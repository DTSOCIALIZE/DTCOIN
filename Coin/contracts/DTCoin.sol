/*
DTSOCIALIZE LIMITED C 87045
VAT: MT 25584806
*/

pragma solidity ^0.5.0;

import '../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol';
import '../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol';
import '../node_modules/openzeppelin-solidity/contracts/lifecycle/Pausable.sol';
import './Freezable.sol';
import './DelegateTransferable.sol';
import './ERC20BatchMintable.sol';


contract DTCoin is ERC20Detailed, ERC20Burnable, ERC20BatchMintable, Freezable, DelegateTransferable, Pausable {

    constructor () public
        ERC20Detailed("DT Coin", "DTC", 18)
    {
        // empty constructor
    }

    function transfer(address to, uint256 value) public whenNotPaused returns (bool) {
        return super.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public whenNotPaused returns (bool) {
        return super.transferFrom(from, to, value);
    }

    function approve(address spender, uint256 value) public whenNotPaused returns (bool) {
        return super.approve(spender, value);
    }

    function increaseAllowance(address spender, uint addedValue) public whenNotPaused returns (bool success) {
        return super.increaseAllowance(spender, addedValue);
    }

    function decreaseAllowance(address spender, uint subtractedValue) public whenNotPaused returns (bool success) {
        return super.decreaseAllowance(spender, subtractedValue);
    }
    function burn(uint256 value) public whenNotPaused {
        return super.burn(value);
    }

    function burnFrom(address from, uint256 value) public whenNotPaused {
        return super.burnFrom(from, value);
    }

    function mint(address to, uint256 value) public whenNotPaused returns (bool) {
        return super.mint(to, value);
    }

    function batchMint(address[] memory to, uint256[] memory value) public whenNotPaused returns (bool) {
        return super.batchMint(to, value);
    }

    function transferPreSigned(
        bytes memory _signature,
        address _to,
        uint256 _value,
        uint256 _secret
    ) public whenNotPaused returns (bool) {
        return super.transferPreSigned(_signature, _to, _value, _secret);
    }
}
