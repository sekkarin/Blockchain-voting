// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TestVoing {
    address manger;
    string[]  candidateList;
    mapping(string => uint256) votesScores;
    mapping(address => bool) isVoted;

    enum State {
        STARTED,
        VOTING,
        ENDED
    }
    State  state;
    modifier inState(State _state) {
        require(state == _state);
        _;
    }
    modifier onlyManger() {
        require(manger == msg.sender);
        _;
    }

    constructor(string[] memory _candidateLists) {
        manger = msg.sender;
        candidateList = _candidateLists;
        state = State.STARTED;
    }

    function startVote() public onlyManger inState(State.STARTED) {
        state = State.VOTING;
    }

    function endtVote() public onlyManger inState(State.VOTING) {
        state = State.ENDED;
    }

    function candidateCount() public view returns (uint256) {
        return candidateList.length;
    }

    function voteForCandidate(string memory _candidate)
        public
        inState(State.VOTING)
    {
        require(isVoted[msg.sender] == false, "Alreadly vote");
        isVoted[msg.sender] = true;
        votesScores[_candidate] += 1;
    }

    function totalVotesFor(string memory _candidate)
        public
        view
        inState(State.ENDED)
        returns (uint256)
    {
        return votesScores[_candidate];
    }
}
