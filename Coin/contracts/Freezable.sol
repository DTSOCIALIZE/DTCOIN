pragma solidity ^0.5.0;

import './FreezerRole.sol';
import '../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';
import '../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol';


contract Freezable is FreezerRole, ERC20, ERC20Burnable {

    mapping (address => bool) internal _frozen;

    event AccountFrozen(address indexed account);
    event AccountUnfrozen(address indexed account);

    function isFrozen(address account) public view returns (bool) {
        return _frozen[account];
    }

    function freezeAccount(address account) public onlyFreezer {
        require(!_frozen[account], "Account already frozen");
        _frozen[account] = true;
        emit AccountFrozen(account);
    }

    function unfreezeAccount(address account) public onlyFreezer {
        require(_frozen[account], "Account not frozen");
        _frozen[account] = false;
        emit AccountUnfrozen(account);
    }
    
    // Transfer overrides

    function transfer(address to, uint256 value) public returns (bool) {
        require(!_frozen[msg.sender], "Account frozen");
        return super.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(!_frozen[from], "Account frozen");
        return super.transferFrom(from, to, value);
    }

    // transferPreSigned from frozen account filtered in DelegateTransfrable.sol

    function burn(uint256 value) public {
        require(!_frozen[msg.sender], "Account frozen");
        return super.burn(value);
    }

    function burnFrom(address from, uint256 value) public {
        require(!_frozen[from], "Account frozen");
        return super.burnFrom(from, value);
    }
}