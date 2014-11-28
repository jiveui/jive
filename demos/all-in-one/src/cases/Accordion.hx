package cases;

import flash.display.Sprite;
class Accordion extends Sprite
{
	public function new()
	{
		super();
		testAccordion();
	}
		
	private var accordion:JAccordion;
	private var statusLabel:JLabel;
	private var frame:JFrame;
	
	public function testAccordion():Void{
		frame = new JFrame(null, "AccordionTest");
		
		accordion = new JAccordion();
		accordion.setBorder(new LineBorder(null, ASColor.RED, 1));
		accordion.setHorizontalTextPosition(AsWingConstants.LEFT);
		
		var pane1:JPanel = new JPanel();
		pane1.setBorder(new LineBorder(null, ASColor.BLUE));
		pane1.setOpaque(true);
		var addTabButton:JButton = new JButton("add tab");
		addTabButton.addActionListener(__addTab);
		pane1.append(addTabButton);
		pane1.append(new JButton("button2"));
		pane1.append(new JButton("button3"));
		accordion.appendTab(pane1, "Buttons");
		
		pane1 = new JPanel();
		pane1.setOpaque(true);
		pane1.append(new JLabel("label1"));
		pane1.append(new JLabel("label2"));
		pane1.append(new JLabel("label3"));
		accordion.appendTab(pane1, "Labels");
		
		pane1 = new JPanel(new BorderLayout());
		pane1.setBorder(new LineBorder(null, ASColor.BLUE));
		pane1.setOpaque(true);
		pane1.append(new JTextField("JTextField"), BorderLayout.NORTH);
		var p:JPanel = new JPanel();
		p.append(new JCheckBox("JCheckBox"));
		p.append(new JRadioButton("JRadioButton"));
		pane1.append(p, BorderLayout.CENTER);
		accordion.appendTab(pane1, "Complex");
		
		frame.getContentPane().append(accordion, BorderLayout.CENTER);
		
		var labelPane:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
		statusLabel = new JLabel("First tab selected");
		//why
		//statusLabel.useHandCursor = true;
		statusLabel.addEventListener(MouseEvent.CLICK, __visibleTab);
		labelPane.append(statusLabel);
		frame.getContentPane().append(labelPane, BorderLayout.EAST);
		
		accordion.addStateListener(__selectionChanged);
		//accordion.setEnabledAt(0, false);
		accordion.setVisibleAt(1, false);
		
		frame.setSizeWH(500, 370);
		frame.show();
	}

	private function __visibleTab(e:Event) : Void{
		accordion.setVisibleAt(1, !accordion.isVisibleAt(1));
	}
	
	
	private function __selectionChanged(e:Event):Void{
		var index:Float= accordion.getSelectedIndex();
		statusLabel.setText("Selected : " + index);
	}
	
	private function __addTab(e:Event):Void{
		var p:JPanel = new JPanel(new BorderLayout());
		p.setOpaque(true);
		p.append(new JLabel("A TextArea"), BorderLayout.NORTH);
		p.append(new JScrollPane(new JTextArea("", 10, 10)), BorderLayout.CENTER);
		accordion.appendTab(p, "title with icon", new ColorIcon(ASColor.RED, 40*Math.random(), 40*Math.random()), "the tip");
	}
}