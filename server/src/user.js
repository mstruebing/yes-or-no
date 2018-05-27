import {query} from './database';

const addUser = async userHash => {
	const sql = 'INSERT INTO "user"("hash") VALUES ($1)';
	const values = [userHash];

	try {
		const result = await query(sql, values);
		return result.rowCount === 1;
	} catch (e) {
		console.log(e.stack);
	}
};

const isUser = async userHash => {
	const sql = 'SELECT COUNT("hash") FROM "user" WHERE "hash" = $1';
	const values = [userHash];

	try {
		const result = await query(sql, values);
		return result.rows[0].count > 0;
	} catch (e) {
		console.log(e.stack);
	}
};

const getUserId = async userHash => {
	const sql = 'SELECT "id" FROM "user" WHERE "hash" = $1';
	const values = [userHash];

	try {
		const result = await query(sql, values);
		return result.rows[0].id;
	} catch (e) {
		console.log(e.stack);
	}
};

export {
	addUser,
	getUserId,
	isUser
};
