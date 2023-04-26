// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.2;

contract GroupManagement {
    struct Member {
        string name;
        uint piority;
    }

    struct MemberWithAddress {
        Member info;
        address walletAddress;
    }

    struct Group {
        uint totalMembers;
        uint totalMembersPiority;
        address[] memberAddresses;
        mapping(address => Member) memberMap;
        mapping(address => bool) memberExists;
    }

    modifier onlyNeverJoined() {
        require(!isJoin(msg.sender), "You already join group");
        _;
    }

    modifier onlyJoined() {
        require(isJoin(msg.sender), "You are not join group");
        _;
    }

    Group private group;

    constructor() {}

    function join(string memory _name) external onlyNeverJoined {
        addMember(msg.sender, _name, 1);
    }

    function listMembers()
        external
        view
        onlyJoined
        returns (MemberWithAddress[] memory)
    {
        MemberWithAddress[] memory response = new MemberWithAddress[](group.totalMembers);
        for (uint index = 0; index < group.totalMembers; index ++) {
            response[index].walletAddress = group.memberAddresses[index];
            response[index].info = group.memberMap[response[index].walletAddress];
        }
        return response;
    }

    function addMember(
        address _address,
        string memory _name,
        uint _piority
    ) private {
        Member storage member = group.memberMap[_address];
        member.name = _name;
        member.piority = _piority;

        group.memberAddresses.push(_address);
        group.memberExists[_address] = true;
        group.totalMembers += 1;
        group.totalMembersPiority += _piority;
    }

    function isJoin(address _address) private view returns (bool) {
        return group.memberExists[_address];
    }
}
