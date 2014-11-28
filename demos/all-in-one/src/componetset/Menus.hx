package componetset;
	import org.aswing.JTextArea;
	import org.aswing.KeySequence;
	import org.aswing.JCheckBoxMenuItem;
	import org.aswing.JScrollPane;
	import org.aswing.JMenuItem;
	import org.aswing.BorderLayout;
 
	import org.aswing.JRadioButtonMenuItem;
	import org.aswing.JMenu;
	import org.aswing.ButtonGroup;
	import org.aswing.JPanel;
	import org.aswing.JOptionPane;
	import org.aswing.KeyboardManager;
	import org.aswing.JSeparator;
	import flash.events.Event;
	import org.aswing.JMenuBar;
	import org.aswing.KeyStroke;
	import org.aswing.AsWingUtils;
class Menus extends JPanel{
	
	private var textArea:JTextArea; 
	private var openItem:JMenuItem;
	private var fileMenu:JMenu;
	
	public function new():Void{
		super(new BorderLayout());
		this.setName("Menus");
		
		var bar:JMenuBar = new JMenuBar();
		
		fileMenu = new JMenu("&File");
		var newMenu:JMenu = new JMenu("New");
		fileMenu.append(newMenu);
		newMenu.addMenuItem("AS2 File").addActionListener(__menuItemAct);
		newMenu.addMenuItem("AS3 File").addActionListener(__menuItemAct);
		newMenu.addMenuItem("haXe File").addActionListener(__menuItemAct);
		openItem = fileMenu.addMenuItem("Open...");
		openItem.addActionListener(__menuItemAct);
		openItem.setAccelerator(new KeySequence([KeyStroke.VK_CONTROL, KeyStroke.VK_O]));
		fileMenu.append(new JSeparator(JSeparator.HORIZONTAL));
		fileMenu.addMenuItem("&Save").addActionListener(__menuItemAct);
		fileMenu.addMenuItem("Save").addActionListener(__menuItemAct);
		fileMenu.addMenuItem("Close").addActionListener(__menuItemAct);
		fileMenu.append(new JSeparator(JSeparator.HORIZONTAL));
		fileMenu.addMenuItem("Exit").addActionListener(__menuItemAct);
		bar.append(fileMenu);
		
		var editMenu:JMenu = new JMenu("&Edit");
		editMenu.addMenuItem("Copy").addActionListener(__menuItemAct);
		editMenu.addMenuItem("Cut").addActionListener(__menuItemAct);
		editMenu.addMenuItem("Paste").addActionListener(__menuItemAct);
		bar.append(editMenu);
		
		var optionMenu:JMenu = new JMenu("Option");
		var check1:JCheckBoxMenuItem = new JCheckBoxMenuItem("Check 1");
		check1.addSelectionListener(__menuSelection);
		check1.setAccelerator(new KeySequence([KeyStroke.VK_CONTROL, KeyStroke.VK_C]));
		optionMenu.append(check1);
		var radio1:JRadioButtonMenuItem = new JRadioButtonMenuItem("Radio 1");
		radio1.addSelectionListener(__menuSelection);
		var radio2:JRadioButtonMenuItem = new JRadioButtonMenuItem("Radio 2");
		radio2.addSelectionListener(__menuSelection);
		var group:ButtonGroup = new ButtonGroup();
		group.append(radio1);
		group.append(radio2);
		optionMenu.append(radio1);
		optionMenu.append(radio2);
		bar.append(optionMenu);
		
		var helpMenu:JMenu = new JMenu("Help");
		helpMenu.addMenuItem("About...").addActionListener(__aboutMenuItemAct);
		bar.append(helpMenu);
		
		append(bar, BorderLayout.NORTH);
		textArea = new JTextArea();
		append(new JScrollPane(textArea), BorderLayout.CENTER);
		
		var km:KeyboardManager = new KeyboardManager();
		km.init(this);
		km.registerKeyAction(
			new KeySequence([KeyStroke.VK_SHIFT, KeyStroke.VK_A]), 
			__keyAction);
	}
	
	private function __keyAction(e:Event) : Void{
		textArea.appendText("Key action!\n");
		fileMenu.remove(openItem);
	}
	

	private function __menuItemAct(e:Event):Void { 	
 
		var source:JMenuItem = cast(e.target,JMenuItem)	;
		textArea.appendText("Menu " + source.getText() + " acted!\n");
	}
	
	private function __menuSelection(e:Event):Void {
 
		var source:JMenuItem = cast(e.target,JMenuItem)	;
		textArea.appendText(
			"Menu " + source.getText() 
			+ " selected ? " 
			+ source.isSelected() + "!\n");
	}
	
	private function __aboutMenuItemAct(e:Event):Void {
 
		var source:JMenuItem = cast(e.target,JMenuItem)	;
		JOptionPane.showMessageDialog("About", "This is just a menu test demo!");
	}
	
}