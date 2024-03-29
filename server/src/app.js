import express from 'express';
import bodyParser from 'body-parser';

import {addQuestion, getAnsweredQuestionsByUser, quesitonStatistics, getCounts, randomQuestion, answerQuestion} from './questions';
import {isUser, getUserId, addUser} from './user';

const app = express();

const allowCrossDomain = (req, res, next) => {
	res.header('Access-Control-Allow-Origin', 'http://localhost:3000');
	res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS');
	res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With');
	res.header('Access-Control-Allow-Credentials', true);

	if (req.method === 'OPTIONS') {
		res.sendStatus(204);
	} else {
		next();
	}
};

app.use(allowCrossDomain);
app.use(bodyParser.json());

app.get('/random/:userHash', async (req, res) => {
	const {userHash} = req.params;
	const userExists = await isUser(userHash);

	if (!userExists) {
		const added = await addUser(userHash);
		if (added) {
			console.log(`user with hash: ${userHash} successfully added`);
		} else {
			console.log(`Something went wrong while adding user with ${userHash} into the database`);
		}
	}

	const userId = await getUserId(userHash);
	const question = await randomQuestion(userId);

	res.send(question);
});

app.post('/answer', async (req, res) => {
	const userId = await getUserId(req.body.userHash);
	const questionId = req.body.id;

	const alreadyAnsweredQuestions = await getAnsweredQuestionsByUser(userId);

	if (alreadyAnsweredQuestions.includes(questionId)) {
		return;
	}

	const {option} = req.body;
	await answerQuestion(questionId, userId, option);

	res.send(req.body);
});

app.get('/statistics/:questionId/:userHash', async (req, res) => {
	const {questionId} = req.params;
	const statistics = await quesitonStatistics(questionId);
	res.send(statistics);
});

app.get('/count', async (req, res) => {
	const count = await getCounts();
	res.send(count);
});

app.post('/addQuestion', async (req, res) => {
	const added = await addQuestion(req.body);

	if (added) {
		res.send(req.body);
	} else {
		res.send('wrong');
	}
});

const port = process.env.port || 3001;

console.log(`Listen on port: ${port}`);
app.listen(port);
