/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;


/**
 * The event for list model.
 * @see org.aswing.JList
 * @see org.aswing.ListModel
 * @see org.aswing.event.ListDataListener
 * @author paling
 */
class ListDataEvent extends ModelEvent{

    private var index0:Int;
    private var index1:Int;
    private var removedItems:Array<Dynamic>;

    /**
     * Returns the lower index of the range. For a single
     * element, this value is the same as that returned by {@link #getIndex1}.
     * @return an int representing the lower index value
     */
    public function getIndex0():Int{ return index0; }
    
    /**
     * Returns the upper index of the range. For a single
     * element, this value is the same as that returned by {@link #getIndex0}.
     * @return an int representing the upper index value
     */
    public function getIndex1():Int{ return index1; }
    
	/**
	 * Returns the removed items, it is null or empty array when this is not a removed event.
	 * @return a array that contains the removed items
	 */
	public function getRemovedItems():Array<Dynamic>{ return removedItems.copy(); }
	
    /**
     * Constructs a ListDataEvent object.
     *
     * @param source  the source Object (typically <code>this</code>)
     * @param index0  an int specifying the bottom of a range
     * @param index1  an int specifying the top of a range
     * @param removedItems (optional) the items has been removed.
     */
	public function new(source:Dynamic, index0:Int, index1:Int, removedItems:Array<Dynamic>){
		super(source);
		this.index0 = index0;
		this.index1 = index1;
		this.removedItems  = removedItems.copy();
	}
	
}