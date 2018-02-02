/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.border;

import org.aswing.Insets;
	import org.aswing.border.EmptyBorder;
	import org.aswing.plaf.UIResource;

/**
 * @private
 */
class ColorChooserBorder extends EmptyBorder  implements UIResource{

	public function new(){
		super(null, new Insets(6, 6, 6, 6));
	}

}