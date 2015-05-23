package demo.view;

class AdjusterView extends org.aswing.JPanel implements jive.DataContextControllable<demo.viewmodel.AdjusterViewModel> {

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/demo/view/AdjusterView.xml:12 characters: 9-21 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/demo/view/AdjusterView.xml:16 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/AdjusterView.xml:16 characters: 51-55 */
        res.size = 30;
        /* declarations/demo/view/AdjusterView.xml:16 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/AdjusterView.xml:19 characters: 13-31 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/AdjusterView.xml:19 characters: 33-39 */
        res.bottom = 30;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/demo/view/AdjusterView.xml:14 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AdjusterView.xml:14 characters: 31-50 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/AdjusterView.xml:14 characters: 13-17 */
        res.text = 'Adjuster';
        /* declarations/demo/view/AdjusterView.xml:14 characters: 85-96 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/demo/view/AdjusterView.xml:15 characters: 9-13 */
        res.font = get_aSFont__0();
        /* declarations/demo/view/AdjusterView.xml:18 characters: 9-15 */
        res.border = get_emptyBorder__0();
        return res;
    }

    inline function get_jAdjuster__0():org.aswing.JAdjuster {
        /* declarations/demo/view/AdjusterView.xml:27 characters: 21-30 */
        var res = new org.aswing.JAdjuster();
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/demo/view/AdjusterView.xml:26 characters: 17-23 */
        var res = new org.aswing.JPanel();
        res.append(get_jAdjuster__0());
        return res;
    }

    inline function get_tabInfo__0():org.aswing.TabInfo {
        /* declarations/demo/view/AdjusterView.xml:24 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AdjusterView.xml:24 characters: 18-23 */
        res.title = 'Demo';
        /* declarations/demo/view/AdjusterView.xml:25 characters: 13-20 */
        res.content = get_jPanel__0();
        return res;
    }

    inline function get_hmlRegExRules__0():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/AdjusterView.xml:37 characters: 29-53 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__0():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/AdjusterView.xml:35 characters: 21-54 */
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
                        
        /* declarations/demo/view/AdjusterView.xml:35 characters: 83-102 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/AdjusterView.xml:36 characters: 25-41 */
        res.rules = get_hmlRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/demo/view/AdjusterView.xml:34 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__0());
        return res;
    }

    inline function get_tabInfo__1():org.aswing.TabInfo {
        /* declarations/demo/view/AdjusterView.xml:32 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AdjusterView.xml:32 characters: 18-23 */
        res.title = 'View (XML source)';
        /* declarations/demo/view/AdjusterView.xml:33 characters: 13-20 */
        res.content = get_jScrollPane__0();
        return res;
    }

    inline function get_haxeRegExRules__0():jive.formatting.HaxeRegExRules {
        /* declarations/demo/view/AdjusterView.xml:48 characters: 29-54 */
        var res = new jive.formatting.HaxeRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__1():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/AdjusterView.xml:46 characters: 21-54 */
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
                        
        /* declarations/demo/view/AdjusterView.xml:46 characters: 84-103 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/AdjusterView.xml:47 characters: 25-41 */
        res.rules = get_haxeRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__1():org.aswing.JScrollPane {
        /* declarations/demo/view/AdjusterView.xml:45 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__1());
        return res;
    }

    inline function get_tabInfo__2():org.aswing.TabInfo {
        /* declarations/demo/view/AdjusterView.xml:43 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AdjusterView.xml:43 characters: 18-23 */
        res.title = 'View Model (Haxe source)';
        /* declarations/demo/view/AdjusterView.xml:44 characters: 13-20 */
        res.content = get_jScrollPane__1();
        return res;
    }

    inline function get_jTabbedPane__0():org.aswing.JTabbedPane {
        /* declarations/demo/view/AdjusterView.xml:22 characters: 5-16 */
        var res = new org.aswing.JTabbedPane();
        if (null != dataContext) { res.selectedIndex = this.dataContext.selectedSpotIndex; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.selectedIndex = this.dataContext.selectedSpotIndex;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.selectedSpotIndex, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.selectedSpotIndex, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.selectedIndex = this.dataContext.selectedSpotIndex;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.selectedSpotIndex = res.selectedIndex;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.selectedIndex, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.selectedSpotIndex = res.selectedIndex;
                                }
                            });
        /* declarations/demo/view/AdjusterView.xml:22 characters: 18-29 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        res.appendTabInfo(get_tabInfo__0());
        res.appendTabInfo(get_tabInfo__1());
        res.appendTabInfo(get_tabInfo__2());
        return res;
    }

    public function new() {
        /* declarations/demo/view/AdjusterView.xml:2 characters: 1-7 */
        super();
        /* declarations/demo/view/AdjusterView.xml:11 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_jLabel__0());
        this.append(get_jTabbedPane__0());
    }
}
