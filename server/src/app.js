import express from 'express';

import {randomQuestion, questionCount} from './questions';

const app = express();

app.get('/', async (req, res) => {
	const question = await randomQuestion();
	res.send(question);
});

app.get('/countl', async (req, res) => {
	const count = await questionCount();
	res.send(count);
});

app.listen(3000);
