/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.adjuster;

 
import flash.filters.GlowFilter;
import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import org.aswing.StyleTune;
import org.aswing.geom.IntRectangle;
import org.aswing.geom.IntDimension;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.basic.BasicSliderUI;

/**
 * SliderUI for JAdjuster popup slider.
 * @author paling
 * @private
 */
class PopupSliderUI extends BasicSliderUI{
	
	public function new(){
		super();
	}
	
	override private function getPropertyPrefix():String{
		return "Adjuster.";
	}
	
	override private function countTrackRect(b:IntRectangle):Void{
		var thumbSize:IntDimension = getThumbSize();
		var h_margin:Int, v_margin:Int;
		if(isVertical()){
			v_margin = Math.ceil(thumbSize.height/2.0);
			h_margin = Std.int((thumbSize.width - 4)/2);
			trackDrawRect.setRectXYWH(b.x+h_margin, b.y+v_margin, 
				thumbSize.width-h_margin*2, b.height-v_margin*2);
			trackRect.setRectXYWH(b.x, b.y+v_margin, 
				thumbSize.width, b.height-v_margin*2);
		}else{
			h_margin = Math.ceil(thumbSize.width/2.0);
			v_margin = Std.int((thumbSize.height - 4)/2);
			trackDrawRect.setRectXYWH(b.x+h_margin, b.y+v_margin, 
				b.width-h_margin*2, thumbSize.height-v_margin*2);
			trackRect.setRectXYWH(b.x+h_margin, b.y, 
				b.width-h_margin*2, thumbSize.height);
		}
	}
	
	override private function paintTrack(g:Graphics2D, drawRect:IntRectangle):Void{
		trackCanvas.graphics.clear();
		if(!slider.getPaintTrack()){
			return;
		}
		g = new Graphics2D(trackCanvas.graphics);
		var verticle:Bool= (slider.getOrientation() == AsWingConstants.VERTICAL);
		var style:StyleTune = slider.getStyleTune();
		var b:IntRectangle = drawRect.clone();
		var radius:Float= 0;
		if(verticle)	{
			radius = Math.floor(b.width/2);
		}else{
			radius = Math.floor(b.height/2);
		}
		if(radius > style.round){
			radius = style.round;
		}
		g.fillRoundRect(new SolidBrush(slider.getBackground()), b.x, b.y, b.width, b.height, radius);
		var f :Array<BitmapFilter> = new Array<BitmapFilter>();
		
		f.push(new  GlowFilter(0x0, style.shadowAlpha, 5, 5, 1, 1, true));
		f.push(new  DropShadowFilter(1, 45, 0xFFFFFF, 0.3, 1, 1, 1, 1));	
		trackCanvas.filters = f;
	}
		
		
	override private function getPrefferedLength():Int{
		return 100;
	}
}