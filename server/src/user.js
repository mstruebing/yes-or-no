import {query} from './database';

const addUser = async userHash => {
	const result = await query(`INSERT INTO "user"("hash") VALUES ('${userHash}')`);
	return result.rowCount === 1;
};

const isUser = async userHash => {
	const result = await query(`SELECT COUNT("hash") FROM "user" WHERE "hash" = '${userHash}'`);
	return result.rows[0].count > 0;
};

const getUserId = async userHash => {
	const result = await query(`SELECT "id" FROM "user" WHERE "hash" = '${userHash}'`);
	return result.rows[0];
};

export {
	addUser,
	isUser
};
