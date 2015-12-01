const q = require('querystring');
const p = require('process');

console.log(q.escape(p.argv[2]));
