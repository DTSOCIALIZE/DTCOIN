/*
DTSOCIALIZE LIMITED C 87045
VAT: MT 25584806
*/

pragma solidity ^0.5.0;

import '../node_modules/openzeppelin-solidity/contracts/cryptography/ECDSA.sol';
import '../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';
import './Freezable.sol';


contract DelegateTransferable is ERC20, Freezable {

    mapping (bytes => bool) internal _signatures;

    event TransferPreSigned(
        address indexed delegate,
        address indexed from,
        address indexed to,
        uint256 value
    );

    function transferPreSigned(
        bytes memory _signature,
        address _to,
        uint256 _value,
        uint256 _secret
    ) public returns (bool) {

        require(_signatures[_signature] == false, "Funds already claimed");

        bytes32 dataHash = _transferPreSignedHashing(_secret, _value);

        address from = ECDSA.recover(dataHash, _signature);

        require(!_frozen[from], "Account frozen");

        require(_value <= balanceOf(from), "Signer doesn't have enough funds");

        _transfer(from, _to, _value);

        _signatures[_signature] = true;

        emit TransferPreSigned(msg.sender, from, _to, _value);

        emit Transfer(from, _to, _value);

        return true;

    }

    function _transferPreSignedHashing(
        uint256 _secret,
        uint256 _value
    )
        internal
        pure
        returns (bytes32)
    {
        bytes32 hash = keccak256(abi.encodePacked(_secret, "#", _value));
        return _prefix(hash);
    }

    function _prefix(bytes32 _hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _hash));
    }
}
