const axios = require("axios");

const leftMatrix = require("./data").leftMatrix;
const rightMatrix = require("./data").rightMatrix;

class Main {
  multiplyAsync(m1, m2) {
    const rows = m1.map((row, i) => ({
      rowNumber: i,
      row
    }));

    m2.map((row, i) => row.map((j, i) => rows.find(x => x.row === i)));
    console.log(rows);
    return rows;
  }

  multiply(m1, m2) {
    var result = [];
    for (var i = 0; i < m1.length; i++) {
      result[i] = [];
      for (var j = 0; j < m2[0].length; j++) {
        var sum = 0;
        for (var k = 0; k < m1[0].length; k++) {
          sum += m1[i][k] * m2[k][j];
        }
        result[i][j] = sum;
      }
    }
    return result;
  }
}

const main = new Main();

const startTimeTraditional = new Date();
const resultTradtional = main.multiply(leftMatrix, rightMatrix);
const runTimeTraditional = new Date() - startTimeTraditional;
console.log("Result for Traditional Multiplicaiton", resultTradtional);
console.log("Run time for Traditional Multiplicaiton", runTimeTraditional);

const startTimeDistributed = new Date();
const resultDistributed = main.multiplyAsync(leftMatrix, rightMatrix);
const runTimeDistributed = new Date() - startTimeDistributed;
console.log("Result for Distributed Multiplicaiton", resultDistributed);
console.log("Run time for Distributed Multiplicaiton", runTimeDistributed);
