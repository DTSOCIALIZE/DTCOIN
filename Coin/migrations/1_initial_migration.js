/*
DTSOCIALIZE LIMITED C 87045
VAT: MT 25584806
*/

const Migrations = artifacts.require("Migrations");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
