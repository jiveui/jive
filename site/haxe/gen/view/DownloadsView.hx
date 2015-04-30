package view;

class DownloadsView extends org.aswing.JPanel {

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/desktop/view/DownloadsView.xml:12 characters: 9-21 */
        var res = new org.aswing.BorderLayout();
        /* declarations/desktop/view/DownloadsView.xml:12 characters: 23-27 */
        res.hgap = 30;
        /* declarations/desktop/view/DownloadsView.xml:12 characters: 33-37 */
        res.vgap = 30;
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/desktop/view/DownloadsView.xml:18 characters: 17-23 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/DownloadsView.xml:18 characters: 55-59 */
        res.size = 30;
        /* declarations/desktop/view/DownloadsView.xml:18 characters: 25-29 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/desktop/view/DownloadsView.xml:21 characters: 17-35 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/desktop/view/DownloadsView.xml:21 characters: 37-43 */
        res.bottom = 30;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/desktop/view/DownloadsView.xml:16 characters: 9-15 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/DownloadsView.xml:16 characters: 36-55 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/DownloadsView.xml:16 characters: 17-21 */
        res.text = 'Downloads';
        /* declarations/desktop/view/DownloadsView.xml:16 characters: 90-101 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/desktop/view/DownloadsView.xml:17 characters: 13-17 */
        res.font = get_aSFont__0();
        /* declarations/desktop/view/DownloadsView.xml:20 characters: 13-19 */
        res.border = get_emptyBorder__0();
        return res;
    }

    inline function get_multilineLabel__0():org.aswing.ext.MultilineLabel {
        /* declarations/desktop/view/DownloadsView.xml:25 characters: 9-27 */
        var res = new org.aswing.ext.MultilineLabel();
        /* declarations/desktop/view/DownloadsView.xml:26 characters: 13-17 */
        res.text = "Use haxelib to install Jive: haxelib install jive";
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/desktop/view/DownloadsView.xml:15 characters: 5-12 */
        var res = new org.aswing.SoftBox();
        /* declarations/desktop/view/DownloadsView.xml:15 characters: 14-25 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        res.append(get_jLabel__0());
        res.append(get_multilineLabel__0());
        return res;
    }

    public function new() {
        /* declarations/desktop/view/DownloadsView.xml:2 characters: 1-7 */
        super();
        /* declarations/desktop/view/DownloadsView.xml:11 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_softBox__0());
    }
}
