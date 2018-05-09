import {questions, randomQuestion} from './questions';

describe('questions', () => {
	test('questions should be an array', () => {
		expect(Array.isArray(questions)).toBeTruthy();
	});

	test('randomQuestion should be in questions', () => {
		expect(questions).toContain(randomQuestion());
	});

	test('randomQuestion should contain one question', () => {
		const question = randomQuestion();
		expect(question).toEqual(
			expect.objectContaining({
				id: expect.any(Number),
				question: expect.any(String),
				answers: expect.any(Array)
			})
		);
	});
});
