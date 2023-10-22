// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

error NotEnoughVote_Rayshomar();

contract Rayshomar {
    address[] private s_voters;
    address[] private s_candidates;
    mapping(address => uint8) remainingVote;
    uint8 private immutable i_votesPerVoter;

    constructor(uint8 _voteForEachVoter) {
        i_votesPerVoter = _voteForEachVoter;
    }

    function Vote(address candidate, uint8 numberOfVotes) public {
        if (
            remainingVote[msg.sender] == 0 ||
            remainingVote[msg.sender] < numberOfVotes
        ) {
            revert NotEnoughVote_Rayshomar();
        }
        remainingVote[candidate] += numberOfVotes;
        remainingVote[msg.sender] -= numberOfVotes;
    }

    function setVoters(address voter) public {
        s_voters.push(voter);
        remainingVote[voter] = i_votesPerVoter;
    }

    function setCandidates(address candidate) public {
        s_candidates.push(candidate);
        remainingVote[candidate] = 0;
    }

    function getRemainingVote(address voter) public view returns (uint8) {
        return remainingVote[voter];
    }

    function getCandidateVote(address candidate) public view returns (uint8) {
        return remainingVote[candidate];
    }
}
