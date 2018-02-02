package org.aswing.table;



/**
 * Property translator, it return the value of a specified property name. 
 * Some property need translate, not directly return the real value, For example a int 
 * value for sex, 0 means female, 1 means male, then your can implement your property translator 
 * like this:
 * <pre>
 * public function translate(info:Object, key:String):*{
 * 		var sex:int = info[key];
 * 		if(sex == 0){
 * 			return "female";
 * 		}else if(sex == 1){
 * 			return "male";
 * 		}else{
 * 			return "no-sex";
 * 		}
 * }
 * </pre> 
 * @author paling
 */
interface PropertyTranslator{
	
	function translate(info:Dynamic, key:String):Dynamic;
	
}