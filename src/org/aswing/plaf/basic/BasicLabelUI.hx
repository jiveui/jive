package org.aswing.plaf.basic;

	
import flash.text.TextFieldAutoSize;
import org.aswing.JLabel;
	import org.aswing.Component;
	import org.aswing.Icon;
	import org.aswing.ASFont;
	import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import org.aswing.geom.IntDimension;
import org.aswing.Component;
import org.aswing.plaf.BaseComponentUI;
	import org.aswing.event.AWEvent;
import flash.text.TextField; 
import flash.filters.DropShadowFilter;
import flash.filters.BitmapFilter;
import flash.filters.BlurFilter;

/**
 * Label UI basic imp.
 * @author paling
 * @private
 */
class BasicLabelUI extends BaseComponentUI{
	
	private var label:JLabel;
	private var textField:TextField;
	
	public function new(){
		super();
	}

    private function getPropertyPrefix():String{
        return "Label.";
    }
    
	override public function installUI(c:Component):Void{
		label = AsWingUtils.as(c,JLabel);
		installDefaults(label);
		installComponents(label);
		installListeners(label);
	}
    
	override public function uninstallUI(c:Component):Void{
		label = AsWingUtils.as(c,JLabel);
		uninstallDefaults(label);
		uninstallComponents(label);
		uninstallListeners(label);
 	}
 	
 	private function installDefaults(b:JLabel):Void{
        var pp:String= getPropertyPrefix();
        
        LookAndFeel.installColorsAndFont(b, pp);
        LookAndFeel.installBorderAndBFDecorators(b, pp);
        LookAndFeel.installBasicProperties(b, pp);
 	}
	
 	private function uninstallDefaults(b:JLabel):Void{
 		LookAndFeel.uninstallBorderAndBFDecorators(b);
 	}
 	
 	private function installComponents(b:JLabel):Void{
 		textField = new TextField();
 		textField.autoSize = TextFieldAutoSize.LEFT;
		 
 		textField.selectable = false;
 		textField.mouseEnabled = false;
		#if(flash)

 		textField.mouseWheelEnabled = false;
		#end
 		b.addChild(textField);
 		b.setFontValidated(false);
 	}
	
 	private function uninstallComponents(b:JLabel):Void{
 		b.removeChild(textField);
 	}
 	
 	private function installListeners(b:JLabel):Void{
 	}
	
 	private function uninstallListeners(b:JLabel):Void{
 	}
    
    //--------------------------------------------------
    
    /* These rectangles/insets are allocated once for all 
     * LabelUI.paint() calls.  Re-using rectangles rather than 
     * allocating them in each paint call substantially reduced the time
     * it took paint to run.  Obviously, this method can't be re-entered.
     */
	private static var viewRect:IntRectangle = new IntRectangle();
    private static var textRect:IntRectangle = new IntRectangle();
    private static var iconRect:IntRectangle = new IntRectangle();    

    override public function paint(c:Component, g:Graphics2D, r:IntRectangle):Void{
    	super.paint(c, g, r);
    	var b:JLabel = AsWingUtils.as(c,JLabel);
    	
    	viewRect.setRect(r);
    	
    	textRect.x = textRect.y = textRect.width = textRect.height = 0;
        iconRect.x = iconRect.y = iconRect.width = iconRect.height = 0;
        // layout the text and icon
	 
        var text:String= AsWingUtils.layoutCompoundLabel(c,
            c.getFont(), b.getText(), getIconToLayout(), 
           Std.int(b.getVerticalAlignment()), Std.int(b.getHorizontalAlignment()),
            Std.int(b.getVerticalTextPosition()), Std.int(b.getHorizontalTextPosition()),
            viewRect, iconRect, textRect, 
	    	Std.int(b.getText() == null ? 0 : b.getIconTextGap()));

    	paintIcon(b, g, iconRect);
    	
        if (text != null && text != ""){
        	textField.visible = true; 
			paintText(b, textRect, text); 
        }else{
        	textField.text = "";
        	textField.visible = false;
		 
        }
        
        textField.selectable = b.isSelectable();
        textField.mouseEnabled = b.isSelectable();
		
    }
    
    private function getIconToLayout():Icon{
    	return label.getIcon();
    }
        
    /**
     * paint the text to specified button with specified bounds
     */
    private function paintText(b:JLabel, textRect:IntRectangle, text:String):Void{
    	var font:ASFont = b.getFont();
    	
        if(textField.text != text){
			textField.text = text;
		}
		if (!b.isFontValidated()) {
			//why
			 AsWingUtils.applyTextFont(textField, font);
			 b.setFontValidated(true);
		}
		 
    	AsWingUtils.applyTextColor(textField, b.getForeground());
		 textField.x = textRect.x;
		 textField.y = textRect.y;
		 

    	if (!b.isEnabled()) {
		 var f :Array<BitmapFilter> = new Array<BitmapFilter>();	
			f.push(new  BlurFilter(2, 2, 2));
    		b.filters = f;
    	}else{
    		b.filters = [];
    	}
	
    	textField.filters = label.getTextFilters();
	 
		
    }
    
    /**
     * paint the icon to specified button's mc with specified bounds
     */
    private function paintIcon(b:JLabel, g:Graphics2D, iconRect:IntRectangle):Void{
        var icon:Icon = b.getIcon();
        var tmpIcon:Icon = null;
        
        var icons:Array<Dynamic>= getIcons();
        for(i in 0...icons.length){
        	var ico:Icon = icons[i];
			setIconVisible(ico, false);
        }
        
	    if(icon == null) {
	    	return;
	    }

		if(!b.isEnabled()) {
			tmpIcon = b.getDisabledIcon();
		}
              
		if(tmpIcon != null) {
			icon = tmpIcon;
		}
		
		setIconVisible(icon, true);
		icon.updateIcon(b, g, iconRect.x, iconRect.y);
    }
    
    private function setIconVisible(icon:Icon, visible:Bool):Void{
    	if(icon.getDisplay(label) != null){
    		icon.getDisplay(label).visible = visible;
    	}
    }
    
    private function getIcons():Array<Dynamic>{
    	var arr:Array<Dynamic>= new Array<Dynamic>();
    	if(label.getIcon() != null){
    		arr.push(label.getIcon());
    	}
    	if(label.getDisabledIcon() != null){
    		arr.push(label.getDisabledIcon());
    	}
    	return arr;
    }
    
      
    /**
     * Returns the a label's preferred size with specified icon and text.
     */
    private function getLabelPreferredSize(b:JLabel, icon:Icon, text:String):IntDimension{
    	viewRect.setRectXYWH(0, 0, 100000, 100000);
    	textRect.x = textRect.y = textRect.width = textRect.height = 0;
        iconRect.x = iconRect.y = iconRect.width = iconRect.height = 0;
        
        AsWingUtils.layoutCompoundLabel(b, 
            b.getFont(), text, icon, 
           Std.int( b.getVerticalAlignment()),Std.int(  b.getHorizontalAlignment()),
            Std.int( b.getVerticalTextPosition()), Std.int( b.getHorizontalTextPosition()),
            viewRect, iconRect, textRect, 
	    	Std.int( b.getText() == null ? 0 : b.getIconTextGap())
        );
        /* The preferred size of the button is the size of 
         * the text and icon rectangles plus the buttons insets.
         */
        var size:IntDimension;
        if(icon == null){
        	size = textRect.getSize();
        }else if(b.getText()==null || b.getText()==""){
        	size = iconRect.getSize();
        }else{
        	var r:IntRectangle = iconRect.union(textRect);
        	size = r.getSize();
        }
        size = b.getInsets().getOutsideSize(size);
		
        return size;
    }    
    
    override public function getPreferredSize(c:Component):IntDimension{
    	var b:JLabel = AsWingUtils.as(c,JLabel);
    	return getLabelPreferredSize(b, getIconToLayout(), b.getText());
    }

    override public function getMinimumSize(c:Component):IntDimension{
    	return c.getInsets().getOutsideSize();
    }

    override public function getMaximumSize(c:Component):IntDimension{
		return IntDimension.createBigDimension();
    }
	
}