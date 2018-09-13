const axios = require("axios");

const size = Math.floor(Math.random() * 100) + 50;

const leftMatrix = require("./data").getDynamicMatrix(15);
const rightMatrix = require("./data").getDynamicMatrix(15);

class Main {
  async multiplyAsync(m1, m2) {
    const getColumn = (arr, n) => arr.map(x => x[n]);
    const resultsPromises = [];

    for (let i = 0; i < m2[0].length; i++) {
      const col = getColumn(m2, i);
      const url = `http://localhost:300${
        i % 2 === 0 ? 1 : 2
      }/api/v1/vector-multiply`;

      const model = {
        matrix: m1,
        column: col,
        columnPosition: i
      };

      resultsPromises.push(axios.post(url, model));
    }

    const results = await Promise.all(resultsPromises);
    return results.map(x => x.data);
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
// console.log("Result for Traditional Multiplicaiton", resultTradtional);
console.log(
  `Run time for Traditional Multiplicaiton => ${runTimeTraditional}ms`
);

const startTimeDistributed = new Date();
main.multiplyAsync(leftMatrix, rightMatrix).then(d => {
  const runTimeDistributed = new Date() - startTimeDistributed;

  const combinedResult = d
    .sort((x, y) => x.columnPosition < y.columnPosition)
    .map(x => x.result);

  for (let i = 0; i < combinedResult.length; i++) {
    let row = "";
    for (let j = 0; j < combinedResult.length; j++) {
      row += `${combinedResult[i][j]} `;
    }
    console.log(row);
  }

  // console.log(combinedResult);
  // console.log("Result for Distributed Multiplicaiton", d);
  console.log(
    `Run time for Distributed Multiplicaiton => ${runTimeDistributed}ms`
  );
});
