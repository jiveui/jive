package org.aswing.plaf;

import org.aswing.JSplitPane;
	/**
 * Pluggable look and feel interface for JSplitPane.
 * @author paling
 */
class SplitPaneUI extends BaseComponentUI
{
	public function new() {
		super();
	}

    /**
     * Messaged to relayout the JSplitPane based on the preferred size
     * of the children components.
     */
    public function resetToPreferredSizes(jc:JSplitPane):Void{
    	trace("Subclass need to override this method!");
    }	
	
}