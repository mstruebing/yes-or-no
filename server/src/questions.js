import {query} from './database';

const randomQuestion = async () => {
	const result = await query('SELECT * FROM question ORDER BY random() limit 1');
	return result.rows[0];
};

const questionCount = async () => {
	const result = await query('SELECT COUNT (*) FROM question');
	return result.rows[0];
};

export {
	randomQuestion,
	questionCount
};
