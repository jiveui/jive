package org.aswing.plaf;


import org.aswing.StyleTune;

/**
 * StyleTune UIResource
 */
class UIStyleTune extends StyleTune  implements UIResource{
	
	/**
	 * Create a StyleTune with specified params
	 * @param cg gradient brightness range of content color
	 * @param bo birightness offset for border color
	 * @param bg gradient brightness range of border color
	 * @param sa shadow alpha
	 * @param ma the adjuster for mideground color, null means use this(StyleTune)
	 */
	public function new(cg:Float=0.2, bo:Float=0.15, bg:Float=0.35, sa:Float=0.2, r:Float=0, ma:UIStyleTune=null){
		super(cg, bo, bg, sa, r, ma);
	}
}