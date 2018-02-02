package jive.plaf.flat.icon;


import org.aswing.UIManager;
import org.aswing.JButton;
import org.aswing.AsWingUtils;
import org.aswing.plaf.basic.icon.SolidArrowIcon;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;

class FlatComboBoxArrowIcon extends SolidArrowIcon  implements UIResource{

    public function new(){
        super(Math.PI/2, Std.int(UIManager.get("iconSize")/2), ASColor.BLACK);
    }

    override public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
        super.updateIcon(c, g, x, y);

        var m: JButton = AsWingUtils.as(c, JButton);
        if (null == m) return;

        paintIconWithColor(if (m.selected || m.model.isRollOver()) m.foreground else m.mideground);
    }
}