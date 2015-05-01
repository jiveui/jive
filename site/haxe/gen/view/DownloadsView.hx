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
        /* declarations/desktop/view/DownloadsView.xml:16 characters: 35-54 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/DownloadsView.xml:16 characters: 17-21 */
        res.text = 'Download';
        /* declarations/desktop/view/DownloadsView.xml:16 characters: 89-100 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/desktop/view/DownloadsView.xml:17 characters: 13-17 */
        res.font = get_aSFont__0();
        /* declarations/desktop/view/DownloadsView.xml:20 characters: 13-19 */
        res.border = get_emptyBorder__0();
        return res;
    }

    inline function get_aSFont__1():org.aswing.ASFont {
        /* declarations/desktop/view/DownloadsView.xml:28 characters: 21-27 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/DownloadsView.xml:28 characters: 59-63 */
        res.size = 16;
        /* declarations/desktop/view/DownloadsView.xml:28 characters: 29-33 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/desktop/view/DownloadsView.xml:26 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/DownloadsView.xml:26 characters: 21-25 */
        res.text = 'From haxelib:';
        /* declarations/desktop/view/DownloadsView.xml:27 characters: 17-21 */
        res.font = get_aSFont__1();
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/desktop/view/DownloadsView.xml:31 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/DownloadsView.xml:31 characters: 21-25 */
        res.text = 'haxelib install jive';
        /* declarations/desktop/view/DownloadsView.xml:31 characters: 51-61 */
        res.selectable = true;
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/desktop/view/DownloadsView.xml:25 characters: 9-15 */
        var res = new org.aswing.JPanel();
        res.append(get_jLabel__1());
        res.append(get_jLabel__2());
        return res;
    }

    inline function get_aSFont__2():org.aswing.ASFont {
        /* declarations/desktop/view/DownloadsView.xml:37 characters: 21-27 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/DownloadsView.xml:37 characters: 59-63 */
        res.size = 16;
        /* declarations/desktop/view/DownloadsView.xml:37 characters: 29-33 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__3():org.aswing.JLabel {
        /* declarations/desktop/view/DownloadsView.xml:35 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/DownloadsView.xml:35 characters: 21-25 */
        res.text = 'Development version from GitHub:';
        /* declarations/desktop/view/DownloadsView.xml:35 characters: 63-73 */
        res.selectable = false;
        /* declarations/desktop/view/DownloadsView.xml:36 characters: 17-21 */
        res.font = get_aSFont__2();
        return res;
    }

    inline function get_jLabel__4():org.aswing.JLabel {
        /* declarations/desktop/view/DownloadsView.xml:40 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/DownloadsView.xml:40 characters: 21-25 */
        res.text = 'haxelib git jive https://github.com/ngrebenshikov/jive';
        /* declarations/desktop/view/DownloadsView.xml:40 characters: 85-95 */
        res.selectable = true;
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/desktop/view/DownloadsView.xml:34 characters: 9-15 */
        var res = new org.aswing.JPanel();
        res.append(get_jLabel__3());
        res.append(get_jLabel__4());
        return res;
    }

    inline function get_aSFont__3():org.aswing.ASFont {
        /* declarations/desktop/view/DownloadsView.xml:46 characters: 21-27 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/DownloadsView.xml:46 characters: 59-63 */
        res.size = 16;
        /* declarations/desktop/view/DownloadsView.xml:46 characters: 29-33 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__5():org.aswing.JLabel {
        /* declarations/desktop/view/DownloadsView.xml:44 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/DownloadsView.xml:44 characters: 21-25 */
        res.text = 'Download manually from GitHub:';
        /* declarations/desktop/view/DownloadsView.xml:45 characters: 17-21 */
        res.font = get_aSFont__3();
        return res;
    }

    inline function get_openLinkCommand__0():jive.OpenLinkCommand {
        /* declarations/desktop/view/DownloadsView.xml:51 characters: 21-41 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/DownloadsView.xml:51 characters: 43-46 */
        res.url = 'https://github.com/ngrebenshikov/jive/archive/master.zip';
        return res;
    }

    inline function get_jLabelButton__0():org.aswing.JLabelButton {
        /* declarations/desktop/view/DownloadsView.xml:49 characters: 13-25 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/DownloadsView.xml:49 characters: 27-31 */
        res.text = 'Download the archive';
        /* declarations/desktop/view/DownloadsView.xml:50 characters: 17-24 */
        res.command = get_openLinkCommand__0();
        return res;
    }

    inline function get_jLabel__6():org.aswing.JLabel {
        /* declarations/desktop/view/DownloadsView.xml:54 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/DownloadsView.xml:54 characters: 21-25 */
        res.text = ', extract files and use [haxelib dev] command.';
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* declarations/desktop/view/DownloadsView.xml:43 characters: 9-15 */
        var res = new org.aswing.JPanel();
        res.append(get_jLabel__5());
        res.append(get_jLabelButton__0());
        res.append(get_jLabel__6());
        return res;
    }

    inline function get_aSFont__4():org.aswing.ASFont {
        /* declarations/desktop/view/DownloadsView.xml:60 characters: 21-27 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/DownloadsView.xml:60 characters: 59-63 */
        res.size = 16;
        /* declarations/desktop/view/DownloadsView.xml:60 characters: 29-33 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__7():org.aswing.JLabel {
        /* declarations/desktop/view/DownloadsView.xml:58 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/DownloadsView.xml:58 characters: 21-25 */
        res.text = 'Dependencies:';
        /* declarations/desktop/view/DownloadsView.xml:59 characters: 17-21 */
        res.font = get_aSFont__4();
        return res;
    }

    inline function get_jLabel__8():org.aswing.JLabel {
        /* declarations/desktop/view/DownloadsView.xml:63 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/DownloadsView.xml:63 characters: 21-25 */
        res.text = 'haxelib git hml https://github.com/profelis/hml';
        /* declarations/desktop/view/DownloadsView.xml:63 characters: 78-88 */
        res.selectable = true;
        return res;
    }

    inline function get_jPanel__3():org.aswing.JPanel {
        /* declarations/desktop/view/DownloadsView.xml:57 characters: 9-15 */
        var res = new org.aswing.JPanel();
        res.append(get_jLabel__7());
        res.append(get_jLabel__8());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/desktop/view/DownloadsView.xml:15 characters: 5-12 */
        var res = new org.aswing.SoftBox();
        /* declarations/desktop/view/DownloadsView.xml:15 characters: 14-25 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        res.append(get_jLabel__0());
        res.append(get_jPanel__0());
        res.append(get_jPanel__1());
        res.append(get_jPanel__2());
        res.append(get_jPanel__3());
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
