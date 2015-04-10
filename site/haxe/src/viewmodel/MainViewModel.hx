package viewmodel;

import openfl.Assets;
import flash.display.DisplayObject;
import bindx.IBindable;
import demo.viewmodel.DemoViewModel;


class MainViewModel implements IBindable {

    @bindable public var demoVM: DemoViewModel = new DemoViewModel();
    #if mobile
    @bindable public var jiveIcon: DisplayObject = Assets.getSvg("logo-dark.svg");
    #else
    @bindable public var jiveIcon: DisplayObject = Assets.getSvg("logo-light.svg");
    #end
    @bindable public var contentIndex: Int = 0;
    public function new() {}
}
