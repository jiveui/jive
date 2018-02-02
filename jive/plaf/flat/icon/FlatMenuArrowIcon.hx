package jive.plaf.flat.icon;


import org.aswing.JMenu;
import org.aswing.AsWingUtils;
import org.aswing.plaf.basic.icon.SolidArrowIcon;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;

class FlatMenuArrowIcon extends SolidArrowIcon  implements UIResource{

    public function new(){
        super(0, 12, ASColor.BLACK);
    }

    override public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
        super.updateIcon(c, g, x, y);

        var m: JMenu = AsWingUtils.as(c, JMenu);
        if (null == m) return;

        //Rotate the arrow for top menu items
        arrow = if (m.isTopLevelMenu()) Math.PI/2 else 0.0;

        paintIconWithColor(if (m.selected || m.model.isRollOver()) m.foreground else m.background.offsetHLS(0, 0.1, 0));
    }
}