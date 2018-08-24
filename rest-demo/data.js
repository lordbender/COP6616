module.exports.leftMatrix = [
  [1, 2, 3, 4, 5],
  [1, 2, 3, 4, 5],
  [1, 2, 3, 4, 5],
  [1, 2, 3, 4, 5],
  [1, 2, 3, 4, 5]
];

module.exports.rightMatrix = [
  [5, 4, 3, 2, 1],
  [5, 4, 3, 2, 1],
  [5, 4, 3, 2, 1],
  [5, 4, 3, 2, 1],
  [5, 4, 3, 2, 1]
];

module.exports.getDynamicMatrix = (size) => {
  const matrix = [];
  for (let i = 0; i < size; i++) {
    matrix[i] = [];
    for (let j = 0; j < size; j++) {
      matrix[i][j] = Math.floor(Math.random() * 100);
    }
  }

  return matrix;
};
