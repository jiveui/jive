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

    inline function get_emptyBorder__1():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/AdjusterView.xml:27 characters: 29-47 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/AdjusterView.xml:27 characters: 49-52 */
        res.top = 30;
        return res;
    }

    inline function get_emptyBorder__2():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/AdjusterView.xml:32 characters: 37-55 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/AdjusterView.xml:32 characters: 57-60 */
        res.top = 30;
        /* declarations/demo/view/AdjusterView.xml:32 characters: 88-93 */
        res.right = 30;
        /* declarations/demo/view/AdjusterView.xml:32 characters: 76-82 */
        res.bottom = 30;
        /* declarations/demo/view/AdjusterView.xml:32 characters: 66-70 */
        res.left = 30;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/demo/view/AdjusterView.xml:35 characters: 37-44 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/AdjusterView.xml:35 characters: 46-49 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/demo/view/AdjusterView.xml:30 characters: 29-46 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/demo/view/AdjusterView.xml:30 characters: 62-67 */
        res.round = 5;
        /* declarations/demo/view/AdjusterView.xml:30 characters: 48-57 */
        res.thickness = 1;
        /* declarations/demo/view/AdjusterView.xml:31 characters: 33-48 */
        res.interior = get_emptyBorder__2();
        /* declarations/demo/view/AdjusterView.xml:34 characters: 33-45 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_aSFont__1():org.aswing.ASFont {
        /* declarations/demo/view/AdjusterView.xml:42 characters: 33-39 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/AdjusterView.xml:42 characters: 71-75 */
        res.size = 18;
        /* declarations/demo/view/AdjusterView.xml:42 characters: 41-45 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__3():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/AdjusterView.xml:44 characters: 37-55 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/AdjusterView.xml:44 characters: 57-63 */
        res.bottom = 10;
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/demo/view/AdjusterView.xml:40 characters: 25-31 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AdjusterView.xml:40 characters: 56-75 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/AdjusterView.xml:40 characters: 33-37 */
        res.text = 'Shopping Cart';
        /* declarations/demo/view/AdjusterView.xml:41 characters: 29-33 */
        res.font = get_aSFont__1();
        /* declarations/demo/view/AdjusterView.xml:44 characters: 29-35 */
        res.border = get_emptyBorder__3();
        return res;
    }

    inline function get_flowLayout__0():org.aswing.FlowLayout {
        /* declarations/demo/view/AdjusterView.xml:49 characters: 33-43 */
        var res = new org.aswing.FlowLayout();
        /* declarations/demo/view/AdjusterView.xml:49 characters: 45-49 */
        res.hgap = 0;
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/demo/view/AdjusterView.xml:53 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/AdjusterView.xml:53 characters: 56-61 */
        res.width = 250;
        /* declarations/demo/view/AdjusterView.xml:53 characters: 68-74 */
        res.height = -1;
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/demo/view/AdjusterView.xml:51 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AdjusterView.xml:51 characters: 67-86 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/AdjusterView.xml:51 characters: 37-41 */
        res.text = 'Apple iPhone 6 64 GB';
        /* declarations/demo/view/AdjusterView.xml:52 characters: 33-46 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/demo/view/AdjusterView.xml:58 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/AdjusterView.xml:58 characters: 56-61 */
        res.width = 100;
        /* declarations/demo/view/AdjusterView.xml:58 characters: 68-74 */
        res.height = -1;
        return res;
    }

    inline function get_jLabel__3():org.aswing.JLabel {
        /* declarations/demo/view/AdjusterView.xml:56 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AdjusterView.xml:56 characters: 54-73 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/AdjusterView.xml:56 characters: 37-41 */
        res.text = '$812.98';
        /* declarations/demo/view/AdjusterView.xml:57 characters: 33-46 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_jAdjuster__0():org.aswing.JAdjuster {
        /* declarations/demo/view/AdjusterView.xml:61 characters: 29-38 */
        var res = new org.aswing.JAdjuster();
        if (null != dataContext) { res.value = this.dataContext.iphoneQuantity; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.value = this.dataContext.iphoneQuantity;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.iphoneQuantity, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.iphoneQuantity, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.value = this.dataContext.iphoneQuantity;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.iphoneQuantity = res.value;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.value, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.iphoneQuantity = res.value;
                                }
                            });
        /* declarations/demo/view/AdjusterView.xml:61 characters: 85-92 */
        res.minimum = 0;
        /* declarations/demo/view/AdjusterView.xml:61 characters: 109-117 */
        res.stepSize = 1;
        /* declarations/demo/view/AdjusterView.xml:61 characters: 97-104 */
        res.maximum = 5;
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/demo/view/AdjusterView.xml:47 characters: 25-31 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/AdjusterView.xml:48 characters: 29-35 */
        res.layout = get_flowLayout__0();
        res.append(get_jLabel__2());
        res.append(get_jLabel__3());
        res.append(get_jAdjuster__0());
        return res;
    }

    inline function get_flowLayout__1():org.aswing.FlowLayout {
        /* declarations/demo/view/AdjusterView.xml:65 characters: 33-43 */
        var res = new org.aswing.FlowLayout();
        /* declarations/demo/view/AdjusterView.xml:65 characters: 45-49 */
        res.hgap = 0;
        return res;
    }

    inline function get_intDimension__2():org.aswing.geom.IntDimension {
        /* declarations/demo/view/AdjusterView.xml:69 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/AdjusterView.xml:69 characters: 56-61 */
        res.width = 250;
        /* declarations/demo/view/AdjusterView.xml:69 characters: 68-74 */
        res.height = -1;
        return res;
    }

    inline function get_jLabel__4():org.aswing.JLabel {
        /* declarations/demo/view/AdjusterView.xml:67 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AdjusterView.xml:67 characters: 74-93 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/AdjusterView.xml:67 characters: 37-41 */
        res.text = 'Samsung Galaxy S6 Edge 64GB';
        /* declarations/demo/view/AdjusterView.xml:68 characters: 33-46 */
        res.preferredSize = get_intDimension__2();
        return res;
    }

    inline function get_intDimension__3():org.aswing.geom.IntDimension {
        /* declarations/demo/view/AdjusterView.xml:74 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/AdjusterView.xml:74 characters: 56-61 */
        res.width = 100;
        /* declarations/demo/view/AdjusterView.xml:74 characters: 68-74 */
        res.height = -1;
        return res;
    }

    inline function get_jLabel__5():org.aswing.JLabel {
        /* declarations/demo/view/AdjusterView.xml:72 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AdjusterView.xml:72 characters: 55-74 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/AdjusterView.xml:72 characters: 37-41 */
        res.text = '$1019.99';
        /* declarations/demo/view/AdjusterView.xml:73 characters: 33-46 */
        res.preferredSize = get_intDimension__3();
        return res;
    }

    inline function get_jAdjuster__1():org.aswing.JAdjuster {
        /* declarations/demo/view/AdjusterView.xml:77 characters: 29-38 */
        var res = new org.aswing.JAdjuster();
        if (null != dataContext) { res.value = this.dataContext.galaxyQuantity; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.value = this.dataContext.galaxyQuantity;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.galaxyQuantity, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.galaxyQuantity, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.value = this.dataContext.galaxyQuantity;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.galaxyQuantity = res.value;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.value, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.galaxyQuantity = res.value;
                                }
                            });
        /* declarations/demo/view/AdjusterView.xml:77 characters: 85-92 */
        res.minimum = 0;
        /* declarations/demo/view/AdjusterView.xml:77 characters: 109-117 */
        res.stepSize = 1;
        /* declarations/demo/view/AdjusterView.xml:77 characters: 97-104 */
        res.maximum = 3;
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/demo/view/AdjusterView.xml:63 characters: 25-31 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/AdjusterView.xml:64 characters: 29-35 */
        res.layout = get_flowLayout__1();
        res.append(get_jLabel__4());
        res.append(get_jLabel__5());
        res.append(get_jAdjuster__1());
        return res;
    }

    inline function get_flowLayout__2():org.aswing.FlowLayout {
        /* declarations/demo/view/AdjusterView.xml:81 characters: 33-43 */
        var res = new org.aswing.FlowLayout();
        /* declarations/demo/view/AdjusterView.xml:81 characters: 45-49 */
        res.hgap = 0;
        return res;
    }

    inline function get_intDimension__4():org.aswing.geom.IntDimension {
        /* declarations/demo/view/AdjusterView.xml:85 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/AdjusterView.xml:85 characters: 56-61 */
        res.width = 250;
        /* declarations/demo/view/AdjusterView.xml:85 characters: 68-74 */
        res.height = -1;
        return res;
    }

    inline function get_jLabel__6():org.aswing.JLabel {
        /* declarations/demo/view/AdjusterView.xml:83 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AdjusterView.xml:83 characters: 62-81 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/AdjusterView.xml:83 characters: 37-41 */
        res.text = 'Nokia Lumia 930';
        /* declarations/demo/view/AdjusterView.xml:84 characters: 33-46 */
        res.preferredSize = get_intDimension__4();
        return res;
    }

    inline function get_intDimension__5():org.aswing.geom.IntDimension {
        /* declarations/demo/view/AdjusterView.xml:90 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/AdjusterView.xml:90 characters: 56-61 */
        res.width = 100;
        /* declarations/demo/view/AdjusterView.xml:90 characters: 68-74 */
        res.height = -1;
        return res;
    }

    inline function get_jLabel__7():org.aswing.JLabel {
        /* declarations/demo/view/AdjusterView.xml:88 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AdjusterView.xml:88 characters: 54-73 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/AdjusterView.xml:88 characters: 37-41 */
        res.text = '$342.49';
        /* declarations/demo/view/AdjusterView.xml:89 characters: 33-46 */
        res.preferredSize = get_intDimension__5();
        return res;
    }

    inline function get_jAdjuster__2():org.aswing.JAdjuster {
        /* declarations/demo/view/AdjusterView.xml:93 characters: 29-38 */
        var res = new org.aswing.JAdjuster();
        if (null != dataContext) { res.value = this.dataContext.lumiaQuantity; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.value = this.dataContext.lumiaQuantity;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.lumiaQuantity, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.lumiaQuantity, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.value = this.dataContext.lumiaQuantity;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.lumiaQuantity = res.value;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.value, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.lumiaQuantity = res.value;
                                }
                            });
        /* declarations/demo/view/AdjusterView.xml:93 characters: 84-91 */
        res.minimum = 0;
        /* declarations/demo/view/AdjusterView.xml:93 characters: 108-116 */
        res.stepSize = 1;
        /* declarations/demo/view/AdjusterView.xml:93 characters: 96-103 */
        res.maximum = 2;
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* declarations/demo/view/AdjusterView.xml:79 characters: 25-31 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/AdjusterView.xml:80 characters: 29-35 */
        res.layout = get_flowLayout__2();
        res.append(get_jLabel__6());
        res.append(get_jLabel__7());
        res.append(get_jAdjuster__2());
        return res;
    }

    inline function get_flowLayout__3():org.aswing.FlowLayout {
        /* declarations/demo/view/AdjusterView.xml:97 characters: 33-43 */
        var res = new org.aswing.FlowLayout();
        /* declarations/demo/view/AdjusterView.xml:97 characters: 45-49 */
        res.hgap = 0;
        return res;
    }

    inline function get_emptyBorder__4():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/AdjusterView.xml:100 characters: 33-51 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/AdjusterView.xml:100 characters: 53-56 */
        res.top = 20;
        return res;
    }

    inline function get_borderLayout__1():org.aswing.BorderLayout {
        /* declarations/demo/view/AdjusterView.xml:103 characters: 33-45 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_flowLayout__4():org.aswing.FlowLayout {
        /* declarations/demo/view/AdjusterView.xml:107 characters: 37-47 */
        var res = new org.aswing.FlowLayout();
        /* declarations/demo/view/AdjusterView.xml:107 characters: 49-53 */
        res.hgap = 0;
        return res;
    }

    inline function get_aSFont__2():org.aswing.ASFont {
        /* declarations/demo/view/AdjusterView.xml:111 characters: 41-47 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/AdjusterView.xml:111 characters: 79-83 */
        res.size = 16;
        /* declarations/demo/view/AdjusterView.xml:111 characters: 49-53 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__8():org.aswing.JLabel {
        /* declarations/demo/view/AdjusterView.xml:109 characters: 33-39 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/AdjusterView.xml:109 characters: 41-45 */
        res.text = 'Total:';
        /* declarations/demo/view/AdjusterView.xml:110 characters: 37-41 */
        res.font = get_aSFont__2();
        return res;
    }

    inline function get_aSFont__3():org.aswing.ASFont {
        /* declarations/demo/view/AdjusterView.xml:116 characters: 41-47 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/AdjusterView.xml:116 characters: 79-83 */
        res.size = 16;
        /* declarations/demo/view/AdjusterView.xml:116 characters: 49-53 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__9():org.aswing.JLabel {
        /* declarations/demo/view/AdjusterView.xml:114 characters: 33-39 */
        var res = new org.aswing.JLabel();
        if (null != dataContext) { res.text = this.dataContext.totalCost; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.totalCost;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.totalCost, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.totalCost, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.totalCost;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/AdjusterView.xml:115 characters: 37-41 */
        res.font = get_aSFont__3();
        return res;
    }

    inline function get_jPanel__3():org.aswing.JPanel {
        /* declarations/demo/view/AdjusterView.xml:105 characters: 29-35 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/AdjusterView.xml:105 characters: 37-48 */
        res.constraints = org.aswing.BorderLayout.WEST;
        /* declarations/demo/view/AdjusterView.xml:106 characters: 33-39 */
        res.layout = get_flowLayout__4();
        res.append(get_jLabel__8());
        res.append(get_jLabel__9());
        return res;
    }

    inline function get_flowLayout__5():org.aswing.FlowLayout {
        /* declarations/demo/view/AdjusterView.xml:122 characters: 37-47 */
        var res = new org.aswing.FlowLayout();
        /* declarations/demo/view/AdjusterView.xml:122 characters: 49-53 */
        res.hgap = 0;
        return res;
    }

    inline function get_jButton__0():org.aswing.JButton {
        /* declarations/demo/view/AdjusterView.xml:124 characters: 33-40 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/AdjusterView.xml:124 characters: 42-46 */
        res.text = 'Cancel';
        return res;
    }

    inline function get_intDimension__6():org.aswing.geom.IntDimension {
        /* declarations/demo/view/AdjusterView.xml:126 characters: 52-69 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/AdjusterView.xml:126 characters: 71-76 */
        res.width = 15;
        /* declarations/demo/view/AdjusterView.xml:126 characters: 82-88 */
        res.height = 15;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/demo/view/AdjusterView.xml:125 characters: 33-40 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/AdjusterView.xml:126 characters: 37-50 */
        res.preferredSize = get_intDimension__6();
        return res;
    }

    inline function get_aSColor__1():org.aswing.ASColor {
        /* declarations/demo/view/AdjusterView.xml:130 characters: 41-48 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/AdjusterView.xml:130 characters: 50-53 */
        res.rgb = 0x2ecc71;
        return res;
    }

    inline function get_jButton__1():org.aswing.JButton {
        /* declarations/demo/view/AdjusterView.xml:128 characters: 33-40 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/AdjusterView.xml:128 characters: 42-46 */
        res.text = 'Checkout';
        /* declarations/demo/view/AdjusterView.xml:129 characters: 37-47 */
        res.background = get_aSColor__1();
        return res;
    }

    inline function get_jPanel__4():org.aswing.JPanel {
        /* declarations/demo/view/AdjusterView.xml:120 characters: 29-35 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/AdjusterView.xml:120 characters: 37-48 */
        res.constraints = org.aswing.BorderLayout.EAST;
        /* declarations/demo/view/AdjusterView.xml:121 characters: 33-39 */
        res.layout = get_flowLayout__5();
        res.append(get_jButton__0());
        res.append(get_jSpacer__0());
        res.append(get_jButton__1());
        return res;
    }

    inline function get_jPanel__5():org.aswing.JPanel {
        /* declarations/demo/view/AdjusterView.xml:95 characters: 25-31 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/AdjusterView.xml:96 characters: 29-35 */
        res.layout = get_flowLayout__3();
        /* declarations/demo/view/AdjusterView.xml:99 characters: 29-35 */
        res.border = get_emptyBorder__4();
        /* declarations/demo/view/AdjusterView.xml:102 characters: 29-35 */
        res.layout = get_borderLayout__1();
        res.append(get_jPanel__3());
        res.append(get_jPanel__4());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/AdjusterView.xml:28 characters: 21-28 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/AdjusterView.xml:28 characters: 30-33 */
        res.gap = 7;
        /* declarations/demo/view/AdjusterView.xml:29 characters: 25-31 */
        res.border = get_lineBorder__0();
        res.append(get_jLabel__1());
        res.append(get_jPanel__0());
        res.append(get_jPanel__1());
        res.append(get_jPanel__2());
        res.append(get_jPanel__5());
        return res;
    }

    inline function get_jPanel__6():org.aswing.JPanel {
        /* declarations/demo/view/AdjusterView.xml:26 characters: 17-23 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/AdjusterView.xml:27 characters: 21-27 */
        res.border = get_emptyBorder__1();
        res.append(get_softBox__0());
        return res;
    }

    inline function get_tabInfo__0():org.aswing.TabInfo {
        /* declarations/demo/view/AdjusterView.xml:24 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AdjusterView.xml:24 characters: 18-23 */
        res.title = 'Demo';
        /* declarations/demo/view/AdjusterView.xml:25 characters: 13-20 */
        res.content = get_jPanel__6();
        return res;
    }

    inline function get_hmlRegExRules__0():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/AdjusterView.xml:146 characters: 29-53 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__0():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/AdjusterView.xml:144 characters: 21-54 */
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
                        
        /* declarations/demo/view/AdjusterView.xml:144 characters: 83-102 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/AdjusterView.xml:145 characters: 25-41 */
        res.rules = get_hmlRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/demo/view/AdjusterView.xml:143 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__0());
        return res;
    }

    inline function get_tabInfo__1():org.aswing.TabInfo {
        /* declarations/demo/view/AdjusterView.xml:141 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AdjusterView.xml:141 characters: 18-23 */
        res.title = 'View (XML source)';
        /* declarations/demo/view/AdjusterView.xml:142 characters: 13-20 */
        res.content = get_jScrollPane__0();
        return res;
    }

    inline function get_haxeRegExRules__0():jive.formatting.HaxeRegExRules {
        /* declarations/demo/view/AdjusterView.xml:157 characters: 29-54 */
        var res = new jive.formatting.HaxeRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__1():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/AdjusterView.xml:155 characters: 21-54 */
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
                        
        /* declarations/demo/view/AdjusterView.xml:155 characters: 84-103 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/AdjusterView.xml:156 characters: 25-41 */
        res.rules = get_haxeRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__1():org.aswing.JScrollPane {
        /* declarations/demo/view/AdjusterView.xml:154 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__1());
        return res;
    }

    inline function get_tabInfo__2():org.aswing.TabInfo {
        /* declarations/demo/view/AdjusterView.xml:152 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/AdjusterView.xml:152 characters: 18-23 */
        res.title = 'View Model (Haxe source)';
        /* declarations/demo/view/AdjusterView.xml:153 characters: 13-20 */
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
