// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {

    // STRUCTS & DATA TYPES
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    // ==========================================
    // 1. STATE VARIABLES (Persistent Blockchain Ledger)
    // ==========================================
    address public electionOfficial;
    uint256 public candidateCount;
    
    // Maps a candidate's ID to their profile data
    mapping(uint256 => Candidate) public candidates;
    
    // Maps a voter's wallet address to their voting status (true/false)
    mapping(address => bool) public hasVoted;

    // CONSTRUCTOR
    constructor() {
        electionOfficial = msg.sender; // The deployer is the official
    }

    // ==========================================
    // 2. FUNCTIONS TO STORE DATA & 3. VALIDATION
    // ==========================================
    
    // Admin Function to register a choice
    function addCandidate(string memory _name) public {
        // VALIDATION: Only the official can add candidates
        require(msg.sender == electionOfficial, "Only the official can add candidates.");
        
        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, _name, 0);
    }

    // Public Function to cast a vote
    function vote(uint256 _candidateId) public {
        // VALIDATION 1: Ensure the candidate exists
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate ID.");
        
        // VALIDATION 2: Prevent double voting (One wallet, one vote)
        require(!hasVoted[msg.sender], "You have already voted.");

        // STORE DATA: Update the state variables
        hasVoted[msg.sender] = true;         // Permanently record voter status
        candidates[_candidateId].voteCount++; // Safely increment candidate tally
    }

    // ==========================================
    // 2. FUNCTIONS TO RETRIEVE DATA
    // ==========================================
    
    // View Function to read results instantly without gas fees
    function getVotes(uint256 _candidateId) public view returns (uint256) {
        // VALIDATION: Ensure the candidate exists
        require(_candidateId > 0 && _candidateId <= candidateCount, "Invalid candidate ID.");
        
        // RETRIEVE DATA: Pull data from state mapping
        return candidates[_candidateId].voteCount;
    }
}