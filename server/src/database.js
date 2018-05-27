import {Pool} from 'pg';

const query = async (text, values = null) => {
	const pool = new Pool({
		user: 'docker',
		host: 'localhost',
		database: 'yes_or_no',
		password: 'docker',
		port: 5432
	});

	try {
		let result;
		if (values === null) {
			result = await pool.query(text);
		} else {
			result = await pool.query(text, values);
		}

		return result;
	} catch (e) {
		console.log(e.stack);
	} finally {
		pool.end();
	}
};

export {
	query
};
