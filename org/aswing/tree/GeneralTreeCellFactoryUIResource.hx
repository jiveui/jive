/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;
 

import org.aswing.plaf.UIResource;
import org.aswing.tree.GeneralTreeCellFactory;

/**
 * @author paling
 */
class GeneralTreeCellFactoryUIResource extends GeneralTreeCellFactory  implements UIResource{
	
	public function new(cellClass :Class<Dynamic>) {
		super(cellClass);
	}

}