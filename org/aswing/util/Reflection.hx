/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.util;

	 
import flash.Lib;
//import flash.system.ApplicationDomain;
import flash.display.DisplayObject;

class Reflection{
	
	public static function createDisplayObjectInstance(fullClassName:String, applicationDomain:Dynamic=null):DisplayObject{
		return AsWingUtils.as(createInstance(fullClassName, applicationDomain) ,DisplayObject);
	}
	
	public static function createInstance(fullClassName:String, applicationDomain:Dynamic=null):Dynamic{
		var assetClass: Class<Dynamic> = Type.resolveClass(fullClassName);
		if(assetClass != null){
			return Type.createInstance(assetClass,[]);
		}
		return null;		
	}
	
	public static function getClass(fullClassName:String, applicationDomain:Dynamic=null):Class<Dynamic>{
		if(applicationDomain == null){
			//applicationDomain = ApplicationDomain.currentDomain;
		}
		var assetClass:Class<Dynamic> = null;
		//assetClass=AsWingUtils.as(applicationDomain.getDefinition(fullClassName), Class) ;
		return assetClass;		
	}
	
	public static function getFullClassName(o:Dynamic):String{
		return Type.getClassName(o);
	}
	
	public static function getClassName(x:Dynamic):String{
		if (Std.is(x, Class))
		{
			var s = Type.getClassName(x);
			return s.substr(s.lastIndexOf('.') + 1);
		}
		else
		if (Type.getClass(x) != null)
			return getClassName(Type.getClass(x));
		else
			return '';
	}
	
	public static function getPackageName(x:Dynamic):String
	{
		if (Std.is(x, String))
		{
			var s:String = x;
			var i = s.lastIndexOf('.');
			if (i != -1)
				return s.substr(0, i);
			else
				return '';
		}
		else
		if (Std.is(x, Class))
		{
			var s = Type.getClassName(x);
			var i = s.lastIndexOf('.');
			if (i != -1)
				return s.substr(0, i);
			else
				return '';
		}
		else
		if (Type.getClass(x) != null)
			return getPackageName(Type.getClass(x));
		else
			throw "invalid argument";
	}
}