package componetset;
	import org.aswing.JAccordion;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JTextArea;
	import org.aswing.JButton;
	import org.aswing.JToolBar;
	import org.aswing.JToggleButton;
	import org.aswing.JSeparator;
	import org.aswing.BorderLayout;
 
	import org.aswing.JSplitPane;
class Containers extends JPanel
{
	public function new(){
		super(new BorderLayout());
		name = "Containers";
		
		var split:JSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT);
		
		var accordion:JAccordion = new JAccordion();
		accordion.appendTab(new JButton(), "Button", null, "a button in accordion");
		accordion.appendTab(new JTextArea("1\n2\n3\n4\n"), "TextArea", null, "a text area in accordion");
		accordion.appendTab(new JPanel(), "A empty panel", null, "a empty panel in accordion");
		
		var toolbar:JToolBar = new JToolBar();
		toolbar.append(new JLabel("This is a ToolBar"));
		toolbar.append(new JSeparator(JSeparator.VERTICAL));
		toolbar.append(new JButton("Button"));
		toolbar.append(new JButton("Button 2"));
		toolbar.append(new JToggleButton("Toggle Button"));
		var toolbarContainer:JPanel = new JPanel(new BorderLayout());
		toolbarContainer.append(toolbar, BorderLayout.NORTH);
		
		split.setTopComponent(accordion);
		split.setBottomComponent(toolbarContainer);
		
		append(split, BorderLayout.CENTER);
	}
	
}