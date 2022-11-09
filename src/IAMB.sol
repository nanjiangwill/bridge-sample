// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

interface IAMB {
    function setRecipientAMB(address _recipientAMB) external;

    function send(address to, bytes calldata data)
        external
        view
        returns (bytes memory);

    function receive(bytes calldata inputData) external;
}
