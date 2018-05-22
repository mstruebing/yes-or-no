import express from 'express';
import bodyParser from 'body-parser';

import {randomQuestion, answerQuestion, questionCount} from './questions';
import {isUser, getUserId, addUser} from './user';

const app = express();

const allowCrossDomain = (req, res, next) => {
	res.header('Access-Control-Allow-Origin', 'http://localhost:3000');
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

app.get('/random/:userHash', async (req, res) => {
	const {userHash} = req.params;
	const userExists = await isUser(userHash);

	if (!userExists) {
        // Bool
		const added = await addUser(userHash);
        if (!added) {
            // Add correct error handling:  <22-05-18, mstruebing> //
            console.log(`Something went wrong while adding user with ${userHash} into the database`);
        }

        console.log(`user with hash: ${userHash} successfully added`);
	}

	const question = await randomQuestion(userHash);
	res.send(question);
});

app.post('/answer', async (req, res) => {
    const userId = await getUserId(req.body.userHash);
    const questionId = req.body.id;
    const option = req.body.option;
    const answered = await answerQuestion(questionId, userId, option);

	res.send(req.body);
});

app.get('/count', async (req, res) => {
	const count = await questionCount();
	res.send(count);
});

const port = process.env.port || 3001;

app.listen(port);
