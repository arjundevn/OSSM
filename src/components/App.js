import React, { Component } from 'react';
import Web3 from 'web3';
import Ossm from '../abis/Ossm.json'
import Navbar from './Navbar'
import Main from './Main'

class App extends Component {

  async componentWillMount() {
    await this.loadWeb3()
    await this.loadBlockchainData()
  
  }
  
  async loadWeb3() {
    if (window.ethereum) {
      window.web3 = new Web3(window.ethereum)
      await window.ethereum.enable()
    }
    else if (window.web3) {
      window.web3 = new Web3(window.web3.currentProvider);
    }
    else {
      window.alert('Non-Ethereum browser detected. You should consider trying MetaMask!');
    }
  }

  async loadBlockchainData() {
    const web3 = window.web3
    //Load Account
    const accounts = await web3.eth.getAccounts()
    this.setState({ account : accounts[0] })
    const networkId = await web3.eth.net.getId()
    const networkData = Ossm.networks[networkId]

    if (networkData) {
      const ossm = web3.eth.Contract(Ossm.abi,networkData.address)
      this.setState({ossm: ossm})

      const postCount = await ossm.methods.postCount().call()
      this.setState({postCount})
      console.log(postCount.toString())

      const p = await ossm.methods.getProfile(accounts[0]).call()
      this.setState({mycoins : p[2].toString()})
      this.setState({mypoints : p[3].toString() })

      //Load posts
      for (var i = 1;i <= postCount; i++) {
        const post = await ossm.methods.posts(i).call()
        this.setState({
          posts: [...this.state.posts, post]
        })
      }
      this.setState({loading: false})
     
     }else{
      window.alert("Ossm smart contract not deployed to this network")
    }
    
  }

  constructor(props) {
    super(props)
    this.state = {
      account: '',
      postCount: 0,
      posts: [],
      mycoins: 0,
      mypoints: 0,
      loading: true
    }

    this.createPost = this.createPost.bind(this)
  }

  createPost(projectName, githubLink, youtubeLink) {
    this.setState({ loading: true })
    this.state.ossm.methods.createPost(projectName, githubLink, youtubeLink).send({ from: this.state.account })
    .once('receipt', (receipt) => {
      this.setState({ loading:false })
    })
  }

  render() {
    return (
      <div>
        <Navbar 
          account={this.state.account}
          mycoins={this.state.mycoins}
          mypoints={this.state.mypoints}
        />
        <div className="container-fluid mt-5">
          <div className="row">
            <main role="main" className="col-lg-12 d-flex">
            { this.state.loading 
              ? <div id="loader" className="text-center"><p className="text-center">Loading...</p></div>
              : <Main
              posts={this.state.posts}
              createPost = {this.createPost} />
            }
            </main>
          </div>
        </div>
      </div>
    );
  }
}

export default App;
