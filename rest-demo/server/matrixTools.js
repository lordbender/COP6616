class MatrixTools {
  multiplyByParts(matrix, column) {
    const result = [];

    for (let i = 0; i < matrix.length; i++) {
      result[i] = 0;
      for (let j = 0; j < matrix.length; j++) {
        result[i] += column[i] * matrix[i][j];
      }
      console.log(result[i]);
    }

    return result;
  }
}

module.exports = MatrixTools;
