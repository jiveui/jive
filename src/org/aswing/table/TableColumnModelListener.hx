/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table;


import org.aswing.table.TableColumnModel;
import org.aswing.table.TableColumnModelEvent;

/**
 * TableColumnModelListener defines the interface for an object that listens
 * to changes in a TableColumnModel.
 * 
 * @author paling
 */
interface TableColumnModelListener{

    /** Tells listeners that a column was added to the model. */
    function columnAdded(e:TableColumnModelEvent):Void;

    /** Tells listeners that a column was removed from the model. */
    function columnRemoved(e:TableColumnModelEvent):Void;

    /** Tells listeners that a column was repositioned. */
    function columnMoved(e:TableColumnModelEvent):Void;

    /** Tells listeners that a column was moved due to a margin change. */
    function columnMarginChanged(source:TableColumnModel):Void;

    /**
     * Tells listeners that the selection model of the
     * TableColumnModel changed.
     */
    function columnSelectionChanged(source:TableColumnModel, firstIndex:Int, lastIndex:Int, programmatic:Bool):Void;
}