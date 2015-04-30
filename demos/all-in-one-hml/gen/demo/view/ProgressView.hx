package demo.view;

class ProgressView extends org.aswing.JPanel implements jive.DataContextControllable<demo.viewmodel.ProgressViewModel> {

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/demo/view/ProgressView.xml:10 characters: 9-21 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/demo/view/ProgressView.xml:14 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/ProgressView.xml:14 characters: 51-55 */
        res.size = 30;
        /* declarations/demo/view/ProgressView.xml:14 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/ProgressView.xml:17 characters: 13-31 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/ProgressView.xml:17 characters: 33-39 */
        res.bottom = 30;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/demo/view/ProgressView.xml:12 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ProgressView.xml:12 characters: 46-65 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ProgressView.xml:12 characters: 13-17 */
        res.text = 'Progress bar and Slider';
        /* declarations/demo/view/ProgressView.xml:12 characters: 100-111 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/demo/view/ProgressView.xml:13 characters: 9-13 */
        res.font = get_aSFont__0();
        /* declarations/demo/view/ProgressView.xml:16 characters: 9-15 */
        res.border = get_emptyBorder__0();
        return res;
    }

    inline function get_emptyBorder__1():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/ProgressView.xml:25 characters: 29-47 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/ProgressView.xml:25 characters: 49-52 */
        res.top = 30;
        return res;
    }

    inline function get_emptyBorder__2():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/ProgressView.xml:30 characters: 37-55 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/ProgressView.xml:30 characters: 57-60 */
        res.top = 30;
        /* declarations/demo/view/ProgressView.xml:30 characters: 88-93 */
        res.right = 30;
        /* declarations/demo/view/ProgressView.xml:30 characters: 76-82 */
        res.bottom = 30;
        /* declarations/demo/view/ProgressView.xml:30 characters: 66-70 */
        res.left = 30;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/demo/view/ProgressView.xml:33 characters: 37-44 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/ProgressView.xml:33 characters: 46-49 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/demo/view/ProgressView.xml:28 characters: 29-46 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/demo/view/ProgressView.xml:28 characters: 62-67 */
        res.round = 5;
        /* declarations/demo/view/ProgressView.xml:28 characters: 48-57 */
        res.thickness = 1;
        /* declarations/demo/view/ProgressView.xml:29 characters: 33-48 */
        res.interior = get_emptyBorder__2();
        /* declarations/demo/view/ProgressView.xml:32 characters: 33-45 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/demo/view/ProgressView.xml:38 characters: 25-31 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ProgressView.xml:38 characters: 55-74 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ProgressView.xml:38 characters: 33-37 */
        res.text = 'Progress bar';
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ProgressView.xml:41 characters: 33-50 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ProgressView.xml:41 characters: 52-57 */
        res.width = 300;
        /* declarations/demo/view/ProgressView.xml:41 characters: 64-70 */
        res.height = 10;
        return res;
    }

    inline function get_jProgressBar__0():org.aswing.JProgressBar {
        /* declarations/demo/view/ProgressView.xml:39 characters: 25-37 */
        var res = new org.aswing.JProgressBar();
        if (null != dataContext) { res.indeterminate = this.dataContext.isScrollbarIndeterminate; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.indeterminate = this.dataContext.isScrollbarIndeterminate;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.isScrollbarIndeterminate, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.isScrollbarIndeterminate, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.indeterminate = this.dataContext.isScrollbarIndeterminate;
                                    bindSourceListener();
                                }
                            });
                        
        if (null != dataContext) { res.value = this.dataContext.sliderValue; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.value = this.dataContext.sliderValue;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.sliderValue, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.sliderValue, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.value = this.dataContext.sliderValue;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/ProgressView.xml:40 characters: 29-42 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ProgressView.xml:45 characters: 49-66 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ProgressView.xml:45 characters: 68-73 */
        res.width = 5;
        /* declarations/demo/view/ProgressView.xml:45 characters: 78-84 */
        res.height = 5;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/demo/view/ProgressView.xml:45 characters: 25-32 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/ProgressView.xml:45 characters: 34-47 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_jCheckBox__0():org.aswing.JCheckBox {
        /* declarations/demo/view/ProgressView.xml:46 characters: 25-34 */
        var res = new org.aswing.JCheckBox();
        if (null != dataContext) { res.selected = this.dataContext.isScrollbarIndeterminate; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.selected = this.dataContext.isScrollbarIndeterminate;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.isScrollbarIndeterminate, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.isScrollbarIndeterminate, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.selected = this.dataContext.isScrollbarIndeterminate;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.isScrollbarIndeterminate = res.selected;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.selected, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.isScrollbarIndeterminate = res.selected;
                                }
                            });
        /* declarations/demo/view/ProgressView.xml:46 characters: 126-145 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ProgressView.xml:46 characters: 36-40 */
        res.text = 'Indeterminate progress';
        return res;
    }

    inline function get_intDimension__2():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ProgressView.xml:48 characters: 49-66 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ProgressView.xml:48 characters: 68-73 */
        res.width = 10;
        /* declarations/demo/view/ProgressView.xml:48 characters: 79-85 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__1():org.aswing.JSpacer {
        /* declarations/demo/view/ProgressView.xml:48 characters: 25-32 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/ProgressView.xml:48 characters: 34-47 */
        res.preferredSize = get_intDimension__2();
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/demo/view/ProgressView.xml:49 characters: 25-31 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ProgressView.xml:49 characters: 73-92 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ProgressView.xml:49 characters: 33-37 */
        res.text = 'Move slider to make a progress';
        return res;
    }

    inline function get_intDimension__3():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ProgressView.xml:54 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ProgressView.xml:54 characters: 56-61 */
        res.width = 300;
        /* declarations/demo/view/ProgressView.xml:54 characters: 68-74 */
        res.height = 20;
        return res;
    }

    inline function get_jSlider__0():org.aswing.JSlider {
        /* declarations/demo/view/ProgressView.xml:52 characters: 29-36 */
        var res = new org.aswing.JSlider();
        if (null != dataContext) { res.value = this.dataContext.sliderValue; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.value = this.dataContext.sliderValue;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.sliderValue, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.sliderValue, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.value = this.dataContext.sliderValue;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.sliderValue = res.value;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.value, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.sliderValue = res.value;
                                }
                            });
        /* declarations/demo/view/ProgressView.xml:53 characters: 33-46 */
        res.preferredSize = get_intDimension__3();
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/demo/view/ProgressView.xml:51 characters: 25-31 */
        var res = new org.aswing.JPanel();
        res.append(get_jSlider__0());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/ProgressView.xml:26 characters: 21-28 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/ProgressView.xml:27 characters: 25-31 */
        res.border = get_lineBorder__0();
        res.append(get_jLabel__1());
        res.append(get_jProgressBar__0());
        res.append(get_jSpacer__0());
        res.append(get_jCheckBox__0());
        res.append(get_jSpacer__1());
        res.append(get_jLabel__2());
        res.append(get_jPanel__0());
        return res;
    }

    inline function get_softBox__1():org.aswing.SoftBox {
        /* declarations/demo/view/ProgressView.xml:24 characters: 17-24 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/ProgressView.xml:24 characters: 26-29 */
        res.gap = 10;
        /* declarations/demo/view/ProgressView.xml:25 characters: 21-27 */
        res.border = get_emptyBorder__1();
        res.append(get_softBox__0());
        return res;
    }

    inline function get_tabInfo__0():org.aswing.TabInfo {
        /* declarations/demo/view/ProgressView.xml:22 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ProgressView.xml:22 characters: 18-23 */
        res.title = 'Demo';
        /* declarations/demo/view/ProgressView.xml:23 characters: 13-20 */
        res.content = get_softBox__1();
        return res;
    }

    inline function get_hmlRegExRules__0():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/ProgressView.xml:68 characters: 29-53 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__0():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/ProgressView.xml:66 characters: 21-54 */
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
                        
        /* declarations/demo/view/ProgressView.xml:66 characters: 83-102 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/ProgressView.xml:67 characters: 25-41 */
        res.rules = get_hmlRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/demo/view/ProgressView.xml:65 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__0());
        return res;
    }

    inline function get_tabInfo__1():org.aswing.TabInfo {
        /* declarations/demo/view/ProgressView.xml:63 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ProgressView.xml:63 characters: 18-23 */
        res.title = 'View (XML source)';
        /* declarations/demo/view/ProgressView.xml:64 characters: 13-20 */
        res.content = get_jScrollPane__0();
        return res;
    }

    inline function get_haxeRegExRules__0():jive.formatting.HaxeRegExRules {
        /* declarations/demo/view/ProgressView.xml:79 characters: 29-54 */
        var res = new jive.formatting.HaxeRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__1():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/ProgressView.xml:77 characters: 21-54 */
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
                        
        /* declarations/demo/view/ProgressView.xml:77 characters: 84-103 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/ProgressView.xml:78 characters: 25-41 */
        res.rules = get_haxeRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__1():org.aswing.JScrollPane {
        /* declarations/demo/view/ProgressView.xml:76 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__1());
        return res;
    }

    inline function get_tabInfo__2():org.aswing.TabInfo {
        /* declarations/demo/view/ProgressView.xml:74 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ProgressView.xml:74 characters: 18-23 */
        res.title = 'View Model (Haxe source)';
        /* declarations/demo/view/ProgressView.xml:75 characters: 13-20 */
        res.content = get_jScrollPane__1();
        return res;
    }

    inline function get_jTabbedPane__0():org.aswing.JTabbedPane {
        /* declarations/demo/view/ProgressView.xml:20 characters: 5-16 */
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
        /* declarations/demo/view/ProgressView.xml:20 characters: 18-29 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        res.appendTabInfo(get_tabInfo__0());
        res.appendTabInfo(get_tabInfo__1());
        res.appendTabInfo(get_tabInfo__2());
        return res;
    }

    public function new() {
        /* declarations/demo/view/ProgressView.xml:2 characters: 1-7 */
        super();
        /* declarations/demo/view/ProgressView.xml:9 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_jLabel__0());
        this.append(get_jTabbedPane__0());
    }
}
