package cases;

	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	class AttachIconTest extends Sprite
	{
		private var loader:Loader;
		public function new(){
			super();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, __onLoaderInnit);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __onLoaderError);
			loader.load(new URLRequest("linkmc.swf"));
		}
		
		private function __onLoaderInnit(e:Event):Void{
			var pane:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
			pane.append(new JButton("xixdfasdfadfasdfsdfdxixdfasdfadfasdfsdfdfasdfadfasdfifasdfadfasdfi", new AttachIcon("link_mc2", loader.contentLoaderInfo.applicationDomain)));
			pane.append(new JButton("xixdfasdfadfa", new AssetIcon(loader)));						
			pane.append(new JButton("xixdfasdfadfasdfsdfdfasdfadfasdfi", new LoadIcon("http://ihome.1001m.com/ihomestatics/images/daily/confirm2.png")));
			for (i in 0...20){
				pane.append(new JButton("xixdfasdfadfasdfsdfdxixdfasdfadfasdfsdfdfasdfadfasdfifasdfadfasdfi", new AttachIcon("link_mc2", loader.contentLoaderInfo.applicationDomain, 20, 20, true)));
			}
			pane.setSizeWH(200,600);
			this.addChild(pane);
			pane.validate();
			//loader.unload();
			//loader = null;
			
		}
		
		private function __onLoaderError(e:IOErrorEvent):Void{
			trace("__onLoaderError:"+e);
		}
	}