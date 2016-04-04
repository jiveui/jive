package jive.plaf.flat.background;


import org.aswing.graphics.Pen;
import flash.display.DisplayObject;
import org.aswing.AsWingUtils;
import org.aswing.JList;
import org.aswing.Component;
import org.aswing.GroundDecorator;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;

class ListSeparatorBackground implements GroundDecorator implements UIResource{

    public function new(){
    }

    public function getDisplay(c:Component):DisplayObject{
        return null;
    }

    @:access(org.aswing.JList)
    public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
        if(c.isOpaque()){
            var list: JList = AsWingUtils.as(c, JList);
            if (null == list || null == g) return;

            g.clear();

            if (null != list.cells) {
                var index = 0;
                var pen = new Pen(list.mideground);
                var y = b.y;
                list.cells.each(function(cell) {
                    if (index < list.cells.getSize()-1) {
                        y += cell.getCellComponent().getPreferredSize().height;
                        g.drawLine(pen, b.x, y, b.x + b.width, y);
                        index++;
                    }
                });
            }
        }
    }

}