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

    public var baseUrl: String = "";

    public function new() {

        #if (site_deployment_github)
        baseUrl = "/jive";
        #end

        demoVM = new DemoViewModel();
        demoVM.areLinksVisible = true;
        aboutVM = new AboutViewModel();

        openDocumentation = new BaseCommand(function() { openLinkInBlankPage(baseUrl + "/docs/api/index.html"); });
        openDownload = new BaseCommand(function() { contentIndex = 1; });
        openContribute = new BaseCommand(function() { openLinkInBlankPage("http://github.com/ngrebenshikov/jive"); });
        openAbout = new BaseCommand(function() { contentIndex = 0; });
        openDemo = new BaseCommand(function() { contentIndex = 2; });
    }
}
