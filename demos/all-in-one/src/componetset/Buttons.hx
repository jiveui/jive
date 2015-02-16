package componetset;

import org.aswing.geom.IntDimension;
import org.aswing.SoftBox;
	import org.aswing.JTextArea;
	import org.aswing.JButton;
	import org.aswing.JRadioButton;
	import org.aswing.JComboBox;
	import org.aswing.ASColor;
	import org.aswing.JToggleButton;
	import org.aswing.JAdjuster;
	import org.aswing.JScrollPane;
	import org.aswing.BorderLayout;
 
	import org.aswing.ButtonGroup;
	import org.aswing.JPanel;
	import org.aswing.JStepper;
	import cases.ColorDotIcon;
	import org.aswing.JCheckBox;
	import org.aswing.JTextField;

class Buttons extends JPanel{
	
	public function new(){
		super(new BorderLayout(5, 5));
		//setOpaque(true);
		//setBackground(new ASColor(0xEEEEEE));
		name = "Basic Controls";
		
		var top:SoftBox = SoftBox.createVerticalBox(4);
		append(top, BorderLayout.NORTH);
		
		var jbuttons:JPanel = new JPanel();
		var jbtn1:JButton = new JButton("JButton");
		var jbtn2:JButton = new JButton("JButton Disabled");
		jbtn2.setEnabled(false);
		var jbtn3:JButton = new JButton("With Icon", new ColorDotIcon(15, ASColor.RED));
		jbuttons.append(jbtn1);
		jbuttons.append(jbtn2);
		jbuttons.append(jbtn3);
		top.append(jbuttons);
			
		var tfs:JPanel = new JPanel();
		var tf1:JTextField = new JTextField("Input Text", 10);
		var tf2:JTextField = new JTextField("Not-Editable", 12);
		tf2.setEditable(false);
		var tf3:JTextField = new JTextField("Disabled");
		tf3.setEnabled(false);
		tfs.append(tf1);
		tfs.append(tf2);
		tfs.append(tf3);

		top.append(tfs);
		 
		
		var toggles:JPanel = new JPanel();
		var tog1:JToggleButton = new JToggleButton("JToggleButton");
		var tog2:JToggleButton = new JToggleButton("Disabled");
		tog2.setEnabled(false);
		var tog3:JToggleButton = new JToggleButton("Icon", new ColorDotIcon(10, ASColor.BLUE));
		toggles.append(tog1);
		toggles.append(tog2);
		toggles.append(tog3);
		top.append(toggles);
	
		var checks:JPanel = new JPanel();
		var che1:JCheckBox = new JCheckBox("JCheckBox");
		var che2:JCheckBox = new JCheckBox("Disabled");
		che2.setEnabled(false);
		var che3:JCheckBox = new JCheckBox("Selected Disabled");
		che3.setSelected(true);
		che3.setEnabled(false);
		checks.append(che1);
		checks.append(che2);
		checks.append(che3);
		top.append(checks);
		
		var radios:JPanel = new JPanel();
		var rad1:JRadioButton = new JRadioButton("JRadioButton");
		var rad2:JRadioButton = new JRadioButton("Disabled");
		rad2.setEnabled(false);
		var rad3:JRadioButton = new JRadioButton("Selected Disabled");
		rad3.setSelected(true);
		rad3.setEnabled(false);
		
			
		var rad4:JRadioButton = new JRadioButton("In fact they are in a Group");
		var group:ButtonGroup = new ButtonGroup();
		group.append(rad1);
		group.append(rad2);
		group.append(rad3);
		group.append(rad4);
		radios.append(rad1);
		radios.append(rad2);
		radios.append(rad3);
		radios.append(rad4);
		top.append(radios); 
		var combos:JPanel = new JPanel();
		var combo1:JComboBox = new JComboBox(["JComboBox", "is", "enabled", "and", "editable!", "!!", "!!!!"]);
		combo1.setSelectedIndex(0);
		combo1.setEditable(true);
		combo1.setPreferredWidth(120);
		var combo2:JComboBox = new JComboBox(["Not-Editable", "This is", "enabled", "but", "not",  "editable!"]);
		combo2.setSelectedIndex(0);
		combo2.setPreferredWidth(120);
		combo2.setEditable(false);
		var combo3:JComboBox = new JComboBox(["Disabled","This is", "disabled", "!"]);
		combo3.setPreferredWidth(80);
		combo3.setSelectedIndex(0);
		combo3.setEnabled(false);
		combos.append(combo1);
		combos.append(combo2);
		combos.append(combo3);
		top.append(combos);
		
		
		var ads:JPanel = new JPanel();
		var ad1:JAdjuster = new JAdjuster(3);
        //ad1.setPreferredSize(new IntDimension(100,20));
		var ad2:JAdjuster = new JAdjuster(6);
		ad2.setValueTranslator(
			function(value:Int):String{
				return Math.round(value) + "%";
			}
		);
		var ad3:JAdjuster = new JAdjuster(7);
		ad3.setValueTranslator(
			function(value:Int):String{
				return Math.round(value) + "cm";
			}
		);
		ad3.setEditable(false);
		var ad4:JAdjuster = new JAdjuster(4);
		ad4.setEnabled(false);
		ads.append(ad1);
		ads.append(ad2);
		ads.append(ad3);
		ads.append(ad4);
		top.append(ads);
		
		var st1:JStepper = new JStepper(3);
		var st2:JStepper = new JStepper(6);
		st2.setValueTranslator(
			function(value:Int):String{
				return Math.round(value) + "%";
			}
		);
		var st3:JStepper = new JStepper(7);
		st3.setValueTranslator(
			function(value:Int):String{
				return Math.round(value) + "cm";
			}
		);
		st3.setEditable(false);
		var st4:JStepper = new JStepper(4);
		st4.setEnabled(false);
		ads.append(st1);
		ads.append(st2);
		ads.append(st3);
		ads.append(st4);
		
		var ta:JTextArea = new JTextArea();
		append(new JScrollPane(ta), BorderLayout.CENTER);
	}
	
}