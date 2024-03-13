// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Token {
    string public name = "Hexar";
    string public symbol = "HTC";
    uint public mintPrice = 1 ether;
    uint256 public _totalSupply;
    uint256 public maxSupply;
    address public owner;
    uint256 public whitelisted=50;
    mapping(address => mapping(address => uint256)) private _allowances;
    mapping(address => uint256) private _balances;

    constructor(){
     owner = msg.sender;
    maxSupply = 200;
    _balances[owner]= whitelisted;
    _totalSupply=whitelisted;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256 ) {
        return _balances[account];
    }

     modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    

    function mint(uint256 amount) public payable  returns (bool) {
        require(msg.value == amount * mintPrice, "Incorrect value sent");

         require(_totalSupply + amount <= maxSupply, "Exceeds max supply");
        _totalSupply += amount;
        _balances[msg.sender] += amount;
        return true;

        
    }


    function transfer(address to, uint256 amount) public returns (bool) {
    require(_balances[msg.sender] >= amount, "Not enough balance");
    
    _balances[msg.sender] -= amount;
    _balances[to] += amount;

    return true;
     }


     function approve(address spender, uint256 amount) public returns (bool) {
    _allowances[msg.sender][spender] = amount;
    
    return true;
     }

function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
    require(_balances[sender] >= amount, "Not enough balance");
    require(_allowances[sender][msg.sender] >= amount, "Allowance exceeded");

    _balances[sender] -= amount;
    _balances[recipient] += amount;
    _allowances[sender][msg.sender] -= amount;

   
    return true;
}

function allowance(address _owner, address spender) public view returns (uint256) {
    return _allowances[_owner][spender];
}

}
