package jive.plaf.flat.tabbedpane;

import org.aswing.ASColor;
import org.aswing.JButton;

class FlatTabButton extends JButton {

    public var normalColor: ASColor;
    public var selectedColor: ASColor;
    public var rolloverColor: ASColor;
    public var borderColor: ASColor;

    public function new() {
        super();
        setName("FlatTabButton");
    }

    override private function calculateTargetBackgroundTransitionFactor(): Float {
        return
            if (model.isPressed() || model.isSelected()) -1.0
            else if (model.isRollOver()) 1.0
            else 0.0;
    }

    @:dox(hide)
    override public function getUIClassID():String{
        return "TabButtonUI";
    }

    @:dox(hide)
    override public function getDefaultBasicUIClass():Class<Dynamic>{
        return jive.plaf.flat.tabbedpane.TabButtonUI;
    }
}
