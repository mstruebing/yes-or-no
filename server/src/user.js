import crypto from 'crypto';

import {query} from './database';

const calculateHash = (randomNumber, timestamp, userAgent) => {
	const secret = 'super cool secret';
	const hash = crypto.createHmac('sha512', secret).update(randomNumber + timestamp + userAgent).digest('hex');
	return hash;
};

const addUser = async user => {
	const result = await query('SELECT * FROM question ORDER BY random() limit 1');
	return result.rows[0];
};

const isUser = async userHash => {
	const result = await query(`SELECT COUNT("hash") FROM "user" WHERE "hash" = '${userHash}'`);
	return result.rows[0];
};

const getUserId = async userHash => {
	const result = await query(`SELECT "id" FROM "user" WHERE "hash" = '${userHash}'`);
	return result.rows[0];
};

export {
	addUser,
	isUser,
	calculateHash
};

