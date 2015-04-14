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
        res.bottom = 15;
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

    inline function get_centerLayout__0():org.aswing.CenterLayout {
        /* declarations/demo/view/ProgressView.xml:26 characters: 25-37 */
        var res = new org.aswing.CenterLayout();
        return res;
    }

    inline function get_emptyBorder__1():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/ProgressView.xml:33 characters: 41-59 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/ProgressView.xml:33 characters: 61-64 */
        res.top = 30;
        /* declarations/demo/view/ProgressView.xml:33 characters: 92-97 */
        res.right = 30;
        /* declarations/demo/view/ProgressView.xml:33 characters: 80-86 */
        res.bottom = 30;
        /* declarations/demo/view/ProgressView.xml:33 characters: 70-74 */
        res.left = 30;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/demo/view/ProgressView.xml:36 characters: 41-48 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/ProgressView.xml:36 characters: 50-53 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/demo/view/ProgressView.xml:31 characters: 33-50 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/demo/view/ProgressView.xml:31 characters: 66-71 */
        res.round = 5;
        /* declarations/demo/view/ProgressView.xml:31 characters: 52-61 */
        res.thickness = 1;
        /* declarations/demo/view/ProgressView.xml:32 characters: 37-52 */
        res.interior = get_emptyBorder__1();
        /* declarations/demo/view/ProgressView.xml:35 characters: 37-49 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/demo/view/ProgressView.xml:41 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ProgressView.xml:41 characters: 59-78 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ProgressView.xml:41 characters: 37-41 */
        res.text = 'Progress bar';
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ProgressView.xml:44 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ProgressView.xml:44 characters: 56-61 */
        res.width = 300;
        /* declarations/demo/view/ProgressView.xml:44 characters: 68-74 */
        res.height = 10;
        return res;
    }

    inline function get_jProgressBar__0():org.aswing.JProgressBar {
        /* declarations/demo/view/ProgressView.xml:42 characters: 29-41 */
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
                        
        /* declarations/demo/view/ProgressView.xml:43 characters: 33-46 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ProgressView.xml:48 characters: 53-70 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ProgressView.xml:48 characters: 72-77 */
        res.width = 5;
        /* declarations/demo/view/ProgressView.xml:48 characters: 82-88 */
        res.height = 5;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/demo/view/ProgressView.xml:48 characters: 29-36 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/ProgressView.xml:48 characters: 38-51 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_jCheckBox__0():org.aswing.JCheckBox {
        /* declarations/demo/view/ProgressView.xml:49 characters: 29-38 */
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
        /* declarations/demo/view/ProgressView.xml:49 characters: 130-149 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ProgressView.xml:49 characters: 40-44 */
        res.text = 'Indeterminate progress';
        return res;
    }

    inline function get_intDimension__2():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ProgressView.xml:51 characters: 53-70 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ProgressView.xml:51 characters: 72-77 */
        res.width = 10;
        /* declarations/demo/view/ProgressView.xml:51 characters: 83-89 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__1():org.aswing.JSpacer {
        /* declarations/demo/view/ProgressView.xml:51 characters: 29-36 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/ProgressView.xml:51 characters: 38-51 */
        res.preferredSize = get_intDimension__2();
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/demo/view/ProgressView.xml:52 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ProgressView.xml:52 characters: 77-96 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ProgressView.xml:52 characters: 37-41 */
        res.text = 'Move slider to make a progress';
        return res;
    }

    inline function get_intDimension__3():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ProgressView.xml:57 characters: 41-58 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ProgressView.xml:57 characters: 60-65 */
        res.width = 300;
        /* declarations/demo/view/ProgressView.xml:57 characters: 72-78 */
        res.height = 20;
        return res;
    }

    inline function get_jSlider__0():org.aswing.JSlider {
        /* declarations/demo/view/ProgressView.xml:55 characters: 33-40 */
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
        /* declarations/demo/view/ProgressView.xml:56 characters: 37-50 */
        res.preferredSize = get_intDimension__3();
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/demo/view/ProgressView.xml:54 characters: 29-35 */
        var res = new org.aswing.JPanel();
        res.append(get_jSlider__0());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/ProgressView.xml:29 characters: 25-32 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/ProgressView.xml:30 characters: 29-35 */
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
        /* declarations/demo/view/ProgressView.xml:28 characters: 21-28 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/ProgressView.xml:28 characters: 30-33 */
        res.gap = 10;
        res.append(get_softBox__0());
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/demo/view/ProgressView.xml:24 characters: 17-23 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/ProgressView.xml:25 characters: 21-27 */
        res.layout = get_centerLayout__0();
        res.append(get_softBox__1());
        return res;
    }

    inline function get_tabInfo__0():org.aswing.TabInfo {
        /* declarations/demo/view/ProgressView.xml:22 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ProgressView.xml:22 characters: 18-23 */
        res.title = 'Demo';
        /* declarations/demo/view/ProgressView.xml:23 characters: 13-20 */
        res.content = get_jPanel__1();
        return res;
    }

    inline function get_hmlRegExRules__0():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/ProgressView.xml:72 characters: 29-53 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__0():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/ProgressView.xml:70 characters: 21-54 */
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
                        
        /* declarations/demo/view/ProgressView.xml:70 characters: 83-102 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/ProgressView.xml:71 characters: 25-41 */
        res.rules = get_hmlRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/demo/view/ProgressView.xml:69 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__0());
        return res;
    }

    inline function get_tabInfo__1():org.aswing.TabInfo {
        /* declarations/demo/view/ProgressView.xml:67 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ProgressView.xml:67 characters: 18-23 */
        res.title = 'View (XML source)';
        /* declarations/demo/view/ProgressView.xml:68 characters: 13-20 */
        res.content = get_jScrollPane__0();
        return res;
    }

    inline function get_haxeRegExRules__0():jive.formatting.HaxeRegExRules {
        /* declarations/demo/view/ProgressView.xml:83 characters: 29-54 */
        var res = new jive.formatting.HaxeRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__1():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/ProgressView.xml:81 characters: 21-54 */
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
                        
        /* declarations/demo/view/ProgressView.xml:81 characters: 84-103 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/ProgressView.xml:82 characters: 25-41 */
        res.rules = get_haxeRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__1():org.aswing.JScrollPane {
        /* declarations/demo/view/ProgressView.xml:80 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__1());
        return res;
    }

    inline function get_tabInfo__2():org.aswing.TabInfo {
        /* declarations/demo/view/ProgressView.xml:78 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ProgressView.xml:78 characters: 18-23 */
        res.title = 'View Model (Haxe source)';
        /* declarations/demo/view/ProgressView.xml:79 characters: 13-20 */
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
