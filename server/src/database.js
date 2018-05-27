import {Client} from 'pg';


const query = async (text, values = null) => {
	const client = new Client({
		user: 'docker',
		host: 'localhost',
		database: 'yes_or_no',
		password: 'docker',
		port: 5432
	});

	client.connect();

	try {
		let result;
		if (values === null) {
			result = await client.query(text);
		} else {
			result = await client.query(text, values);
		}

		return result;
	} catch (e) {
		console.log(e.stack);
	} finally {
		client.end();
	}
};

export {
	query
};
