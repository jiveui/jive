package jive.themes;

class Theme {
    public var foreground: Color = Color.BLUE;
    public var margin: Int;
    public var cornerSize: Int;
    public var dpiScale: Int;
    public var fontSize: Float = 14;
    public var controlHeaderFont: Font;

    public function new() {
    	var size = 700;

        cornerSize = Std.int(fontSize / 3);
        margin = Std.int(size / 10);
        dpiScale = Capabilities.screenDPI / 72;
        controlHeaderFont = new Font();
    }
}
