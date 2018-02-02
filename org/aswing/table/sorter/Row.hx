/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.table.sorter;


import org.aswing.table.TableModel;

/**
 * @author paling
 */
class Row{
	
	public var modelIndex:Int;
	public var tableSorter:TableSorter;

    public function new(tableSorter:TableSorter, index:Int) {
    	this.tableSorter = tableSorter;
        this.modelIndex = index;
    }

    public function compareTo(o:Dynamic):Int{
        var row1:Int= modelIndex;
        var row2:Int= (AsWingUtils.as(o,Row)).modelIndex;
		var sortingColumns:Array<Dynamic>= tableSorter.getSortingColumns();
		var tableModel:TableModel = tableSorter.getTableModel();
        for (i in 0...sortingColumns.length){
            var directive:Directive = AsWingUtils.as(sortingColumns[i],Directive);
            var column:Int= directive.column;
            var o1:Dynamic= tableModel.getValueAt(row1, column);
            var o2:Dynamic= tableModel.getValueAt(row2, column);

            var comparison:Int= 0;
            // Define null less than everything, except null.
            if (o1 == null && o2 == null) {
                comparison = 0;
            } else if (o1 == null) {
                comparison = -1;
            } else if (o2 == null) {
                comparison = 1;
            } else {
            	var comparator:Dynamic ->Dynamic-> Int= tableSorter.getComparator(column);
                comparison = comparator(o1, o2);
            }
            if (comparison != 0) {
                return directive.direction == TableSorter.DESCENDING ? -comparison : comparison;
            }
        }
        return 0;
    }
    
    public function getModelIndex():Int{
    	return modelIndex;
    }
}