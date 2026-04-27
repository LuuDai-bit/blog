// encode@1.0.1 downloaded from https://ga.jspm.io/npm:encode@1.0.1/encode.js

import e from"buffer";var f={};var t=e.Buffer;"hex utf8 ascii binary base64 ucs2 utf16le".split(/\s+/).forEach((function(e){f[e]={encode:function(f){return new t(f,e)},decode:function(f){return f.toString(e)},buffer:true,name:e}}));f.json={encode:JSON.stringify,decode:JSON.parse,buffer:false,name:"json"};f["utf-8"]=f.utf8;f["ucs-2"]=f.ucs2;f["utf-16le"]=f.utf16le;const n=f.json;export default f;export{n as json};

