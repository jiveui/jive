package jive.nativetools;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end


class NativeTools {

	public static var dpi(default, never): Int = 160;
	public static var scale(default, never): Float = 1; 
	
	
	public static function setStatusBarColor(color:Int) {
		
		trace("Include jive-nativetools extension.");
		
	}


	public static function showStatusBar() {
		
		trace("Include jive-nativetools extension.");
		
	}


	public static function getDPI() : Int {
		
		return dpi;
		
	}


	public static function getScale() : Float {
		
		return scale;
		
	}

}