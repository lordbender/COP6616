class MatrixTools {
  multiplyByParts(martix, column) {
    const result = [];

    martix.forEach((row, i) => {
      const agrigator = [];
      column.forEach((val, j) => {
        result[i] += row[i] * val;
      });
    });

    return result;
  }
}

module.exports = MatrixTools;
