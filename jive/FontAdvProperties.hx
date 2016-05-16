/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package jive;


 
import flash.text.TextField;
	

/**
 * The advanced properties for font.
 * @see flash.text.TextField
 * @see flash.text.AntiAliasType
 * @see flash.text.GridFitType
 * @author paling
 */
class FontAdvProperties{
	
	
 	private var antiAliasType:String;
 	private var gridFitType:String;
 	private var sharpness:Float;
 	private var thickness:Float;
 	private var embedFonts:Bool;
 	
	public function new(
		embedFonts:Bool=false, ?antiAliasType:String= "NORMAL", 
		?gridFitType:String="PIXEL", sharpness:Float=0, thickness:Float=0){
		this.embedFonts = embedFonts;
		this.antiAliasType = antiAliasType ;	
		this.gridFitType = gridFitType ;
		this.sharpness = sharpness;
		this.thickness = thickness;
	}
	
	public function getAntiAliasType():String{
		return antiAliasType!=null?antiAliasType: "NORMAL";
	}
	
	public function changeAntiAliasType(newType:String):FontAdvProperties{
		
		return new FontAdvProperties(embedFonts, newType, gridFitType, sharpness, thickness);
	}
	
	public function getGridFitType():String{
		return gridFitType!=null?gridFitType:  "PIXEL";
	}
	
	public function changeGridFitType(newType:String):FontAdvProperties{
		return new FontAdvProperties(embedFonts, antiAliasType, newType, sharpness, thickness);
	}
	
	public function getSharpness():Float{
		return sharpness;
	}
	
	public function changeSharpness(newSharpness:Float):FontAdvProperties{
		return new FontAdvProperties(embedFonts, antiAliasType, gridFitType, newSharpness, thickness);
	}
	
	public function getThickness():Float{
		return thickness;
	}
	
	public function changeThickness(newThickness:Float):FontAdvProperties{
		return new FontAdvProperties(embedFonts, antiAliasType, gridFitType, sharpness, newThickness);
	}
	
	public function isEmbedFonts():Bool{
		return embedFonts;
	}
	
	public function changeEmbedFonts(ef:Bool):FontAdvProperties{
		return new FontAdvProperties(ef, antiAliasType, gridFitType, sharpness, thickness);
	}	
	
	/**
	 * Applys the properties to the specified text field.
	 * @param textField the text filed to be applied font.
	 */
	public function apply(textField:TextField):Void {
		#if(flash9)
			textField.embedFonts = isEmbedFonts();		
			textField.antiAliasType = Type.createEnum(flash.text.AntiAliasType,getAntiAliasType());
			textField.gridFitType = Type.createEnum(flash.text.GridFitType, getGridFitType());			
			textField.sharpness = getSharpness();
			textField.thickness = getThickness();
		#end
	}
	
	public function toString():String{
		return "FontAdvProperties[" 
			+ "embedFonts : " + embedFonts 
			+ ", antiAliasType : " + antiAliasType 
			+ ", gridFitType : " + gridFitType 
			+ ", sharpness : " + sharpness 
			+ ", thickness : " + thickness 
			+ "]";
	}
}