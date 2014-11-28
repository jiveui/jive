package cases;


import flash.display.Sprite;
import org.aswing.event.InteractiveEvent;

class TabbedPane extends Sprite{
	
	public function new(){
		super();
		doTabbedPaneTest();
	}
	
	private var tabbedPane:JTabbedPane;
	private var statusLabel:JLabel;
	private var placementButton:JButton;
	private var frame:JFrame;
	
	public function doTabbedPaneTest():Void{
		frame = new JFrame(null, "TabbedPaneTest");
		
		tabbedPane = new JTabbedPane();
		tabbedPane.setTabPlacement(JTabbedPane.TOP);
		tabbedPane.setForeground(ASColor.RED);
		tabbedPane.setFont(new ASFont("Arial", 20));
		//tabbedPane.setVerticalAlignment(JTabbedPane.BOTTOM);
		//tabbedPane.setBorder(new BevelBorder(new EmptyBorder(new LineBorder(null, ASColor.GRAY.darker(), 1), new Insets(2,2,2,2)), BevelBorder.LOWERED));
		
		var pane1:JPanel = new JPanel();
		pane1.setOpaque(true);
		var addTabButton:JButton = new JButton("add tab");
		var removeTabButton:JButton = new JButton("remove tab");
		removeTabButton.setToolTipText("Remove a random tab");
		pane1.append(new JButton("button2"));
		pane1.append(new JButton("button3"));
		tabbedPane.appendTab(pane1, "Buttons", new ColorIcon(ASColor.GREEN, 30, 20), "tip for tab");
		
		pane1 = new JPanel();
		pane1.append(new JLabel("label1"));
		pane1.append(new JLabel("label2"));
		pane1.append(new JLabel("label3"));
		tabbedPane.appendTab(pane1, "Labels", null, "tip2\nline2");
		
		pane1 = new JPanel(new BorderLayout());
		pane1.append(new JTextField("JTextField"), BorderLayout.NORTH);
		var p:JPanel = new JPanel();
		p.append(new JCheckBox("JCheckBox"));
		p.append(new JRadioButton("JRadioButton"));
		pane1.append(p, BorderLayout.CENTER);
		tabbedPane.appendTab(pane1, "Complex", null, "Disabled");
		
		frame.getContentPane().append(tabbedPane, BorderLayout.CENTER);
		
		var rightPane:Container = SoftBox.createVerticalBox(10);
		statusLabel = new JLabel("First tab selected");
		statusLabel.addEventListener(MouseEvent.CLICK, __visibleTab);
		placementButton = new JButton("Change Placement");
		rightPane.append(statusLabel);
		rightPane.append(placementButton);
		rightPane.append(addTabButton);
		rightPane.append(removeTabButton);
		frame.getContentPane().append(rightPane, BorderLayout.EAST);
		
		tabbedPane.appendTab(new JButton("Button"), "Four a long title hahhahaa");
		tabbedPane.appendTab(new JButton("Button2"), "Tab2");
		tabbedPane.appendTab(new JButton("Button3"), "Tab tab cool tab");
				
		tabbedPane.addEventListener(InteractiveEvent.STATE_CHANGED, __selectionChanged);
		placementButton.addActionListener(__changePlacement);
		addTabButton.addActionListener(__addTab);
		removeTabButton.addActionListener(__removeTab);
		
		tabbedPane.setEnabledAt(2, false);
		
		frame.setSizeWH(400, 380);
		frame.show();
	}
	
	private function __addTab(e:Event):Void{
		var p:JPanel = new JPanel(new BorderLayout());
		p.setOpaque(true);
		p.append(new JLabel("A TextArea" + tabbedPane.getComponentCount()), BorderLayout.NORTH);
		p.append(new JScrollPane(new JTextArea("", 10, 10)), BorderLayout.CENTER);
		tabbedPane.insertTab(Math.floor(Math.random()*tabbedPane.getComponentCount()+0.5), p, "title with icon", new ColorIcon(ASColor.RED, 40*Math.random(), 40*Math.random()), "the tip");
	}
	private function __removeTab(e:Event):Void{
		tabbedPane.removeTabAt(Math.floor(Math.random()*tabbedPane.getComponentCount()));
	}
	
	private function __visibleTab(e:Event) : Void{
		tabbedPane.setVisibleAt(2, !tabbedPane.isVisibleAt(2));
	}
	
	private function __selectionChanged(e:Event):Void{
		var index:Float= tabbedPane.getSelectedIndex();
		statusLabel.setText("Selected : " + index);
	}
	private function __changePlacement(e:Event):Void{
		if(tabbedPane.getTabPlacement() == JTabbedPane.LEFT){
			tabbedPane.setTabPlacement(JTabbedPane.RIGHT);
		}else if(tabbedPane.getTabPlacement() == JTabbedPane.RIGHT){
			tabbedPane.setTabPlacement(JTabbedPane.BOTTOM);
		}else if(tabbedPane.getTabPlacement() == JTabbedPane.BOTTOM){
			tabbedPane.setTabPlacement(JTabbedPane.TOP);
		}else{
			tabbedPane.setTabPlacement(JTabbedPane.LEFT);
		}
	}
}