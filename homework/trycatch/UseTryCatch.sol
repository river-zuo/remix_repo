pragma solidity ^0.8.0;

interface IBank {
    function withdraw() external;
}

contract Admin {
    address public owner;

    uint storedValue;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function adminWithdraw(IBank bank) external onlyOwner {
        try bank.withdraw() {
            // 提款成功
        } catch Error(string memory reason) {
            // 处理提款失败
            // revert("Bank withdrawal failed: %s", reason);
            revert("Bank withdrawal failed: %s");
        } catch {
            // 其他错误
            revert("Unknown withdrawal error");
        }
    }

    function getValue() public view returns (uint) {
        return storedValue;
    }

    function setValue(uint value) public {
        storedValue = value;
    }

    // function selectorAA() public returns (bytes4) {
    //     // setValue.selector();
    //     // // return bytes4(keccak256("setValue(uint)"));
    //     bytes4(keccak256("getValue()"));
    //     bytes4(keccak256("setValue(uint)"));
    //     abi.encode("");
    //     return this.getValue.selector;
    // }

    function encode_bytes_len() public pure returns (uint) {
        bytes memory data = abi.encodeWithSignature("transfer(address , uint256)", 1, 2);
        return data.length;
    }

}

contract UseTryCatch {

    function callAddr(Admin ad) public returns(uint) {
        address addr = address(ad);
        
    }

    function calc() public pure returns (uint) {
        // function transfer(address recipient, uint256 amount)
        string memory tmp = "function transfer(address recipient, uint256 amount)";
        // string memory tmp = "function transfer(address, uint256)";
        
        // bytes memory bl = abi.encode(tmp);
        bytes memory bl = abi.encode(tmp);
        // bytes memory bl = abi.encodePacked(tmp);
        // abi.encodeWithSelector(bytes4, 1, 2);
        // return bl;
        return bl.length;
    }

    function byteLength(string memory hexString) public pure returns (uint256) {
        if (bytes(hexString).length < 2) return 0;
        bytes memory hexBytes = bytes(hexString);

        // 检查是否以 "0x" 开头
        if (hexBytes[0] != '0' || (hexBytes[1] != 'x' && hexBytes[1] != 'X')) {
            revert("Invalid hex string");
        }

        // 去掉 "0x" 后的字符数必须是偶数
        uint256 dataLength = hexBytes.length - 2;
        if (dataLength % 2 != 0) {
            revert("Hex string has odd length");
        }

        return dataLength / 2;
    }

}

// 0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003466756e6374696f6e207472616e73666572286164647265737320726563697069656e742c2075696e7432353620616d6f756e7429000000000000000000000000


contract Callee {
    function getData() public pure returns (uint256) {
        return 42;
    }
}

contract Caller {
    function callGetData(address callee) public view returns (uint256 data) {
        bytes memory res = abi.encodeWithSignature("getData()");
        (bool succ, bytes memory results) = callee.staticcall(res);
        if (!succ)  {
            revert("staticcall failed");
        }
        data = abi.decode(results, (uint));
        return data;
    }
}

contract CallerA {
    function sendEther(address to, uint256 value) public returns (bool) {
        // 使用 call 发送 ether
        (bool success, ) = to.call{value: value}(new bytes(0));
        if (!success) {
            revert("sendEther failed");
        }
        return success;
    }

    receive() external payable {}

    // function setValue(uint256 value_) public payable {
    //     require(msg.value > 0);
    //     value = value_;
    // }

    function callSetValue(address callee, uint256 value) public returns (bool) {
        // call setValue()
        bytes memory data = abi.encodeWithSignature("setValue(uint256)", value);
        (bool success, ) = callee.call{value: 1e18}(data);
        if (!success) {
            revert("call function failed");
        }
        return success;
    }

    function delegateSetValue(address callee, uint256 _newValue) public {
        // delegatecall setValue()
        bytes memory data = abi.encodeWithSignature("setValue(uint256)", _newValue);
        (bool success, ) = callee.delegatecall(data);
        if (!success) {
            revert("");
        }
    }

    

}

contract ABIEncoder {
    function encodeUint(uint256 value) public pure returns (bytes memory) {
        return abi.encode(value);
    }

    function encodeMultiple(
        uint num,
        string memory text
    ) public pure returns (bytes memory) {
       return abi.encode(num, text);
    }
}

contract ABIDecoder {
    function decodeUint(bytes memory data) public pure returns (uint) {
        (uint res) = abi.decode(data, (uint));
        return res;
    }

    function decodeMultiple(
        bytes memory data
    ) public pure returns (uint, string memory) {
        (uint p0, string memory p1) = abi.decode(data, (uint, string));
        return (p0, p1);
    }
}

contract DataStorage {
    string private data;

    function setData(string memory newData) public {
        data = newData;
    }

    function getData() public view returns (string memory) {
        return data;
    }
}

contract DataConsumer {
    address private dataStorageAddress;

    constructor(address _dataStorageAddress) {
        dataStorageAddress = _dataStorageAddress;
    }

    function getDataByABI() public returns (string memory) {
        // payload
        bytes memory payload = abi.encodeWithSignature("getData");
        (bool success, bytes memory data) = dataStorageAddress.call(payload);
        require(success, "call function failed");
        string memory res = abi.decode(data, (string));
        return res;
        // return data
    }

    function setDataByABI1(string calldata newData) public returns (bool) {
        // playload
        bytes memory payload = abi.encodeWithSignature("setData(string)", newData);
        (bool success, ) = dataStorageAddress.call(payload);
        require(success, "call function failed");
        return success;
    }

    function setDataByABI2(string calldata newData) public returns (bool) {
        // selector
        // playload
        // abi.encodeWithSelector(bytes4(keccak256("setData(string)")), arg);
        bytes memory payload = abi.encodeWithSelector(DataStorage.setData.selector, newData);
        (bool success, ) = dataStorageAddress.call(payload);
        require(success, "call function failed");
        return success;
    }

    function setDataByABI3(string calldata newData) public returns (bool) {
        // playload
        bytes memory playload = abi.encodeCall(DataStorage.setData, (newData));
        (bool success, ) = dataStorageAddress.call(playload);
        require(success, "call function failed");
        return success;
    }
    // bytes memory payload = abi.encodeCall(DataStorage.getData, (newData));
    //     (bool success, ) = dataStorageAddress.call(payload);
    //     require(success, "call function failed");
    //     return success;
}



contract BaseERC20 {
    string public name; 
    string public symbol; 
    uint8 public decimals; 

    uint256 public totalSupply;

    mapping (address => uint256) balances; 

    mapping (address => mapping (address => uint256)) allowances; 

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

//     设置 Token 名称（name）："BaseERC20"
// 设置 Token 符号（symbol）："BERC20"
// 设置 Token 小数位decimals：18
// 设置 Token 总量（totalSupply）:100,000,000
// 允许任何人查看任何地址的 Token 余额（balanceOf）

// 1) Should fail if sender doesn’t have enough balance
// 2) Should update balances after transfers
// Approval
// 3) Should set an approval amount for delegated tranfer
// Allowance
// 4) Should update allowance after transferFrom
// transferFrom
// 5) Should transfer the tokens from sender to recipient
// 6) Should fail if sender doesn’t have enough tokens
// 7) Should fail if trying to transfer more tokens than approved


    constructor()  {
        // write your code here
        // set name,symbol,decimals,totalSupply
        name = "BaseERC20";
        symbol = "BERC20";
        decimals = 18;
        totalSupply = 1e8 * 1e18;
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        // write your code here
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        // write your code here
        require(balances[msg.sender] >= _value, "ERC20: transfer amount exceeds balance");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);  
        return true;   
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        // write your code here
        require(balances[_from] >= _value, "ERC20: transfer amount exceeds balance");
        balances[_from] -= _value;
        balances[_to] += _value;
        uint256 curAllow = allowance(_from, msg.sender);
        require(curAllow >= _value, "ERC20: transfer amount exceeds allowance");
        allowances[_from][msg.sender] = curAllow - _value;
        emit Transfer(_from, _to, _value);
        return true; 
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        // write your code here
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {   
        // write your code here     
        return allowances[_owner][_spender];
    }
}



