package jive.plaf.flat;

import org.aswing.UIManager;
import org.aswing.UIManager;
import motion.easing.Linear;
import motion.Actuate;
import org.aswing.StyleTune;
import org.aswing.JScrollPane;
import jive.plaf.flat.icon.FlatComboBoxArrowIcon;
import org.aswing.ASColor;
import org.aswing.plaf.basic.icon.SolidArrowIcon;
import jive.plaf.flat.icon.FlatMenuArrowIcon;
import org.aswing.Insets;
import org.aswing.geom.IntDimension;
import org.aswing.JButton;
import org.aswing.Component;
import org.aswing.plaf.basic.BasicComboBoxUI;

class FlatComboBoxUI extends BasicComboBoxUI {
    public function new() { super(); }

    override private function createDropDownButton():Component{
        var btn:JButton = new JButton("", new FlatComboBoxArrowIcon());
        btn.setFocusable(false);
        btn.setPreferredSize(new IntDimension(Std.int(UIManager.get("iconSize")/2), Std.int(UIManager.get("iconSize")/2)));
        btn.setBackgroundDecorator(null);
        btn.setMargin(new Insets());
        btn.setBorder(null);

        //make it proxy to the combobox
        btn.setMideground(null);
        btn.setStyleTune(null);
        return btn;
    }

    override private function installDefaults():Void {
        super.installDefaults();
        box.notEditableForeground = getColor(getPropertyPrefix() + "notEditableForeground");
        box.notEditableBackground = getColor(getPropertyPrefix() + "notEditableBackground");
    }

    override private function layoutCombobox():Void {
        super.layoutCombobox();
        // Mideground - normal state
        dropDownButton.mideground = if (!box.enabled)
            box.foreground.offsetHLS(0, 0.3, 0)
            else if (box.editable) box.foreground.offsetHLS(0, 0.3, 0) else box.notEditableBackground.offsetHLS(0, -0.1, 0);
        //Foreground - rolled over and pressed states
        dropDownButton.foreground = if (!box.enabled)
            box.foreground.offsetHLS(0, 0.3, 0)
            else if (box.editable) box.foreground else box.notEditableForeground;
    }

    override private function getScollPane():JScrollPane{
        if(scollPane == null){
            scollPane = new JScrollPane(getPopupList());
            scollPane.setBorder(getBorder(getPropertyPrefix()+"popupBorder"));
            scollPane.setOpaque(false);
            scollPane.setStyleProxy(box);
            scollPane.setBackground(getColor(getPropertyPrefix()+"popupBackground"));
            scollPane.setStyleTune(new StyleTune(0, 0, 0, 0, UIManager.get("cornerSize")));
        }
        return scollPane;
    }

    override private function startMoveToView():Void {
        var gp = box.getGlobalLocation();
        gp.y += box.getHeight();
        popup.setGlobalLocation(gp);
        popup.alpha = 0.0;
        Actuate.stop(popup);
        Actuate.tween(popup, 0.25, { alpha: 1.0 })
            .ease(Linear.easeNone)
            .onComplete(function() { popup.alpha = 1.0; });
    }

    override private function hidePopup():Void {
        Actuate.stop(popup);
        super.hidePopup();
    }
}
