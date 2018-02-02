/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;


import haxe.ds.StringMap;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.EmptyUIResources;
import org.aswing.resizer.ResizerController;
/**
 * A table of defaults for AsWing components.  Applications can set/get
 * default values via the <code>UIManager</code>.
 * 
 * @see UIManager
 * @author paling
 */
class UIDefaults extends StringMap<Dynamic>
{
	public function new()
	{
		super();
	}

	/**
     * Puts all of the key/value pairs in the database.
     * @param keyValueList  an array of key/value pairs
     * @see #put()
     * @see org.aswing.utils.Maptable#put()
     */
	public function putDefaults(keyValueList:Array<Dynamic>):Void {
	 
			var i:Int = 0; 
	
		while (i<keyValueList.length){
             set(keyValueList[i],keyValueList[i + 1]);
            
			 i += 2;
        }
	}
	
	/**
	 * Returns the component LookAndFeel specified UI object
	 * @return target's UI object, or null if there is not his UI object
	 */
	public function getUI(target:Component):ComponentUI{
		var ui:ComponentUI = AsWingUtils.as(getInstance(target.getUIClassID()) , ComponentUI);
		if(ui == null){
			ui = AsWingUtils.as(getCreateInstance(target.getDefaultBasicUIClass()) , ComponentUI);
		}
		return ui;
	}
	
	public function getBoolean(key:String):Bool{
		return (this.get(key) == true);
	}
	
	public function getNumber(key:String):Float{
		return AsWingUtils.as(this.get(key), cast Float);
	}
	
	public function getInt(key:String):Int {
		return AsWingUtils.as(this.get(key) , cast Int);
	}
	
	public function getUint(key:String):Int{
		return AsWingUtils.as(this.get(key) , cast Int);
	}
	
	public function getString(key:String):String{
		return AsWingUtils.as(this.get(key) , cast String);
	}
	
	public function getBorder(key:String):Border{
		var border:Border = AsWingUtils.as(getInstance(key) , Border);
		if(border == null){
			border = EmptyUIResources.BORDER; //make it to be an ui resource then can override by next LAF
		
		}
		return border;
	}
	
	public function getIcon(key:String):Icon{
		var icon:Icon = AsWingUtils.as(getInstance(key) , Icon);
		if(icon == null){
			icon = EmptyUIResources.ICON; //make it to be ui resource property then can override by next LAF
		}
		return icon;
	}
	
	public function getGroundDecorator(key:String):GroundDecorator{
		var dec:GroundDecorator = AsWingUtils.as(getInstance(key) , GroundDecorator);
		if(dec == null){
			dec = EmptyUIResources.DECORATOR; //make it to be ui resource property then can override by next LAF
		}
		return dec;
	}
	
	public function getColor(key:String):ASColor{
		var color:ASColor = AsWingUtils.as(getInstance(key) , ASColor);
		if(color == null){
			color = EmptyUIResources.COLOR; //make it to be an ui resource then can override by next LAF
		}
		return color;
	}
	
	public function getFont(key:String):ASFont{
		var font:ASFont = AsWingUtils.as(getInstance(key) , ASFont);
		if(font == null){
			font = EmptyUIResources.FONT; //make it to be an ui resource then can override by next LAF
		}
		return font;
	}
	
	public function getInsets(key:String):Insets{
		var i:Insets = AsWingUtils.as(getInstance(key) , Insets);
		if(i == null){
			i = EmptyUIResources.INSETS; //make it to be an ui resource then can override by next LAF
		}
		return i;
	}
	
	public function getStyleTune(key:String):StyleTune{
		var i:StyleTune = AsWingUtils.as(getInstance(key) , StyleTune);
		if(i == null){
			i = EmptyUIResources.STYLE_TUNE; //make it to be an ui resource then can override by next LAF
		}
		return i;
	}
	
	//-------------------------------------------------------------
	public function getConstructor(key:String):Dynamic{
		return AsWingUtils.as(this.get(key) , cast Class);
	}
	
	public function getInstance(key:String):Dynamic{
		var value:Dynamic= this.get(key);
		if(Std.is(value,Class)){
			return getCreateInstance(value);
		}else{
			return value;
		}
	}
	
	private function getCreateInstance(constructor:Dynamic):Dynamic {
		return Type.createInstance( constructor,[]);
		//return new constructor();
	}
}