package view;

class ProgressView extends org.aswing.SoftBox implements jive.DataContextControllable<viewmodel.ProgressViewModel> {

    public function destroyHml():Void {
        
    }
    

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/view/ProgressView.xml:10 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/view/ProgressView.xml:10 characters: 51-55 */
        res.size = 30;
        /* declarations/view/ProgressView.xml:10 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/view/ProgressView.xml:8 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/view/ProgressView.xml:8 characters: 46-65 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/ProgressView.xml:8 characters: 13-17 */
        res.text = 'Progress bar and Slider';
        /* declarations/view/ProgressView.xml:9 characters: 9-13 */
        res.font = get_aSFont__0();
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/view/ProgressView.xml:18 characters: 25-43 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/view/ProgressView.xml:18 characters: 45-48 */
        res.top = 30;
        /* declarations/view/ProgressView.xml:18 characters: 76-81 */
        res.right = 30;
        /* declarations/view/ProgressView.xml:18 characters: 64-70 */
        res.bottom = 30;
        /* declarations/view/ProgressView.xml:18 characters: 54-58 */
        res.left = 30;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/view/ProgressView.xml:21 characters: 25-32 */
        var res = new org.aswing.ASColor();
        /* declarations/view/ProgressView.xml:21 characters: 34-37 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/view/ProgressView.xml:16 characters: 17-34 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/view/ProgressView.xml:16 characters: 50-55 */
        res.round = 5;
        /* declarations/view/ProgressView.xml:16 characters: 36-45 */
        res.thickness = 1;
        /* declarations/view/ProgressView.xml:17 characters: 21-36 */
        res.interior = get_emptyBorder__0();
        /* declarations/view/ProgressView.xml:20 characters: 21-33 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/view/ProgressView.xml:26 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/view/ProgressView.xml:26 characters: 43-62 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/ProgressView.xml:26 characters: 21-25 */
        res.text = 'Progress bar';
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/view/ProgressView.xml:29 characters: 21-38 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/ProgressView.xml:29 characters: 40-45 */
        res.width = 300;
        /* declarations/view/ProgressView.xml:29 characters: 52-58 */
        res.height = 10;
        return res;
    }

    inline function get_jProgressBar__0():org.aswing.JProgressBar {
        /* declarations/view/ProgressView.xml:27 characters: 13-25 */
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
                        
        /* declarations/view/ProgressView.xml:28 characters: 17-30 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/view/ProgressView.xml:33 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/ProgressView.xml:33 characters: 56-61 */
        res.width = 5;
        /* declarations/view/ProgressView.xml:33 characters: 66-72 */
        res.height = 5;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/view/ProgressView.xml:33 characters: 13-20 */
        var res = new org.aswing.JSpacer();
        /* declarations/view/ProgressView.xml:33 characters: 22-35 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_jCheckBox__0():org.aswing.JCheckBox {
        /* declarations/view/ProgressView.xml:34 characters: 13-22 */
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
        /* declarations/view/ProgressView.xml:34 characters: 114-133 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/ProgressView.xml:34 characters: 24-28 */
        res.text = 'Indeterminate progress';
        return res;
    }

    inline function get_intDimension__2():org.aswing.geom.IntDimension {
        /* declarations/view/ProgressView.xml:36 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/ProgressView.xml:36 characters: 56-61 */
        res.width = 10;
        /* declarations/view/ProgressView.xml:36 characters: 67-73 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__1():org.aswing.JSpacer {
        /* declarations/view/ProgressView.xml:36 characters: 13-20 */
        var res = new org.aswing.JSpacer();
        /* declarations/view/ProgressView.xml:36 characters: 22-35 */
        res.preferredSize = get_intDimension__2();
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/view/ProgressView.xml:37 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/view/ProgressView.xml:37 characters: 61-80 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/ProgressView.xml:37 characters: 21-25 */
        res.text = 'Move slider to make a progress';
        return res;
    }

    inline function get_intDimension__3():org.aswing.geom.IntDimension {
        /* declarations/view/ProgressView.xml:42 characters: 25-42 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/ProgressView.xml:42 characters: 44-49 */
        res.width = 300;
        /* declarations/view/ProgressView.xml:42 characters: 56-62 */
        res.height = 20;
        return res;
    }

    inline function get_jSlider__0():org.aswing.JSlider {
        /* declarations/view/ProgressView.xml:40 characters: 17-24 */
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
        /* declarations/view/ProgressView.xml:41 characters: 21-34 */
        res.preferredSize = get_intDimension__3();
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/view/ProgressView.xml:39 characters: 13-19 */
        var res = new org.aswing.JPanel();
        res.append(get_jSlider__0());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/view/ProgressView.xml:14 characters: 9-16 */
        var res = new org.aswing.SoftBox();
        /* declarations/view/ProgressView.xml:15 characters: 13-19 */
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
        /* declarations/view/ProgressView.xml:13 characters: 5-12 */
        var res = new org.aswing.SoftBox();
        /* declarations/view/ProgressView.xml:13 characters: 14-18 */
        res.axis = org.aswing.SoftBoxLayout.X_AXIS;
        /* declarations/view/ProgressView.xml:13 characters: 53-56 */
        res.gap = 30;
        res.append(get_softBox__0());
        return res;
    }

    public function new() {
        /* declarations/view/ProgressView.xml:2 characters: 1-8 */
        super();
        /* declarations/view/ProgressView.xml:2 characters: 10-13 */
        this.gap = 10;
        this.append(get_jLabel__0());
        this.append(get_softBox__1());
    }
}
