/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf;


import org.aswing.JTable;
import org.aswing.geom.IntDimension;

/**
 * Pluginable ui for JTable.
 * @see org.aswing.JTable
 * @author paling
 */
interface TableUI extends ComponentUI{
	
    /**
     * Returns the view size.
     */    
	function getViewSize(table:JTable):IntDimension;
}