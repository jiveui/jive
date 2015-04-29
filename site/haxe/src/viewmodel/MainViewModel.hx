package viewmodel;

import bindx.Bind;
import jive.BaseCommand;
import jive.Command;
import js.Browser;
import openfl.Assets;
import flash.display.DisplayObject;
import bindx.IBindable;
import demo.viewmodel.DemoViewModel;


class MainViewModel implements IBindable {

    @bindable public var demoVM: DemoViewModel;
    @bindable public var aboutVM: AboutViewModel;

    #if mobile
    @bindable public var jiveIcon: DisplayObject = Assets.getSvg("logo-dark.svg");
    #else
    @bindable public var jiveIcon: DisplayObject = Assets.getSvg("logo-light.svg");
    #end
    @bindable public var contentIndex: Int = 0;

    @bindable public var openDocumentation: Command;
    @bindable public var openDownload: Command;
    @bindable public var openContribute: Command;
    @bindable public var openAbout: Command;
    @bindable public var openDemo: Command;

    public function openLinkInBlankPage(url: String) {
        Browser.window.open(url, "_blank");
    }

    public function new() {
        demoVM = new DemoViewModel();
        demoVM.areLinksVisible = true;
        aboutVM = new AboutViewModel();

        var baseUrl = if (Browser.location.pathname != "/") Browser.location.pathname else "";
        baseUrl = StringTools.replace(baseUrl,"index.html", "");

        openDocumentation = new BaseCommand(function() { openLinkInBlankPage(baseUrl + "/docs/api/index.html"); });
        openDownload = new BaseCommand(function() { openLinkInBlankPage("/download"); });
        openContribute = new BaseCommand(function() { openLinkInBlankPage("http://github.com/ngrebenshikov/jive"); });
        openAbout = new BaseCommand(function() { contentIndex = 0; });
        openDemo = new BaseCommand(function() { contentIndex = 1; });
    }
}
