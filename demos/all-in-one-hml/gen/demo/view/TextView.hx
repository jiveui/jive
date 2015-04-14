package demo.view;

class TextView extends org.aswing.JPanel implements jive.DataContextControllable<demo.viewmodel.TextViewModel> {

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/demo/view/TextView.xml:11 characters: 9-21 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/demo/view/TextView.xml:15 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/TextView.xml:15 characters: 51-55 */
        res.size = 30;
        /* declarations/demo/view/TextView.xml:15 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/TextView.xml:18 characters: 13-31 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/TextView.xml:18 characters: 33-39 */
        res.bottom = 15;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/demo/view/TextView.xml:13 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/TextView.xml:13 characters: 27-46 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/TextView.xml:13 characters: 13-17 */
        res.text = 'Text';
        /* declarations/demo/view/TextView.xml:13 characters: 81-92 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/demo/view/TextView.xml:14 characters: 9-13 */
        res.font = get_aSFont__0();
        /* declarations/demo/view/TextView.xml:17 characters: 9-15 */
        res.border = get_emptyBorder__0();
        return res;
    }

    inline function get_centerLayout__0():org.aswing.CenterLayout {
        /* declarations/demo/view/TextView.xml:27 characters: 25-37 */
        var res = new org.aswing.CenterLayout();
        return res;
    }

    inline function get_emptyBorder__1():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/TextView.xml:35 characters: 45-63 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/TextView.xml:35 characters: 65-68 */
        res.top = 30;
        /* declarations/demo/view/TextView.xml:35 characters: 96-101 */
        res.right = 30;
        /* declarations/demo/view/TextView.xml:35 characters: 84-90 */
        res.bottom = 30;
        /* declarations/demo/view/TextView.xml:35 characters: 74-78 */
        res.left = 30;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/demo/view/TextView.xml:38 characters: 45-52 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/TextView.xml:38 characters: 54-57 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/demo/view/TextView.xml:33 characters: 37-54 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/demo/view/TextView.xml:33 characters: 70-75 */
        res.round = 5;
        /* declarations/demo/view/TextView.xml:33 characters: 56-65 */
        res.thickness = 1;
        /* declarations/demo/view/TextView.xml:34 characters: 41-56 */
        res.interior = get_emptyBorder__1();
        /* declarations/demo/view/TextView.xml:37 characters: 41-53 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/demo/view/TextView.xml:46 characters: 45-62 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/TextView.xml:46 characters: 64-69 */
        res.width = 100;
        /* declarations/demo/view/TextView.xml:46 characters: 76-82 */
        res.height = -1;
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/demo/view/TextView.xml:44 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/TextView.xml:44 characters: 63-82 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/TextView.xml:44 characters: 45-49 */
        res.text = 'Predator';
        /* declarations/demo/view/TextView.xml:45 characters: 41-54 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_jTextField__0():org.aswing.JTextField {
        /* declarations/demo/view/TextView.xml:49 characters: 37-47 */
        var res = new org.aswing.JTextField();
        if (null != dataContext) { res.text = this.dataContext.predator; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.predator;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.predator, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.predator, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.predator;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.predator = res.text;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.text, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.predator = res.text;
                                }
                            });
        /* declarations/demo/view/TextView.xml:49 characters: 49-56 */
        res.columns = 15;
        /* declarations/demo/view/TextView.xml:49 characters: 62-72 */
        res.inlineHint = 'Lion';
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/demo/view/TextView.xml:43 characters: 33-39 */
        var res = new org.aswing.JPanel();
        res.append(get_jLabel__1());
        res.append(get_jTextField__0());
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/demo/view/TextView.xml:55 characters: 45-62 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/TextView.xml:55 characters: 64-69 */
        res.width = 100;
        /* declarations/demo/view/TextView.xml:55 characters: 76-82 */
        res.height = -1;
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/demo/view/TextView.xml:53 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/TextView.xml:53 characters: 59-78 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/TextView.xml:53 characters: 45-49 */
        res.text = 'Prey';
        /* declarations/demo/view/TextView.xml:54 characters: 41-54 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_jTextField__1():org.aswing.JTextField {
        /* declarations/demo/view/TextView.xml:58 characters: 37-47 */
        var res = new org.aswing.JTextField();
        if (null != dataContext) { res.text = this.dataContext.prey; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.prey;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.prey, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.prey, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.prey;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.prey = res.text;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.text, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.prey = res.text;
                                }
                            });
        /* declarations/demo/view/TextView.xml:58 characters: 49-56 */
        res.columns = 15;
        /* declarations/demo/view/TextView.xml:58 characters: 62-72 */
        res.inlineHint = 'Antelope';
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/demo/view/TextView.xml:52 characters: 33-39 */
        var res = new org.aswing.JPanel();
        res.append(get_jLabel__2());
        res.append(get_jTextField__1());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/TextView.xml:31 characters: 29-36 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/TextView.xml:32 characters: 33-39 */
        res.border = get_lineBorder__0();
        res.append(get_jPanel__0());
        res.append(get_jPanel__1());
        return res;
    }

    inline function get_aSFont__1():org.aswing.ASFont {
        /* declarations/demo/view/TextView.xml:64 characters: 37-43 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/TextView.xml:64 characters: 75-79 */
        res.size = 20;
        /* declarations/demo/view/TextView.xml:64 characters: 45-49 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_multilineLabel__0():org.aswing.ext.MultilineLabel {
        /* declarations/demo/view/TextView.xml:62 characters: 29-47 */
        var res = new org.aswing.ext.MultilineLabel();
        if (null != dataContext) { res.text = this.dataContext.predatorVictimSentence; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.predatorVictimSentence;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.predatorVictimSentence, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.predatorVictimSentence, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.predatorVictimSentence;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/TextView.xml:62 characters: 110-117 */
        res.columns = 20;
        /* declarations/demo/view/TextView.xml:62 characters: 101-105 */
        res.rows = 5;
        /* declarations/demo/view/TextView.xml:63 characters: 33-41 */
        res.font = get_aSFont__1();
        return res;
    }

    inline function get_softBox__1():org.aswing.SoftBox {
        /* declarations/demo/view/TextView.xml:30 characters: 25-32 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/TextView.xml:30 characters: 34-38 */
        res.axis = org.aswing.SoftBoxLayout.X_AXIS;
        /* declarations/demo/view/TextView.xml:30 characters: 73-76 */
        res.gap = 30;
        res.append(get_softBox__0());
        res.append(get_multilineLabel__0());
        return res;
    }

    inline function get_softBox__2():org.aswing.SoftBox {
        /* declarations/demo/view/TextView.xml:29 characters: 21-28 */
        var res = new org.aswing.SoftBox();
        res.append(get_softBox__1());
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* declarations/demo/view/TextView.xml:25 characters: 17-23 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/TextView.xml:26 characters: 21-27 */
        res.layout = get_centerLayout__0();
        res.append(get_softBox__2());
        return res;
    }

    inline function get_tabInfo__0():org.aswing.TabInfo {
        /* declarations/demo/view/TextView.xml:23 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/TextView.xml:23 characters: 18-23 */
        res.title = 'Demo';
        /* declarations/demo/view/TextView.xml:24 characters: 13-20 */
        res.content = get_jPanel__2();
        return res;
    }

    inline function get_hmlRegExRules__0():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/TextView.xml:78 characters: 29-53 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__0():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/TextView.xml:76 characters: 21-54 */
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
                        
        /* declarations/demo/view/TextView.xml:76 characters: 83-102 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/TextView.xml:77 characters: 25-41 */
        res.rules = get_hmlRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/demo/view/TextView.xml:75 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__0());
        return res;
    }

    inline function get_tabInfo__1():org.aswing.TabInfo {
        /* declarations/demo/view/TextView.xml:73 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/TextView.xml:73 characters: 18-23 */
        res.title = 'View (XML source)';
        /* declarations/demo/view/TextView.xml:74 characters: 13-20 */
        res.content = get_jScrollPane__0();
        return res;
    }

    inline function get_haxeRegExRules__0():jive.formatting.HaxeRegExRules {
        /* declarations/demo/view/TextView.xml:89 characters: 29-54 */
        var res = new jive.formatting.HaxeRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__1():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/TextView.xml:87 characters: 21-54 */
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
                        
        /* declarations/demo/view/TextView.xml:87 characters: 84-103 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/TextView.xml:88 characters: 25-41 */
        res.rules = get_haxeRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__1():org.aswing.JScrollPane {
        /* declarations/demo/view/TextView.xml:86 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__1());
        return res;
    }

    inline function get_tabInfo__2():org.aswing.TabInfo {
        /* declarations/demo/view/TextView.xml:84 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/TextView.xml:84 characters: 18-23 */
        res.title = 'View Model (Haxe source)';
        /* declarations/demo/view/TextView.xml:85 characters: 13-20 */
        res.content = get_jScrollPane__1();
        return res;
    }

    inline function get_jTabbedPane__0():org.aswing.JTabbedPane {
        /* declarations/demo/view/TextView.xml:21 characters: 5-16 */
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
        /* declarations/demo/view/TextView.xml:21 characters: 18-29 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        res.appendTabInfo(get_tabInfo__0());
        res.appendTabInfo(get_tabInfo__1());
        res.appendTabInfo(get_tabInfo__2());
        return res;
    }

    public function new() {
        /* declarations/demo/view/TextView.xml:2 characters: 1-7 */
        super();
        /* declarations/demo/view/TextView.xml:10 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_jLabel__0());
        this.append(get_jTabbedPane__0());
    }
}
