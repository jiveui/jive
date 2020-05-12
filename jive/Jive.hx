package jive;

import haxe.CallStack;
import org.aswing.AsWingManager;
import openfl.Lib;

class Jive {
	public static function init() {
		AsWingManager.initAsStandard(Lib.current, false);
	}

	public static var useMobileTheme(get, null): Bool;
	private static function get_useMobileTheme(): Bool {
		#if (jive_pseudo_mobile || ios || android)
		return true;
		#else
		return false;
		#end
	}

	public static var dpi(get, null): Float;
	private static function get_dpi(): Float {
		var display = lime.system.System.getDisplay(0);
		if (null == display) {
            trace(CallStack.toString(CallStack.callStack()));
			throw "Jive.dpi is called before putting the app on a display.";
		}

		//hack
		var iPadMini = Lambda.fold(
			["iPad4,4", "iPad4,5", "iPad4,6", "iPad4,7", "iPad4,8", "iPad4,9", "iPad5,1", "iPad5,2"],
			function(s, r) {
				var m = lime.system.System.deviceModel;
				return r || (m != null && m.indexOf(s) >= 0);
			},
			false
		);

		return if (iPadMini) 326 else display.dpi;

	}

	private static var _scale: Null<Float>;
	public static var scale(get, null): Float;
	private static function get_scale(): Float {
		if (_scale == null) {
			#if jive_pseudo_mobile
			_scale = 1.0;
			#elseif mobile
			_scale = Math.fceil(dpi / 163);
			#else
			_scale = dpi / 123;
			#end
		}
		return _scale;
	}

	public static function toPixelSize(v: Int): Int {
		return Std.int(v * scale);
	}

	public static var atom(get, null): Int;
	private static function get_atom(): Int {
		return Std.int(15.0 * scale);
	}
}