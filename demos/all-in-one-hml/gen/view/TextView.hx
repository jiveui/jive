package view;

class TextView extends org.aswing.SoftBox implements jive.DataContextControllable<viewmodel.TextViewModel> {

    public function destroyHml():Void {
        
    }
    

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/view/TextView.xml:11 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/view/TextView.xml:11 characters: 51-55 */
        res.size = 30;
        /* declarations/view/TextView.xml:11 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/view/TextView.xml:9 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/view/TextView.xml:9 characters: 27-46 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/TextView.xml:9 characters: 13-17 */
        res.text = 'Text';
        /* declarations/view/TextView.xml:10 characters: 9-13 */
        res.font = get_aSFont__0();
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/view/TextView.xml:19 characters: 25-43 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/view/TextView.xml:19 characters: 45-48 */
        res.top = 30;
        /* declarations/view/TextView.xml:19 characters: 76-81 */
        res.right = 30;
        /* declarations/view/TextView.xml:19 characters: 64-70 */
        res.bottom = 30;
        /* declarations/view/TextView.xml:19 characters: 54-58 */
        res.left = 30;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/view/TextView.xml:22 characters: 25-32 */
        var res = new org.aswing.ASColor();
        /* declarations/view/TextView.xml:22 characters: 34-37 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/view/TextView.xml:17 characters: 17-34 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/view/TextView.xml:17 characters: 50-55 */
        res.round = 5;
        /* declarations/view/TextView.xml:17 characters: 36-45 */
        res.thickness = 1;
        /* declarations/view/TextView.xml:18 characters: 21-36 */
        res.interior = get_emptyBorder__0();
        /* declarations/view/TextView.xml:21 characters: 21-33 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/view/TextView.xml:30 characters: 25-42 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/TextView.xml:30 characters: 44-49 */
        res.width = 100;
        /* declarations/view/TextView.xml:30 characters: 56-62 */
        res.height = -1;
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/view/TextView.xml:28 characters: 17-23 */
        var res = new org.aswing.JLabel();
        /* declarations/view/TextView.xml:28 characters: 43-62 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/TextView.xml:28 characters: 25-29 */
        res.text = 'Predator';
        /* declarations/view/TextView.xml:29 characters: 21-34 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_jTextField__0():org.aswing.JTextField {
        /* declarations/view/TextView.xml:33 characters: 17-27 */
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
        /* declarations/view/TextView.xml:33 characters: 29-36 */
        res.columns = 15;
        /* declarations/view/TextView.xml:33 characters: 42-52 */
        res.inlineHint = 'Lion';
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/view/TextView.xml:27 characters: 13-19 */
        var res = new org.aswing.JPanel();
        res.append(get_jLabel__1());
        res.append(get_jTextField__0());
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/view/TextView.xml:39 characters: 25-42 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/TextView.xml:39 characters: 44-49 */
        res.width = 100;
        /* declarations/view/TextView.xml:39 characters: 56-62 */
        res.height = -1;
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/view/TextView.xml:37 characters: 17-23 */
        var res = new org.aswing.JLabel();
        /* declarations/view/TextView.xml:37 characters: 39-58 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/TextView.xml:37 characters: 25-29 */
        res.text = 'Prey';
        /* declarations/view/TextView.xml:38 characters: 21-34 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_jTextField__1():org.aswing.JTextField {
        /* declarations/view/TextView.xml:42 characters: 17-27 */
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
        /* declarations/view/TextView.xml:42 characters: 29-36 */
        res.columns = 15;
        /* declarations/view/TextView.xml:42 characters: 42-52 */
        res.inlineHint = 'Antelope';
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/view/TextView.xml:36 characters: 13-19 */
        var res = new org.aswing.JPanel();
        res.append(get_jLabel__2());
        res.append(get_jTextField__1());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/view/TextView.xml:15 characters: 9-16 */
        var res = new org.aswing.SoftBox();
        /* declarations/view/TextView.xml:16 characters: 13-19 */
        res.border = get_lineBorder__0();
        res.append(get_jPanel__0());
        res.append(get_jPanel__1());
        return res;
    }

    inline function get_aSFont__1():org.aswing.ASFont {
        /* declarations/view/TextView.xml:48 characters: 17-23 */
        var res = new org.aswing.ASFont();
        /* declarations/view/TextView.xml:48 characters: 55-59 */
        res.size = 20;
        /* declarations/view/TextView.xml:48 characters: 25-29 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_multilineLabel__0():org.aswing.ext.MultilineLabel {
        /* declarations/view/TextView.xml:46 characters: 9-27 */
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
                        
        /* declarations/view/TextView.xml:46 characters: 90-97 */
        res.columns = 20;
        /* declarations/view/TextView.xml:46 characters: 81-85 */
        res.rows = 5;
        /* declarations/view/TextView.xml:47 characters: 13-21 */
        res.font = get_aSFont__1();
        return res;
    }

    inline function get_softBox__1():org.aswing.SoftBox {
        /* declarations/view/TextView.xml:14 characters: 5-12 */
        var res = new org.aswing.SoftBox();
        /* declarations/view/TextView.xml:14 characters: 14-18 */
        res.axis = org.aswing.SoftBoxLayout.X_AXIS;
        /* declarations/view/TextView.xml:14 characters: 53-56 */
        res.gap = 30;
        res.append(get_softBox__0());
        res.append(get_multilineLabel__0());
        return res;
    }

    public function new() {
        /* declarations/view/TextView.xml:2 characters: 1-8 */
        super();
        /* declarations/view/TextView.xml:2 characters: 10-13 */
        this.gap = 10;
        this.append(get_jLabel__0());
        this.append(get_softBox__1());
    }
}
