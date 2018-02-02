package org.aswing.tree;
 
/*
 Copyright aswing.org, see the LICENCE.txt.
*/

import org.aswing.tree.DefaultTreeSelectionModel;

/**
 * <code>EmptySelectionModel</code> is a <code>TreeSelectionModel</code>
 * that does not allow anything to be selected.
 * @author paling
 */
class EmptySelectionModel extends DefaultTreeSelectionModel {
	
	public function new() {
		super();
	}

    /** Unique shared instance. */
    private static var _sharedInstance:EmptySelectionModel;

    /** Returns a shared instance of an empty selection model. */
    public static function sharedInstance():EmptySelectionModel {
    	if(_sharedInstance == null){
    		_sharedInstance = new EmptySelectionModel();
    	}
        return _sharedInstance;
    }

    /** A <code>null</code> implementation that selects nothing. */
    override public function setSelectionPaths(pPaths:Array<Dynamic>, programmatic:Bool=true):Void{}
    /** A <code>null</code> implementation that adds nothing. */
    override public function addSelectionPaths(pPaths:Array<Dynamic>, programmatic:Bool=true):Void{}
    /** A <code>null</code> implementation that removes nothing. */
    override public function removeSelectionPaths(pPaths:Array<Dynamic>, programmatic:Bool=true):Void{}
}