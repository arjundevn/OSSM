import React, { Component } from 'react';

class Main extends Component {

  render() {
    return (
        // <div id = "content">
        //     <div class="card mt-20">
        //     <h5 id="project-title" class="card-header project-title">Lendroid</h5>
        //     <div class="card-body">
        //         <h5 class="card-title">Vignesh Sundresan</h5>
        //         <p class="card-text">MASTER WEI: 526</p>
        //         <div>
        //             you cant write class and id like that, where is your css file
        //             this was the css file u gave ,me, import in, in wat?></div>
        //         </div>
        //     </div>
        // </div>
        <div className="App">
            <h2>Posts:</h2>
            <table className="table">
                <thead>
                    <tr>
                        <th scope="col">Name</th>
                        <th scope="col">Github link</th>
                        <th scope="col">Youtube link</th>
                        <th scope="col">Owner</th>
                        <th scope="col"></th>
                    </tr>
                </thead>
                <tbody id="postList">
                    { this.props.posts.map((post, key) => {
                        return(
                            <tr key={key}>
                                <td>{post.projectName.toString()}</td>
                                <td>{post.githubLink}</td>
                                <td>{post.youtubeLink}</td>
                                <td>{post.postOwner}</td>
                            </tr>
                        )
                    })}
                </tbody>
            </table>

            <h1>Post a New Project:</h1>
        <form onSubmit={(event) => {
            event.preventDefault()
            const projectName = this.projectName.value
            const githubLink = this.githubLink.value
            const youtubeLink = this.youtubeLink.value
            this.props.createPost(projectName, githubLink, youtubeLink)
        }}>
            <div className="form-group mr-sm-2">
                <input
                    id = "projectName"
                    type="text"
                    ref ={(input) => {this.projectName = input}}
                    className="form-control"
                    placeholder="Project Name"
                    required />
            </div>
            <div className="form-group mr-sm-2">
                <input
                    id = "githubLink"
                    type="text"
                    ref ={(input) => {this.githubLink = input}}
                    className="form-control"
                    placeholder="Github Link"
                    required />
            </div>
            <div className="form-group mr-sm-2">
                <input
                    id = "youtubeLink"
                    type="text"
                    ref ={(input) => {this.youtubeLink = input}}
                    className="form-control"
                    placeholder="Youtube Link"
                    required />
            </div>
            <button type="submit" className="btn-btn-primary">Submit</button>
        </form>
        </div>
    );
  }
}

export default Main;