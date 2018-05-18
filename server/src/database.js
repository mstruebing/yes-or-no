import {Client} from 'pg';

async function query(query) {
	const client = new Client({
		user: 'docker',
		host: 'localhost',
		database: 'yes_or_no',
		password: 'docker',
		port: 5432
	});

	client.connect();
	const res = await client.query(query);
	client.end();

	return res;
}

export {query};
