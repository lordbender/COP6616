class MatrixTools {
  multiplyByParts(matrix, column) {
    const result = [];

    for (let i = 0; i < column.length; i++) {
      result[i] = 0;
      for (let j = 0; j < matrix[i].length; j++) {
        result[i] += column[i] * matrix[i][j];
      }
    }

    return result;
  }
}

module.exports = MatrixTools;
