import { writeFile, appendFile } from "node:fs/promises";
import * as process from "node:process";
import { v4 as uuidv4 } from "uuid";
import { uuidv7 } from "uuidv7";
// const process = require('node:process');

// console.log(uuidv4());
// console.log(uuidv7());
// console.log(process.argv[2]);
// console.log(parseInt(process.argv[2]));
// writeFile("uuids.txt",'');

const filename = process.argv[2];
const qtyIDs = process.argv[3];

const addIDv7 = (IDv7, i) => {
  try {
    setTimeout(async () => {
      const value = await appendFile(filename, `${IDv7}\n`);
      console.log(value, i);
    }, 10);
  } catch (error) {
    throw error;
  }
};

for (let i = 1; i <= qtyIDs; i++) {
  addIDv7(uuidv7(), i);
  //   console.log(IDv7);
}
