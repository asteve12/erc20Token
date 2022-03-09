pragma solidity ^0.8.4;

/*this enables us to talk to the token contract we have created*/
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";



contract BuySteveToken{
    IERC20 steveToken;
    uint startdate = block.timestamp;
    uint enddate = startdate + 2 days;

    uint256 rate = 100;
    uint minimumBuy;
    uint maximumBuy;
        event purchasedToken(address buyer,uint amount);

    constructor(address steveTokenAddress,uint _minimumBuy,uint _maximumBuy){
        steveToken = IERC20(steveTokenAddress);
        minimumBuy = _minimumBuy;
        maximumBuy = _maximumBuy;
}

        function buy()public payable{
            require(block.timestamp>= startdate,"sorry sale has not started");
             require(block.timestamp<= enddate,"sorry sale has ended");
             require(msg.value>= minimumBuy,"below purchase expectation");
             require(msg.value<=  maximumBuy,"above purchase expectation");
             uint tokenBalance = checkTokenBalance();
             require(msg.value*100 <= tokenBalance,"no enough token available");

             steveToken.transfer(msg.sender,msg.value*100);
            emit purchasedToken(msg.sender,msg.value*100);
             
        }
        function checkBalance()external view returns(uint256){
            return address(this).balance;
        }

        function checkTokenBalance()public view returns(uint){
            return steveToken.balanceOf(address(this));
        }

}