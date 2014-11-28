package org.aswing;


/**
 * The class for a result of a main color adjusted by a adjuster.
 */
class StyleResult{

	/**
	 * Content light color
	 */
	public var clight:ASColor;
	/**
	 * Content dark color
	 */	
	public var cdark:ASColor;
	/**
	 * Border light color
	 */		
	public var blight:ASColor;
	/**
	 * Border dark color
	 */		
	public var bdark:ASColor;
	/**
	 * Shadow color alpha
	 */
	public var shadow:Float;
	/**
	 * The round rect radius
	 */
	public var round:Float;
	
	public function new(mainColor:ASColor, tune:StyleTune){
		clight = tune.getCLight(mainColor);
		cdark  = tune.getCDark(mainColor);
		blight = tune.getBLight(mainColor);
		bdark  = tune.getBDark(mainColor);
		shadow = tune.getShadowAlpha();
		round  = tune.round;
	}

}