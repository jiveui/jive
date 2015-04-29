package viewmodel;

import jive.Navigation;
import jive.BaseCommand;
import jive.Command;
import openfl.Assets;
import flash.display.DisplayObject;
import bindx.IBindable;


class AboutViewModel implements IBindable {

    @bindable public var jiveIcon: DisplayObject = Assets.getSvg("logo-dark.svg");
    @bindable public var openFlIcon: DisplayObject = Assets.getSvg("openfl.svg");
    @bindable public var brainIcon: DisplayObject = Assets.getSvg("brain.svg");
    @bindable public var desktopIcon: DisplayObject = Assets.getSvg("desktop.svg");
    @bindable public var arrowIcon(get, set): DisplayObject;
    private function get_arrowIcon(): DisplayObject { return Assets.getSvg("arrow.svg"); }
    private function set_arrowIcon(v: DisplayObject): DisplayObject { return v; }

    @bindable public var openDemo: Command;

    public function new() {
        #if (!mobile)
        openDemo = new BaseCommand(function() { Navigation.instance.navigate([Main.mainView.menuBar.getMenu(2)]); });
        #end
    }
}
