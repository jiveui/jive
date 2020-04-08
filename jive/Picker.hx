package jive;

import org.aswing.UIManager;
import jive.plaf.flat.FlatPickerUI;
import org.aswing.FlowLayout;
import org.aswing.Component;
import jive.LookAndFeelHelper;
import org.aswing.AsWingUtils;
import org.aswing.event.PropertyChangeEvent;
import org.aswing.Insets;
import org.aswing.border.EmptyBorder;
import org.aswing.geom.IntPoint;
import org.aswing.JLabel;
import org.aswing.BorderLayout;
import org.aswing.JViewport;
import org.aswing.SoftBox;
import org.aswing.SoftBoxLayout;
import org.aswing.JPanel;

class Picker extends JPanel {

    public var MAGNETIC_BORDER_SIZE: Int;

    private var panel: SoftBox;
    public var viewport: JViewport;

    public var model: PickerModel;

    public function new(model: PickerModel) {
        MAGNETIC_BORDER_SIZE = 2*UIManager.getFont("Label.font").size;

        super();

        this.model = model;

        panel = new SoftBox(SoftBoxLayout.Y_AXIS);
        {
            var items: Array<Dynamic> = model.items.copy();
            addEmptyItems(items, Math.floor(model.visibleItems/2));

            Lambda.iter(items, function(d) {
                var l: JLabel = createLabel(d);
//                if (l.getPreferredWidth() < 100*LookAndFeelHelper.scale) {
//                    var p = new JPanel(new FlowLayout(FlowLayout.CENTER, 0, 0, false));
//                    p.append(l);
//                    p.setPreferredHeight(MAGNETIC_BORDER_SIZE);
//                    p.setPreferredWidth(Std.int(100*LookAndFeelHelper.scale));
//                    panel.append(p);
//                } else {
                    panel.append(l);
//                }
            });
            panel.setPreferredHeight(MAGNETIC_BORDER_SIZE*items.length);
        }
        viewport = new JViewport(panel, false, false);
        viewport.magneticBorderSize = MAGNETIC_BORDER_SIZE;
        viewport.setPreferredHeight(MAGNETIC_BORDER_SIZE * model.visibleItems);
        viewport.addEventListener(JViewport.SCROLLED, onRollersScrolled);

        append(viewport);

        setPreferredHeight(MAGNETIC_BORDER_SIZE * model.visibleItems + Jive.toPixelSize(4));
        setBorder(new EmptyBorder(null, Insets.createIdentic(Jive.toPixelSize(2))));

        setUI(getUI());

        update();

        model.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onModelPropertyChanged);
    }

    override public function getDefaultBasicUIClass():Class<Dynamic>{
        return FlatPickerUI;
    }

    override public function getUIClassID():String{
        return "PickerUI";
    }

    private function createLabel(d: Dynamic): JLabel {
        var s = Std.string(d);
        s = s.substr(0,1).toUpperCase() + s.substr(1);
        var l = new JLabel(if (d != null && s != "0") s else "");
//        l.setUI(new TimeTrackerLabelUI(0xff000000, 0x00000000));
        l.setPreferredHeight(MAGNETIC_BORDER_SIZE);
        l.setBorder(new EmptyBorder(null, new Insets(0,Jive.toPixelSize(10),0, Jive.toPixelSize(10))));
        return l;
    }

    private function addEmptyItems(a: Array<Dynamic>, num: Int) {
        for (i in 0...num) {
            a.push(null);
            a.unshift(null);
        }
    }

    private function getSelectedIndexByViewportOffset(offset: Int) {
        return Math.round(offset / MAGNETIC_BORDER_SIZE);
    }

    private function onRollersScrolled(e: Dynamic) {
        model.updateBySelectedIndex(getSelectedIndexByViewportOffset(viewport.getViewPosition().y));
    }

    private function onModelPropertyChanged(e: Dynamic) {
        var event: PropertyChangeEvent = AsWingUtils.as(e, PropertyChangeEvent);
        if (event.getPropertyName() == "selected") {
            update();
        }
    }

    private function update() {
        if (null == viewport) return;
        viewport.setViewPosition(new IntPoint(0, model.getSelectedIndex() * MAGNETIC_BORDER_SIZE));
    }
}
