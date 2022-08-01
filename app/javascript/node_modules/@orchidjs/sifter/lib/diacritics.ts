
// @ts-ignore TS2691 "An import path cannot end with a '.ts' extension"
import { escape_regex } from './utils.ts';

type TDiacraticList = {[key:string]:string};

// https://github.com/andrewrk/node-diacritics/blob/master/index.js

var latin_pat:RegExp;
const accent_pat = '[\u0300-\u036F\u{b7}\u{2be}]'; // \u{2bc}
const accent_reg = new RegExp(accent_pat,'gu');
var diacritic_patterns:TDiacraticList;

const latin_convert:TDiacraticList = {
	'æ': 'ae',
	'ⱥ': 'a',
	'ø': 'o',
};

const convert_pat = new RegExp(Object.keys(latin_convert).join('|'),'gu');

const code_points:[[number,number]] = [[ 0, 65535 ]];

/**
 * Remove accents
 * via https://github.com/krisk/Fuse/issues/133#issuecomment-318692703
 *
 */
export const asciifold = (str:string):string => {
	return str
		.normalize('NFKD')
		.replace(accent_reg, '')
		.toLowerCase()
		.replace(convert_pat,function(foreignletter) {
			return latin_convert[foreignletter];
		});
};

/**
 * Convert array of strings to a regular expression
 *	ex ['ab','a'] => (?:ab|a)
 * 	ex ['a','b'] => [ab]
 *
 */
export const arrayToPattern = (chars:string[],glue:string='|'):string =>{

	if( chars.length == 1 ){
		return chars[0];
	}

	var longest = 1;
	chars.forEach((a)=>{longest = Math.max(longest,a.length)});

	if( longest == 1 ){
		return '['+chars.join('')+']';
	}

	return '(?:'+chars.join(glue)+')';
};

export const escapeToPattern = (chars:string[]):string =>{
	const escaped = chars.map((diacritic) => escape_regex(diacritic));
	return arrayToPattern(escaped);
};

/**
 * Get all possible combinations of substrings that add up to the given string
 * https://stackoverflow.com/questions/30169587/find-all-the-combination-of-substrings-that-add-up-to-the-given-string
 *
 */
export const allSubstrings = (input:string):string[][] => {

    if( input.length === 1) return [[input]];

    var result:string[][] = [];
    allSubstrings(input.substring(1)).forEach(function(subresult) {
        var tmp = subresult.slice(0);
        tmp[0] = input.charAt(0) + tmp[0];
        result.push(tmp);

        tmp = subresult.slice(0);
        tmp.unshift(input.charAt(0));
        result.push(tmp);
    });

    return result;
}

/**
 * Generate a list of diacritics from the list of code points
 *
 */
export const generateDiacritics = (code_points:[[number,number]]):TDiacraticList => {

	var diacritics:{[key:string]:string[]} = {};
	code_points.forEach((code_range)=>{

		for(let i = code_range[0]; i <= code_range[1]; i++){

			let diacritic	= String.fromCharCode(i);
			let	latin		= asciifold(diacritic);

			if( latin == diacritic.toLowerCase() ){
				continue;
			}

			// skip when latin is a string longer than 3 characters long
			// bc the resulting regex patterns will be long
			// eg:
			// latin صلى الله عليه وسلم length 18 code point 65018
			// latin جل جلاله length 8 code point 65019
			if( latin.length > 3 ){
				continue;
			}

			if( !(latin in diacritics) ){
				diacritics[latin] = [latin];
			}

			var patt = new RegExp( escapeToPattern(diacritics[latin]),'iu');
			if( diacritic.match(patt) ){
				continue;
			}

			diacritics[latin].push(diacritic);
		}
	});

	// filter out if there's only one character in the list
	let latin_chars = Object.keys(diacritics);
	for( let i = 0; i < latin_chars.length; i++){
		const latin = latin_chars[i];
		if( diacritics[latin].length < 2 ){
			delete diacritics[latin];
		}
	}


	// latin character pattern
	// match longer substrings first
	latin_chars		= Object.keys(diacritics).sort((a, b) => b.length - a.length );
	latin_pat		= new RegExp('('+ escapeToPattern(latin_chars) + accent_pat + '*)','gu');


	// build diacritic patterns
	// ae needs:
	//	(?:(?:ae|Æ|Ǽ|Ǣ)|(?:A|Ⓐ|Ａ...)(?:E|ɛ|Ⓔ...))
	var diacritic_patterns:TDiacraticList = {};
	latin_chars.sort((a,b) => a.length -b.length).forEach((latin)=>{

		var substrings	= allSubstrings(latin);
		var pattern = substrings.map((sub_pat)=>{

			sub_pat = sub_pat.map((l)=>{
				if( diacritics.hasOwnProperty(l) ){
					return escapeToPattern(diacritics[l]);
				}
				return l;
			});

			return arrayToPattern(sub_pat,'');
		});

		diacritic_patterns[latin] = arrayToPattern(pattern);
	});


	return diacritic_patterns;
}

/**
 * Expand a regular expression pattern to include diacritics
 * 	eg /a/ becomes /aⓐａẚàáâầấẫẩãāăằắẵẳȧǡäǟảåǻǎȁȃạậặḁąⱥɐɑAⒶＡÀÁÂẦẤẪẨÃĀĂẰẮẴẲȦǠÄǞẢÅǺǍȀȂẠẬẶḀĄȺⱯ/
 *
 */
export const diacriticRegexPoints = (regex:string):string => {

	if( diacritic_patterns === undefined ){
		diacritic_patterns = generateDiacritics(code_points);
	}

	const decomposed		= regex.normalize('NFKD').toLowerCase();

	return decomposed.split(latin_pat).map((part:string)=>{

		// "ﬄ" or "ffl"
		const no_accent = asciifold(part);
		if( no_accent == '' ){
			return '';
		}

		if( diacritic_patterns.hasOwnProperty(no_accent) ){
			return diacritic_patterns[no_accent];
		}

		return part;
	}).join('');

}
