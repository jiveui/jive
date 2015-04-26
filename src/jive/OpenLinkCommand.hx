package jive;

class OpenLinkCommand extends BaseCommand {
    public function new() {
        super(null);
        actionHandler = function() {
            if (null != url) {
                #if (js)
                js.Browser.window.open(url, "_blank");
                #end
            }
        };
    }

    public var url(get, set): String;
    private var _url: String;
    private function get_url(): String { return _url; }
    private function set_url(v: String): String {
        _url = v;
        return v;
    }
}
