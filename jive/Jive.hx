package jive;

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
		return lime.system.System.getDisplay(0).dpi;
	}

	public static var scale(get, null): Float;
	private static function get_scale(): Float {
		return dpi / 96;
	}

	public static var atom(get, null): Int;
	private static function get_atom(): Int {
		return Std.int(15 * scale);
	}
}