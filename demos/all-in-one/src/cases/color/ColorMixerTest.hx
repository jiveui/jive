package cases.color;

import flash.display.Sprite;

import org.aswing.event.ColorChooserEvent;
import org.aswing.event.InteractiveEvent;
import org.aswing.border.LineBorder;

class ColorMixerTest extends Sprite
{
	private var infoText:JTextArea;
	
	public function new(){
		super();
		var p:JPanel = new JPanel(new BorderLayout());
		p.setBorder(new LineBorder(null, ASColor.RED));
		var cm:JColorMixer = new JColorMixer();
		cm.addEventListener(InteractiveEvent.STATE_CHANGED, __colorChanged);
		cm.setNoColorSectionVisible(true);
		p.append(cm, BorderLayout.CENTER);		
		var cs:JColorSwatches = new JColorSwatches();
		cs.addEventListener(InteractiveEvent.STATE_CHANGED, __colorChanged);
		cs.setNoColorSectionVisible(true);
		//p.append(cs, BorderLayout.CENTER);
		infoText = new JTextArea("", 10, 10);
		
		p.append(new JScrollPane(infoText), BorderLayout.SOUTH);
		p.setSizeWH(400,400);
		this.addChild(p);
		p.validate();
		p.x = 100;
	}
	
	private function __colorChanged(e:InteractiveEvent):Void{
		infoText.appendText(AbstractColorChooserPanel(e.target).getSelectedColor() + "\n");
	}
}