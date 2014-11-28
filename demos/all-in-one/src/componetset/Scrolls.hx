package componetset;

	import org.aswing.JProgressBar;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import org.aswing.JSlider;
	import org.aswing.JScrollPane;
	import org.aswing.JPanel;
	import org.aswing.geom.IntDimension;
	import flash.events.Event;
	import org.aswing.AssetPane;
	import flash.display.Bitmap;
class Scrolls extends JPanel{
	//[Embed(source="princess.jpg")]
	private var imgClass:Loader;
	
	public function new(){
		super();
		name = "Scrolls";
		this.addEventListener( Event.ADDED_TO_STAGE, __init);
	}
	private function __init(e:Event):Void
	{
		this.removeEventListener( Event.ADDED_TO_STAGE, __init);
		imgClass = new Loader();
		imgClass.contentLoaderInfo.addEventListener(  Event.COMPLETE, __COMPLETE);
		imgClass.load(new URLRequest("2.jpg"));
		
	}
	private function __COMPLETE(e:Event):Void
	{
	 	var bmp:Bitmap  = untyped imgClass.content;	
		var asset = new AssetPane(bmp);
		//asset.setPreferredSize(new IntDimension(500, 458));
		 var scrollPane:JScrollPane = new JScrollPane(asset);// new AssetPane(new imgClass() as DisplayObject));
		 scrollPane.setPreferredSize(new IntDimension(300, 300));
		
		 append(scrollPane);
		
		var slider:JSlider = new JSlider();
		append(slider);
		slider.setMajorTickSpacing(20);
		slider.setMinorTickSpacing(4);
		slider.setPaintTicks(true);
		slider.setShowValueTip(true);
		
		var progress:JProgressBar = new JProgressBar();
		progress.setIndeterminate(true);
		append(progress);
	}
	
}
