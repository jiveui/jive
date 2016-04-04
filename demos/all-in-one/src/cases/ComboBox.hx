package cases;

	
import flash.display.Sprite;
import org.aswing.geom.IntDimension;
import flash.events.Event;

class ComboBox extends Sprite{
	
	private var frame:JFrame;
	private var box:JComboBox;
	private var statusText:JTextField;
	private var inputText:JTextField;
	private var model:VectorListModel;
	
	public function new(){
		super();
		
		frame = new JFrame(null, "ComboBoxTest");
		frame.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
		
		var listData:Array<Dynamic>= ["11111111111111",
								"22222222222222222",
								"3333333333333333",
								"44444444444444444---------5555555555555555",
								"55555555555555555",
								"666666666666666",
								"22222222222222222",
								"3333333333333333",
								"44444444444444444",
								"55555555555555555"];
		model = new VectorListModel(listData);
		
		box = new JComboBox(model);
		box.setName("box");
		box.setPreferredWidth(200);
		box.setEditable(true);
		box.setMaximumRowCount(10);
		box.setSelectedIndex(0);
		box.addActionListener(__comboBoxActed);
		
		var pane:JPanel = new JPanel();
		pane.append(box);
		
		var box2:JComboBox = new JComboBox(model);
		box2.setName("box2");
		box2.setPreferredWidth(150);
		box2.setMaximumRowCount(3);
		box2.setSelectedIndex(9);
		box2.addActionListener(__comboBoxActed);
		pane.append(box2);
		
		var box3:JComboBox = new JComboBox(model);
		box3.setName("box3");
		box3.setPreferredWidth(150);
		box3.setMaximumRowCount(3);
		box3.setSelectedIndex(9);
		box3.setEnabled(false);
		box3.addActionListener(__comboBoxActed);
		pane.append(box3);
		
		frame.getContentPane().append(pane, BorderLayout.NORTH);
		
		inputText = new JTextField("", 10);
		var button:JButton = new JButton("Add Item");
		button.addActionListener(__addItem);
		pane = new JPanel();
		pane.append(inputText);
		pane.append(button);
		frame.getContentPane().append(pane, BorderLayout.CENTER);
		
		statusText = new JTextField();
		frame.getContentPane().append(statusText, BorderLayout.SOUTH);
		
		frame.setComBoundsXYWH(10, 10, 400, 200);
		frame.show();
	}
	
	private function __comboBoxActed(e:Event):Void{
		var box:JComboBox = flash.Lib.as(e.target,JComboBox)	;
		statusText.setText(box.getName() + " selected : " + box.getSelectedItem());
	}
	
	private function __addItem(e:Event):Void{
		model.append(inputText.getText());
		box.setSelectedItem(model.last());
	}
	
	
}