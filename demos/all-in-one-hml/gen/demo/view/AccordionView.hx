package demo.view;

class AccordionView extends org.aswing.JPanel implements jive.DataContextControllable<demo.viewmodel.AccordionViewModel> {

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/demo/view/AccordionView.xml:11 characters: 9-21 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/demo/view/AccordionView.xml:15 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/AccordionView.xml:15 characters: 51-55 */
        res.size = 30;
        /* declarations/demo/view/AccordionView.xml:15 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/AccordionView.xml:18 characters: 13-31 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/AccordionView.xml:18 characters: 33-39 */
        res.bottom = 30;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/demo/view/AccordionView.xml:13 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AccordionView.xml:13 characters: 32-51 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/AccordionView.xml:13 characters: 13-17 */
        res.text = 'Accordion';
        /* declarations/demo/view/AccordionView.xml:13 characters: 86-97 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/demo/view/AccordionView.xml:14 characters: 9-13 */
        res.font = get_aSFont__0();
        /* declarations/demo/view/AccordionView.xml:17 characters: 9-15 */
        res.border = get_emptyBorder__0();
        return res;
    }

    inline function get_borderLayout__1():org.aswing.BorderLayout {
        /* declarations/demo/view/AccordionView.xml:27 characters: 25-37 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_emptyBorder__1():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/AccordionView.xml:29 characters: 29-47 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/AccordionView.xml:29 characters: 49-52 */
        res.top = 30;
        return res;
    }

    inline function get_aSFont__1():org.aswing.ASFont {
        /* declarations/demo/view/AccordionView.xml:32 characters: 29-35 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/AccordionView.xml:32 characters: 67-71 */
        res.size = 18;
        /* declarations/demo/view/AccordionView.xml:32 characters: 37-41 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__2():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/AccordionView.xml:35 characters: 29-47 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/AccordionView.xml:35 characters: 49-55 */
        res.bottom = 15;
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/demo/view/AccordionView.xml:30 characters: 21-27 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AccordionView.xml:30 characters: 42-61 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/AccordionView.xml:30 characters: 29-33 */
        res.text = 'FAQ';
        /* declarations/demo/view/AccordionView.xml:30 characters: 96-107 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/demo/view/AccordionView.xml:31 characters: 25-29 */
        res.font = get_aSFont__1();
        /* declarations/demo/view/AccordionView.xml:34 characters: 25-31 */
        res.border = get_emptyBorder__2();
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/demo/view/AccordionView.xml:44 characters: 45-52 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/AccordionView.xml:44 characters: 54-57 */
        res.rgb = 0x8e44ad;
        return res;
    }

    inline function get_jButton__0():org.aswing.JButton {
        /* declarations/demo/view/AccordionView.xml:42 characters: 37-44 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/AccordionView.xml:42 characters: 46-50 */
        res.text = 'Hello wisteria world!';
        /* declarations/demo/view/AccordionView.xml:43 characters: 41-51 */
        res.background = get_aSColor__0();
        return res;
    }

    inline function get_aSColor__1():org.aswing.ASColor {
        /* declarations/demo/view/AccordionView.xml:49 characters: 45-52 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/AccordionView.xml:49 characters: 54-57 */
        res.rgb = 0x2980b9;
        return res;
    }

    inline function get_jButton__1():org.aswing.JButton {
        /* declarations/demo/view/AccordionView.xml:47 characters: 37-44 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/AccordionView.xml:47 characters: 46-50 */
        res.text = 'Hello world from Belize!';
        /* declarations/demo/view/AccordionView.xml:48 characters: 41-51 */
        res.background = get_aSColor__1();
        return res;
    }

    inline function get_aSColor__2():org.aswing.ASColor {
        /* declarations/demo/view/AccordionView.xml:54 characters: 45-52 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/AccordionView.xml:54 characters: 54-57 */
        res.rgb = 0x2ecc71;
        return res;
    }

    inline function get_jButton__2():org.aswing.JButton {
        /* declarations/demo/view/AccordionView.xml:52 characters: 37-44 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/AccordionView.xml:52 characters: 46-50 */
        res.text = 'Emeralds\'re better than diamonds!';
        /* declarations/demo/view/AccordionView.xml:53 characters: 41-51 */
        res.background = get_aSColor__2();
        return res;
    }

    inline function get_aSColor__3():org.aswing.ASColor {
        /* declarations/demo/view/AccordionView.xml:59 characters: 45-52 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/AccordionView.xml:59 characters: 54-57 */
        res.rgb = 0xf39c12;
        return res;
    }

    inline function get_jButton__3():org.aswing.JButton {
        /* declarations/demo/view/AccordionView.xml:57 characters: 37-44 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/AccordionView.xml:57 characters: 46-50 */
        res.text = 'Let\'s make it orange!';
        /* declarations/demo/view/AccordionView.xml:58 characters: 41-51 */
        res.background = get_aSColor__3();
        return res;
    }

    inline function get_aSColor__4():org.aswing.ASColor {
        /* declarations/demo/view/AccordionView.xml:64 characters: 45-52 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/AccordionView.xml:64 characters: 54-57 */
        res.rgb = 0xc0392b;
        return res;
    }

    inline function get_jButton__4():org.aswing.JButton {
        /* declarations/demo/view/AccordionView.xml:62 characters: 37-44 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/AccordionView.xml:62 characters: 46-50 */
        res.text = 'I love pomegranates!';
        /* declarations/demo/view/AccordionView.xml:63 characters: 41-51 */
        res.background = get_aSColor__4();
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/AccordionView.xml:41 characters: 33-40 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/AccordionView.xml:41 characters: 42-45 */
        res.gap = 10;
        res.append(get_jButton__0());
        res.append(get_jButton__1());
        res.append(get_jButton__2());
        res.append(get_jButton__3());
        res.append(get_jButton__4());
        return res;
    }

    inline function get_tabInfo__0():org.aswing.TabInfo {
        /* declarations/demo/view/AccordionView.xml:39 characters: 25-32 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AccordionView.xml:39 characters: 34-39 */
        res.title = 'Can I put color buttons inside?';
        /* declarations/demo/view/AccordionView.xml:40 characters: 29-36 */
        res.content = get_softBox__0();
        return res;
    }

    inline function get_hmlRegExRules__0():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/AccordionView.xml:75 characters: 45-69 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__0():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/AccordionView.xml:73 characters: 37-70 */
        var res = new jive.formatting.RegExFormattedTextArea();
        if (null != dataContext) { res.text = this.dataContext.xmlSource; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.xmlSource;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.xmlSource, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.xmlSource, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.xmlSource;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/AccordionView.xml:73 characters: 99-118 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/AccordionView.xml:74 characters: 41-57 */
        res.rules = get_hmlRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/demo/view/AccordionView.xml:72 characters: 33-44 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__0());
        return res;
    }

    inline function get_tabInfo__1():org.aswing.TabInfo {
        /* declarations/demo/view/AccordionView.xml:70 characters: 25-32 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AccordionView.xml:70 characters: 34-39 */
        res.title = 'Can I put the accordion demo XML source inside?';
        /* declarations/demo/view/AccordionView.xml:71 characters: 29-36 */
        res.content = get_jScrollPane__0();
        return res;
    }

    inline function get_centerLayout__0():org.aswing.CenterLayout {
        /* declarations/demo/view/AccordionView.xml:85 characters: 41-53 */
        var res = new org.aswing.CenterLayout();
        return res;
    }

    inline function get_assetIcon__0():org.aswing.AssetIcon {
        /* declarations/demo/view/AccordionView.xml:87 characters: 105-114 */
        var res = new org.aswing.AssetIcon();
        if (null != dataContext) { res.asset = this.dataContext.haxeLogo; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.asset = this.dataContext.haxeLogo;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.haxeLogo, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.haxeLogo, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.asset = this.dataContext.haxeLogo;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/AccordionView.xml:87 characters: 143-148 */
        res.width = 200;
        /* declarations/demo/view/AccordionView.xml:87 characters: 155-161 */
        res.height = 200;
        /* declarations/demo/view/AccordionView.xml:87 characters: 168-173 */
        res.scale = true;
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/demo/view/AccordionView.xml:87 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AccordionView.xml:87 characters: 45-64 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/AccordionView.xml:87 characters: 99-103 */
        res.icon = get_assetIcon__0();
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/demo/view/AccordionView.xml:83 characters: 33-39 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/AccordionView.xml:84 characters: 37-43 */
        res.layout = get_centerLayout__0();
        res.append(get_jLabel__2());
        return res;
    }

    inline function get_tabInfo__2():org.aswing.TabInfo {
        /* declarations/demo/view/AccordionView.xml:81 characters: 25-32 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AccordionView.xml:81 characters: 34-39 */
        res.title = 'Can I put the Haxe logo inside?';
        /* declarations/demo/view/AccordionView.xml:82 characters: 29-36 */
        res.content = get_jPanel__0();
        return res;
    }

    inline function get_jAccordion__0():org.aswing.JAccordion {
        /* declarations/demo/view/AccordionView.xml:38 characters: 21-31 */
        var res = new org.aswing.JAccordion();
        res.appendTabInfo(get_tabInfo__0());
        res.appendTabInfo(get_tabInfo__1());
        res.appendTabInfo(get_tabInfo__2());
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/demo/view/AccordionView.xml:25 characters: 17-23 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/AccordionView.xml:26 characters: 21-27 */
        res.layout = get_borderLayout__1();
        /* declarations/demo/view/AccordionView.xml:29 characters: 21-27 */
        res.border = get_emptyBorder__1();
        res.append(get_jLabel__1());
        res.append(get_jAccordion__0());
        return res;
    }

    inline function get_tabInfo__3():org.aswing.TabInfo {
        /* declarations/demo/view/AccordionView.xml:23 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AccordionView.xml:23 characters: 18-23 */
        res.title = 'Demo';
        /* declarations/demo/view/AccordionView.xml:24 characters: 13-20 */
        res.content = get_jPanel__1();
        return res;
    }

    inline function get_hmlRegExRules__1():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/AccordionView.xml:101 characters: 29-53 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__1():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/AccordionView.xml:99 characters: 21-54 */
        var res = new jive.formatting.RegExFormattedTextArea();
        if (null != dataContext) { res.text = this.dataContext.xmlSource; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.xmlSource;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.xmlSource, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.xmlSource, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.xmlSource;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/AccordionView.xml:99 characters: 83-102 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/AccordionView.xml:100 characters: 25-41 */
        res.rules = get_hmlRegExRules__1();
        return res;
    }

    inline function get_jScrollPane__1():org.aswing.JScrollPane {
        /* declarations/demo/view/AccordionView.xml:98 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__1());
        return res;
    }

    inline function get_tabInfo__4():org.aswing.TabInfo {
        /* declarations/demo/view/AccordionView.xml:96 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AccordionView.xml:96 characters: 18-23 */
        res.title = 'View (XML source)';
        /* declarations/demo/view/AccordionView.xml:97 characters: 13-20 */
        res.content = get_jScrollPane__1();
        return res;
    }

    inline function get_haxeRegExRules__0():jive.formatting.HaxeRegExRules {
        /* declarations/demo/view/AccordionView.xml:112 characters: 29-54 */
        var res = new jive.formatting.HaxeRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__2():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/AccordionView.xml:110 characters: 21-54 */
        var res = new jive.formatting.RegExFormattedTextArea();
        if (null != dataContext) { res.text = this.dataContext.haxeSource; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.haxeSource;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.haxeSource, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.haxeSource, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.haxeSource;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/AccordionView.xml:110 characters: 84-103 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/AccordionView.xml:111 characters: 25-41 */
        res.rules = get_haxeRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__2():org.aswing.JScrollPane {
        /* declarations/demo/view/AccordionView.xml:109 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__2());
        return res;
    }

    inline function get_tabInfo__5():org.aswing.TabInfo {
        /* declarations/demo/view/AccordionView.xml:107 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AccordionView.xml:107 characters: 18-23 */
        res.title = 'View Model (Haxe source)';
        /* declarations/demo/view/AccordionView.xml:108 characters: 13-20 */
        res.content = get_jScrollPane__2();
        return res;
    }

    inline function get_jTabbedPane__0():org.aswing.JTabbedPane {
        /* declarations/demo/view/AccordionView.xml:21 characters: 5-16 */
        var res = new org.aswing.JTabbedPane();
        /* declarations/demo/view/AccordionView.xml:21 characters: 18-29 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        res.appendTabInfo(get_tabInfo__3());
        res.appendTabInfo(get_tabInfo__4());
        res.appendTabInfo(get_tabInfo__5());
        return res;
    }

    public function new() {
        /* declarations/demo/view/AccordionView.xml:2 characters: 1-7 */
        super();
        /* declarations/demo/view/AccordionView.xml:10 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_jLabel__0());
        this.append(get_jTabbedPane__0());
    }
}
