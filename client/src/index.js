import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
import crypto from 'crypto';

let userHash = localStorage.getItem('userHash');

if (userHash === null) {
	const secret = navigator.buildID + new Date().getTime();
	userHash = crypto.createHmac('sha512', secret).update(navigator.userAgent).digest('hex');
    localStorage.setItem('userHash', userHash);
}

const app = Main.embed(document.getElementById('root'), userHash);

registerServiceWorker();
