package cases;

	
import flash.events.Event;
import flash.display.Sprite;
import cases.table.SexIconCell;

class Table extends Sprite{
	
	private var frame:JFrame;
	private var table:JTable;
	private static var timer:Timer;
	
	public function new(){
		super();
		
		frame = new JFrame(null, "TableTest");
		
		var data:Array<Dynamic>= [["iiley", 100, true, 23, 33, "the last"], 
		  ["I dont know who", -12, false, 13, 33, "the last"],
		  ["A little cute girl", 98765, false, 0, 33, "the last2"], 
		  ["Therion1", 99, true, 23, 33, "the last3"],
		  ["Therion2", 99, true, 63, 33, "the last4"],
		  ["Therion3", 99, true, 23, 33, "the last5"],
		  ["Therion4", 99, true, 23, 33, "the last5"]];
		for(i in 0...100){
			data.push(["other"+i, i, Math.random()<0.5, 13, 323, i+"last"]);
		}
		var column:Array<Dynamic>= ["name", "score", "male", "number", "number", "last"];
		
		var model:DefaultTableModel = (new DefaultTableModel()).initWithDataNames(data, column);
		model.setColumnClass(1, "Number");
		model.setColumnClass(2, "Boolean");
		table = new JTable(model);
//		table.setShowHorizontalLines(false);
//		table.setShowVerticalLines(false);
//		table.setIntercellSpacing(new Dimension(0, 0));
		//table.setColumnSelectionAllowed(true);
		//model.setAllCellEditable(false);
		
		var combEditor:DefaultComboBoxCellEditor = new DefaultComboBoxCellEditor();
		combEditor.getComboBox().setListData(["Therion1", "Therion2", "Therion3", "Therion4"]);
		table.getColumn("name").setCellEditor(combEditor);
		table.getColumn("male").setCellFactory(new GeneralTableCellFactory(SexIconCell));
		table.setDefaultCellFactory("Object", new GeneralTableCellFactory(PoorTextCell));
		table.setBorder(new EmptyBorder(new LineBorder(null, ASColor.RED, 2), new Insets(5, 5, 5, 5)));
		table.setRowSelectionInterval(10, 13);
		table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
		var scrollPane:JScrollPane = new JScrollPane(table); 
		
		frame.getContentPane().append(scrollPane, BorderLayout.CENTER);
		var button:JButton = new JButton("Change Table AutoResizeMode");
		button.addActionListener(__changeAutoResizeMode);
		frame.getContentPane().append(button, BorderLayout.SOUTH);
		
		frame.setSizeWH(400, 450);
		frame.show();
	}
	
	
	private function __changeAutoResizeMode(e:Event):Void{
		if(table.getAutoResizeMode() == JTable.AUTO_RESIZE_ALL_COLUMNS){
			table.setAutoResizeMode(JTable.AUTO_RESIZE_LAST_COLUMN);
			
		}else if(table.getAutoResizeMode() == JTable.AUTO_RESIZE_LAST_COLUMN){
			table.setAutoResizeMode(JTable.AUTO_RESIZE_NEXT_COLUMN);
			
		}else if(table.getAutoResizeMode() == JTable.AUTO_RESIZE_NEXT_COLUMN){
			table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
			
		}else if(table.getAutoResizeMode() == JTable.AUTO_RESIZE_OFF){
			table.setAutoResizeMode(JTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
		}else{
			table.setAutoResizeMode(JTable.AUTO_RESIZE_ALL_COLUMNS);
		}
		frame.setTitle("resize mode changed " + Math.random());
	}
	
}