package demo.view;

class ComboBoxView extends org.aswing.JPanel implements jive.DataContextControllable<demo.viewmodel.ComboBoxViewModel> {

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/demo/view/ComboBoxView.xml:11 characters: 9-21 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/demo/view/ComboBoxView.xml:15 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/ComboBoxView.xml:15 characters: 51-55 */
        res.size = 30;
        /* declarations/demo/view/ComboBoxView.xml:15 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/ComboBoxView.xml:18 characters: 13-31 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/ComboBoxView.xml:18 characters: 33-39 */
        res.bottom = 15;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/demo/view/ComboBoxView.xml:13 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ComboBoxView.xml:13 characters: 32-51 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ComboBoxView.xml:13 characters: 13-17 */
        res.text = 'Combo Box';
        /* declarations/demo/view/ComboBoxView.xml:13 characters: 86-97 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/demo/view/ComboBoxView.xml:14 characters: 9-13 */
        res.font = get_aSFont__0();
        /* declarations/demo/view/ComboBoxView.xml:17 characters: 9-15 */
        res.border = get_emptyBorder__0();
        return res;
    }

    inline function get_centerLayout__0():org.aswing.CenterLayout {
        /* declarations/demo/view/ComboBoxView.xml:27 characters: 25-37 */
        var res = new org.aswing.CenterLayout();
        return res;
    }

    inline function get_emptyBorder__1():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/ComboBoxView.xml:33 characters: 37-55 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/ComboBoxView.xml:33 characters: 57-60 */
        res.top = 30;
        /* declarations/demo/view/ComboBoxView.xml:33 characters: 88-93 */
        res.right = 30;
        /* declarations/demo/view/ComboBoxView.xml:33 characters: 76-82 */
        res.bottom = 30;
        /* declarations/demo/view/ComboBoxView.xml:33 characters: 66-70 */
        res.left = 30;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/demo/view/ComboBoxView.xml:36 characters: 37-44 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/ComboBoxView.xml:36 characters: 46-49 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/demo/view/ComboBoxView.xml:31 characters: 29-46 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/demo/view/ComboBoxView.xml:31 characters: 62-67 */
        res.round = 5;
        /* declarations/demo/view/ComboBoxView.xml:31 characters: 48-57 */
        res.thickness = 1;
        /* declarations/demo/view/ComboBoxView.xml:32 characters: 33-48 */
        res.interior = get_emptyBorder__1();
        /* declarations/demo/view/ComboBoxView.xml:35 characters: 33-45 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/demo/view/ComboBoxView.xml:41 characters: 25-31 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ComboBoxView.xml:41 characters: 66-85 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ComboBoxView.xml:41 characters: 33-37 */
        res.text = 'Login into your account';
        return res;
    }

    inline function get_jTextField__0():org.aswing.JTextField {
        /* declarations/demo/view/ComboBoxView.xml:43 characters: 25-35 */
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
        /* declarations/demo/view/ComboBoxView.xml:43 characters: 37-44 */
        res.columns = 13;
        /* declarations/demo/view/ComboBoxView.xml:43 characters: 50-60 */
        res.inlineHint = 'E-mail';
        return res;
    }

    inline function get_jTextField__1():org.aswing.JTextField {
        /* declarations/demo/view/ComboBoxView.xml:44 characters: 25-35 */
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
        /* declarations/demo/view/ComboBoxView.xml:44 characters: 37-44 */
        res.columns = 14;
        /* declarations/demo/view/ComboBoxView.xml:44 characters: 112-129 */
        res.displayAsPassword = true;
        /* declarations/demo/view/ComboBoxView.xml:44 characters: 50-60 */
        res.inlineHint = 'Password';
        return res;
    }

    inline function get_borderLayout__1():org.aswing.BorderLayout {
        /* declarations/demo/view/ComboBoxView.xml:47 characters: 33-45 */
        var res = new org.aswing.BorderLayout();
        /* declarations/demo/view/ComboBoxView.xml:47 characters: 47-51 */
        res.hgap = 30;
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ComboBoxView.xml:51 characters: 37-54 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ComboBoxView.xml:51 characters: 56-61 */
        res.width = 150;
        /* declarations/demo/view/ComboBoxView.xml:51 characters: 68-74 */
        res.height = -1;
        return res;
    }

    inline function get_string__0():String {
        /* declarations/demo/view/ComboBoxView.xml:55 characters: 41-49 */
        var res = 'Administrator';
        return res;
    }

    inline function get_string__1():String {
        /* declarations/demo/view/ComboBoxView.xml:56 characters: 41-49 */
        var res = 'Moderator';
        return res;
    }

    inline function get_string__2():String {
        /* declarations/demo/view/ComboBoxView.xml:57 characters: 41-49 */
        var res = 'User';
        return res;
    }

    inline function get_vectorListModel__0():org.aswing.VectorListModel {
        /* declarations/demo/view/ComboBoxView.xml:54 characters: 37-52 */
        var res = new org.aswing.VectorListModel();
        res.append(get_string__0());
        res.append(get_string__1());
        res.append(get_string__2());
        return res;
    }

    inline function get_jComboBox__0():org.aswing.JComboBox {
        /* declarations/demo/view/ComboBoxView.xml:49 characters: 29-38 */
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
        /* declarations/demo/view/ComboBoxView.xml:49 characters: 40-51 */
        res.constraints = org.aswing.BorderLayout.WEST;
        /* declarations/demo/view/ComboBoxView.xml:50 characters: 33-46 */
        res.preferredSize = get_intDimension__0();
        /* declarations/demo/view/ComboBoxView.xml:53 characters: 33-38 */
        res.model = get_vectorListModel__0();
        return res;
    }

    inline function get_jCheckBox__0():org.aswing.JCheckBox {
        /* declarations/demo/view/ComboBoxView.xml:61 characters: 29-38 */
        var res = new org.aswing.JCheckBox();
        /* declarations/demo/view/ComboBoxView.xml:61 characters: 40-44 */
        res.text = 'Remember me';
        /* declarations/demo/view/ComboBoxView.xml:61 characters: 61-72 */
        res.constraints = org.aswing.BorderLayout.EAST;
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/demo/view/ComboBoxView.xml:45 characters: 25-31 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/ComboBoxView.xml:46 characters: 29-35 */
        res.layout = get_borderLayout__1();
        res.append(get_jComboBox__0());
        res.append(get_jCheckBox__0());
        return res;
    }

    inline function get_flowLayout__0():org.aswing.FlowLayout {
        /* declarations/demo/view/ComboBoxView.xml:65 characters: 33-43 */
        var res = new org.aswing.FlowLayout();
        /* declarations/demo/view/ComboBoxView.xml:65 characters: 45-50 */
        res.align = org.aswing.FlowLayout.RIGHT;
        return res;
    }

    inline function get_jButton__0():org.aswing.JButton {
        /* declarations/demo/view/ComboBoxView.xml:67 characters: 29-36 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/ComboBoxView.xml:67 characters: 38-42 */
        res.text = 'Sign up';
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ComboBoxView.xml:68 characters: 53-70 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ComboBoxView.xml:68 characters: 72-77 */
        res.width = 10;
        /* declarations/demo/view/ComboBoxView.xml:68 characters: 83-89 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/demo/view/ComboBoxView.xml:68 characters: 29-36 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/ComboBoxView.xml:68 characters: 38-51 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_aSColor__1():org.aswing.ASColor {
        /* declarations/demo/view/ComboBoxView.xml:71 characters: 37-44 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/ComboBoxView.xml:71 characters: 46-49 */
        res.rgb = 0x1abc9c;
        return res;
    }

    inline function get_jButton__1():org.aswing.JButton {
        /* declarations/demo/view/ComboBoxView.xml:69 characters: 29-36 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/ComboBoxView.xml:69 characters: 38-42 */
        res.text = 'Sign in';
        /* declarations/demo/view/ComboBoxView.xml:70 characters: 33-43 */
        res.background = get_aSColor__1();
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/demo/view/ComboBoxView.xml:63 characters: 25-31 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/ComboBoxView.xml:64 characters: 29-35 */
        res.layout = get_flowLayout__0();
        res.append(get_jButton__0());
        res.append(get_jSpacer__0());
        res.append(get_jButton__1());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/ComboBoxView.xml:29 characters: 21-28 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/ComboBoxView.xml:29 characters: 30-33 */
        res.gap = 20;
        /* declarations/demo/view/ComboBoxView.xml:30 characters: 25-31 */
        res.border = get_lineBorder__0();
        res.append(get_jLabel__1());
        res.append(get_jTextField__0());
        res.append(get_jTextField__1());
        res.append(get_jPanel__0());
        res.append(get_jPanel__1());
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* declarations/demo/view/ComboBoxView.xml:25 characters: 17-23 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/ComboBoxView.xml:26 characters: 21-27 */
        res.layout = get_centerLayout__0();
        res.append(get_softBox__0());
        return res;
    }

    inline function get_tabInfo__0():org.aswing.TabInfo {
        /* declarations/demo/view/ComboBoxView.xml:23 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ComboBoxView.xml:23 characters: 18-23 */
        res.title = 'Demo';
        /* declarations/demo/view/ComboBoxView.xml:24 characters: 13-20 */
        res.content = get_jPanel__2();
        return res;
    }

    inline function get_hmlRegExRules__0():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/ComboBoxView.xml:85 characters: 29-53 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__0():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/ComboBoxView.xml:83 characters: 21-54 */
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
                        
        /* declarations/demo/view/ComboBoxView.xml:83 characters: 83-102 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/ComboBoxView.xml:84 characters: 25-41 */
        res.rules = get_hmlRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/demo/view/ComboBoxView.xml:82 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__0());
        return res;
    }

    inline function get_tabInfo__1():org.aswing.TabInfo {
        /* declarations/demo/view/ComboBoxView.xml:80 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ComboBoxView.xml:80 characters: 18-23 */
        res.title = 'View (XML source)';
        /* declarations/demo/view/ComboBoxView.xml:81 characters: 13-20 */
        res.content = get_jScrollPane__0();
        return res;
    }

    inline function get_haxeRegExRules__0():jive.formatting.HaxeRegExRules {
        /* declarations/demo/view/ComboBoxView.xml:96 characters: 29-54 */
        var res = new jive.formatting.HaxeRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__1():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/ComboBoxView.xml:94 characters: 21-54 */
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
                        
        /* declarations/demo/view/ComboBoxView.xml:94 characters: 84-103 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/ComboBoxView.xml:95 characters: 25-41 */
        res.rules = get_haxeRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__1():org.aswing.JScrollPane {
        /* declarations/demo/view/ComboBoxView.xml:93 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__1());
        return res;
    }

    inline function get_tabInfo__2():org.aswing.TabInfo {
        /* declarations/demo/view/ComboBoxView.xml:91 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ComboBoxView.xml:91 characters: 18-23 */
        res.title = 'View Model (Haxe source)';
        /* declarations/demo/view/ComboBoxView.xml:92 characters: 13-20 */
        res.content = get_jScrollPane__1();
        return res;
    }

    inline function get_jTabbedPane__0():org.aswing.JTabbedPane {
        /* declarations/demo/view/ComboBoxView.xml:21 characters: 5-16 */
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
        /* declarations/demo/view/ComboBoxView.xml:21 characters: 18-29 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        res.appendTabInfo(get_tabInfo__0());
        res.appendTabInfo(get_tabInfo__1());
        res.appendTabInfo(get_tabInfo__2());
        return res;
    }

    public function new() {
        /* declarations/demo/view/ComboBoxView.xml:2 characters: 1-7 */
        super();
        /* declarations/demo/view/ComboBoxView.xml:10 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_jLabel__0());
        this.append(get_jTabbedPane__0());
    }
}
