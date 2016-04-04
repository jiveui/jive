package cases.table;

import flash.display.Sprite;
class TableDemo extends Sprite
{
	public function new()
	{
		super();
		initDemo();
	}
	
	
	private var tableModel:DefaultTableModel;
	private var sortableTable:JTable;
	private var unsortableTable:JTable;
	private var frame:JFrame;
	
	private function initDemo():Void{
		frame = new JFrame(null, "TableDemo -- one model two view - MVC test");
		//*****************************************************************
		//                       Init Data
		var bands:Array<Dynamic>= ["Stoa", "Empyruim", "Therion", "Radiohead", "The Czars"];
		var data:Array<Dynamic>= [["iiley", 25, true, bands[1]], 
		  ["Igor", 27, true, bands[0]],
		  ["Firdosh", 24, true, bands[3]], 
		  ["Guy", 27, true, bands[2]],
		  ["Tomato", 24, true, bands[4]],
		  ["Some one A", 18, false, bands[4]],
		  ["Some one B", 18, false, bands[4]]];
		for(i in 0...20){
			data.push(["Some one"+i, 
						20+i, 
						Math.random()<0.5, 
						bands[Math.floor(Math.random()*bands.length)]]);
		}
		var column:Array<Dynamic>= ["Name", "Age", "Male", "Favorite Band"];		
		
		tableModel = (new DefaultTableModel()).initWithDataNames(data, column);
		tableModel.setColumnClass(1, "Number");
		tableModel.setColumnClass(2, "Boolean");
		tableModel.setColumnEditable(0, false);
		//                       End of Init Data
		//*****************************************************************	
		
		unsortableTable = new JTable(tableModel);
		unsortableTable.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
		
		//*****************************************************************
		//                       Sortable Making
		var sorter:TableSorter = new TableSorter(tableModel);
		sortableTable = new JTable(sorter);
		sorter.setTableHeader(sortableTable.getTableHeader());
		sorter.setColumnSortable(1, false);
		sorter.setSortingStatus(3, TableSorter.ASCENDING);
		//                       End of Sortable Making
		//*****************************************************************	
		
		//set comboBox editor
		var combEditor:DefaultComboBoxCellEditor = new DefaultComboBoxCellEditor();
		combEditor.getComboBox().setListData(bands);
		unsortableTable.getColumn("Favorite Band").setCellEditor(combEditor);
		sortableTable.getColumn("Favorite Band").setCellEditor(combEditor);
		
		//set sex icon renderer
		sortableTable.getColumnAt(2).setCellFactory(new GeneralTableCellFactory(SexIconCell));
		
		var pane:Container = Box.createVerticalBox(0);
		var topPane:JScrollPane = new JScrollPane(unsortableTable);
		topPane.setBorder(new TitledBorder(null, "Unsortable Table"));
		var bottomPane:JScrollPane = new JScrollPane(sortableTable);
		bottomPane.setBorder(new TitledBorder(null, "Sortable Table"));	
		pane.append(topPane);
		pane.append(bottomPane);
		pane.append(new JButton("JButton"));
		frame.setContentPane(pane);
		frame.setClosable(false);
		frame.setLocationXY(50, 50);
		frame.setSizeWH(400, 400);
		frame.show();
	}
}