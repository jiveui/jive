package cases;

import flash.display.Sprite;
import org.aswing.geom.IntDimension;
import org.aswing.border.LineBorder;

class AttachPane extends Sprite
{
	private var pane:JPanel;
	private var attachPane:JAttachPane;
	private var loadPane:JLoadPane;
	private var unloadButton:JButton;
	private var loadButton:JButton;
	
	public function new(){
		pane = new JPanel(new BorderLayout());
		//the test.swf hava a linkage movieclip name link_mc
		loadPane = new JLoadPane("../res/test.swf", AssetPane.PREFER_SIZE_LAYOUT);
		loadPane.addEventListener(Event.INIT, __onLoadInnit);
		loadPane.setScaleMode(AssetPane.SCALE_FIT_PANE);
		loadPane.setPreferredSize(new IntDimension(100,100));
		loadPane.setBorder(new LineBorder(null, ASColor.BLUE));
		attachPane = new JAttachPane(null, AssetPane.PREFER_SIZE_BOTH);
		attachPane.setScaleMode(AssetPane.SCALE_FIT_PANE);
		attachPane.setVerticalAlignment(AssetPane.CENTER);
		attachPane.setBorder(new LineBorder(null, ASColor.RED));
		attachPane.setPreferredHeight(100);
		pane.append(loadPane, BorderLayout.CENTER);
		
		unloadButton = new JButton("unload");
		loadButton = new JButton("load");
		unloadButton.addEventListener(MouseEvent.CLICK, __unloadButton);
		loadButton.addEventListener(MouseEvent.CLICK, __loadButton);
		var newpane:JPanel = new JPanel();
		newpane.append(unloadButton);
		newpane.append(loadButton);

		pane.append(attachPane, BorderLayout.NORTH);
		pane.append(newpane, BorderLayout.SOUTH);		
		pane.setSizeWH(200,300);

		this.addChild(pane);
		pane.validate();
	}

	private function __unloadButton(e:Event):Void{
		attachPane.unloadAsset();
	}
	
	private function __loadButton(e:Event):Void{
		attachPane.setAssetClassNameAndLoader("link_mc", loadPane.getLoader());	
	}

	private function __onLoadInnit(e:Event):Void{
		attachPane.setAssetClassNameAndLoader("link_mc", loadPane.getLoader());				
	}
}