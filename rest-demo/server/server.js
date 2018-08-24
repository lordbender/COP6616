const express = require("express");
const bodyParser = require("body-parser");
const MatrixTools = require("./matrixTools");
const matrixTools = new MatrixTools();

const mockServerOne = express();
mockServerOne.use(bodyParser.json());
mockServerOne.post("/api/v1/vector-multiply", (req, res) => {
  const { body: { matrix = [[]], column = [], columnPosition = 0 } = {} } = req;
  const result = matrixTools.multiplyByParts(matrix, column);
  res.json({ columnPosition, result });
});
mockServerOne.listen(3001, () =>
  console.log("Example app listening on port 3001!")
);


/* ***************************************** */

const mockServerTwo = express();
mockServerTwo.use(bodyParser.json());
mockServerTwo.post("/api/v1/vector-multiply", (req, res) => {
  const { body: { matrix = [[]], column = [], columnPosition = 0 } = {} } = req;
  const result = matrixTools.multiplyByParts(matrix, column);
  res.json({ columnPosition, result });
});

mockServerTwo.listen(3002, () =>
  console.log("Example app listening on port 3002!")
);

