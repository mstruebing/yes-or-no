import {query} from './database';

// use userHash to get all non answered questions:  <22-05-18, mstruebing> //
const randomQuestion = async userHash => {
	const result = await query('SELECT * FROM question ORDER BY random() limit 1');
	return result.rows[0];
};

const questionCount = async () => {
	const result = await query('SELECT COUNT (*) FROM question');
	return result.rows[0];
};

const answerQuestion = async (questionId, userId, option) => {
	const result = await query(`INSERT INTO "answer"("question_id", "user_id", "answer") VALUES ('${questionId}', '${userId}', '${option}')`);
	return result.rowCount === 1;
};

export {
	randomQuestion,
	answerQuestion,
	questionCount
};
