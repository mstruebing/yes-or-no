import {query} from './database';

const getAnsweredQuestionsByUser = async userId => {
	const sql = 'SELECT "question_id" FROM answer WHERE "user_id" = $1';
	const values = [userId];

	try {
		const userAlreadyAnswered = await query(sql, values);

		return userAlreadyAnswered.rows.reduce((answeredQuestions, question) => {
			if (!answeredQuestions.includes(question.question_id)) {
				return [...answeredQuestions, question.question_id];
			}

			return answeredQuestions;
		}, []);
	} catch (e) {
		console.log(e.stack);
	}
};

const randomQuestion = async userId => {
	try {
		const answeredQuestionsByUser = await getAnsweredQuestionsByUser(userId);

		let result;
		if (answeredQuestionsByUser.length > 0) {
			const sql = `SELECT * FROM question WHERE NOT id IN (${answeredQuestionsByUser}) limit 1`;
			result = await query(sql);
		} else {
			const sql = 'SELECT * FROM question ORDER BY random() limit 1';
			result = await query(sql);
		}

		return result.rows[0];
	} catch (e) {
		console.log(e.stack);
	}
};

const getCounts = async () => {
	try {
		const questions = await query('SELECT COUNT (*) FROM "question"');
		const answers = await query('SELECT COUNT (*) FROM "answer"');
		const users = await query('SELECT COUNT (*) FROM "user"');

		return {
			answers: Number(answers.rows[0].count),
			questions: Number(questions.rows[0].count),
			users: Number(users.rows[0].count)
		};
	} catch (e) {
		console.log(e.stack);
	}
};

const answerQuestion = async (questionId, userId, option) => {
	const sql = 'INSERT INTO "answer"("question_id", "user_id", "answer") VALUES ($1, $2, $3)';
	const values = [questionId, userId, option];

	try {
		const result = await query(sql, values);
		return result.rowCount === 1;
	} catch (e) {
		console.log(e.stack);
	}
};

const userAnsweredQuestion = async (questionId, userId) => {
	try {
		const answeredQuestions = await getAnsweredQuestionsByUser(userId);
		return answeredQuestions.includes(questionId);
	} catch (e) {
		console.log(e.stack);
	}
};

const quesitonStatistics = async questionId => {
	const sql = 'SELECT "answer" FROM "answer" WHERE "question_id" = $1';
	const values = [questionId];

	try {
		const result = await query(sql, values);
		return result.rows.reduce((acc, curr) => {
			if (curr.answer === 1) {
				return {id: Number(questionId), option1: acc.option1 + 1, option2: acc.option2};
			}

			return {id: Number(questionId), option1: acc.option1, option2: acc.option2 + 1};
		}, {id: Number(questionId), option1: 0, option2: 0});
	} catch (e) {
		console.log(e.stack);
	}
};

export {
	randomQuestion,
	answerQuestion,
	getCounts,
	getAnsweredQuestionsByUser,
	userAnsweredQuestion,
	quesitonStatistics
};
