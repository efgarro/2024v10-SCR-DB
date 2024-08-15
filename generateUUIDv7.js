// import * as readline from "node:readline";
const rl = require("readline-sync");

// const rl = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout,
// });

const name = rl.question(`What's your name?`);

console.log(`Hi ${name}!`);

// rl.close();
