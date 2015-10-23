package ;

import view.MainView;
import flash.events.Event;
import flash.Lib;
import org.aswing.Insets;
import org.aswing.border.EmptyBorder;
import org.aswing.UIManager;
import org.aswing.SolidBackground;
class Main {

    public static function main() {

        var mainView: MainView = new MainView();
        trace("sdsd");
        mainView.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
        mainView.setBorder(new EmptyBorder(null, Insets.createIdentic(10)));
        mainView.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);

        Lib.current.stage.addEventListener(Event.RESIZE, function(e) {
            mainView.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        });

        mainView.show();
    }
}

