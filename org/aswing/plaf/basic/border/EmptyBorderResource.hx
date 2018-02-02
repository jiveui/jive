/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.border;


import org.aswing.Insets;
import org.aswing.Border;
import org.aswing.plaf.UIResource;
import org.aswing.border.EmptyBorder;

class EmptyBorderResource extends EmptyBorder  implements UIResource{
	
	public function new(interior:Border=null, margin:Insets=null){
		super(interior, margin);
	}
	
}