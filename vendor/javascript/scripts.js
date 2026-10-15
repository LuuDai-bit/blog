// scripts@0.1.0 downloaded from https://ga.jspm.io/npm:scripts@0.1.0/index.js

import r from"path";import t from"fs";var e={};var n=r,o=t,s=o.existsSync||n.existsSync;e.resolve=function(r,t){if(s(r))return r;t?"string"==typeof t&&(t=[t]):t=Object.keys({}).map((function(r){return r}));var e,n;for(var o=0,f=t.length;o<f;++o){e=t[o];"."!=e[0]&&(e="."+e);n=r+e;if(s(n))return n}return r+".js"};const f=e.resolve;export default e;export{f as resolve};

