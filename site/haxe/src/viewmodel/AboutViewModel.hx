package viewmodel;

import jive.Navigation;
import jive.BaseCommand;
import jive.Command;
import openfl.Assets;
import flash.display.DisplayObject;
import bindx.IBindable;


class AboutViewModel implements IBindable {

    @bindable public var jiveIcon: DisplayObject = null; //Assets.getSvg("logo-dark.svg");
    @bindable public var openFlIcon: DisplayObject = null; //Assets.getSvg("openfl.svg");
    @bindable public var brainIcon: DisplayObject = null; //Assets.getSvg("brain.svg");
    @bindable public var desktopIcon: DisplayObject = null; //Assets.getSvg("desktop.svg");
    @bindable public var arrowIcon(get, set): DisplayObject;
    private function get_arrowIcon(): DisplayObject { return null; }//Assets.getSvg("arrow.svg"); }
    private function set_arrowIcon(v: DisplayObject): DisplayObject { return v; }

    @bindable public var openDemo: Command;

    public function new() {
        #if (!site_target_mobile)
        openDemo = new BaseCommand(function() { Navigation.instance.navigate([Main.mainView.menuBar.getMenu(2)]); });
        #end
    }
}
