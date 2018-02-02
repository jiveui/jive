/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event;
 

/**
 * TableModelListener defines the interface for an object that listens
 * to changes in a TableModel.
 * @author paling
 */
interface TableModelListener {
    /**
     * This fine grain notification tells listeners the exact range
     * of cells, rows, or columns that changed.
     */
    function tableChanged(e:TableModelEvent):Void;
}