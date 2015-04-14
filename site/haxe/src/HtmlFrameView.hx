package ;

import snap.Snap;
import org.aswing.Component;

class HtmlFrameView extends Component {

    private var foreignObject: SnapFragment;

    public function new() {
        super();

        foreignObject = Snap.parse("<foreignObject width=\"800\" height=\"300\"><body><iframe src=\"http://www.grebenshikov.ru\"></iframe></body></foreignObject>");
        snap.append(foreignObject);

    }

    public var url(get, set): Int;
    private var _url: Int;
    private function get_url(): Int { return _url; }
    private function set_url(v: Int): Int {
        _url = v;
        return v;
    }
}
