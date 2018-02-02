package jive.plaf.flat;

import org.aswing.graphics.SolidBrush;
import org.aswing.geom.IntRectangle;
import org.aswing.JTabbedPane;
import org.aswing.ASColor;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.basic.BasicTabbedPaneUI;

class FlatTabbedPaneUI extends BasicTabbedPaneUI {
    public function new() { super(); }

    override private function drawBaseLine(tabBarBounds:IntRectangle, g:Graphics2D, fullB:IntRectangle, selTabB:IntRectangle):Void{
        var b:IntRectangle = tabBarBounds.clone();
        var placement:Int= tabbedPane.getTabPlacement();
        var lineT:Int = Std.int(contentRoundLineThickness);

        if(selTabB == null){
            selTabB = new IntRectangle(Std.int(fullB.x + fullB.width/2), Std.int(fullB.y + fullB.height/2), 0, 0);
        }
        selTabB = selTabB.clone();

        var leadingOffset:Int= tabbedPane.getLeadingOffset();
        var brush = new SolidBrush(tabbedPane.mideground);

        if(isTabHorizontalPlacing()) {
            var isTop:Bool= (placement == JTabbedPane.TOP);
            if(isTop)	{
                b.y = b.y + b.height - contentMargin.top;
            }else{
                b.y += Std.int(contentMargin.top - lineT/2);
            }
            b.width += tabBorderInsets.getMarginWidth();
            b.x -= tabBorderInsets.left;
            var leftPart:IntRectangle = new IntRectangle(b.x, b.y, selTabB.x-b.x, 2);
            var rightPart:IntRectangle = new IntRectangle(selTabB.x+selTabB.width, b.y, b.x+b.width-(selTabB.x+selTabB.width), 2);

            g.fillRectangle(brush, leftPart.x, leftPart.y, leftPart.width, lineT);
            g.fillRectangle(brush, rightPart.x, rightPart.y, rightPart.width, lineT);
        } else {
            var isLeft:Bool= (placement == JTabbedPane.LEFT);
            if(isLeft)	{
                b.x = b.x + b.width - contentMargin.top;
            }else{
                b.x +=Std.int( contentMargin.top - lineT/2);
            }
            b.height += tabBorderInsets.getMarginWidth();
            b.y -= tabBorderInsets.left;

            var topPart:IntRectangle = new IntRectangle(b.x, b.y, lineT, selTabB.y-b.y);
            var botPart:IntRectangle = new IntRectangle(b.x, selTabB.y+selTabB.height, lineT, b.y+b.height-(selTabB.y+selTabB.height));


            g.fillRectangle(brush, topPart.x, topPart.y, 1, topPart.height);
            g.fillRectangle(brush, botPart.x, botPart.y, 1, botPart.height);
        }
    }

}
