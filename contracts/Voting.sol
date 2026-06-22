// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    address public electionOfficial;
    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public hasVoted;
    uint256 public candidatesCount;

    event Voted(uint256 indexed candidateId, address indexed voter);
    event CandidateAdded(uint256 indexed candidateId, string name);

    modifier onlyOfficial() {
        require(msg.sender == electionOfficial, "Only the election official can perform this action.");
        _;
    }

    constructor() {
        electionOfficial = msg.sender;
    }

    function addCandidate(string memory _name) public onlyOfficial {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        emit CandidateAdded(candidatesCount, _name);
    }

    function vote(uint256 _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted.");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;

        emit Voted(_candidateId, msg.sender);
    }

    function getVotes(uint256 _candidateId) public view returns (uint256) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");
        return candidates[_candidateId].voteCount;
    }
}