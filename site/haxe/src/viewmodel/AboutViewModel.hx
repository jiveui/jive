package viewmodel;

import openfl.Assets;
import flash.display.DisplayObject;
import bindx.IBindable;


class AboutViewModel implements IBindable {

    @bindable public var jiveIcon: DisplayObject = Assets.getSvg("logo-dark.svg");

    public function new() {
    }
}
