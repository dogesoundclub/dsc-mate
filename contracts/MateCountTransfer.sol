pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP17/IKIP17Enumerable.sol";

contract MateCountTransfer {

    IKIP17Enumerable public mate;

    constructor(IKIP17Enumerable _mate) public {
        mate = _mate;
    }

    function countTransfer(address to, uint256 start, uint256 count) external {
        uint256 total = mate.totalSupply();
        uint256 _count = 0;
        for (uint256 id = start; id < total; id += 1) {
            if (mate.ownerOf(id) == msg.sender) {
                mate.transferFrom(msg.sender, to, id);
                _count += 1;
                if (_count == count) {
                    break;
                }
            }
        }
        require(_count == count);
    }
}