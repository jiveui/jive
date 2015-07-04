package jive;

//import assets.icons.Waiting;
import org.aswing.UIManager;
import org.aswing.CenterLayout;
import org.aswing.JPanel;
import org.aswing.geom.IntDimension;
import org.aswing.JSpacer;
import flash.Lib;
import org.aswing.AsWingManager;
import org.aswing.JButton;
import org.aswing.JProgressBar;
import org.aswing.JWindow;
import org.aswing.JLabel;
import org.aswing.SoftBox;
import org.aswing.SolidBackground;
import org.aswing.ASColor;
import org.aswing.JFrame;
import org.aswing.Insets;
import org.aswing.border.EmptyBorder;

class WaitingPopup extends Dialog {

    private var panel: SoftBox;
    //private var waitingIcon: MovieClipView;
    private var label: JLabel;

    public function new(title: String) {
        super(null, "", true);
        setResizable(false);
        setClosable(false);
        content = new JPanel(new CenterLayout());
        content.border = new EmptyBorder(null, Insets.createIdentic(UIManager.get("margin")));
        content.append(new JLabel(title));
    }

    public static function createAndShow(title: String): WaitingPopup {
        var dialog: WaitingPopup = new WaitingPopup(title);
        dialog.show();
        return dialog;
    }
}