// File: `./migrations/2_deploy_token.js`

/*
DTSOCIALIZE LIMITED C 87045
VAT: MT 25584806
*/

var Token = artifacts.require("DTCoin");

const deploy = async (deployer, network, accounts) => {

    let token = await deployer.deploy(Token)

    console.log('Token address', token.address)

}

module.exports = (deployer, network, accounts) => {

    deployer.then(async () => await deploy(deployer, network, accounts))

};
