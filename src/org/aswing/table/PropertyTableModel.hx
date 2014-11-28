package org.aswing.table;


import org.aswing.error.Error;
import org.aswing.ListModel;
import org.aswing.event.ListDataEvent;
import org.aswing.event.ListDataListener;
import org.aswing.AsWingUtils;
/**
 * The table model return the properties of a row to be column data.
 * <p>
 * PropertyTableModel is very conveniently to use when your table data can be stored in a list 
 * and each columns can be a property of a object of a row.
 * <br/>
 * For example, you can a data like this:<br/>
 * <pre>
 * data = 
 *  [{name:"paling", sex:1, age:26}, 
 *  {name:"Comeny", sex:0, age:24}, 
 *  {name:"Tom", sex:1, age:30},
 *  {name:"Lita", sex:0, age:16}
 *  ];
 * </pre>
 * Woool, it is very suit for PropertyTableModel to provide data to a JTable to view the datas.
 * You can create your JTable like this:
 * <pre>
 * var dataList:VectorListModel = new VectorListModel();
 * dataList.appendAll(data);
 * var tableModel:PropertyTableModel = new PropertyTableModel(
 * 		dataList, 
 * 		["Guy's Name", "Sex", "Age"], 
 * 		["name", "sex", "age"], 
 * 		[null, new SexTranslator(), null]
 * );
 * var table:JTable = new JTable(tableModel);
 * </pre>
 * Then the table will render a table for each object each properties like this.
 * <pre>
 * -------------------------------
 * | Guy's Name |  Sex   |  Age  | 
 * |------------------------------
 * | paling      |  male  |  26   | 
 * |------------------------------
 * | Comeny     | female |  24   | 
 * |------------------------------
 * | Tom        |  male  |  30   | 
 * |------------------------------
 * | Lita       | female |  16   | 
 * -------------------------------
 * </pre>
 * </p>
 * 
 * @author paling
 */
class PropertyTableModel extends AbstractTableModel  implements ListDataListener{
	
	private var list:ListModel;
	private var names:Array<Dynamic>;
	private var properties:Array<String>;
	private var translators:Array<Dynamic>;
	private var columnsEditable:Array<Dynamic>;
	
	/**
	 * Create a Property table model, column headers, properties names, and translators.
	 * @param listModel the list model that contains the row objects.
	 * @param names column header labels.
	 * @param properties property names for column values, "." means returns row data object directly.
	 * @param translators the translators for each column, a null translator for a columns means return the property 
	 * of that name directly. translator can be a PropertyTranslator instance or a Function(info:*, key:String):*
	 */
	public function new(listModel:ListModel, names:Array<Dynamic>, properties:Array<String>, translators:Array<Dynamic>){
		super();
		this.setList(listModel);
		this.names = names.copy();
		this.properties = properties.copy();
		this.translators = translators.copy();
		columnsEditable = new Array<Dynamic>();
	}
	
	/**
	 * Sets the row data provider, a list model.
	 * @param listModel the row object datas.
	 */
	public function setList(listModel:ListModel):Void{
		if(list != null){
			list.removeListDataListener(this);
		}
		list = listModel;
		if(list != null){
			list.addListDataListener(this);
		}
		fireTableDataChanged();
	}
	
	/**
	 * Returns the row data provider, a list model.
	 * @returns the row data provider.
	 */
	public function getList():ListModel{
		return list;
	}
	
	/**
	 * Return the properties.
	 * @see #PropertyTableModel
	 */
	public function getProperties():Array<Dynamic>{
		return properties.copy();
	}

	override public function getRowCount():Int{
		if(list!=null)	{
			return list.getSize();
		}else{
			return 0;
		}
	}

	override public function getColumnCount():Int{
		return names.length;
	}
	
	/**
	 * Returns the translated value for specified row and column.
	 * @return the translated value for specified row and column.
	 */
	override public function getValueAt(rowIndex:Int, columnIndex:Int):Dynamic{
		var translator:Dynamic= translators[columnIndex];
		var info:Dynamic =  list.getElementAt(rowIndex) ;
		var key:String= properties[columnIndex];
		if(translator != null){
			 if(Reflect.isFunction(translator)){
				return translator(info, key);
			}else if(Std.is(translator,PropertyTranslator)){
				return AsWingUtils.as(translator,PropertyTranslator).translate(info, key);
			}else{
				throw new Error("Translator must be a PropertyTranslator or a Function : " + translator);
			}
		}else{
			if(key == "."){
				return info;
			}
			//	Reflect.setField(info,key,aValue);
			return   Reflect.field(info,key);
		}
	}
	
	/**
	 * Returns the column name for specified column.
	 */
	override public function getColumnName(column:Int):String{
		return names[column];
	}
	
	/**
	 * Returns is the row column editable, default is true.
	 *
	 * @param   row			 the row whose value is to be queried
	 * @param   column		  the column whose value is to be queried
	 * @return				  is the row column editable, default is true.
	 * @see #setValueAt()
	 * @see #setCellEditable()
	 * @see #setAllCellEditable()
	 */
	override public function isCellEditable(row:Int, column:Int):Bool{
		if(columnsEditable[column] == null){
			return true;
		}else{
			return columnsEditable[column] == true;
		}
	}

	/**
	 * Returns is the column editable, default is true.
	 *
	 * @param   column		  the column whose value is to be queried
	 * @return				  is the column editable, default is true.
	 * @see #setValueAt()
	 * @see #setCellEditable()
	 * @see #setAllCellEditable()
	 */
	public function isColumnEditable(column:Int):Bool{
		return isCellEditable(0, column);
	}
	
	/**
	 * Sets spcecifed column editable or not.
	 * @param column the column whose value is to be queried
	 * @param editable editable or not
	 */
	public function setColumnEditable(column:Int, editable:Bool):Void{
		columnsEditable[column] = editable;
	}
	
	/**
	 * Sets all cells editable or not.
	 * @param editable editable or not
	 */
	public function setAllCellEditable(editable:Bool):Void{
		for(i in 0...getColumnCount() ){
			columnsEditable[i] = editable;
		}
	}
	
	override public function setValueAt(aValue:Dynamic, rowIndex:Int, columnIndex:Int):Void{
		var info: Dynamic =  list.getElementAt(rowIndex) ;
		var key:String = properties[columnIndex];
		Reflect.setField(info,key,aValue);
		fireTableCellUpdated(rowIndex, columnIndex);
	}
	
	//__________Listeners for List Model, to keep table view updated when row objects changed__________
	
	public function intervalAdded(e:ListDataEvent):Void{
		fireTableRowsInserted(e.getIndex0(), e.getIndex1());
	}

	public function intervalRemoved(e:ListDataEvent):Void{
		fireTableRowsDeleted(e.getIndex0(), e.getIndex1());
	}

	public function contentsChanged(e:ListDataEvent):Void{
		fireTableRowsUpdated(e.getIndex0(), e.getIndex1());
	}		
}