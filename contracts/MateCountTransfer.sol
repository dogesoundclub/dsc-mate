pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP17/IKIP17Enumerable.sol";
import "./klaytn-contracts/math/SafeMath.sol";

contract MateCountTransfer {
    using SafeMath for uint256;

    IKIP17Enumerable public mate;

    constructor(IKIP17Enumerable _mate) public {
        mate = _mate;
    }

    function countTransfer(address to, uint256 start, uint256 count) external {
        uint256 total = mate.totalSupply();
        uint256 _count = 0;
        for (uint256 id = start; id < total; id = id.add(1)) {
            if (mate.ownerOf(id) == msg.sender) {
                mate.transferFrom(msg.sender, to, id);
                _count = _count.add(1);
                if (_count == count) {
                    break;
                }
            }
        }
        require(_count == count);
    }
}