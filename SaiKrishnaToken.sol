// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.1.0/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => uint256) private _balances;
    address sender = 0xc969F303DDB233Ae18276257579Ef2c9EDE6C819;

    constructor() ERC20("SaiKrishnaToken", "SKT") {
        _mint(sender, 1000000);
        _balances[sender] = balanceOf(sender);
    }

    function totalSupply() public view virtual override returns(uint256) {
        return super.totalSupply();
    }

    function balanceOf(address account) public view virtual override returns (uint256){
        return super.balanceOf(account);
    }
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        require(amount<= _balances[sender]);
        _balances[sender] -= amount;
        _balances[recipient] += amount;

        _transfer( sender, recipient, amount);
        return true;
    }

    

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return super.allowance(owner, spender);
    }
    
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        require(to != address(0), "ERC20: transfer to the zero address");
        require(amount <= _balances[from], "ERC20: transfer amount exceeds balance");
        require(amount <= _allowances[from][sender], "ERC20: transfer amount exceeds allowance");
    
        _balances[from] -= amount;
        _balances[to] += amount;
        _allowances[from][sender] -= amount;
    
        emit Transfer(from, to, amount);
        return true;
    }
}
