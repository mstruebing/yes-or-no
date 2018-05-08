import express from 'express';

import {randomQuestion} from './questions';

const app = express();

app.get('/', (req, res) => {
  res.send(randomQuestion());
});

app.listen(3000);
