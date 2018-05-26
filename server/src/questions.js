import {query} from './database';

const getAnsweredQuestionsByUser = async userId => {
	const userAlreadyAnswered = await query(`SELECT "question_id" FROM answer WHERE "user_id" = ${userId}`);

	return userAlreadyAnswered.rows.reduce((answeredQuestions, question) => {
		if (!answeredQuestions.includes(question.question_id)) {
			return [...answeredQuestions, question.question_id];
		}

		return answeredQuestions;
	}, []);
};

// Use userHash to get all non answered questions:  <22-05-18, mstruebing> //
const randomQuestion = async userId => {
	const answeredQuestionsByUser = await getAnsweredQuestionsByUser(userId);

	let result;
	if (answeredQuestionsByUser.length > 0) {
		result = await query(`SELECT * FROM question WHERE NOT id in (${answeredQuestionsByUser.toString()}) ORDER BY random() limit 1`);
	} else {
		result = await query(`SELECT * FROM question ORDER BY random() limit 1`);
	}

	return result.rows[0];
};

const getCounts = async () => {
	const questions = await query('SELECT COUNT (*) FROM question');
	const answers = await query('SELECT COUNT (*) FROM answer');
	return {answers: Number(answers.rows[0].count), questions: Number(questions.rows[0].count)};
};

const answerQuestion = async (questionId, userId, option) => {
	const result = await query(`INSERT INTO "answer"("question_id", "user_id", "answer") VALUES ('${questionId}', '${userId}', '${option}')`);
	return result.rowCount === 1;
};

const userAnsweredQuestion = async (questionId, userId) => {
	const answeredQuestions = await getAnsweredQuestionsByUser(userId);
	return answeredQuestions.includes(questionId);
};

const quesitonStatistics = async questionId => {
	const result = await query(`SELECT "answer" FROM "answer" WHERE "question_id" = ${questionId}`);
	return result.rows.reduce((acc, curr) => {
		if (curr.answer === 1) {
			return {id: Number(questionId), option1: acc.option1 + 1, option2: acc.option2};
		}

		return {id: Number(questionId), option1: acc.option1, option2: acc.option2 + 1};
	}, {id: Number(questionId), option1: 0, option2: 0});
};

export {
	randomQuestion,
	answerQuestion,
	getCounts,
	getAnsweredQuestionsByUser,
	userAnsweredQuestion,
	quesitonStatistics
};
