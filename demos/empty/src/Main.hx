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

	org.aswing.AsWingManager.initAsStandard(Lib.current);
        
        var mainView: MainView = new MainView();
        mainView.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);

        Lib.current.stage.addEventListener(Event.RESIZE, function(e) {
            mainView.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        });

        mainView.show();
    }
}

