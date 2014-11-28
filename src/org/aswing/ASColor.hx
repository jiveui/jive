/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


/**
 * ASColor object to set color and alpha for a movieclip.
 * @author firdosh, paling, n0rthwood
 */
class ASColor{
			
	public static var WHITE:ASColor = new ASColor(0xffffff);
	
	public static var LIGHT_GRAY:ASColor = new ASColor(0xc0c0c0);
	
	public static var GRAY:ASColor = new ASColor(0x808080);
	
	public static var DARK_GRAY:ASColor = new ASColor(0x404040);
	
	public static var BLACK:ASColor = new ASColor(0x000000);
	
	public static var RED:ASColor = new ASColor(0xff0000);
	
	public static var PINK:ASColor = new ASColor(0xffafaf);
	
	public static var ORANGE:ASColor = new ASColor(0xffc800);
	
	public static var HALO_ORANGE:ASColor = new ASColor(0xFFC200);
	
	public static var YELLOW:ASColor = new ASColor(0xffff00);
	
	public static var GREEN:ASColor = new ASColor(0x00ff00);
	
	public static var HALO_GREEN:ASColor = new ASColor(0x80FF4D);
	
	public static var MAGENTA:ASColor = new ASColor(0xff00ff);
	
	public static var CYAN:ASColor = new ASColor(0x00ffff);
	
	public static var BLUE:ASColor = new ASColor(0x0000ff);
	
	public static var HALO_BLUE:ASColor = new ASColor(0x2BF5F5);
	
	
	private var _rgb:Int;
	private var _alpha:Float;
	
	private var hue:Float;
	private var luminance:Float;
	private var saturation:Float;
	private var hlsCounted:Bool;

	public var rgb(get,set):Int;
	private function get_rgb(): Int { return _rgb; }
	private function set_rgb(v: Int): Int { _rgb = v; hlsCounted = false; return v; }

	public var alpha(get,set):Float;
	private function get_alpha(): Float { return _alpha; }
	private function set_alpha(v: Float): Float { _alpha = v; return v; }

	/**
	 * Create a ASColor
	 */
	public function new(rgb:Int=0x000000, ?alpha:Float=1){
		this._rgb = rgb;
		this._alpha = Math.min(1, Math.max(0, alpha));
		hlsCounted = false;
	}
	
	/**
	 * Returns the alpha component in the range 0-1.
	 */
	public function getAlpha():Float{
		return _alpha;
	}
	
	/**
	 * Returns the RGB value representing the color.
	 */
	public function getRGB():Int{
		return _rgb;
	}
	
	/**
	 * Returns the ARGB value representing the color.
	 */	
	public function getARGB():Int{
		var a:Int= Std.int(_alpha*255);
		return _rgb | (a << 24);
	}
	
	/**
     * Returns the red component in the range 0-255.
     * @return the red component.
     */
	public function getRed():Int{
		return (_rgb & 0x00FF0000) >> 16;
	}
	
	/**
     * Returns the green component in the range 0-255.
     * @return the green component.
     */	
	public function getGreen():Int{
		return (_rgb & 0x0000FF00) >> 8;
	}
	
	/**
     * Returns the blue component in the range 0-255.
     * @return the blue component.
     */	
	public function getBlue():Int{
		return (_rgb & 0x000000FF);
	}
	
	/**
     * Returns the hue component in the range [0, 1].
     * @return the hue component.
     */
	public function getHue():Float{
		countHLS();
		return hue;
	}
	
	
	/**
     * Returns the luminance component in the range [0, 1].
     * @return the luminance component.
     */
	public function getLuminance():Float{
		countHLS();
		return luminance;
	}
	
	
	/**
     * Returns the saturation component in the range [0, 1].
     * @return the saturation component.
     */
	public function getSaturation():Float{
		countHLS();
		return saturation;
	}
	
	private function countHLS():Void{
		if(hlsCounted)	{
			return;
		}
		hlsCounted = true;
		var rr:Float= getRed() / 255.0;
		var gg:Float= getGreen() / 255.0;
		var bb:Float= getBlue() / 255.0;
		
		var rnorm:Float, gnorm:Float, bnorm:Float;
		var minval:Float, maxval:Float, msum:Float, mdiff:Float;
		var r:Float, g:Float, b:Float;
		   
		r = g = b = 0;
		if (rr > 0) r = rr; if (r > 1) r = 1;
		if (gg > 0) g = gg; if (g > 1) g = 1;
		if (bb > 0) b = bb; if (b > 1) b = 1;
		
		minval = r;
		if (g < minval) minval = g;
		if (b < minval) minval = b;
		maxval = r;
		if (g > maxval) maxval = g;
		if (b > maxval) maxval = b;
		
		rnorm = gnorm = bnorm = 0;
		mdiff = maxval - minval;
		msum  = maxval + minval;
		luminance = 0.5 * msum;
		if (maxval != minval) {
			rnorm = (maxval - r)/mdiff;
			gnorm = (maxval - g)/mdiff;
			bnorm = (maxval - b)/mdiff;
		} else {
			saturation = hue = 0;
			return;
		}
		
		if (luminance < 0.5)
		  saturation = mdiff/msum;
		else
		  saturation = mdiff/(2.0 - msum);
		
		if (r == maxval)
		  hue = 60.0 * (6.0 + bnorm - gnorm);
		else if (g == maxval)
		  hue = 60.0 * (2.0 + rnorm - bnorm);
		else
		  hue = 60.0 * (4.0 + gnorm - rnorm);
		
		if (hue > 360)
			hue = hue - 360;
		hue /= 360;
	}	
	
	/**
	 * Create a new <code>ASColor</code> with another alpha but same rgb.
	 * @param newAlpha the new alpha
	 * @return the new <code>ASColor</code>
	 */
	public function changeAlpha(newAlpha:Float):ASColor{
		return new ASColor(getRGB(), newAlpha);
	}
	
	/**
	 * Create a new <code>ASColor</code> with just change hue channel value.
	 * @param newHue the new hue value
	 * @return the new <code>ASColor</code>
	 */	
	public function changeHue(newHue:Float):ASColor{
		return getASColorWithHLS(newHue, getLuminance(), getSaturation(), getAlpha());
	}
	
	/**
	 * Create a new <code>ASColor</code> with just change luminance channel value.
	 * @param newLuminance the new luminance value
	 * @return the new <code>ASColor</code>
	 */	
	public function changeLuminance(newLuminance:Float):ASColor{
		return getASColorWithHLS(getHue(), newLuminance, getSaturation(), getAlpha());
	}
	
	/**
	 * Create a new <code>ASColor</code> with just change saturation channel value.
	 * @param newSaturation the new saturation value
	 * @return the new <code>ASColor</code>
	 */	
	public function changeSaturation(newSaturation:Float):ASColor{
		return getASColorWithHLS(getHue(), getLuminance(), newSaturation, getAlpha());
	}
	
	/**
	 * Create a new <code>ASColor</code> with just scale the hue luminace and saturation channel values.
	 * @param hScale scale for hue
	 * @param lScale scale for luminance
	 * @param sScale scale for saturation
	 * @return the new <code>ASColor</code> scaled
	 */
	public function scaleHLS(hScale:Float, lScale:Float, sScale:Float):ASColor{
		var h:Float= getHue() * hScale;
		var l:Float= getLuminance() * lScale;
		var s:Float= getSaturation() * sScale;
		return getASColorWithHLS(h, l, s, _alpha);
	}
	
	/**
	 * Create a new <code>ASColor</code> with just offset the hue luminace and saturation channel values.
	 * @param hOffset offset for hue
	 * @param lOffset offset for luminance
	 * @param sOffset offset for saturation
	 * @return the new <code>ASColor</code> offseted
	 */
	public function offsetHLS(hOffset:Float, lOffset:Float, sOffset:Float):ASColor{
		var h:Float= getHue() + hOffset;
		if(h > 1) h -= 1;
		if(h < 0) h += 1;
		var l:Float= getLuminance() + lOffset;
		var s:Float= getSaturation() + sOffset;
		return getASColorWithHLS(h, l, s, _alpha);
	}	
	
    /**
     * Creates a new <code>ASColor</code> that is a darker version of this
     * <code>ASColor</code>.
     * @param factor the darker factor(0, 1), default is 0.7
     * @return     a new <code>ASColor</code> object that is  
     *                 a darker version of this <code>ASColor</code>.
     * @see        #brighter()
     */		
	public function darker(factor:Float=0.7):ASColor{
        var r:Int= getRed();
        var g:Int= getGreen();
        var b:Int= getBlue();
		return getASColor(Std.int(r*factor),Std.int( g*factor), Std.int(b*factor), _alpha);
	}
	
    /**
     * Creates a new <code>ASColor</code> that is a brighter version of this
     * <code>ASColor</code>.
     * @param factor the birghter factor 0 to 1, default is 0.7
     * @return     a new <code>ASColor</code> object that is  
     *                 a brighter version of this <code>ASColor</code>.
     * @see        #darker()
     */	
	public function brighter(factor:Float=0.7):ASColor{
        var r:Float= getRed();
        var g:Float= getGreen();
        var b:Float= getBlue();

        /* From 2D group:
         * 1. black.brighter() should return grey
         * 2. applying brighter to blue will always return blue, brighter
         * 3. non pure color (non zero rgb) will eventually return white
         */
        var i:Float= Math.floor(1.0/(1.0-factor));
        if ( r == 0 && g == 0 && b == 0) {
           return getASColor(Std.int(i), Std.int(i), Std.int(i), _alpha);
        }
        if ( r > 0 && r < i ) r = i;
        if ( g > 0 && g < i ) g = i;
        if ( b > 0 && b < i ) b = i;
        
        return getASColor(Std.int(r/factor), Std.int(g/factor), Std.int(b/factor), _alpha);
	}
	
	/**
	 * Returns a ASColor with the specified red, green, blue values in the range [0 - 255] 
	 * and alpha value in range[0, 1]. 
	 * @param r red channel
	 * @param g green channel
	 * @param b blue channel
	 * @param a alpha channel
	 */
	public static function getASColor(r:Int, g:Int, b:Int, a:Float=1):ASColor{
		return new ASColor(getRGBWith(r, g, b), a);
	}
	
	/**
	 * Returns a ASColor with specified ARGB uint value.
	 * @param argb ARGB value representing the color
	 * @return the ASColor
	 */
	public static function getWithARGB(argb:Int):ASColor{
		var rgb:Int= argb & 0x00FFFFFF;
		var alpha:Float= (argb >>> 24)/255;
		return new ASColor(rgb, alpha);
	}
	
	/**
	 * Returns a ASColor with with the specified hue, luminance, 
	 * saturation and alpha values in the range [0 - 1]. 
	 * @param h hue channel
	 * @param l luminance channel
	 * @param s saturation channel
	 * @param a alpha channel
	 */	
	public static function getASColorWithHLS(h:Float, l:Float, s:Float, a:Float=1):ASColor{
		var c:ASColor = new ASColor(0, a);
		c.hlsCounted = true;
		c.hue = Math.max(0, Math.min(1, h));
		c.luminance = Math.max(0, Math.min(1, l));
		c.saturation = Math.max(0, Math.min(1, s));
		
		var H:Float= c.hue;
		var L:Float= c.luminance;
		var S:Float= c.saturation;
		
		var p1:Float, p2:Float, r:Float, g:Float, b:Float;
		p1 = p2 = 0;
		H = H*360;
		if(L<0.5){
			p2=L*(1+S);
		}else{
			p2=L + S - L*S;
		}
		p1=2*L-p2;
		if(S==0){
			r=L;
			g=L;
			b=L;
		}else{
			r = hlsValue(p1, p2, H+120);
			g = hlsValue(p1, p2, H);
			b = hlsValue(p1, p2, H-120);
		}
		r *= 255;
		g *= 255;
		b *= 255;
		var color_n:Float= (Std.int(r)<<16) + (Std.int(g)<<8) +b;
		var color_rgb:Int= Std.int(Math.max(0, Math.min(0xFFFFFF, Math.round(color_n))));
		c._rgb = color_rgb;
		return c;
	}
	
	private static function hlsValue(p1:Float, p2:Float, h:Float):Float{
	   if (h > 360) h = h - 360;
	   if (h < 0)   h = h + 360;
	   if (h < 60 ) return p1 + (p2-p1)*h/60;
	   if (h < 180) return p2;
	   if (h < 240) return p1 + (p2-p1)*(240-h)/60;
	   return p1;
	}	
		
	/**
	 * Returns the RGB value representing the red, green, and blue values. 
	 * @param rr red channel
	 * @param gg green channel
	 * @param bb blue channel
	 */
	public static function getRGBWith(rr:Int, gg:Int, bb:Int):Int{
		var r:Int= rr;
		var g:Int= gg;
		var b:Int= bb;
		if(r > 255){
			r = 255;
		}
		if(g > 255){
			g = 255;
		}
		if(b > 255){
			b = 255;
		}
		var color_n:Int= (r<<16) + (g<<8) +b;
		return color_n;
	}
	
	public function toString():String{
		return "ASColor(rgb:"+StringTools.hex(_rgb)+", alpha:"+_alpha+")";
	}

	/**
	 * Compare if compareTo object has the same value as this ASColor object does
	 * @param compareTo the object to compare with
	 * 
	 * @return  a Boolean value that indicates if the compareTo object's value is the same as this one
	 */	
	public function equals(o:Dynamic):Bool{
		var c:ASColor = AsWingUtils.as(o,ASColor)	;
		if(c != null){
			return c._alpha == _alpha && c._rgb == _rgb;
		}else{
			return false;
		}
	}
	
	/**
	 * Clone a ASColor, most time you dont need to call this because ASColor 
	 * is un-mutable class, but to avoid UIResource, you can call this.
	 */
	public function clone():ASColor{
		return new ASColor(getRGB(), getAlpha());
	}
}