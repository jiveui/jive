package decl;

class ComponentTest extends org.aswing.Component {

    inline function get_field0():org.aswing.ASColor {
        /* tests/declarations/decl/ComponentTest.xml:7 characters: 9-16 */
        var res = new org.aswing.ASColor();
        /* tests/declarations/decl/ComponentTest.xml:8 characters: 13-16 */
        res.rgb = 0x123456;
        /* tests/declarations/decl/ComponentTest.xml:9 characters: 13-18 */
        res.alpha = 0.5;
        return res;
    }

    inline function get_field1():org.aswing.SolidBackground {
        /* tests/declarations/decl/ComponentTest.xml:13 characters: 9-24 */
        var res = new org.aswing.SolidBackground();
        return res;
    }

    inline function get_field2():org.aswing.geom.IntRectangle {
        /* tests/declarations/decl/ComponentTest.xml:16 characters: 9-26 */
        var res = new org.aswing.geom.IntRectangle();
        /* tests/declarations/decl/ComponentTest.xml:17 characters: 13-19 */
        res.x = 10;
        /* tests/declarations/decl/ComponentTest.xml:18 characters: 13-19 */
        res.y = 11;
        /* tests/declarations/decl/ComponentTest.xml:19 characters: 13-23 */
        res.width = 100;
        /* tests/declarations/decl/ComponentTest.xml:20 characters: 13-24 */
        res.height = 101;
        return res;
    }

    inline function get_field3():org.aswing.geom.IntRectangle {
        /* tests/declarations/decl/ComponentTest.xml:24 characters: 9-26 */
        var res = new org.aswing.geom.IntRectangle();
        /* tests/declarations/decl/ComponentTest.xml:25 characters: 13-19 */
        res.x = 11;
        /* tests/declarations/decl/ComponentTest.xml:26 characters: 13-19 */
        res.y = 12;
        /* tests/declarations/decl/ComponentTest.xml:27 characters: 13-23 */
        res.width = 98;
        /* tests/declarations/decl/ComponentTest.xml:28 characters: 13-24 */
        res.height = 99;
        return res;
    }

    inline function get_field4():org.aswing.geom.IntDimension {
        /* tests/declarations/decl/ComponentTest.xml:32 characters: 9-26 */
        var res = new org.aswing.geom.IntDimension();
        /* tests/declarations/decl/ComponentTest.xml:33 characters: 13-23 */
        res.width = 95;
        /* tests/declarations/decl/ComponentTest.xml:34 characters: 13-24 */
        res.height = 96;
        return res;
    }

    public function new() {
        /* tests/declarations/decl/ComponentTest.xml:2 characters: 1-10 */
        super();
        /* tests/declarations/decl/ComponentTest.xml:4 characters: 5-15 */
        this.alignmentX = 0.3;
        /* tests/declarations/decl/ComponentTest.xml:5 characters: 5-15 */
        this.alignmentY = 0.7;
        /* tests/declarations/decl/ComponentTest.xml:6 characters: 5-15 */
        this.background = get_field0();
        /* tests/declarations/decl/ComponentTest.xml:12 characters: 5-24 */
        this.backgroundDecorator = get_field1();
        /* tests/declarations/decl/ComponentTest.xml:15 characters: 5-11 */
        this.bounds = get_field2();
        /* tests/declarations/decl/ComponentTest.xml:23 characters: 5-15 */
        this.clipBounds = get_field3();
        /* tests/declarations/decl/ComponentTest.xml:31 characters: 5-16 */
        this.currentSize = get_field4();
        /* tests/declarations/decl/ComponentTest.xml:37 characters: 5-16 */
        this.dragEnabled = true;
    }
}
