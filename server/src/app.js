import express from 'express';
import bodyParser from 'body-parser';

import {randomQuestion, questionCount} from './questions';
import {isUser, calculateHash} from './user';

const app = express();

const allowCrossDomain = (req, res, next) => {
	res.header('Access-Control-Allow-Origin', 'http://local:3000');
	res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
	res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With');
	res.header('Access-Control-Allow-Credentials', true);

	// Intercept OPTIONS method
	if (req.method === 'OPTIONS') {
		res.sendStatus(204);
	} else {
		next();
	}
};

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
