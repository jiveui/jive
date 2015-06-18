package jive.plaf.flat;

import motion.easing.Linear;
import motion.Actuate;
import motion.Actuate;
import flash.events.MouseEvent;
import org.aswing.StyleTune;
import org.aswing.ASFont;
import jive.plaf.flat.border.TextCellComponentBorder;
import org.aswing.geom.IntPoint;
import org.aswing.JSharedToolTip;
import org.aswing.event.ResizedEvent;
import org.aswing.ASColor;
import org.aswing.JLabel;
import org.aswing.BoxLayout;
import org.aswing.JPanel;

class TextCellComponent extends JPanel {
    public var isFirst: Bool;
    public var isLast: Bool;

    private var label: JLabel;

    public var value(get, set): String;
    private function get_value(): String { return label.text; }
    private function set_value(v: String): String {
        label.text = v;
        __resized(null);
        return v;
    }

    private static var sharedToolTip:JSharedToolTip;

    public var rollover: Bool;

    public var transitBackgroundFactor: Float = 0.0;

    private function calculateTargetBackgroundTransitionFactor(): Float {
        return if (rollover) 1.0 else 0.0;
    }

    private function doBackgroundTransition(immediately:Bool = false) {

        var targetFactor: Float = calculateTargetBackgroundTransitionFactor();
        if (transitBackgroundFactor != targetFactor) {
            if (immediately) {
                transitBackgroundFactor = targetFactor;
                return;
            }
            Actuate.stop(this, "transitBackgroundFactor");
            Actuate.tween(this, 0.4, { transitBackgroundFactor: targetFactor })
            .ease(Linear.easeNone)
            .onUpdate(function() {
                repaint();
            })
            .onComplete(function() { transitBackgroundFactor = targetFactor; });
        }
    }

    public function new() {

        label = new JLabel();
        label.setHorizontalAlignment(JLabel.LEFT);
        label.setOpaque(false);
        label.setFocusable(false);
        label.addEventListener(ResizedEvent.RESIZED, __resized);

        super(new BoxLayout());

        if(sharedToolTip == null){
            sharedToolTip = JSharedToolTip.getSharedInstance();
            sharedToolTip.setOffsetsRelatedToMouse(false);
            sharedToolTip.setOffsets(new IntPoint(0, 0));
        }

        append(label);

        border = new TextCellComponentBorder();
        styleTune = new StyleTune(0, 0, 0, 0, 5);

        addEventListener(MouseEvent.ROLL_OVER, function(e) { rollover = true; doBackgroundTransition(); });
        addEventListener(MouseEvent.ROLL_OUT, function(e) { rollover = false; doBackgroundTransition(); });
    }

    override function setForeground(color: ASColor) {
        super.setForeground(color);
        label.setForeground(color);
    }

    override function setFont(font: ASFont) {
        super.setFont(font);
        label.setFont(font);
    }

    private function __resized(e:ResizedEvent):Void {
        if(label.getWidth() < label.getPreferredWidth()){
            label.setToolTipText(value);
            sharedToolTip.registerComponent(label);
        }else{
            label.setToolTipText(null);
            sharedToolTip.unregisterComponent(label);
        }
    }

    override public function updateUI():Void {}
}
