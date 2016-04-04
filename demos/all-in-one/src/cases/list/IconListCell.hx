package cases.list;

	import org.aswing.DefaultListCell;
	import cases.ColorIcon;
	import cases.CircleIcon;
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
					getJLabel().setIcon(new ColorIcon(new ASColor(Math.random()*0xFFFFFF), 10+Math.random()*30, 10+Math.random()*30));
				}else{
					getJLabel().setIcon(new CircleIcon(new ASColor(Math.random()*0xFFFFFF), 10+Math.random()*30, 10+Math.random()*30));
				}
			}
		}
		
	}