package jive.plaf.flat;

import org.aswing.Component;
import org.aswing.plaf.UIResource;
import org.aswing.ASFont;
import org.aswing.graphics.SolidBrush;
import org.aswing.geom.IntRectangle;
import org.aswing.ASColor;
import org.aswing.graphics.Graphics2D;
import org.aswing.JMenuItem;
import org.aswing.plaf.basic.BasicMenuUI;

class FlatMenuUI extends BasicMenuUI {
    public function new() { super(); }

    override private function doPaintMenuBackground(c:JMenuItem, g:Graphics2D, cl:ASColor, r:IntRectangle, round:Float):Void{
        if (isTopMenu()) round = 0;
        g.fillRoundRect(new SolidBrush(cl), r.x, r.y, r.width, r.height, round);
    }

    override private function useCheckAndArrow():Bool { return true; }

    override public function paint(c:Component, g:Graphics2D, b:IntRectangle):Void{
        if(isTopMenu()) {
            menuItem.font = getFont(getPropertyPrefix() + "topMenuFont");
        }
        super.paint(c, g, b);
    }
}
