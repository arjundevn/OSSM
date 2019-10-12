pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../src/contracts/Ossm.sol";

contract TestOSSM is Ossm{

    function test_1_Deployed_user_not_present() public{
        Assert.notEqual(exists[msg.sender],false, "This user is present");
    }

    function test_2_Existing_user_present() public{
        initialiseNewUser();
        Assert.equal(exists[msg.sender], true, "This user is not initalized");
    }

    function test_3_ICO_to_new_user() public{
        Assert.equal(profile[msg.sender].coin, 10, "New user has not got 10 free coins");
    }

    function test_4_Points_to_new_user() public{
        Assert.equal(profile[msg.sender].coin, 10, "New user has not got 10 free coins");
    }

    function test_5_Id_assigned_to_new_user() public{
        Assert.equal(profile[msg.sender].id, msg.sender, "New user has not been registered");
    }

    function test_6_ICO_to_new_user() public{
        Assert.equal(profile[msg.sender].coin, 10, "New user has not got 10 free coins");
    }

    function test_7_Insert_new_username() public{
        string memory n = "arjun";
        profile[msg.sender].userName = n;
        Assert.equal("arjun", profile[msg.sender].userName, "New user has not got 10 free coins");
    }

    function test_8_Array_getPosts_is_initialized_and_has_no_elements() public{
        Assert.equal(postCount,1, "New array has predefined elements");
    }

    function test_9_Inserting_new_post() public{
        createPost("p1", "g1", "y1");
    }

    function test_10_Verifying_name_of_new_post_inserted() public{
        Assert.equal(posts[1].projectName, "p0", "Name of first post is wrong");
    }

    function test_11_Verifying_github_linkof_new_post_inserted() public{
        Assert.equal(posts[1].githubLink, "g0", "Github link of first post is wrong");
    }

    function test_12_Verifying_youtube_link_of_new_post_inserted() public{
        Assert.equal(posts[1].youtubeLink, "y0", "Youtube link of first post is wrong");
    }

    function test_13_Verifying_addition_of_10_coins_for_new_post_inserted() public{
        Assert.equal(profile[msg.sender].coin, 20, "Total number of coins after posting a new post is not equal to 20");
    }
    function test_14_Verifying_addition_of_10_points_for_new_post_inserted() public{
        Assert.equal(profile[msg.sender].points, 10, "Total number of points after posting a new post is not equal to 10");
    }
}