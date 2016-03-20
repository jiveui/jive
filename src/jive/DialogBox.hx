package jive;

//import assets.icons.Waiting;

import org.aswing.SoftBoxLayout;
import org.aswing.JButton;
import org.aswing.JLabel;
import org.aswing.JLabelButton;
import org.aswing.ASColor;
import org.aswing.JFrame;
import org.aswing.SoftBox;
import org.aswing.UIManager;
import org.aswing.AsWingConstants;

typedef DialogButton = {
    private var title: String;
    private var command: Void -> Void;
}

class DialogBox extends Dialog {
    public static function createAndShow(title: String, text: String/*, ?after: Void -> Void*/): DialogBox {
        var dialog: DialogBox = new DialogBox(title, text);
//        if (null != after) {
//            dialog.addEventListener(PopupEvent.POPUP_CLOSED, function(e) { after(); });
//        }
        dialog.show();

        return dialog;
    }

//    private var panel: SoftBox;
    private var label: JLabel;
    private var buttons: Array<JLabelButton>;
    private var buttonsWrapper: SoftBox;

    public function new(title: String, text: String) {
        super(null, title, true);
        defaultCloseOperation = JFrame.DISPOSE_ON_CLOSE;
        setResizable(false);
        closable = false;

        buttonsWrapper = new SoftBox();
        buttonsWrapper.axis = SoftBoxLayout.X_AXIS;
        buttonsWrapper.align = AsWingConstants.CENTER;

        label = new JLabel(text);
        label.font = UIManager.get("dialogBoxFont");

        var contentWrapper = new SoftBox();
        contentWrapper.axis = SoftBoxLayout.Y_AXIS;
        contentWrapper.gap = label.getPreferredSize().height;

        content = contentWrapper;
        content.append(label);
        content.append(buttonsWrapper);

        var defaultButton = {title: "OK", command: function() {}};
        var defaultListButton = new List();
        defaultListButton.add(defaultButton);

        setButtons(defaultListButton);
    }

    private override function set_foreground(v: ASColor): ASColor {
        label.foreground = v;
        for (button in buttons) {
            button.foreground = v;
        }
        return super.set_foreground(v);
    }

    private function createButton(button: DialogButton): JLabelButton {
        var btn: JLabelButton = new JLabelButton();
        btn.text = button.title;
        btn.font = UIManager.get("dialogBoxButtonFont");
        btn.foreground = this.foreground;
        btn.command = new BaseCommand(function() {
            closeReleased();
            if (button.command != null) button.command();
        });

        return btn;
    }

    public function setButtons(buttons: List<DialogButton>) {
        var btn: JLabelButton;

        this.buttons = new Array();
        buttonsWrapper.removeAll();

        for (button in buttons) {
            if (button.title != null && button.title.length > 0) {
                btn = createButton(button);
                buttonsWrapper.append(btn);
                this.buttons.push(btn);
            }
        }
    }
}