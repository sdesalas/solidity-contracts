// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.8.6;

/**
 * This contract:
 * 1) Sets the donation target at contract creation
 * 2) Allows making donations via `donate()` function
 * 3) Total donation amounts available via `getTotalDonations()` function
 * 
 * Ref: https://ethereum.stackexchange.com/questions/64766/pass-arguments-to-constructor
 * Ref: https://dev.to/emanuelferreira/how-to-create-a-smart-contract-to-receive-donations-using-solidity-4k8
 */
contract Donation {

  uint totalDonations; // the amount of donations
  address payable target; // target of donations

  constructor(address _target) {
    target = payable(_target); // set the donation target at initialization
  }

  // public function to donate
  function donate() public payable {
    (bool success,) = target.call{value: msg.value}("");
    require(success, "Failed to send money");
    totalDonations += msg.value;
  }

  // public function to return total of donations
  function getTotalDonations() view public returns(uint) {
    return totalDonations;
  }
}
