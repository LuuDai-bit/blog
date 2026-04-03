// entities@3.0.1 downloaded from https://ga.jspm.io/npm:entities@3.0.1/lib/index.js

import e from"./decode.js";import d from"./encode.js";import"./decode_codepoint.js";import"./maps/xml.json.js";import"./maps/entities.json.js";var t={};Object.defineProperty(t,"__esModule",{value:true});t.decodeXMLStrict=t.decodeHTML5Strict=t.decodeHTML4Strict=t.decodeHTML5=t.decodeHTML4=t.decodeHTMLStrict=t.decodeHTML=t.decodeXML=t.encodeHTML5=t.encodeHTML4=t.escapeUTF8=t.escape=t.encodeNonAsciiHTML=t.encodeHTML=t.encodeXML=t.encode=t.decodeStrict=t.decode=t.EncodingMode=t.DecodingMode=t.EntityLevel=void 0;var c=e;var o=d;var n;(function(e){e[e.XML=0]="XML";e[e.HTML=1]="HTML"})(n=t.EntityLevel||(t.EntityLevel={}));var r;(function(e){e[e.Legacy=0]="Legacy";e[e.Strict=1]="Strict"})(r=t.DecodingMode||(t.DecodingMode={}));var i;(function(e){e[e.UTF8=0]="UTF8";e[e.ASCII=1]="ASCII";e[e.Extensive=2]="Extensive"})(i=t.EncodingMode||(t.EncodingMode={}));
/**
 * Decodes a string with entities.
 *
 * @param data String to decode.
 * @param options Decoding options.
 */function decode(e,d){void 0===d&&(d=n.XML);var t="number"===typeof d?{level:d}:d;return t.level===n.HTML?t.mode===r.Strict?c.decodeHTMLStrict(e):c.decodeHTML(e):c.decodeXML(e)}t.decode=decode;
/**
 * Decodes a string with entities. Does not allow missing trailing semicolons for entities.
 *
 * @param data String to decode.
 * @param options Decoding options.
 * @deprecated Use `decode` with the `mode` set to `Strict`.
 */function decodeStrict(e,d){void 0===d&&(d=n.XML);var t="number"===typeof d?{level:d}:d;return t.level===n.HTML?t.mode===r.Legacy?c.decodeHTML(e):c.decodeHTMLStrict(e):c.decodeXML(e)}t.decodeStrict=decodeStrict;
/**
 * Encodes a string with entities.
 *
 * @param data String to encode.
 * @param options Encoding options.
 */function encode(e,d){void 0===d&&(d=n.XML);var t="number"===typeof d?{level:d}:d;return t.mode===i.UTF8?o.escapeUTF8(e):t.level===n.HTML?t.mode===i.ASCII?o.encodeNonAsciiHTML(e):o.encodeHTML(e):o.encodeXML(e)}t.encode=encode;var M=d;Object.defineProperty(t,"encodeXML",{enumerable:true,get:function(){return M.encodeXML}});Object.defineProperty(t,"encodeHTML",{enumerable:true,get:function(){return M.encodeHTML}});Object.defineProperty(t,"encodeNonAsciiHTML",{enumerable:true,get:function(){return M.encodeNonAsciiHTML}});Object.defineProperty(t,"escape",{enumerable:true,get:function(){return M.escape}});Object.defineProperty(t,"escapeUTF8",{enumerable:true,get:function(){return M.escapeUTF8}});Object.defineProperty(t,"encodeHTML4",{enumerable:true,get:function(){return M.encodeHTML}});Object.defineProperty(t,"encodeHTML5",{enumerable:true,get:function(){return M.encodeHTML}});var L=e;Object.defineProperty(t,"decodeXML",{enumerable:true,get:function(){return L.decodeXML}});Object.defineProperty(t,"decodeHTML",{enumerable:true,get:function(){return L.decodeHTML}});Object.defineProperty(t,"decodeHTMLStrict",{enumerable:true,get:function(){return L.decodeHTMLStrict}});Object.defineProperty(t,"decodeHTML4",{enumerable:true,get:function(){return L.decodeHTML}});Object.defineProperty(t,"decodeHTML5",{enumerable:true,get:function(){return L.decodeHTML}});Object.defineProperty(t,"decodeHTML4Strict",{enumerable:true,get:function(){return L.decodeHTMLStrict}});Object.defineProperty(t,"decodeHTML5Strict",{enumerable:true,get:function(){return L.decodeHTMLStrict}});Object.defineProperty(t,"decodeXMLStrict",{enumerable:true,get:function(){return L.decodeXML}});const u=t.__esModule,T=t.decodeXMLStrict,H=t.decodeHTML5Strict,a=t.decodeHTML4Strict,f=t.decodeHTML5,p=t.decodeHTML4,s=t.decodeHTMLStrict,l=t.decodeHTML,b=t.decodeXML,m=t.encodeHTML5,v=t.encodeHTML4,S=t.escapeUTF8,g=t.encodeNonAsciiHTML,y=t.encodeHTML,j=t.encodeXML;const X=t.escape,O=t.encode,P=t.decodeStrict,E=t.decode,A=t.EncodingMode,F=t.DecodingMode,U=t.EntityLevel;export default t;export{F as DecodingMode,A as EncodingMode,U as EntityLevel,u as __esModule,E as decode,l as decodeHTML,p as decodeHTML4,a as decodeHTML4Strict,f as decodeHTML5,H as decodeHTML5Strict,s as decodeHTMLStrict,P as decodeStrict,b as decodeXML,T as decodeXMLStrict,O as encode,y as encodeHTML,v as encodeHTML4,m as encodeHTML5,g as encodeNonAsciiHTML,j as encodeXML,X as escape,S as escapeUTF8};

