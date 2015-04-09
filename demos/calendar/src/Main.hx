package;
import view.EventPanelModel;
import flash.events.Event;
import org.aswing.border.EmptyBorder;
import org.aswing.Insets;
import org.aswing.SolidBackground;
import org.aswing.UIManager;
import org.aswing.JWindow;
import openfl.events.Event;
import flash.display.Sprite;
import flash.Lib;
import org.aswing.AsWingManager;

class demo.Main extends Sprite {

    public function new() {
        super();
        AsWingManager.initAsStandard(Lib.current);

        var WINDOW = new JWindow(this);

        WINDOW.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));

        //WINDOW.setBorder(new EmptyBorder(null, new Insets(4, 4, 4, 4)));

        var ep = new EventPanel();
        ep.dataContext = new EventPanelModel();

        WINDOW.setContentPane(ep);
        WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        WINDOW.show();

        Lib.current.stage.addEventListener(Event.RESIZE, function(e) {
            WINDOW.setSizeWH(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        });

        Lib.current.addChild(WINDOW);
    }
}