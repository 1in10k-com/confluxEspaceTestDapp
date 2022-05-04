// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Market {
    address payable owner;
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    struct Board {
        string words;
        address payable boardOwner;
        uint256 price;
    }

    mapping(uint256 => Board) boards;

    constructor() {
        owner = payable(msg.sender);
        createBoard(1, "boardwords111", 1);
        createBoard(2, "boardwords222", 2);
        createBoard(3, "boardwords333", 3);
    }

    function createBoard(
        uint256 _id,
        string memory _words,
        uint256 _price
    ) public onlyOwner {
        Board storage board = boards[_id];
        board.words = _words;
        board.boardOwner = payable(msg.sender);
        board.price = _price;
    }

    function getBoardInfo(uint256 _id)
        public
        view
        returns (
            string memory,
            address,
            uint256
        )
    {
        return (boards[_id].words, boards[_id].boardOwner, boards[_id].price);
    }

    function modifyWords(uint256 _id, string memory _words) public {
        require(msg.sender == boards[_id].boardOwner);
        boards[_id].words = _words;
    }

    function modifyPrice(uint256 _id, uint256 _price) public {
        require(msg.sender == boards[_id].boardOwner);
        boards[_id].price = _price;
    }

    function modifyBoardOwner(uint256 _id) public payable {
        boards[_id].boardOwner.transfer(boards[_id].price * 10**18);
        boards[_id].boardOwner = payable(msg.sender);
    }
}
