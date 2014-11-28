package componetset;
	import org.aswing.DefaultListCell;
	import cases.CircleIcon;
	import org.aswing.ASColor;
	import cases.ColorIcon; 
	class IconListCell extends DefaultListCell
	{
		public function new()
		{
			super();
		}
		
		override public function setCellValue(value:Dynamic) : Void{
			if(this.value != value){
				this.value = value;
				getJLabel().setText(value.toString());
				if(Math.random() > 0.5){
					getJLabel().setIcon(new ColorIcon(new ASColor(Std.int(Math.random()*0xFFFFFF)), Std.int(10+Math.random()*30), Std.int(10+Math.random()*30)));
				}else{
					getJLabel().setIcon(new CircleIcon(new ASColor(Std.int(Math.random()*0xFFFFFF)), Std.int(10+Math.random()*30), Std.int(10+Math.random()*30)));
				}
			}
		}
		
	}