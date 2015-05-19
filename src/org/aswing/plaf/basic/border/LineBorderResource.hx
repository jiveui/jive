/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.border;


import org.aswing.border.LineBorder;
import org.aswing.Insets;
import org.aswing.Border;
import org.aswing.plaf.UIResource;
import org.aswing.border.EmptyBorder;

class LineBorderResource extends LineBorder implements UIResource{
	
	public function new(interior:Border=null, color:ASColor=null, thickness:Float=1, round:Float=0){
		super(interior, color, thickness, round);
	}
	
}