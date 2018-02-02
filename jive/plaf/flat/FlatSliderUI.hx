package jive.plaf.flat;

import org.aswing.Component;
import org.aswing.geom.IntDimension;
import org.aswing.graphics.SolidBrush;
import org.aswing.StyleTune;
import org.aswing.AsWingConstants;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.basic.BasicSliderUI;
class FlatSliderUI extends BasicSliderUI {
    public function new() { super(); }

    override private function paintTrack(g:Graphics2D, drawRect:IntRectangle):Void{
        trackCanvas.graphics.clear();
        if(!slider.getPaintTrack()){
            return;
        }
        g = new Graphics2D(trackCanvas.graphics);
        var verticle:Bool= (slider.getOrientation() == AsWingConstants.VERTICAL);
        var style:StyleTune = slider.styleTune;
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
        g.fillRoundRect(new SolidBrush(slider.background), b.x, b.y, b.width, b.height, radius);
    }

    override private function paintTrackProgress(g:Graphics2D, trackDrawRect:IntRectangle):Void{
        if(!slider.paintTrack){
            return;
        }

        var style:StyleTune = slider.styleTune;
        var rect:IntRectangle = trackDrawRect.clone();
        var width:Int;
        var height:Int;
        var x:Int;
        var y:Int;
        var inverted:Bool= slider.isInverted;
        var radius:Float= 0;

        if(isVertical()){
            radius = Math.floor(rect.width/2);
            width = rect.width;
            height = Std.int(thumbRect.y + thumbRect.height/2 - rect.y);
            x = rect.x;
            if(inverted)	{
                y = rect.y;
            }else{
                height = Std.int(rect.y + rect.height - thumbRect.y - thumbRect.height/2);
                y = Std.int(thumbRect.y + thumbRect.height/2);
            }
        } else {
            height = rect.height;
            radius = Math.floor(rect.height/2);
            if(inverted)	{
                width = Std.int(rect.x + rect.width - thumbRect.x - thumbRect.width/2);
                x = Std.int(thumbRect.x + thumbRect.width/2);
            }else{
                width = Std.int(thumbRect.x + thumbRect.width/2 - rect.x);
                x = rect.x;
            }
            y = rect.y;
        }

        if(radius > style.round) {
            radius = style.round;
        }
        g.fillRoundRect(new SolidBrush(progressColor), x, y, width, height, radius);
    }

    override private function countTrackRect(b:IntRectangle):Void{
        var thumbSize:IntDimension = getThumbSize();
        var h_margin:Int, v_margin:Int;
        if(isVertical()){
            v_margin = Math.ceil(thumbSize.height/2.0);
            h_margin = Math.ceil(thumbSize.width/6);
            trackDrawRect.setRectXYWH(b.x+h_margin, b.y+v_margin,
                thumbSize.width-h_margin*2, b.height-v_margin*2);
            trackRect.setRectXYWH(b.x, b.y+v_margin,
                thumbSize.width, b.height-v_margin*2);
        }else{
            h_margin = Math.ceil(thumbSize.width/2.0);
            v_margin = Math.ceil(thumbSize.height/6);
            trackDrawRect.setRectXYWH(b.x+h_margin, b.y+v_margin,
                b.width-h_margin*2, thumbSize.height-v_margin*2);
            trackRect.setRectXYWH(b.x+h_margin, b.y,
                b.width-h_margin*2, thumbSize.height);
        }
    }

    override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
        super.paint(c, g, b);
        progressCanvas.graphics.clear();
        paintTrackProgress(new Graphics2D(progressCanvas.graphics), trackDrawRect);
    }
}
