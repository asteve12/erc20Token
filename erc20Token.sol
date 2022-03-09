pragma solidity ^0.8.4;
/* lectures on erc20 token*/

/* imoorted our erc20 token interface and we are inheriting from it the reason for these is to ensure our contract conforms to the

erc2otoken standard 
*/
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

/* this second import is not neccessary to meet the erc20 token standard rather it adds additional feature to our token
 such as symbol and name */

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/IERC20Metadata.sol";


contract ERC20TOKEN is IERC20Metadata {
    string private _name;
    uint8 private _decimal;
    string private _symbol;
    uint private totalSupply_;
    mapping(address=>uint) private _balances;
    mapping(address=>mapping(address=>uint))private _allowances;
    
     constructor(string memory name_,string memory symbol_,uint8 decimal,uint _totalSupply){
            _name=name_;
        _decimal=decimal;
        _symbol=symbol_;
        totalSupply_ = _totalSupply* 10**decimal;
        _balances[msg.sender] =totalSupply_;
        //if you are minting and burning your from & to address respectivelyshould be  address(0) 
        //which enable us to detect whether we are burning or minting;
        emit Transfer(address(0),msg.sender,_totalSupply); 
    

      }
    
    function name() external override view returns(string memory){
        return _name;

    }
      function symbol() external override view returns (string memory){
           return _symbol;
      }
      function decimals() external override view returns (uint8){

        return _decimal;

      }
       function balanceOf(address account) external override view returns (uint256){
           return _balances[account];

       }
        function totalSupply() external override view returns(uint256){
            return totalSupply_;
        }

        function _transfer(address _from,address _to,uint256 _amount )public{
               uint userBalance = _balances[_from];
              require(userBalance>= _amount,"insufficient balance");
            _balances[_from]-=_amount;
            _balances[_to]+=_amount;

        }
          function transfer(address _to, uint256 _amount) external override returns (bool){
           
              _transfer(msg.sender,_to,_amount);
              return true;
              }

        function approve(address _spender, uint256 _amount) external override returns (bool){
            _allowances[msg.sender][_spender] = _amount;
            emit Approval(msg.sender,_spender,_amount);
                  return true;
              }

function allowance(address _owner, address _spender) public override view returns (uint256){
    return _allowances[_owner][_spender];

}
    function transferFrom(address _from,address _to,uint256 _amount) external override returns (bool){
            uint allow= allowance(_from,msg.sender);
            require(allow >= _amount);
            _allowances[_from][msg.sender]-= _amount;
            _transfer(_from,_to,_amount);
            return true;
            
    }
     

}