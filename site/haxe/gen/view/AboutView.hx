package view;

class AboutView extends org.aswing.JPanel implements jive.DataContextControllable<viewmodel.AboutViewModel> {

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/desktop/view/AboutView.xml:12 characters: 13-25 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_centerLayout__0():org.aswing.CenterLayout {
        /* declarations/desktop/view/AboutView.xml:18 characters: 13-25 */
        var res = new org.aswing.CenterLayout();
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/desktop/view/AboutView.xml:21 characters: 21-39 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/desktop/view/AboutView.xml:21 characters: 41-47 */
        res.bottom = 50;
        return res;
    }

    inline function get_centerLayout__1():org.aswing.CenterLayout {
        /* declarations/desktop/view/AboutView.xml:25 characters: 25-37 */
        var res = new org.aswing.CenterLayout();
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/desktop/view/AboutView.xml:29 characters: 56-73 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/desktop/view/AboutView.xml:29 characters: 75-80 */
        res.width = 50;
        /* declarations/desktop/view/AboutView.xml:29 characters: 86-92 */
        res.height = 50;
        return res;
    }

    inline function get_jSeparator__0():org.aswing.JSeparator {
        /* declarations/desktop/view/AboutView.xml:29 characters: 29-39 */
        var res = new org.aswing.JSeparator();
        /* declarations/desktop/view/AboutView.xml:29 characters: 41-54 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_assetIcon__0():org.aswing.AssetIcon {
        /* declarations/desktop/view/AboutView.xml:30 characters: 97-106 */
        var res = new org.aswing.AssetIcon();
        if (null != dataContext) { res.asset = this.dataContext.jiveIcon; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.asset = this.dataContext.jiveIcon;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.jiveIcon, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.jiveIcon, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.asset = this.dataContext.jiveIcon;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/desktop/view/AboutView.xml:30 characters: 135-140 */
        res.width = 300;
        /* declarations/desktop/view/AboutView.xml:30 characters: 147-153 */
        res.height = 190;
        /* declarations/desktop/view/AboutView.xml:30 characters: 160-165 */
        res.scale = true;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:30 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:30 characters: 37-56 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/AboutView.xml:30 characters: 91-95 */
        res.icon = get_assetIcon__0();
        return res;
    }

    inline function get_emptyBorder__1():org.aswing.border.EmptyBorder {
        /* declarations/desktop/view/AboutView.xml:32 characters: 41-59 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/desktop/view/AboutView.xml:32 characters: 61-65 */
        res.left = 20;
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:34 characters: 43-49 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:34 characters: 81-85 */
        res.size = 16;
        /* declarations/desktop/view/AboutView.xml:34 characters: 51-55 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__2():org.aswing.border.EmptyBorder {
        /* declarations/desktop/view/AboutView.xml:35 characters: 45-63 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/desktop/view/AboutView.xml:35 characters: 65-69 */
        res.left = 5;
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:33 characters: 33-39 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:33 characters: 69-88 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/AboutView.xml:33 characters: 41-45 */
        res.text = 'The roots of Jive:';
        /* declarations/desktop/view/AboutView.xml:34 characters: 37-41 */
        res.font = get_aSFont__0();
        /* declarations/desktop/view/AboutView.xml:35 characters: 37-43 */
        res.border = get_emptyBorder__2();
        return res;
    }

    inline function get_flowLayout__0():org.aswing.FlowLayout {
        /* declarations/desktop/view/AboutView.xml:38 characters: 45-55 */
        var res = new org.aswing.FlowLayout();
        /* declarations/desktop/view/AboutView.xml:38 characters: 57-61 */
        res.hgap = 5;
        return res;
    }

    inline function get_openLinkCommand__0():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:40 characters: 50-70 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:40 characters: 72-75 */
        res.url = 'http://en.wikipedia.org/wiki/Swing_(Java)';
        return res;
    }

    inline function get_jLabelButton__0():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:39 characters: 37-49 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:39 characters: 71-90 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/AboutView.xml:39 characters: 51-55 */
        res.text = 'Java Swing';
        /* declarations/desktop/view/AboutView.xml:40 characters: 41-48 */
        res.command = get_openLinkCommand__0();
        return res;
    }

    inline function get_assetIcon__1():org.aswing.AssetIcon {
        /* declarations/desktop/view/AboutView.xml:42 characters: 51-60 */
        var res = new org.aswing.AssetIcon();
        if (null != dataContext) { res.asset = this.dataContext.arrowIcon; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.asset = this.dataContext.arrowIcon;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.arrowIcon, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.arrowIcon, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.asset = this.dataContext.arrowIcon;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/desktop/view/AboutView.xml:42 characters: 90-95 */
        res.width = 10;
        /* declarations/desktop/view/AboutView.xml:42 characters: 101-107 */
        res.height = 8;
        /* declarations/desktop/view/AboutView.xml:42 characters: 112-117 */
        res.scale = true;
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:42 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:42 characters: 45-49 */
        res.icon = get_assetIcon__1();
        return res;
    }

    inline function get_openLinkCommand__1():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:44 characters: 50-70 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:44 characters: 72-75 */
        res.url = 'http://github.com/longde123/aswing-openfl';
        return res;
    }

    inline function get_jLabelButton__1():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:43 characters: 37-49 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:43 characters: 67-86 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/AboutView.xml:43 characters: 51-55 */
        res.text = 'AsWing';
        /* declarations/desktop/view/AboutView.xml:44 characters: 41-48 */
        res.command = get_openLinkCommand__1();
        return res;
    }

    inline function get_assetIcon__2():org.aswing.AssetIcon {
        /* declarations/desktop/view/AboutView.xml:46 characters: 51-60 */
        var res = new org.aswing.AssetIcon();
        if (null != dataContext) { res.asset = this.dataContext.arrowIcon; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.asset = this.dataContext.arrowIcon;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.arrowIcon, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.arrowIcon, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.asset = this.dataContext.arrowIcon;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/desktop/view/AboutView.xml:46 characters: 90-95 */
        res.width = 10;
        /* declarations/desktop/view/AboutView.xml:46 characters: 101-107 */
        res.height = 8;
        /* declarations/desktop/view/AboutView.xml:46 characters: 112-117 */
        res.scale = true;
        return res;
    }

    inline function get_jLabel__3():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:46 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:46 characters: 45-49 */
        res.icon = get_assetIcon__2();
        return res;
    }

    inline function get_jLabel__4():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:47 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:47 characters: 59-78 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/AboutView.xml:47 characters: 45-49 */
        res.text = 'Jive';
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/desktop/view/AboutView.xml:37 characters: 33-39 */
        var res = new org.aswing.JPanel();
        /* declarations/desktop/view/AboutView.xml:38 characters: 37-43 */
        res.layout = get_flowLayout__0();
        res.append(get_jLabelButton__0());
        res.append(get_jLabel__2());
        res.append(get_jLabelButton__1());
        res.append(get_jLabel__3());
        res.append(get_jLabel__4());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:31 characters: 29-36 */
        var res = new org.aswing.SoftBox();
        /* declarations/desktop/view/AboutView.xml:32 characters: 33-39 */
        res.border = get_emptyBorder__1();
        res.append(get_jLabel__1());
        res.append(get_jPanel__0());
        return res;
    }

    inline function get_softBox__1():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:28 characters: 25-32 */
        var res = new org.aswing.SoftBox();
        res.append(get_jSeparator__0());
        res.append(get_jLabel__0());
        res.append(get_softBox__0());
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/desktop/view/AboutView.xml:27 characters: 21-27 */
        var res = new org.aswing.JPanel();
        res.append(get_softBox__1());
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* declarations/desktop/view/AboutView.xml:23 characters: 17-23 */
        var res = new org.aswing.JPanel();
        /* declarations/desktop/view/AboutView.xml:24 characters: 21-27 */
        res.layout = get_centerLayout__1();
        res.append(get_jPanel__1());
        return res;
    }

    inline function get_flowLayout__1():org.aswing.FlowLayout {
        /* declarations/desktop/view/AboutView.xml:57 characters: 29-39 */
        var res = new org.aswing.FlowLayout();
        /* declarations/desktop/view/AboutView.xml:57 characters: 41-45 */
        res.hgap = 0;
        return res;
    }

    inline function get_emptyBorder__3():org.aswing.border.EmptyBorder {
        /* declarations/desktop/view/AboutView.xml:60 characters: 29-47 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/desktop/view/AboutView.xml:60 characters: 49-55 */
        res.bottom = 10;
        return res;
    }

    inline function get_aSFont__1():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:63 characters: 35-41 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:63 characters: 74-78 */
        res.size = 36;
        /* declarations/desktop/view/AboutView.xml:63 characters: 43-47 */
        res.name = 'assets/Lato-Light.ttf';
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:64 characters: 41-48 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:64 characters: 50-53 */
        res.rgb = 0xe80050;
        return res;
    }

    inline function get_jLabel__5():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:62 characters: 25-31 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:62 characters: 33-37 */
        res.text = 'Cross platform';
        /* declarations/desktop/view/AboutView.xml:63 characters: 29-33 */
        res.font = get_aSFont__1();
        /* declarations/desktop/view/AboutView.xml:64 characters: 29-39 */
        res.foreground = get_aSColor__0();
        return res;
    }

    inline function get_aSFont__2():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:67 characters: 35-41 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:67 characters: 74-78 */
        res.size = 36;
        /* declarations/desktop/view/AboutView.xml:67 characters: 43-47 */
        res.name = 'assets/Lato-Light.ttf';
        return res;
    }

    inline function get_aSColor__1():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:68 characters: 41-48 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:68 characters: 50-53 */
        res.rgb = 0xd22a02;
        return res;
    }

    inline function get_jLabel__6():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:66 characters: 25-31 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:66 characters: 33-37 */
        res.text = 'UI framework';
        /* declarations/desktop/view/AboutView.xml:67 characters: 29-33 */
        res.font = get_aSFont__2();
        /* declarations/desktop/view/AboutView.xml:68 characters: 29-39 */
        res.foreground = get_aSColor__1();
        return res;
    }

    inline function get_aSFont__3():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:71 characters: 35-41 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:71 characters: 74-78 */
        res.size = 36;
        /* declarations/desktop/view/AboutView.xml:71 characters: 43-47 */
        res.name = 'assets/Lato-Light.ttf';
        return res;
    }

    inline function get_aSColor__2():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:72 characters: 41-48 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:72 characters: 50-53 */
        res.rgb = 0xeb9500;
        return res;
    }

    inline function get_jLabel__7():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:70 characters: 25-31 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:70 characters: 33-37 */
        res.text = 'for Haxe';
        /* declarations/desktop/view/AboutView.xml:71 characters: 29-33 */
        res.font = get_aSFont__3();
        /* declarations/desktop/view/AboutView.xml:72 characters: 29-39 */
        res.foreground = get_aSColor__2();
        return res;
    }

    inline function get_jPanel__3():org.aswing.JPanel {
        /* declarations/desktop/view/AboutView.xml:55 characters: 21-27 */
        var res = new org.aswing.JPanel();
        /* declarations/desktop/view/AboutView.xml:56 characters: 25-31 */
        res.layout = get_flowLayout__1();
        /* declarations/desktop/view/AboutView.xml:59 characters: 25-31 */
        res.border = get_emptyBorder__3();
        res.append(get_jLabel__5());
        res.append(get_jLabel__6());
        res.append(get_jLabel__7());
        return res;
    }

    inline function get_aSColor__3():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:77 characters: 41-48 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:77 characters: 50-53 */
        res.rgb = 0xe7e7e7;
        return res;
    }

    inline function get_flatPanelBackground__0():jive.plaf.flat.background.FlatPanelBackground {
        /* declarations/desktop/view/AboutView.xml:79 characters: 33-56 */
        var res = new jive.plaf.flat.background.FlatPanelBackground();
        return res;
    }

    inline function get_emptyBorder__4():org.aswing.border.EmptyBorder {
        /* declarations/desktop/view/AboutView.xml:83 characters: 37-55 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/desktop/view/AboutView.xml:83 characters: 78-81 */
        res.top = 25;
        /* declarations/desktop/view/AboutView.xml:83 characters: 67-72 */
        res.right = 15;
        /* declarations/desktop/view/AboutView.xml:83 characters: 87-93 */
        res.bottom = 25;
        /* declarations/desktop/view/AboutView.xml:83 characters: 57-61 */
        res.left = 15;
        return res;
    }

    inline function get_assetIcon__3():org.aswing.AssetIcon {
        /* declarations/desktop/view/AboutView.xml:85 characters: 47-56 */
        var res = new org.aswing.AssetIcon();
        if (null != dataContext) { res.asset = this.dataContext.openFlIcon; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.asset = this.dataContext.openFlIcon;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.openFlIcon, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.openFlIcon, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.asset = this.dataContext.openFlIcon;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/desktop/view/AboutView.xml:85 characters: 87-92 */
        res.width = 85;
        /* declarations/desktop/view/AboutView.xml:85 characters: 98-104 */
        res.height = 85;
        /* declarations/desktop/view/AboutView.xml:85 characters: 110-115 */
        res.scale = true;
        return res;
    }

    inline function get_jLabel__8():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:85 characters: 33-39 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:85 characters: 41-45 */
        res.icon = get_assetIcon__3();
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/desktop/view/AboutView.xml:86 characters: 60-77 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/desktop/view/AboutView.xml:86 characters: 79-84 */
        res.width = 15;
        /* declarations/desktop/view/AboutView.xml:86 characters: 90-96 */
        res.height = 15;
        return res;
    }

    inline function get_jSeparator__1():org.aswing.JSeparator {
        /* declarations/desktop/view/AboutView.xml:86 characters: 33-43 */
        var res = new org.aswing.JSeparator();
        /* declarations/desktop/view/AboutView.xml:86 characters: 45-58 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_aSFont__4():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:88 characters: 43-49 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:88 characters: 81-85 */
        res.size = 20;
        /* declarations/desktop/view/AboutView.xml:88 characters: 51-55 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__9():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:87 characters: 33-39 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:87 characters: 41-45 */
        res.text = 'Based on';
        /* declarations/desktop/view/AboutView.xml:88 characters: 37-41 */
        res.font = get_aSFont__4();
        return res;
    }

    inline function get_openLinkCommand__2():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:91 characters: 46-66 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:91 characters: 68-71 */
        res.url = 'http://www.openfl.org';
        return res;
    }

    inline function get_jLabelButton__2():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:90 characters: 33-45 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:90 characters: 47-51 */
        res.text = 'OpenFL';
        /* declarations/desktop/view/AboutView.xml:91 characters: 37-44 */
        res.command = get_openLinkCommand__2();
        return res;
    }

    inline function get_openLinkCommand__3():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:94 characters: 46-66 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:94 characters: 68-71 */
        res.url = 'http://github.com/longde123/aswing-openfl';
        return res;
    }

    inline function get_jLabelButton__3():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:93 characters: 33-45 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:93 characters: 47-51 */
        res.text = 'Forked from AsWing';
        /* declarations/desktop/view/AboutView.xml:94 characters: 37-44 */
        res.command = get_openLinkCommand__3();
        return res;
    }

    inline function get_flowLayout__2():org.aswing.FlowLayout {
        /* declarations/desktop/view/AboutView.xml:98 characters: 41-51 */
        var res = new org.aswing.FlowLayout();
        /* declarations/desktop/view/AboutView.xml:98 characters: 71-76 */
        res.align = org.aswing.FlowLayout.CENTER;
        /* declarations/desktop/view/AboutView.xml:98 characters: 53-57 */
        res.hgap = 0;
        /* declarations/desktop/view/AboutView.xml:98 characters: 62-66 */
        res.vgap = 0;
        return res;
    }

    inline function get_openLinkCommand__4():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:101 characters: 50-70 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:101 characters: 72-75 */
        res.url = 'http://github.com/profelis/bindx2';
        return res;
    }

    inline function get_jLabelButton__4():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:100 characters: 37-49 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:100 characters: 51-55 */
        res.text = 'Bindx';
        /* declarations/desktop/view/AboutView.xml:101 characters: 41-48 */
        res.command = get_openLinkCommand__4();
        return res;
    }

    inline function get_jLabel__10():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:103 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:103 characters: 45-49 */
        res.text = '/';
        return res;
    }

    inline function get_openLinkCommand__5():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:105 characters: 50-70 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:105 characters: 72-75 */
        res.url = 'http://github.com/profelis/hml';
        return res;
    }

    inline function get_jLabelButton__5():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:104 characters: 37-49 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:104 characters: 51-55 */
        res.text = 'HML';
        /* declarations/desktop/view/AboutView.xml:105 characters: 41-48 */
        res.command = get_openLinkCommand__5();
        return res;
    }

    inline function get_jPanel__4():org.aswing.JPanel {
        /* declarations/desktop/view/AboutView.xml:96 characters: 33-39 */
        var res = new org.aswing.JPanel();
        /* declarations/desktop/view/AboutView.xml:97 characters: 37-43 */
        res.layout = get_flowLayout__2();
        res.append(get_jLabelButton__4());
        res.append(get_jLabel__10());
        res.append(get_jLabelButton__5());
        return res;
    }

    inline function get_softBox__2():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:81 characters: 29-36 */
        var res = new org.aswing.SoftBox();
        /* declarations/desktop/view/AboutView.xml:82 characters: 33-39 */
        res.border = get_emptyBorder__4();
        res.append(get_jLabel__8());
        res.append(get_jSeparator__1());
        res.append(get_jLabel__9());
        res.append(get_jLabelButton__2());
        res.append(get_jLabelButton__3());
        res.append(get_jPanel__4());
        return res;
    }

    inline function get_softBox__3():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:76 characters: 25-32 */
        var res = new org.aswing.SoftBox();
        /* declarations/desktop/view/AboutView.xml:76 characters: 34-40 */
        res.opaque = true;
        /* declarations/desktop/view/AboutView.xml:77 characters: 29-39 */
        res.background = get_aSColor__3();
        /* declarations/desktop/view/AboutView.xml:78 characters: 29-48 */
        res.backgroundDecorator = get_flatPanelBackground__0();
        res.append(get_softBox__2());
        return res;
    }

    inline function get_aSColor__4():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:111 characters: 41-48 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:111 characters: 50-53 */
        res.rgb = 0xe7e7e7;
        return res;
    }

    inline function get_flatPanelBackground__1():jive.plaf.flat.background.FlatPanelBackground {
        /* declarations/desktop/view/AboutView.xml:113 characters: 33-56 */
        var res = new jive.plaf.flat.background.FlatPanelBackground();
        return res;
    }

    inline function get_emptyBorder__5():org.aswing.border.EmptyBorder {
        /* declarations/desktop/view/AboutView.xml:117 characters: 37-55 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/desktop/view/AboutView.xml:117 characters: 78-81 */
        res.top = 25;
        /* declarations/desktop/view/AboutView.xml:117 characters: 67-72 */
        res.right = 15;
        /* declarations/desktop/view/AboutView.xml:117 characters: 87-93 */
        res.bottom = 25;
        /* declarations/desktop/view/AboutView.xml:117 characters: 57-61 */
        res.left = 15;
        return res;
    }

    inline function get_assetIcon__4():org.aswing.AssetIcon {
        /* declarations/desktop/view/AboutView.xml:119 characters: 47-56 */
        var res = new org.aswing.AssetIcon();
        if (null != dataContext) { res.asset = this.dataContext.brainIcon; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.asset = this.dataContext.brainIcon;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.brainIcon, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.brainIcon, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.asset = this.dataContext.brainIcon;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/desktop/view/AboutView.xml:119 characters: 86-91 */
        res.width = 85;
        /* declarations/desktop/view/AboutView.xml:119 characters: 97-103 */
        res.height = 85;
        /* declarations/desktop/view/AboutView.xml:119 characters: 109-114 */
        res.scale = true;
        return res;
    }

    inline function get_jLabel__11():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:119 characters: 33-39 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:119 characters: 41-45 */
        res.icon = get_assetIcon__4();
        return res;
    }

    inline function get_intDimension__2():org.aswing.geom.IntDimension {
        /* declarations/desktop/view/AboutView.xml:120 characters: 60-77 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/desktop/view/AboutView.xml:120 characters: 79-84 */
        res.width = 15;
        /* declarations/desktop/view/AboutView.xml:120 characters: 90-96 */
        res.height = 15;
        return res;
    }

    inline function get_jSeparator__2():org.aswing.JSeparator {
        /* declarations/desktop/view/AboutView.xml:120 characters: 33-43 */
        var res = new org.aswing.JSeparator();
        /* declarations/desktop/view/AboutView.xml:120 characters: 45-58 */
        res.preferredSize = get_intDimension__2();
        return res;
    }

    inline function get_aSFont__5():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:122 characters: 43-49 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:122 characters: 81-85 */
        res.size = 20;
        /* declarations/desktop/view/AboutView.xml:122 characters: 51-55 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__12():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:121 characters: 33-39 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:121 characters: 41-45 */
        res.text = 'Main ideas';
        /* declarations/desktop/view/AboutView.xml:122 characters: 37-41 */
        res.font = get_aSFont__5();
        return res;
    }

    inline function get_openLinkCommand__6():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:125 characters: 46-66 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:125 characters: 68-71 */
        res.url = 'http://en.wikipedia.org/wiki/Model_View_ViewModel';
        return res;
    }

    inline function get_jLabelButton__6():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:124 characters: 33-45 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:124 characters: 47-51 */
        res.text = 'MVVM';
        /* declarations/desktop/view/AboutView.xml:125 characters: 37-44 */
        res.command = get_openLinkCommand__6();
        return res;
    }

    inline function get_openLinkCommand__7():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:128 characters: 46-66 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:128 characters: 68-71 */
        res.url = 'http://en.wikipedia.org/wiki/Data_binding';
        return res;
    }

    inline function get_jLabelButton__7():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:127 characters: 33-45 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:127 characters: 47-51 */
        res.text = 'Data Binding';
        /* declarations/desktop/view/AboutView.xml:128 characters: 37-44 */
        res.command = get_openLinkCommand__7();
        return res;
    }

    inline function get_softBox__4():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:115 characters: 29-36 */
        var res = new org.aswing.SoftBox();
        /* declarations/desktop/view/AboutView.xml:116 characters: 33-39 */
        res.border = get_emptyBorder__5();
        res.append(get_jLabel__11());
        res.append(get_jSeparator__2());
        res.append(get_jLabel__12());
        res.append(get_jLabelButton__6());
        res.append(get_jLabelButton__7());
        return res;
    }

    inline function get_softBox__5():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:110 characters: 25-32 */
        var res = new org.aswing.SoftBox();
        /* declarations/desktop/view/AboutView.xml:110 characters: 34-40 */
        res.opaque = true;
        /* declarations/desktop/view/AboutView.xml:111 characters: 29-39 */
        res.background = get_aSColor__4();
        /* declarations/desktop/view/AboutView.xml:112 characters: 29-48 */
        res.backgroundDecorator = get_flatPanelBackground__1();
        res.append(get_softBox__4());
        return res;
    }

    inline function get_aSColor__5():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:133 characters: 41-48 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:133 characters: 50-53 */
        res.rgb = 0xe7e7e7;
        return res;
    }

    inline function get_flatPanelBackground__2():jive.plaf.flat.background.FlatPanelBackground {
        /* declarations/desktop/view/AboutView.xml:135 characters: 33-56 */
        var res = new jive.plaf.flat.background.FlatPanelBackground();
        return res;
    }

    inline function get_emptyBorder__6():org.aswing.border.EmptyBorder {
        /* declarations/desktop/view/AboutView.xml:139 characters: 37-55 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/desktop/view/AboutView.xml:139 characters: 78-81 */
        res.top = 25;
        /* declarations/desktop/view/AboutView.xml:139 characters: 67-72 */
        res.right = 15;
        /* declarations/desktop/view/AboutView.xml:139 characters: 87-93 */
        res.bottom = 25;
        /* declarations/desktop/view/AboutView.xml:139 characters: 57-61 */
        res.left = 15;
        return res;
    }

    inline function get_assetIcon__5():org.aswing.AssetIcon {
        /* declarations/desktop/view/AboutView.xml:141 characters: 47-56 */
        var res = new org.aswing.AssetIcon();
        if (null != dataContext) { res.asset = this.dataContext.desktopIcon; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.asset = this.dataContext.desktopIcon;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.desktopIcon, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.desktopIcon, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.asset = this.dataContext.desktopIcon;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/desktop/view/AboutView.xml:141 characters: 88-93 */
        res.width = 85;
        /* declarations/desktop/view/AboutView.xml:141 characters: 99-105 */
        res.height = 85;
        /* declarations/desktop/view/AboutView.xml:141 characters: 111-116 */
        res.scale = true;
        return res;
    }

    inline function get_jLabel__13():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:141 characters: 33-39 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:141 characters: 41-45 */
        res.icon = get_assetIcon__5();
        return res;
    }

    inline function get_intDimension__3():org.aswing.geom.IntDimension {
        /* declarations/desktop/view/AboutView.xml:142 characters: 60-77 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/desktop/view/AboutView.xml:142 characters: 79-84 */
        res.width = 15;
        /* declarations/desktop/view/AboutView.xml:142 characters: 90-96 */
        res.height = 15;
        return res;
    }

    inline function get_jSeparator__3():org.aswing.JSeparator {
        /* declarations/desktop/view/AboutView.xml:142 characters: 33-43 */
        var res = new org.aswing.JSeparator();
        /* declarations/desktop/view/AboutView.xml:142 characters: 45-58 */
        res.preferredSize = get_intDimension__3();
        return res;
    }

    inline function get_aSFont__6():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:144 characters: 43-49 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:144 characters: 81-85 */
        res.size = 20;
        /* declarations/desktop/view/AboutView.xml:144 characters: 51-55 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__14():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:143 characters: 33-39 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:143 characters: 41-45 */
        res.text = 'Platforms';
        /* declarations/desktop/view/AboutView.xml:144 characters: 37-41 */
        res.font = get_aSFont__6();
        return res;
    }

    inline function get_jLabelButton__8():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:147 characters: 33-45 */
        var res = new org.aswing.JLabelButton();
        if (null != dataContext) { res.command = this.dataContext.openDemo; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.command = this.dataContext.openDemo;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.openDemo, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.openDemo, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.command = this.dataContext.openDemo;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/desktop/view/AboutView.xml:147 characters: 47-51 */
        res.text = 'HTML5';
        return res;
    }

    inline function get_openLinkCommand__8():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:150 characters: 46-66 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:150 characters: 68-71 */
        res.url = '/demos/jive-demo.zip';
        return res;
    }

    inline function get_jLabelButton__9():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:149 characters: 33-45 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:149 characters: 47-51 */
        res.text = 'Windows';
        /* declarations/desktop/view/AboutView.xml:150 characters: 37-44 */
        res.command = get_openLinkCommand__8();
        return res;
    }

    inline function get_openLinkCommand__9():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:154 characters: 46-66 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:154 characters: 68-71 */
        res.url = '/demos/jive-demo.dmg';
        return res;
    }

    inline function get_jLabelButton__10():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:153 characters: 33-45 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:153 characters: 47-51 */
        res.text = 'OS X';
        /* declarations/desktop/view/AboutView.xml:154 characters: 37-44 */
        res.command = get_openLinkCommand__9();
        return res;
    }

    inline function get_openLinkCommand__10():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:158 characters: 46-66 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:158 characters: 68-71 */
        res.url = '/flash.html';
        return res;
    }

    inline function get_jLabelButton__11():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:157 characters: 33-45 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:157 characters: 47-51 */
        res.text = 'Flash';
        /* declarations/desktop/view/AboutView.xml:158 characters: 37-44 */
        res.command = get_openLinkCommand__10();
        return res;
    }

    inline function get_softBox__6():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:137 characters: 29-36 */
        var res = new org.aswing.SoftBox();
        /* declarations/desktop/view/AboutView.xml:138 characters: 33-39 */
        res.border = get_emptyBorder__6();
        res.append(get_jLabel__13());
        res.append(get_jSeparator__3());
        res.append(get_jLabel__14());
        res.append(get_jLabelButton__8());
        res.append(get_jLabelButton__9());
        res.append(get_jLabelButton__10());
        res.append(get_jLabelButton__11());
        return res;
    }

    inline function get_softBox__7():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:132 characters: 25-32 */
        var res = new org.aswing.SoftBox();
        /* declarations/desktop/view/AboutView.xml:132 characters: 34-40 */
        res.opaque = true;
        /* declarations/desktop/view/AboutView.xml:133 characters: 29-39 */
        res.background = get_aSColor__5();
        /* declarations/desktop/view/AboutView.xml:134 characters: 29-48 */
        res.backgroundDecorator = get_flatPanelBackground__2();
        res.append(get_softBox__6());
        return res;
    }

    inline function get_box__0():org.aswing.Box {
        /* declarations/desktop/view/AboutView.xml:75 characters: 21-24 */
        var res = new org.aswing.Box();
        /* declarations/desktop/view/AboutView.xml:75 characters: 26-30 */
        res.axis = org.aswing.BoxLayout.X_AXIS;
        /* declarations/desktop/view/AboutView.xml:75 characters: 61-64 */
        res.gap = 20;
        res.append(get_softBox__3());
        res.append(get_softBox__5());
        res.append(get_softBox__7());
        return res;
    }

    inline function get_softBox__8():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:54 characters: 17-24 */
        var res = new org.aswing.SoftBox();
        res.append(get_jPanel__3());
        res.append(get_box__0());
        return res;
    }

    inline function get_softBox__9():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:22 characters: 13-20 */
        var res = new org.aswing.SoftBox();
        /* declarations/desktop/view/AboutView.xml:22 characters: 22-26 */
        res.axis = org.aswing.SoftBoxLayout.X_AXIS;
        res.append(get_jPanel__2());
        res.append(get_softBox__8());
        return res;
    }

    inline function get_softBox__10():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:20 characters: 9-16 */
        var res = new org.aswing.SoftBox();
        /* declarations/desktop/view/AboutView.xml:21 characters: 13-19 */
        res.border = get_emptyBorder__0();
        res.append(get_softBox__9());
        return res;
    }

    inline function get_jPanel__5():org.aswing.JPanel {
        /* declarations/desktop/view/AboutView.xml:16 characters: 5-11 */
        var res = new org.aswing.JPanel();
        /* declarations/desktop/view/AboutView.xml:16 characters: 13-24 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        /* declarations/desktop/view/AboutView.xml:17 characters: 9-15 */
        res.layout = get_centerLayout__0();
        res.append(get_softBox__10());
        return res;
    }

    inline function get_flowLayout__3():org.aswing.FlowLayout {
        /* declarations/desktop/view/AboutView.xml:169 characters: 17-27 */
        var res = new org.aswing.FlowLayout();
        /* declarations/desktop/view/AboutView.xml:169 characters: 29-34 */
        res.align = org.aswing.AsWingConstants.RIGHT;
        return res;
    }

    inline function get_flowLayout__4():org.aswing.FlowLayout {
        /* declarations/desktop/view/AboutView.xml:173 characters: 21-31 */
        var res = new org.aswing.FlowLayout();
        /* declarations/desktop/view/AboutView.xml:173 characters: 33-37 */
        res.hgap = 0;
        /* declarations/desktop/view/AboutView.xml:173 characters: 42-46 */
        res.vgap = 0;
        return res;
    }

    inline function get_aSFont__7():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:176 characters: 27-33 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:176 characters: 68-72 */
        res.size = 12;
        /* declarations/desktop/view/AboutView.xml:176 characters: 35-39 */
        res.name = 'assets/Lato-Regular.ttf';
        return res;
    }

    inline function get_aSColor__6():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:177 characters: 33-40 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:177 characters: 42-45 */
        res.rgb = 0x999999;
        return res;
    }

    inline function get_jLabel__15():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:175 characters: 17-23 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:175 characters: 57-76 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/AboutView.xml:175 characters: 25-29 */
        res.text = 'The site\'s powered by';
        /* declarations/desktop/view/AboutView.xml:176 characters: 21-25 */
        res.font = get_aSFont__7();
        /* declarations/desktop/view/AboutView.xml:177 characters: 21-31 */
        res.foreground = get_aSColor__6();
        return res;
    }

    inline function get_aSFont__8():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:180 characters: 27-33 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:180 characters: 68-72 */
        res.size = 12;
        /* declarations/desktop/view/AboutView.xml:180 characters: 35-39 */
        res.name = 'assets/Lato-Regular.ttf';
        /* declarations/desktop/view/AboutView.xml:180 characters: 78-87 */
        res.underline = true;
        return res;
    }

    inline function get_aSColor__7():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:181 characters: 33-40 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:181 characters: 42-45 */
        res.rgb = 0x999999;
        return res;
    }

    inline function get_jLabelButton__12():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:179 characters: 17-29 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:179 characters: 31-35 */
        res.text = 'Jive';
        /* declarations/desktop/view/AboutView.xml:180 characters: 21-25 */
        res.font = get_aSFont__8();
        /* declarations/desktop/view/AboutView.xml:181 characters: 21-31 */
        res.foreground = get_aSColor__7();
        return res;
    }

    inline function get_aSFont__9():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:184 characters: 27-33 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:184 characters: 68-72 */
        res.size = 12;
        /* declarations/desktop/view/AboutView.xml:184 characters: 35-39 */
        res.name = 'assets/Lato-Regular.ttf';
        return res;
    }

    inline function get_aSColor__8():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:185 characters: 33-40 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:185 characters: 42-45 */
        res.rgb = 0x999999;
        return res;
    }

    inline function get_jLabel__16():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:183 characters: 17-23 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:183 characters: 38-57 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/AboutView.xml:183 characters: 25-29 */
        res.text = 'and';
        /* declarations/desktop/view/AboutView.xml:184 characters: 21-25 */
        res.font = get_aSFont__9();
        /* declarations/desktop/view/AboutView.xml:185 characters: 21-31 */
        res.foreground = get_aSColor__8();
        return res;
    }

    inline function get_aSFont__10():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:188 characters: 27-33 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:188 characters: 68-72 */
        res.size = 12;
        /* declarations/desktop/view/AboutView.xml:188 characters: 35-39 */
        res.name = 'assets/Lato-Regular.ttf';
        /* declarations/desktop/view/AboutView.xml:188 characters: 78-87 */
        res.underline = true;
        return res;
    }

    inline function get_aSColor__9():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:189 characters: 33-40 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:189 characters: 42-45 */
        res.rgb = 0x999999;
        return res;
    }

    inline function get_openLinkCommand__11():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:190 characters: 30-50 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:190 characters: 52-55 */
        res.url = 'https://github.com/ngrebenshikov/openfl-snapsvg';
        return res;
    }

    inline function get_jLabelButton__13():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:187 characters: 17-29 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:187 characters: 56-75 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/AboutView.xml:187 characters: 31-35 */
        res.text = 'OpenFL-Snap.SVG';
        /* declarations/desktop/view/AboutView.xml:188 characters: 21-25 */
        res.font = get_aSFont__10();
        /* declarations/desktop/view/AboutView.xml:189 characters: 21-31 */
        res.foreground = get_aSColor__9();
        /* declarations/desktop/view/AboutView.xml:190 characters: 21-28 */
        res.command = get_openLinkCommand__11();
        return res;
    }

    inline function get_jPanel__6():org.aswing.JPanel {
        /* declarations/desktop/view/AboutView.xml:171 characters: 13-19 */
        var res = new org.aswing.JPanel();
        /* declarations/desktop/view/AboutView.xml:172 characters: 17-23 */
        res.layout = get_flowLayout__4();
        res.append(get_jLabel__15());
        res.append(get_jLabelButton__12());
        res.append(get_jLabel__16());
        res.append(get_jLabelButton__13());
        return res;
    }

    inline function get_flowLayout__5():org.aswing.FlowLayout {
        /* declarations/desktop/view/AboutView.xml:195 characters: 21-31 */
        var res = new org.aswing.FlowLayout();
        /* declarations/desktop/view/AboutView.xml:195 characters: 33-37 */
        res.hgap = 0;
        /* declarations/desktop/view/AboutView.xml:195 characters: 42-46 */
        res.vgap = 0;
        return res;
    }

    inline function get_aSFont__11():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:198 characters: 27-33 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:198 characters: 68-72 */
        res.size = 12;
        /* declarations/desktop/view/AboutView.xml:198 characters: 35-39 */
        res.name = 'assets/Lato-Regular.ttf';
        return res;
    }

    inline function get_aSColor__10():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:199 characters: 33-40 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:199 characters: 42-45 */
        res.rgb = 0x999999;
        return res;
    }

    inline function get_jLabel__17():org.aswing.JLabel {
        /* declarations/desktop/view/AboutView.xml:197 characters: 17-23 */
        var res = new org.aswing.JLabel();
        /* declarations/desktop/view/AboutView.xml:197 characters: 53-72 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/AboutView.xml:197 characters: 25-29 */
        res.text = 'The logo design by';
        /* declarations/desktop/view/AboutView.xml:198 characters: 21-25 */
        res.font = get_aSFont__11();
        /* declarations/desktop/view/AboutView.xml:199 characters: 21-31 */
        res.foreground = get_aSColor__10();
        return res;
    }

    inline function get_aSFont__12():org.aswing.ASFont {
        /* declarations/desktop/view/AboutView.xml:202 characters: 27-33 */
        var res = new org.aswing.ASFont();
        /* declarations/desktop/view/AboutView.xml:202 characters: 68-72 */
        res.size = 12;
        /* declarations/desktop/view/AboutView.xml:202 characters: 35-39 */
        res.name = 'assets/Lato-Regular.ttf';
        /* declarations/desktop/view/AboutView.xml:202 characters: 78-87 */
        res.underline = true;
        return res;
    }

    inline function get_aSColor__11():org.aswing.ASColor {
        /* declarations/desktop/view/AboutView.xml:203 characters: 33-40 */
        var res = new org.aswing.ASColor();
        /* declarations/desktop/view/AboutView.xml:203 characters: 42-45 */
        res.rgb = 0x999999;
        return res;
    }

    inline function get_openLinkCommand__12():jive.OpenLinkCommand {
        /* declarations/desktop/view/AboutView.xml:204 characters: 30-50 */
        var res = new jive.OpenLinkCommand();
        /* declarations/desktop/view/AboutView.xml:204 characters: 52-55 */
        res.url = 'http://endelea.ru';
        return res;
    }

    inline function get_jLabelButton__14():org.aswing.JLabelButton {
        /* declarations/desktop/view/AboutView.xml:201 characters: 17-29 */
        var res = new org.aswing.JLabelButton();
        /* declarations/desktop/view/AboutView.xml:201 characters: 51-70 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/desktop/view/AboutView.xml:201 characters: 31-35 */
        res.text = 'Endelea.ru';
        /* declarations/desktop/view/AboutView.xml:202 characters: 21-25 */
        res.font = get_aSFont__12();
        /* declarations/desktop/view/AboutView.xml:203 characters: 21-31 */
        res.foreground = get_aSColor__11();
        /* declarations/desktop/view/AboutView.xml:204 characters: 21-28 */
        res.command = get_openLinkCommand__12();
        return res;
    }

    inline function get_jPanel__7():org.aswing.JPanel {
        /* declarations/desktop/view/AboutView.xml:193 characters: 13-19 */
        var res = new org.aswing.JPanel();
        /* declarations/desktop/view/AboutView.xml:194 characters: 17-23 */
        res.layout = get_flowLayout__5();
        res.append(get_jLabel__17());
        res.append(get_jLabelButton__14());
        return res;
    }

    inline function get_softBox__11():org.aswing.SoftBox {
        /* declarations/desktop/view/AboutView.xml:170 characters: 9-16 */
        var res = new org.aswing.SoftBox();
        res.append(get_jPanel__6());
        res.append(get_jPanel__7());
        return res;
    }

    inline function get_jPanel__8():org.aswing.JPanel {
        /* declarations/desktop/view/AboutView.xml:168 characters: 5-11 */
        var res = new org.aswing.JPanel();
        /* declarations/desktop/view/AboutView.xml:168 characters: 13-24 */
        res.constraints = org.aswing.BorderLayout.SOUTH;
        /* declarations/desktop/view/AboutView.xml:169 characters: 9-15 */
        res.layout = get_flowLayout__3();
        res.append(get_softBox__11());
        return res;
    }

    public function new() {
        /* declarations/desktop/view/AboutView.xml:2 characters: 1-7 */
        super();
        /* declarations/desktop/view/AboutView.xml:12 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_jPanel__5());
        this.append(get_jPanel__8());
    }
}
