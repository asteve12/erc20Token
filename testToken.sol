pragma solidity ^0.8.4;
//building token


contract TestToken{
    mapping(address => uint)public balances;
    string public name;
    string public  symbol;
    uint totalSupply;

    constructor(string memory _name,string memory _symbol, uint _totalSupply){
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        balances[msg.sender] = totalSupply;

}

function transfer(address _to, uint _amount)external returns(bool){
   uint userBal = balances[msg.sender];
   require(_amount <= userBal);
   balances[msg.sender]-= _amount;
   balances[_to] += _amount;
   return true;
}


}