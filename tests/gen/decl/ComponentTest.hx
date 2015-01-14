package decl;

class ComponentTest extends org.aswing.JLabel {

    public function destroyHml():Void {
        
    }
    

    inline function get_aSColor__0():org.aswing.ASColor {
        /* tests/declarations/decl/ComponentTest.xml:8 characters: 9-16 */
        var res = new org.aswing.ASColor();
        /* tests/declarations/decl/ComponentTest.xml:9 characters: 13-16 */
        res.rgb = 0x123456;
        /* tests/declarations/decl/ComponentTest.xml:10 characters: 13-18 */
        res.alpha = 0.5;
        return res;
    }

    inline function get_solidBackground__0():org.aswing.SolidBackground {
        /* tests/declarations/decl/ComponentTest.xml:14 characters: 9-24 */
        var res = new org.aswing.SolidBackground();
        return res;
    }

    inline function get_intRectangle__0():org.aswing.geom.IntRectangle {
        /* tests/declarations/decl/ComponentTest.xml:17 characters: 9-26 */
        var res = new org.aswing.geom.IntRectangle();
        /* tests/declarations/decl/ComponentTest.xml:18 characters: 13-19 */
        res.x = 10;
        /* tests/declarations/decl/ComponentTest.xml:19 characters: 13-19 */
        res.y = 11;
        /* tests/declarations/decl/ComponentTest.xml:20 characters: 13-23 */
        res.width = 100;
        /* tests/declarations/decl/ComponentTest.xml:21 characters: 13-24 */
        res.height = 101;
        return res;
    }

    inline function get_intRectangle__1():org.aswing.geom.IntRectangle {
        /* tests/declarations/decl/ComponentTest.xml:25 characters: 9-26 */
        var res = new org.aswing.geom.IntRectangle();
        /* tests/declarations/decl/ComponentTest.xml:26 characters: 13-19 */
        res.x = 11;
        /* tests/declarations/decl/ComponentTest.xml:27 characters: 13-19 */
        res.y = 12;
        /* tests/declarations/decl/ComponentTest.xml:28 characters: 13-23 */
        res.width = 98;
        /* tests/declarations/decl/ComponentTest.xml:29 characters: 13-24 */
        res.height = 99;
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* tests/declarations/decl/ComponentTest.xml:33 characters: 9-26 */
        var res = new org.aswing.geom.IntDimension();
        /* tests/declarations/decl/ComponentTest.xml:34 characters: 13-23 */
        res.width = 95;
        /* tests/declarations/decl/ComponentTest.xml:35 characters: 13-24 */
        res.height = 96;
        return res;
    }

    inline function get_emptyFont__0():org.aswing.EmptyFont {
        /* tests/declarations/decl/ComponentTest.xml:44 characters: 9-18 */
        var res = new org.aswing.EmptyFont();
        return res;
    }

    inline function get_aSColor__1():org.aswing.ASColor {
        /* tests/declarations/decl/ComponentTest.xml:47 characters: 9-16 */
        var res = new org.aswing.ASColor();
        /* tests/declarations/decl/ComponentTest.xml:48 characters: 13-16 */
        res.rgb = 0x654321;
        /* tests/declarations/decl/ComponentTest.xml:49 characters: 13-18 */
        res.alpha = 0.1;
        return res;
    }

    inline function get_intPoint__0():org.aswing.geom.IntPoint {
        /* tests/declarations/decl/ComponentTest.xml:53 characters: 9-22 */
        var res = new org.aswing.geom.IntPoint();
        /* tests/declarations/decl/ComponentTest.xml:54 characters: 13-19 */
        res.x = 15;
        /* tests/declarations/decl/ComponentTest.xml:55 characters: 13-19 */
        res.y = 16;
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* tests/declarations/decl/ComponentTest.xml:59 characters: 9-26 */
        var res = new org.aswing.geom.IntDimension();
        /* tests/declarations/decl/ComponentTest.xml:60 characters: 13-23 */
        res.width = 500;
        /* tests/declarations/decl/ComponentTest.xml:61 characters: 13-24 */
        res.height = 600;
        return res;
    }

    inline function get_intDimension__2():org.aswing.geom.IntDimension {
        /* tests/declarations/decl/ComponentTest.xml:65 characters: 9-26 */
        var res = new org.aswing.geom.IntDimension();
        /* tests/declarations/decl/ComponentTest.xml:66 characters: 13-23 */
        res.width = 10;
        /* tests/declarations/decl/ComponentTest.xml:67 characters: 13-24 */
        res.height = 10;
        return res;
    }

    inline function get_aSColor__2():org.aswing.ASColor {
        /* tests/declarations/decl/ComponentTest.xml:71 characters: 9-16 */
        var res = new org.aswing.ASColor();
        /* tests/declarations/decl/ComponentTest.xml:72 characters: 13-16 */
        res.rgb = 0x123123;
        /* tests/declarations/decl/ComponentTest.xml:73 characters: 13-18 */
        res.alpha = 0.4;
        return res;
    }

    inline function get_intDimension__3():org.aswing.geom.IntDimension {
        /* tests/declarations/decl/ComponentTest.xml:78 characters: 9-26 */
        var res = new org.aswing.geom.IntDimension();
        /* tests/declarations/decl/ComponentTest.xml:79 characters: 13-23 */
        res.width = 100;
        /* tests/declarations/decl/ComponentTest.xml:80 characters: 13-24 */
        res.height = 100;
        return res;
    }

    inline function get_styleTune__0():org.aswing.StyleTune {
        /* tests/declarations/decl/ComponentTest.xml:84 characters: 9-18 */
        var res = new org.aswing.StyleTune();
        return res;
    }

    inline function get_basicLabelUI__0():org.aswing.plaf.basic.BasicLabelUI {
        /* tests/declarations/decl/ComponentTest.xml:88 characters: 9-26 */
        var res = new org.aswing.plaf.basic.BasicLabelUI();
        return res;
    }

    public function new() {
        /* tests/declarations/decl/ComponentTest.xml:2 characters: 1-7 */
        super();
        /* tests/declarations/decl/ComponentTest.xml:5 characters: 5-15 */
        this.alignmentX = 0.3;
        /* tests/declarations/decl/ComponentTest.xml:6 characters: 5-15 */
        this.alignmentY = 0.7;
        /* tests/declarations/decl/ComponentTest.xml:7 characters: 5-15 */
        this.background = get_aSColor__0();
        /* tests/declarations/decl/ComponentTest.xml:13 characters: 5-24 */
        this.backgroundDecorator = get_solidBackground__0();
        /* tests/declarations/decl/ComponentTest.xml:16 characters: 5-11 */
        this.bounds = get_intRectangle__0();
        /* tests/declarations/decl/ComponentTest.xml:24 characters: 5-15 */
        this.clipBounds = get_intRectangle__1();
        /* tests/declarations/decl/ComponentTest.xml:32 characters: 5-16 */
        this.currentSize = get_intDimension__0();
        /* tests/declarations/decl/ComponentTest.xml:38 characters: 5-16 */
        this.dragEnabled = true;
        /* tests/declarations/decl/ComponentTest.xml:39 characters: 5-16 */
        this.dropTrigger = true;
        /* tests/declarations/decl/ComponentTest.xml:40 characters: 5-12 */
        this.enabled = false;
        /* tests/declarations/decl/ComponentTest.xml:41 characters: 5-14 */
        this.focusable = false;
        /* tests/declarations/decl/ComponentTest.xml:42 characters: 5-17 */
        this.focusableSet = true;
        /* tests/declarations/decl/ComponentTest.xml:43 characters: 5-9 */
        this.font = get_emptyFont__0();
        /* tests/declarations/decl/ComponentTest.xml:46 characters: 5-15 */
        this.foreground = get_aSColor__1();
        /* tests/declarations/decl/ComponentTest.xml:52 characters: 5-13 */
        this.location = get_intPoint__0();
        /* tests/declarations/decl/ComponentTest.xml:58 characters: 5-16 */
        this.maximumSize = get_intDimension__1();
        /* tests/declarations/decl/ComponentTest.xml:64 characters: 5-16 */
        this.minimumSize = get_intDimension__2();
        /* tests/declarations/decl/ComponentTest.xml:70 characters: 5-15 */
        this.mideground = get_aSColor__2();
        /* tests/declarations/decl/ComponentTest.xml:76 characters: 5-11 */
        this.opaque = true;
        /* tests/declarations/decl/ComponentTest.xml:77 characters: 5-18 */
        this.preferredSize = get_intDimension__3();
        /* tests/declarations/decl/ComponentTest.xml:83 characters: 5-14 */
        this.styleTune = get_styleTune__0();
        /* tests/declarations/decl/ComponentTest.xml:86 characters: 5-16 */
        this.toolTipText = 'Tooltip text!';
        /* tests/declarations/decl/ComponentTest.xml:87 characters: 5-7 */
        this.ui = get_basicLabelUI__0();
        /* tests/declarations/decl/ComponentTest.xml:90 characters: 5-14 */
        this.uiElement = true;
        /* tests/declarations/decl/ComponentTest.xml:91 characters: 5-15 */
        this.visibility = true;
        /* tests/declarations/decl/ComponentTest.xml:92 characters: 5-9 */
        this.text = 'Hello world!!!';
    }
}
