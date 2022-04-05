// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
        // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
        // for accounts without code, i.e. `keccak256('')`
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        // solhint-disable-next-line no-inline-assembly
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

contract Velamis is Context, IERC20 {
    using SafeMath for uint256;
    using Address for address;

    //address public constant ManageWallet = 0x6742e82826f03F69B46D86FF2Afaf870F9A188c6;
    address public constant ManageWallet = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8; // for testing

    address public constant PrivSaleWallet = 0x2f609c920c78535bF3aE62B92ffb131Cb37b03EB;
    address public constant PubSaleWallet = 0xd0BDc14f6457511655E2290c56FdAd5a3F96Ddea;
    address public constant AdvisoryWallet = 0x1fa257b5aA21e21bD6fa0f421638661b8A422902;
    address public constant TeamWallet = 0x7De8E2b7f921Ba243454B30406076a89FDf7c343;
    address public constant EcoGrowthWallet = 0x5b58E5DF395F87Ce0cd2A677b9a48Cbb7cB3a843;
    address public constant CompanyWallet = 0x333431Cdae737Cd1BF6ad26C22e443700710d819;
    address public constant TreasuryWallet = 0xA9ED9C85A7Cc10ED3Cb439934a25D737C6b8d006;
    address public constant StakingRewardWallet = 0x44a7CC9762C267180e0E09d56a84D70629258e29;

    //address public constant PauseWallet = 0x13200C0FAC543e5A7f85791e65Bea038fE6eE25d;
    address public constant PauseWallet = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC; //for testing
    uint public constant PrivSalePercent = 5;
    uint public constant PubSalePercent = 10;
    uint public constant AdvisoryPercent = 5;
    uint public constant TeamPercent = 5;
    uint public constant EcoGrowthPercent = 10;
    uint public constant CompanyPercent = 20;
    uint public constant TreasuryPercent = 25;
    uint public constant StakingRewardPercent = 20;

    uint[] public IssuancePercent = [
        2222, 2397, 3040, 3294, 4253, 4507, 5441, 
        5623, 6434, 6615, 7328, 7455, 8015, 8142, 
        8690, 8781, 9234, 9807, 9879, 9952, 10000
    ];

    mapping(address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;

    string private _name = "VELAMIS";
    string private _symbol = "VEL";
    uint8 private _decimals = 18;
    uint256 private _totalSupply;
    uint256 private _marketCap;
    bool[] private _distributed; 

    uint256 public burnFee = 10; // Burn Fee
    uint256 public constant intervalIssuance = 30 * 24 * 3600; 
    uint public issuanceIndex = 0;
    uint256 public issuanceTime;
    uint256 public burnTime;
    bool public status;
    uint256 public starttime;
    uint256 public totalBurnedTokens;
        
    constructor () {
        _marketCap = 300_000_000 * (10 ** _decimals);
        _totalSupply = 0;
        status = true;

        issuanceTime = starttime;
        issuanceIndex = 0;
        totalBurnedTokens = 0;
        _distributed = new bool[](8);
        for(uint i = 0; i < 8; i++) _distributed[i] = false;
    }

    modifier onlyStopper() {
        require(_msgSender() == PauseWallet, "VELAMIS: caller isn't stopper of the contract");
        _;
    }

    modifier onlyManager() {
        require(_msgSender() == ManageWallet, "VELAMIS: caller isn't manager of the contract");
        _;
    }

    modifier isRunning() {
        require(status, "VELAMIS: contract is stopped");
        _;
    }

    function pauseContract() external onlyStopper {
        status = false;
    }

    function issueTokens() external onlyManager isRunning{
        require(issuanceIndex <= 20, "VELAMIS: token issuace is ended");
        require(block.timestamp >= issuanceTime, "VELAMIS: it isn't the issuace time now");
        uint256 amount;
        if(issuanceIndex > 0) amount = _marketCap * (IssuancePercent[issuanceIndex] - IssuancePercent[issuanceIndex -1]) / 10000;
        else amount = _marketCap * IssuancePercent[issuanceIndex] / 10000;
        _balances[ManageWallet] += amount;
        _totalSupply += amount;
        issuanceTime += intervalIssuance;
        issuanceIndex = issuanceIndex + 1;
        emit Transfer(address(0), ManageWallet, amount);
    }

    function distributeTokens(uint8 index) external onlyManager isRunning{
        require(index < 8, "VELAMIS: index must be less than 8.");
        require(!_distributed[index], "VELAMIS: distribution with this index had already done.");
        address wallet;
        uint percent;
        if(index == 0) { wallet = PrivSaleWallet; percent = PrivSalePercent;}
        else if(index == 1) { wallet = PubSaleWallet; percent = PubSalePercent;}
        else if(index == 2) { wallet = AdvisoryWallet; percent = AdvisoryPercent;}
        else if(index == 3) { wallet = TeamWallet; percent = TeamPercent;}
        else if(index == 4) { wallet = EcoGrowthWallet; percent = EcoGrowthPercent;}
        else if(index == 5) { wallet = CompanyWallet; percent = CompanyPercent;}
        else if(index == 6) { wallet = TreasuryWallet; percent = TreasuryPercent;}
        else if(index == 7) { wallet = StakingRewardWallet; percent = StakingRewardPercent;}

        uint256 amount = _marketCap * percent / 100;
        _transfer(ManageWallet, wallet, amount);
    }

    function burnTokens(uint256 amount) external onlyManager isRunning{
        uint256 _burnamount = amount * burnFee / 100;
        uint256 maxBurnedTokens = _marketCap * 50 / 100;
        require(totalBurnedTokens < maxBurnedTokens, "VELAMIS: tokens have already burned");
        if(totalBurnedTokens + _burnamount > maxBurnedTokens) _burnamount = maxBurnedTokens - totalBurnedTokens;
        
        _burn(ManageWallet, _burnamount);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }
    function transfer(address to, uint256 amount) public override isRunning returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override isRunning returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override isRunning returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override isRunning returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public isRunning returns (bool)  {
        address owner = _msgSender();
        _approve(owner, spender, _allowances[owner][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public isRunning returns (bool)  {
        address owner = _msgSender();
        uint256 currentAllowance = _allowances[owner][spender];
        require(currentAllowance >= subtractedValue, "VELAMIS: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        require(from != address(0), "VELAMIS: transfer from the zero address");
        require(to != address(0), "VELAMIS: transfer to the zero address");

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "VELAMIS: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
        }
        _balances[to] += amount;

        emit Transfer(from, to, amount);

    }

    function _burn(address account, uint256 amount) internal {
        require(account != address(0), "VELAMIS: burn from the zero address");

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "VELAMIS: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        require(owner != address(0), "VELAMIS: approve from the zero address");
        require(spender != address(0), "VELAMIS: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "VELAMIS: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }
}