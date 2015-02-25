package jive.plaf.flat.border;


import org.aswing.graphics.SolidBrush;
import flash.display.Shape;
import flash.display.DisplayObject;

import flash.filters.BitmapFilter;
import flash.filters.DropShadowFilter;
import org.aswing.Border;
import org.aswing.Component;
import org.aswing.StyleTune;
import org.aswing.ASColor;
import org.aswing.StyleResult;
import org.aswing.Insets;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.basic.BasicGraphicsUtils;

class FlatPopupMenuBorder implements Border implements UIResource{

    private var shape:Shape;

    public function new(){
        shape = new Shape();
    }

    public function updateBorder(c:Component, g:Graphics2D, b:IntRectangle):Void{
        shape.graphics.clear();
        if(c.isOpaque()){
            g = new Graphics2D(shape.graphics);
            g.fillRoundRect(new SolidBrush(c.getBackground()), b.x, b.y, b.width, b.height, c.styleTune.round);
        }
        shape.visible = c.isOpaque();
    }

    public function getBorderInsets(com:Component, bounds:IntRectangle):Insets{
        return new Insets(3, 3, 3, 3);
    }

    public function getDisplay(c:Component):DisplayObject{
        return shape;
    }

}