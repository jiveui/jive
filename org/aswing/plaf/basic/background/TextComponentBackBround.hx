/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.background;


import flash.display.DisplayObject;
import flash.display.Shape; 
import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import org.aswing.ASColor;
import org.aswing.AsWingManager;
import org.aswing.Component;
import org.aswing.EditableComponent;
import org.aswing.GroundDecorator;
import org.aswing.StyleResult;
import org.aswing.StyleTune;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;

/**
 * @private
 */
class TextComponentBackBround implements GroundDecorator implements UIResource{
	
	private var shape:Shape;
	
	public function new(){
		shape = new Shape();
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, r:IntRectangle):Void{
   
		shape.visible = c.isOpaque();
    	if(c.isOpaque()){
    		shape.graphics.clear();
    		g = new Graphics2D(shape.graphics);
			var cl:ASColor = c.getBackground();
			var tune:StyleTune = c.getStyleTune();
			var result:StyleResult = new StyleResult(cl, tune);
			var ml:ASColor = result.bdark;
			var ed:EditableComponent = AsWingUtils.as(c,EditableComponent)	;
			var editable:Bool= true;
			if(ed != null){
				editable = ed.isEditable();
			}
		 
			if(!c.isEnabled() || !editable){
				ml = ml.changeAlpha(ml.getAlpha()*getChangeSharpen(c.isEnabled(), editable));
				cl = cl.changeAlpha(cl.getAlpha()*getChangeAlpha(c.isEnabled(), editable));
			}

            var tf = AsWingUtils.as(c, JTextField);

			r = new IntRectangle(0, 0, Std.int(c.getWidth()-1), Std.int(c.getHeight()-1));
			var round:Float= tune.round;
			if(round >= 1){
				g.fillRoundRect(new SolidBrush(cl), r.x, r.y, r.width, r.height, round);
				g.fillRoundRectRingWithThickness(new SolidBrush(ml), r.x, r.y, r.width, r.height, round, 1, round-1);
			}else{
				g.fillRectangle(new SolidBrush(cl), r.x, r.y, r.width, r.height);
				g.fillRectangleRingWithThickness(new SolidBrush(ml), r.x, r.y, r.width, r.height, 1);
			}
			var f :Array<BitmapFilter>= new Array<BitmapFilter>();
			f.push(new  DropShadowFilter(1, 45, cl.getRGB(), tune.shadowAlpha*cl.getAlpha(), 0, 0, 1, 1));
			shape.filters = f;
		}
	}
	
	private function getChangeSharpen(enabled:Bool, editable:Bool):Float{
		if(enabled!=true){
			return 0.2;
		}else if(editable!=true){
			return 1;
		}else{
			return 1;
		}
	}
	
	private function getChangeAlpha(enabled:Bool, editable:Bool):Float{
		if(enabled!=true){
			return 0.2;
		}else if(editable!=true){
			return 0.3;
		}else{
			return 1;
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
}