import express from 'express';
import cors from 'cors';

import {randomQuestion, questionCount} from './questions';

const app = express();

app.use(cors());

app.get('/random', async (req, res) => {
	const question = await randomQuestion();
	res.send(question);
});

app.get('/count', async (req, res) => {
	const count = await questionCount();
	res.send(count);
});

const port = process.env.port || 3001;

app.listen(port);
