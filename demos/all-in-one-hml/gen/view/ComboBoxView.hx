package view;

class ComboBoxView extends org.aswing.SoftBox implements jive.DataContextControllable<viewmodel.ComboBoxViewModel> {

    public function destroyHml():Void {
        
    }
    

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/view/ComboBoxView.xml:13 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/view/ComboBoxView.xml:13 characters: 51-55 */
        res.size = 30;
        /* declarations/view/ComboBoxView.xml:13 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/view/ComboBoxView.xml:11 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/view/ComboBoxView.xml:11 characters: 32-51 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/ComboBoxView.xml:11 characters: 13-17 */
        res.text = 'Combo Box';
        /* declarations/view/ComboBoxView.xml:12 characters: 9-13 */
        res.font = get_aSFont__0();
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/view/ComboBoxView.xml:21 characters: 21-39 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/view/ComboBoxView.xml:21 characters: 41-44 */
        res.top = 30;
        /* declarations/view/ComboBoxView.xml:21 characters: 72-77 */
        res.right = 30;
        /* declarations/view/ComboBoxView.xml:21 characters: 60-66 */
        res.bottom = 30;
        /* declarations/view/ComboBoxView.xml:21 characters: 50-54 */
        res.left = 30;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/view/ComboBoxView.xml:24 characters: 21-28 */
        var res = new org.aswing.ASColor();
        /* declarations/view/ComboBoxView.xml:24 characters: 30-33 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/view/ComboBoxView.xml:19 characters: 13-30 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/view/ComboBoxView.xml:19 characters: 46-51 */
        res.round = 5;
        /* declarations/view/ComboBoxView.xml:19 characters: 32-41 */
        res.thickness = 1;
        /* declarations/view/ComboBoxView.xml:20 characters: 17-32 */
        res.interior = get_emptyBorder__0();
        /* declarations/view/ComboBoxView.xml:23 characters: 17-29 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/view/ComboBoxView.xml:29 characters: 9-15 */
        var res = new org.aswing.JLabel();
        /* declarations/view/ComboBoxView.xml:29 characters: 50-69 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/ComboBoxView.xml:29 characters: 17-21 */
        res.text = 'Login into your account';
        return res;
    }

    inline function get_jTextField__0():org.aswing.JTextField {
        /* declarations/view/ComboBoxView.xml:31 characters: 9-19 */
        var res = new org.aswing.JTextField();
        if (null != dataContext) { res.text = this.dataContext.email; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.email;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.email, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.email, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.email;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.email = res.text;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.text, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.email = res.text;
                                }
                            });
        /* declarations/view/ComboBoxView.xml:31 characters: 21-28 */
        res.columns = 13;
        /* declarations/view/ComboBoxView.xml:31 characters: 34-44 */
        res.inlineHint = 'E-mail';
        return res;
    }

    inline function get_jTextField__1():org.aswing.JTextField {
        /* declarations/view/ComboBoxView.xml:32 characters: 9-19 */
        var res = new org.aswing.JTextField();
        if (null != dataContext) { res.text = this.dataContext.password; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.password;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.password, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.password, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.password;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.password = res.text;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.text, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.password = res.text;
                                }
                            });
        /* declarations/view/ComboBoxView.xml:32 characters: 21-28 */
        res.columns = 14;
        /* declarations/view/ComboBoxView.xml:32 characters: 96-113 */
        res.displayAsPassword = true;
        /* declarations/view/ComboBoxView.xml:32 characters: 34-44 */
        res.inlineHint = 'Password';
        return res;
    }

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/view/ComboBoxView.xml:35 characters: 17-29 */
        var res = new org.aswing.BorderLayout();
        /* declarations/view/ComboBoxView.xml:35 characters: 31-35 */
        res.hgap = 30;
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/view/ComboBoxView.xml:39 characters: 21-38 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/ComboBoxView.xml:39 characters: 40-45 */
        res.width = 150;
        /* declarations/view/ComboBoxView.xml:39 characters: 52-58 */
        res.height = -1;
        return res;
    }

    inline function get_string__0():String {
        /* declarations/view/ComboBoxView.xml:43 characters: 25-33 */
        var res = 'Administrator';
        return res;
    }

    inline function get_string__1():String {
        /* declarations/view/ComboBoxView.xml:44 characters: 25-33 */
        var res = 'Moderator';
        return res;
    }

    inline function get_string__2():String {
        /* declarations/view/ComboBoxView.xml:45 characters: 25-33 */
        var res = 'User';
        return res;
    }

    inline function get_vectorListModel__0():org.aswing.VectorListModel {
        /* declarations/view/ComboBoxView.xml:42 characters: 21-36 */
        var res = new org.aswing.VectorListModel();
        res.append(get_string__0());
        res.append(get_string__1());
        res.append(get_string__2());
        return res;
    }

    inline function get_jComboBox__0():org.aswing.JComboBox {
        /* declarations/view/ComboBoxView.xml:37 characters: 13-22 */
        var res = new org.aswing.JComboBox();
        if (null != dataContext) { res.selectedIndex = this.dataContext.role; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.selectedIndex = this.dataContext.role;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.role, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.role, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.selectedIndex = this.dataContext.role;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.role = res.selectedIndex;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.selectedIndex, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.role = res.selectedIndex;
                                }
                            });
        /* declarations/view/ComboBoxView.xml:37 characters: 24-35 */
        res.constraints = org.aswing.BorderLayout.WEST;
        /* declarations/view/ComboBoxView.xml:38 characters: 17-30 */
        res.preferredSize = get_intDimension__0();
        /* declarations/view/ComboBoxView.xml:41 characters: 17-22 */
        res.model = get_vectorListModel__0();
        return res;
    }

    inline function get_jCheckBox__0():org.aswing.JCheckBox {
        /* declarations/view/ComboBoxView.xml:49 characters: 13-22 */
        var res = new org.aswing.JCheckBox();
        /* declarations/view/ComboBoxView.xml:49 characters: 24-28 */
        res.text = 'Remember me';
        /* declarations/view/ComboBoxView.xml:49 characters: 45-56 */
        res.constraints = org.aswing.BorderLayout.EAST;
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/view/ComboBoxView.xml:33 characters: 9-15 */
        var res = new org.aswing.JPanel();
        /* declarations/view/ComboBoxView.xml:34 characters: 13-19 */
        res.layout = get_borderLayout__0();
        res.append(get_jComboBox__0());
        res.append(get_jCheckBox__0());
        return res;
    }

    inline function get_flowLayout__0():org.aswing.FlowLayout {
        /* declarations/view/ComboBoxView.xml:53 characters: 17-27 */
        var res = new org.aswing.FlowLayout();
        /* declarations/view/ComboBoxView.xml:53 characters: 29-34 */
        res.align = org.aswing.FlowLayout.RIGHT;
        return res;
    }

    inline function get_jButton__0():org.aswing.JButton {
        /* declarations/view/ComboBoxView.xml:55 characters: 13-20 */
        var res = new org.aswing.JButton();
        /* declarations/view/ComboBoxView.xml:55 characters: 22-26 */
        res.text = 'Sign up';
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/view/ComboBoxView.xml:56 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/ComboBoxView.xml:56 characters: 56-61 */
        res.width = 10;
        /* declarations/view/ComboBoxView.xml:56 characters: 67-73 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/view/ComboBoxView.xml:56 characters: 13-20 */
        var res = new org.aswing.JSpacer();
        /* declarations/view/ComboBoxView.xml:56 characters: 22-35 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_aSColor__1():org.aswing.ASColor {
        /* declarations/view/ComboBoxView.xml:59 characters: 21-28 */
        var res = new org.aswing.ASColor();
        /* declarations/view/ComboBoxView.xml:59 characters: 30-33 */
        res.rgb = 0x1abc9c;
        return res;
    }

    inline function get_jButton__1():org.aswing.JButton {
        /* declarations/view/ComboBoxView.xml:57 characters: 13-20 */
        var res = new org.aswing.JButton();
        /* declarations/view/ComboBoxView.xml:57 characters: 22-26 */
        res.text = 'Sign in';
        /* declarations/view/ComboBoxView.xml:58 characters: 17-27 */
        res.background = get_aSColor__1();
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/view/ComboBoxView.xml:51 characters: 9-15 */
        var res = new org.aswing.JPanel();
        /* declarations/view/ComboBoxView.xml:52 characters: 13-19 */
        res.layout = get_flowLayout__0();
        res.append(get_jButton__0());
        res.append(get_jSpacer__0());
        res.append(get_jButton__1());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/view/ComboBoxView.xml:17 characters: 5-12 */
        var res = new org.aswing.SoftBox();
        /* declarations/view/ComboBoxView.xml:17 characters: 14-17 */
        res.gap = 20;
        /* declarations/view/ComboBoxView.xml:18 characters: 9-15 */
        res.border = get_lineBorder__0();
        res.append(get_jLabel__1());
        res.append(get_jTextField__0());
        res.append(get_jTextField__1());
        res.append(get_jPanel__0());
        res.append(get_jPanel__1());
        return res;
    }

    public function new() {
        /* declarations/view/ComboBoxView.xml:2 characters: 1-8 */
        super();
        /* declarations/view/ComboBoxView.xml:2 characters: 10-13 */
        this.gap = 10;
        this.append(get_jLabel__0());
        this.append(get_softBox__0());
    }
}
