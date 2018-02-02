/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.util;

class StringUtils
{
	/**
 	 * Returns value is a string type value.
 	 * with undefined or null value, false returned.
 	 */
 	public static function isString(value:Dynamic):Bool{
 		return Std.is(value , String);
 	}
 	
 	public static function castString(str:Dynamic):String{
 		return AsWingUtils.as(str , String);
 	}
 	
 	/**
 	 * replace oldString with newString in targetString
 	 */
 	public static function replace(targetString:String, oldString:String, newString:String):String{
 		return targetString.split(oldString).join(newString);
 	}
 	
 	/**
 	 * remove the blankspaces of left and right in targetString
 	 */
 	public static function trim(targetString:String):String{
 		return trimLeft(trimRight(targetString));
 	}
 	
 	/**
 	 * remove only the blankspace on targetString's left
 	 */
 	public static function trimLeft(targetString:String):String{
 		var tempIndex:Int= 0;
 		var tempChar:String= "";
 		for(i in 0 ...targetString.length ){
 			tempChar = targetString.charAt(i);
 			if(tempChar != " "){
 				tempIndex = i;
 				break;
 			}
 		}
 		return targetString.substr(tempIndex);
 	}
 	
 	/**
 	 * remove only the blankspace on targetString's right
 	 */
 	public static function trimRight(targetString:String):String{
 		var tempIndex:Int= targetString.length-1;
 		var tempChar:String= "";
 		for(i in 0...targetString.length  ){
 			tempChar = targetString.charAt(i);
 			if(tempChar != " "){
 				tempIndex = i;
 				break;
 			}
 		}
 		return targetString.substr(0 , tempIndex+1);
 	}
 	
 	public static function getCharsArray(targetString:String, hasBlankSpace:Bool):Array<Dynamic>{
 		var tempString:String= targetString;
		if(hasBlankSpace == false){
			tempString = trim(targetString);
		} 		
 		return tempString.split("");
 	}
 	
 	public static function startsWith(targetString:String, subString:String):Bool{
 		return (targetString.indexOf(subString) == 0);	
 	}

 	public static function endsWith(targetString:String, subString:String):Bool{
 		return (targetString.lastIndexOf(subString) == (targetString.length - subString.length));	
 	}
 	
 	public static function isLetter(chars:String):Bool{
 		if(chars == null || chars == ""){
 			return false;
 		}
 		for(i in 0...chars.length){
 			var code:Int= chars.charCodeAt(i);
 			if(code < 65 || code > 122 || (code > 90 && code < 97)){
 				return false;
 			}
 		}
 		return true;
 	}
}