import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';

import {randomQuestion, questionCount} from './questions';

const app = express();

const allowCrossDomain = function (req, res, next) {
	res.header('Access-Control-Allow-Origin', '*');
	res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
	res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With');

	// Intercept OPTIONS method
	if (req.method === 'OPTIONS') {
		res.sendStatus(204);
	} else {
		next();
	}
};

app.use(cors());
app.use(allowCrossDomain);
app.use(bodyParser.json());

app.get('/random', async (req, res) => {
	const question = await randomQuestion();
	res.send(question);
});

app.post('/answer', async (req, res) => {
	console.log(req.body);
	res.send(req.body);
});

app.get('/count', async (req, res) => {
	const count = await questionCount();
	res.send(count);
});

const port = process.env.port || 3001;

app.listen(port);
