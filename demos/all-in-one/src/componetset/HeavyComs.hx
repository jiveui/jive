package componetset;
import org.aswing.border.LineBorder;
	import org.aswing.Box;
	import org.aswing.border.EmptyBorder;
	import componetset.SexIconCell;
	import org.aswing.DefaultListCell;
	import org.aswing.DefaultListCellFactory;
	import org.aswing.DefaultListTextCellFactory;
	import org.aswing.table.DefaultTableModel;
	import org.aswing.ASColor;
	import org.aswing.Component;
	import org.aswing.JTable;
	import org.aswing.JScrollPane;
	import org.aswing.border.TitledBorder;
	import org.aswing.BorderLayout;
	 
	import org.aswing.VectorListModel;
	import org.aswing.table.GeneralTableCellFactory;
	import org.aswing.JPanel;
	import org.aswing.DefaultComboBoxCellEditor;
	import org.aswing.JTree;
	import org.aswing.JList;
	import org.aswing.table.sorter.TableSorter;
	import componetset.IconListCell;
	import org.aswing.GeneralListCellFactory;
	import org.aswing.Insets;
	import org.aswing.table.PoorTextCell;
class HeavyComs extends JPanel{
	
	public function new(){
		super(new BorderLayout());
		name = "HeavyComponents";
		
		var list:Component = createList();
		
		var tree:JTree = new JTree();
		
		
		var top:Box = Box.createHorizontalBox(2);
		top.append(list);
		top.append(new JScrollPane(tree));
		top.setPreferredHeight(200);
		top.setBorder(new TitledBorder(null, "List and Tree"));
		
		append(top, BorderLayout.NORTH);
		
		var table:Component = createTable();
 
		table.setBorder(new TitledBorder(null, "Table(DataGrid)"));
		
		 append(table, BorderLayout.CENTER);
	}
	
	private function createList():Component{
		var arr:Array<Dynamic>= new Array<Dynamic>();
        var str:String= "A long String with many many many many A long String with many many many many many chars!!!";
        for(i in 0...60){
            var startI:Int=Std.int( Math.floor(Math.random()*40));
            var length:Int= Std.int( Math.floor(Math.random()*(str.length - startI)));
            arr.push(i + " " + str.substr(startI, length));
        }
        var listData:VectorListModel = new VectorListModel(arr); 
		// var list:JList = new JList(listData ,new DefaultListCellFactory(false)  ); 
        var list:JList = new JList(listData  , new GeneralListCellFactory(IconListCell, false, false));
        list.setBorder(new LineBorder(null, ASColor.RED, 3));
        return new JScrollPane(list);
	}
	
	private function createTable():Component{
		
		var data:Array<Array<Dynamic>>= [["iiley", 100, true, 23, 33, "the last"], 
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
		
		var sorter:TableSorter = new TableSorter(model);
		var table:JTable = new JTable(sorter);
		
		table.setRowHeight(22);
 
		sorter.setTableHeader(table.getTableHeader());
 
		sorter.setColumnSortable(4, false);
		sorter.setSortingStatus(3, TableSorter.ASCENDING);
	
		
		var combEditor:DefaultComboBoxCellEditor = new DefaultComboBoxCellEditor();
		combEditor.getComboBox().setListData(["Therion1", "Therion2", "Therion3", "Therion4"]);
		table.getColumn("name").setCellEditor(combEditor);
		table.getColumn("male").setCellFactory(new GeneralTableCellFactory(SexIconCell));
		table.setDefaultCellFactory("Object", new GeneralTableCellFactory(PoorTextCell));
		table.setBorder(new EmptyBorder(new LineBorder(null, ASColor.RED, 2), new Insets(5, 5, 5, 5)));
		table.setRowSelectionInterval(10, 13);
		table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF); 
		
		var scrollPane:JScrollPane = new JScrollPane(table); 

		return scrollPane;
	}
}
