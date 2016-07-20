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
	
	
	public static function setStatusBarColor(color:Int) {
		
		trace("Include jive-nativetools extension.");
		
	}


	public static function showStatusBar() {
		
		trace("Include jive-nativetools extension.");
		
	}


	public static function getDPI() : Int {
		
		return 160;
		
	}


	public static function getScale() : Float {
		
		return 1.0;
		
	}

}