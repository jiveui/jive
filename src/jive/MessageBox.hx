package jive;

//import assets.icons.Waiting;
import org.aswing.event.PopupEvent;
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

class MessageBox extends Dialog {

    private var panel: SoftBox;
    //private var waitingIcon: MovieClipView;
    private var label: JLabel;

    public function new(title: String, text: String) {
        super(null, title, true);
        defaultCloseOperation = JFrame.DISPOSE_ON_CLOSE;
        setResizable(false);
        content = new JPanel();
        {
            var label = new JLabel(text);
            label.font = UIManager.get("systemFont").changeSize(Std.int(UIManager.get("fontSize")*0.85));
            content.append(label);
        }
    }

    public static function createAndShow(title: String, text: String, ?after: Void -> Void): MessageBox {
        var dialog: MessageBox = new MessageBox(title, text);
        if (null != after) {
            dialog.addEventListener(PopupEvent.POPUP_CLOSED, function(e) { after(); });
        }
        dialog.show();
        return dialog;
    }
}