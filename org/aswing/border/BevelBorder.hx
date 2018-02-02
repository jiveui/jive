/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.border;


import flash.display.CapsStyle;
import flash.display.DisplayObject;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import org.aswing.ASColor;
	import org.aswing.Border;
	import org.aswing.Component;
	import org.aswing.Insets;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.graphics.Pen;
	/**
 * A class which implements a simple 2 line bevel border.
 * @author paling
 */
class BevelBorder extends DecorateBorder {
	
    /** Raised bevel type. */
    inline public static var RAISED:Int= 0;
    /** Lowered bevel type. */
    inline public static var LOWERED:Int= 1;

    private var bevelType:Int;
    private var highlightOuter:ASColor;
    private var highlightInner:ASColor;
    private var shadowInner:ASColor;
    private var shadowOuter:ASColor;
    private var thickness:Float;

    /**
     * BevelBorder()<br> default bevelType to LOWERED<br>
     * BevelBorder(interior:Border, bevelType:Number)<br>
     * Creates a bevel border with the specified type and whose
     * colors will be derived from the background color of the
     * component passed into the paintBorder method.
     * <p>
     * BevelBorder(interior:Border, bevelType:Number, highlight:ASColor, shadow:ASColor)<br>
     * Creates a bevel border with the specified type, highlight and
     * shadow colors.
     * <p>
     * BevelBorder(interior:Border, bevelType:Number, highlightOuterColor:ASColor, highlightInnerColor:ASColor, shadowOuterColor:ASColor, shadowInnerColor:ASColor)<br>
     * Creates a bevel border with the specified type, specified four colors.
     * @param interior the border in this border
     * @param bevelType the type of bevel for the border
     * @param highlightOuterColor the color to use for the bevel outer highlight
     * @param highlightInnerColor the color to use for the bevel inner highlight
     * @param shadowOuterColor the color to use for the bevel outer shadow
     * @param shadowInnerColor the color to use for the bevel inner shadow
     * @param thickness the thickness of border frame lines, default is 2
     */
    public function new(interior:Border=null, bevelType:Int=LOWERED, highlightOuterColor:ASColor=null, 
                       highlightInnerColor:ASColor=null, shadowOuterColor:ASColor=null, 
                       shadowInnerColor:ASColor=null, thickness:Float=2) {
        super(interior);
        this.bevelType = bevelType;
        if(highlightInnerColor != null && shadowOuterColor == null){
        	this.highlightOuter = highlightOuterColor.brighter();
        	this.highlightInner = highlightOuterColor;
        	this.shadowOuter = null;
        	this.shadowInner = null;
        }else{
        	this.highlightOuter = highlightOuterColor;
        	this.highlightInner = highlightInnerColor;
        	this.shadowOuter = shadowOuterColor;
        	this.shadowInner = shadowInnerColor;
        }
        this.thickness = thickness;
    }


	override public function updateBorderImp(com:Component, g:Graphics2D, b:IntRectangle):Void{
        if (bevelType == RAISED) {
             paintRaisedBevel(com, g, b.x, b.y, b.width, b.height);
        }else{
             paintLoweredBevel(com, g, b.x, b.y, b.width, b.height);
        }
    }
    
    override public function getBorderInsetsImp(c:Component, bounds:IntRectangle):Insets{
    	return new Insets(Std.int(thickness), Std.int(thickness), Std.int(thickness), Std.int(thickness));
    }
    
	override public function getDisplayImp():DisplayObject
	{
		return null;
	}
	
    /**
     * Sets the thickness of border frame lines
     * @param t the thickness of border frame lines to set.
     */
    public function setThickness(t:Float):Void{
    	thickness = t;
    }
    
    /**
     * Returns the thickness of border frame lines
     * @return the thickness of border frame lines
     */
    public function getThickness():Float{
    	return thickness;
    }

    /**
     * Returns the outer highlight color of the bevel border
     * when rendered on the specified component.  If no highlight
     * color was specified at instantiation, the highlight color
     * is derived from the specified component's background color.
     * @param c the component for which the highlight may be derived
     */
    public function getHighlightOuterColorWith(c:Component):ASColor{
        var highlight:ASColor = getHighlightOuterColor();
        if(highlight == null){
        	highlight = c.getBackground().brighter().brighter();
        }
        return highlight;
    }

    /**
     * Returns the inner highlight color of the bevel border
     * when rendered on the specified component.  If no highlight
     * color was specified at instantiation, the highlight color
     * is derived from the specified component's background color.
     * @param c the component for which the highlight may be derived
     */
    public function getHighlightInnerColorWith(c:Component):ASColor{
        var highlight:ASColor = getHighlightInnerColor();
        if(highlight == null){
        	highlight = c.getBackground().brighter();
        }
        return highlight;
    }

    /**
     * Returns the inner shadow color of the bevel border
     * when rendered on the specified component.  If no shadow
     * color was specified at instantiation, the shadow color
     * is derived from the specified component's background color.
     * @param c the component for which the shadow may be derived
     */
    public function getShadowInnerColorWith(c:Component):ASColor{
        var shadow:ASColor = getShadowInnerColor();
        if(shadow == null){
        	shadow = c.getBackground().darker();
        }
        return shadow ;
                                    
    }

    /**
     * Returns the outer shadow color of the bevel border
     * when rendered on the specified component.  If no shadow
     * color was specified at instantiation, the shadow color
     * is derived from the specified component's background color.
     * @param c the component for which the shadow may be derived
     */
    public function getShadowOuterColorWith(c:Component):ASColor{
        var shadow:ASColor = getShadowOuterColor();
        if(shadow == null){
        	shadow = c.getBackground().darker().darker();
        }
        return shadow ;
    }

	/**
	 * Sets new outer highlight color of the bevel border.
	 */
	public function setHighlightOuterColor(color:ASColor):Void{
		highlightOuter = color;
	}

    /**
     * Returns the outer highlight color of the bevel border.
     * Will return null if no highlight color was specified
     * at instantiation.
     */
    public function getHighlightOuterColor():ASColor{
        return highlightOuter;
    }

	/**
	 * Sets new inner highlight color of the bevel border.
	 */
	public function setHighlightInnerColor(color:ASColor):Void{
		highlightInner = color;
	}

    /**
     * Returns the inner highlight color of the bevel border.
     * Will return null if no highlight color was specified
     * at instantiation.
     */
    public function getHighlightInnerColor():ASColor{
        return highlightInner;
    }

	/**
	 * Sets new inner shadow color of the bevel border.
	 */
	public function setShadowInnerColor(color:ASColor):Void{
		shadowInner = color;
	}

    /**
     * Returns the inner shadow color of the bevel border.
     * Will return null if no shadow color was specified
     * at instantiation.
     */
    public function getShadowInnerColor():ASColor{
        return shadowInner;
    }

	/**
	 * Sets new outer shadow color of the bevel border.
	 */
	public function setShadowOuterColor(color:ASColor):Void{
		shadowOuter = color;
	}

    /**
     * Returns the outer shadow color of the bevel border.
     * Will return null if no shadow color was specified
     * at instantiation.
     */
    public function getShadowOuterColor():ASColor{
        return shadowOuter;
    }

    /**
     * Sets new type of the bevel border.
     */
    public function setBevelType(bevelType:Float):Void{
        this.bevelType = Std.int(bevelType);
    }

    /**
     * Returns the type of the bevel border.
     */
    public function getBevelType():Float{
        return bevelType;
    }

    private function paintRaisedBevel(c:Component, g:Graphics2D, x:Float, y:Float,
                                    width:Float, height:Float):Void{
        var h:Float= height;
        var w:Float= width;
        var pt:Float= thickness/2;
        x += pt/2;
        y += pt/2;
        w -= pt;
        h -= pt;
        //		 ?scaleMode:LineScaleMode= null,  ?caps:CapsStyle= null,  ?joints:JointStyle= null, 
		 
        var pen:Pen = new Pen(getHighlightOuterColorWith(c), pt, false,   LineScaleMode.NORMAL, CapsStyle.SQUARE,   JointStyle.MITER);
        g.drawLine(pen, x, y, x, y+h-1*pt);
        g.drawLine(pen, x+1*pt, y, x+w-1*pt, y);
		
		pen.setColor(getHighlightInnerColorWith(c));
        g.drawLine(pen, x+1*pt, y+1*pt, x+1*pt, y+h-2*pt);
        g.drawLine(pen, x+2*pt, y+1*pt, x+w-2*pt, y+1*pt);

		pen.setColor(getShadowOuterColorWith(c));
        g.drawLine(pen, x, y+h-0*pt, x+w-0*pt, y+h-0*pt);
        g.drawLine(pen, x+w-0*pt, y, x+w-0*pt, y+h-1*pt);

		pen.setColor(getShadowInnerColorWith(c));
        g.drawLine(pen, x+1*pt, y+h-1*pt, x+w-1*pt, y+h-1*pt);
        g.drawLine(pen, x+w-1*pt, y+1*pt, x+w-1*pt, y+h-2*pt);

    }

    private function paintLoweredBevel(c:Component, g:Graphics2D, x:Float, y:Float,
                                    width:Float, height:Float):Void{
        var h:Float= height;
        var w:Float= width;
        var pt:Float= thickness/2;
        x += pt/2;
        y += pt/2;
        w -= pt;
        h -= pt;
        
        var pen:Pen = new Pen(getShadowInnerColorWith(c), pt, false,  LineScaleMode.NORMAL, CapsStyle.SQUARE,   JointStyle.MITER);
        g.drawLine(pen, x, y, x, y+h-1*pt);
        g.drawLine(pen, x+1*pt, y, x+w-1*pt, y);
        
       	pen.setColor(getShadowOuterColorWith(c));
        g.drawLine(pen, x+1*pt, y+1*pt, x+1*pt, y+h-2*pt);
        g.drawLine(pen, x+2*pt, y+1*pt, x+w-2*pt, y+1*pt);

        pen.setColor(getHighlightOuterColorWith(c));
        g.drawLine(pen, x, y+h-0*pt, x+w-0*pt, y+h-0*pt);
        g.drawLine(pen, x+w-0*pt, y, x+w-0*pt, y+h-1*pt);

        pen.setColor(getHighlightInnerColorWith(c));
        g.drawLine(pen, x+1*pt, y+h-1*pt, x+w-1*pt, y+h-1*pt);
        g.drawLine(pen, x+w-1*pt, y+1*pt, x+w-1*pt, y+h-2*pt);
    }

}