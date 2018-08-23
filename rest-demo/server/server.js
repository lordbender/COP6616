const express = require('express')

const mockServerOne = express()
mockServerOne.post('/api/v1/vector-multiply', (req, res) => res.send('result'))
mockServerOne.listen(3001, () => console.log('Example app listening on port 3001!'))

const mockServerTwo = express()
mockServerTwo.post('/api/v1/vector-multiply', (req, res) => res.send('result'))
mockServerTwo.listen(3002, () => console.log('Example app listening on port 3002!'))

const mockServerThree = express()
mockServerThree.post('/api/v1/vector-multiply', (req, res) => res.send('result'))
mockServerThree.listen(3003, () => console.log('Example app listening on port 3003!'))