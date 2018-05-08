import sample from 'lodash.sample';

const questions = [
	{
		id: 0,
		question: 'Hamburg or Berlin',
		answers: ['Hamburg', 'Berlin']
	},
	{
		id: 1,
		question: 'Mac oder Linux',
		answers: ['Mac', 'Linux']
	},
	{
		id: 2,
		question: 'Burger or Steak',
		answers: ['Burger', 'Steak']
	}
];

const randomQuestion = () => sample(questions);

export {
	questions,
	randomQuestion
};
