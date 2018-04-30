import express from 'express';

import sum from './sum';

const app = express();

console.log(sum(1, 2));

app.get('/', (req, res) => {
  res.send('Hello World!!!');
});

app.listen(3000);
