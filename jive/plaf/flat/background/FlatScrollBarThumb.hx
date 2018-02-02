package jive.plaf.flat.background;

import org.aswing.graphics.SolidBrush;
import org.aswing.ASColor;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.basic.background.ScrollBarThumb;

class FlatScrollBarThumb extends ScrollBarThumb{
    public function new() { super(); }

    override private function paint() {
        thumb.graphics.clear();
        var g:Graphics2D = new Graphics2D(thumb.graphics);

        var cl:ASColor = bar.mideground;
        if(!bar.enabled){//disabled
            cl = cl.offsetHLS(0, 0.1, -0.03);
        }else if(rollover)	{//over
            cl = cl.offsetHLS(0, -0.2, 0);
        }

        g.fillRoundRect(new SolidBrush(cl),
            if (verticle) 2 else 0,
            if (verticle) 0 else 2,
            if (verticle) size.width-4 else size.width,
            if (verticle) size.height else size.height-4,
            (Math.min(size.width, size.height)-4)/2);
    }
}
