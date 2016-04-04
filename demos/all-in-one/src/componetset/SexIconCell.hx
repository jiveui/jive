package componetset;

	import cases.ColorIcon;
	import org.aswing.ASColor;
	import org.aswing.Icon;
	import org.aswing.table.DefaultTextCell;
	import cases.CircleIcon;
	class SexIconCell extends DefaultTextCell{
	
	private var male_icon:Icon;
	private var female_icon:Icon;
	
	public function new(){
		super();
		male_icon = new CircleIcon(ASColor.RED, 18, 18);
		female_icon = new ColorIcon(ASColor.BLUE, 18, 18);
	}
	
	override public function setCellValue(value:Dynamic) : Void{
		this.value = value;
		setText(value.toString());
		if(value!=null)	{
			setIcon(male_icon);
		}else{
			setIcon(female_icon);
		}
	}
}