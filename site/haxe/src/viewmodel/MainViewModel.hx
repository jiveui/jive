package viewmodel;

import jive.BaseCommand;
import jive.Command;
import js.Browser;
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

    @bindable public var openDocumentation: Command;
    @bindable public var openDownload: Command;
    @bindable public var openContribute: Command;

    public function openLinkInBlankPage(url: String) {
        Browser.window.open(url, "_blank");
    }

    public function new() {
        openDocumentation = new BaseCommand(function() { openLinkInBlankPage("/docs/api/index.html"); });
        openDownload = new BaseCommand(function() { openLinkInBlankPage("/download"); });
        openContribute = new BaseCommand(function() { openLinkInBlankPage("http://github.com/ngrebenshikov/jive"); });
    }
}
