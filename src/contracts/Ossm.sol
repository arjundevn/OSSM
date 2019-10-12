pragma solidity ^0.5.0;

contract Ossm{

    string public nam;

    constructor() public {
        nam = "Project Ossm";
        initialiseNewUser();
        createPost("Project OSSM!!","www.github.com", "www.youtube.com");
    }

    uint public postCount  = 0;
    mapping (uint => Post) public posts;

    struct Post{
        string projectName; //Title of the project
        string githubLink; //Github Link of the project
        string youtubeLink;//Youtube link of the project
        address postOwner;  // Address of the owner of this post
        uint totalReviewers; // Total number of users who have reviewed this post
        uint points;    // Total point received by this post
    }

    function createPost(string memory _projectName, string memory _githubLink, string memory _youtubeLink) public{
        require(bytes(_projectName).length > 0, "Blank Project Name not allowed");
        require(bytes(_githubLink).length > 0, "Blank Github Link not allowed");
        require(bytes(_youtubeLink).length > 0, "Blank Youtube Link not allowed");
        postCount++;
        posts[postCount] = Post(_projectName, _githubLink, _youtubeLink, msg.sender, 0, 0);
        profile[msg.sender].coin += 10;
        profile[msg.sender].points += 10;
    }

    modifier checkCoinBalance(){
        require(profile[msg.sender].coin>0, "You are out of balance, Upload a new project to get 10 coins and be OSSM!!");
        _;
    }

    function ratePost(uint postnum, uint rating) public checkCoinBalance{
        require(posts[postnum].postOwner != msg.sender, "You cannot rate your own project");
        profile[msg.sender].coin--;
        profile[msg.sender].points += 5;
        posts[postnum].totalReviewers++;
        posts[postnum].points += rating;
        profile[posts[postnum].postOwner].points += rating;
    }
//-------------------------------------------------------------------------------------------------------------------------
    // Creating a struct for each user with 4 attributes:
     struct User {
        address id;
        string userName;
        uint coin;
        uint points;
    }
    //Mapping the user struct for every address, hence creating a profile
    mapping (address => User) profile;

    //Mapping to check if new user or existing user
    mapping (address =>bool) exists;

    //Modifier to use the "exists" mapping
    modifier checkNewUser(){
        require(exists[msg.sender] == false, "User already exists");
        _;
    }

    //Initializing new user with 10 freely earned coins
    function initialiseNewUser() public checkNewUser {
            exists[msg.sender] = true;
            profile[msg.sender].coin = 10;
            profile[msg.sender].points = 0;
            profile[msg.sender].id = msg.sender;
        }
    //Allowing the new user to enter his/her username
    function inputUserName(string memory n) public checkNewUser {
        profile[msg.sender].userName = n;
    }


    //Array containing all the posts to be displayed on the "wall"
    //post[] public getPosts; // randomize thru front-end

    //Get user profile with all 4 attributes
    function getProfile(address a) public view returns (address id, string memory user_name, uint coin, uint points){
        return (profile[a].id, profile[a].userName, profile[a].coin, profile[a].points);
    }
}
