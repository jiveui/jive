package demo.view;

class FrameView extends org.aswing.JPanel implements jive.DataContextControllable<demo.viewmodel.FrameViewModel> {

    var loginDialog_initialized:Bool = false;

    @:isVar public var loginDialog(get, set):jive.Dialog;

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/demo/view/FrameView.xml:12 characters: 9-21 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/demo/view/FrameView.xml:16 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/FrameView.xml:16 characters: 51-55 */
        res.size = 30;
        /* declarations/demo/view/FrameView.xml:16 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/FrameView.xml:19 characters: 13-31 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/FrameView.xml:19 characters: 33-39 */
        res.bottom = 30;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/demo/view/FrameView.xml:14 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/FrameView.xml:14 characters: 29-48 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/FrameView.xml:14 characters: 13-17 */
        res.text = 'Dialog';
        /* declarations/demo/view/FrameView.xml:14 characters: 83-94 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/demo/view/FrameView.xml:15 characters: 9-13 */
        res.font = get_aSFont__0();
        /* declarations/demo/view/FrameView.xml:18 characters: 9-15 */
        res.border = get_emptyBorder__0();
        return res;
    }

    inline function get_jButton__0():org.aswing.JButton {
        /* declarations/demo/view/FrameView.xml:27 characters: 21-28 */
        var res = new org.aswing.JButton();
        if (null != dataContext) { res.command = this.dataContext.openLoginDialogCommand; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.command = this.dataContext.openLoginDialogCommand;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.openLoginDialogCommand, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.openLoginDialogCommand, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.command = this.dataContext.openLoginDialogCommand;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/FrameView.xml:27 characters: 30-34 */
        res.text = 'Open login dialog...';
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/demo/view/FrameView.xml:26 characters: 17-23 */
        var res = new org.aswing.JPanel();
        res.append(get_jButton__0());
        return res;
    }

    inline function get_tabInfo__0():org.aswing.TabInfo {
        /* declarations/demo/view/FrameView.xml:24 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/FrameView.xml:24 characters: 18-23 */
        res.title = 'Demo';
        /* declarations/demo/view/FrameView.xml:25 characters: 13-20 */
        res.content = get_jPanel__0();
        return res;
    }

    inline function get_hmlRegExRules__0():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/FrameView.xml:37 characters: 29-53 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__0():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/FrameView.xml:35 characters: 21-54 */
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
                        
        /* declarations/demo/view/FrameView.xml:35 characters: 83-102 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/FrameView.xml:36 characters: 25-41 */
        res.rules = get_hmlRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/demo/view/FrameView.xml:34 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__0());
        return res;
    }

    inline function get_tabInfo__1():org.aswing.TabInfo {
        /* declarations/demo/view/FrameView.xml:32 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/FrameView.xml:32 characters: 18-23 */
        res.title = 'View (XML source)';
        /* declarations/demo/view/FrameView.xml:33 characters: 13-20 */
        res.content = get_jScrollPane__0();
        return res;
    }

    inline function get_haxeRegExRules__0():jive.formatting.HaxeRegExRules {
        /* declarations/demo/view/FrameView.xml:48 characters: 29-54 */
        var res = new jive.formatting.HaxeRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__1():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/FrameView.xml:46 characters: 21-54 */
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
                        
        /* declarations/demo/view/FrameView.xml:46 characters: 84-103 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/FrameView.xml:47 characters: 25-41 */
        res.rules = get_haxeRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__1():org.aswing.JScrollPane {
        /* declarations/demo/view/FrameView.xml:45 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__1());
        return res;
    }

    inline function get_tabInfo__2():org.aswing.TabInfo {
        /* declarations/demo/view/FrameView.xml:43 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/FrameView.xml:43 characters: 18-23 */
        res.title = 'View Model (Haxe source)';
        /* declarations/demo/view/FrameView.xml:44 characters: 13-20 */
        res.content = get_jScrollPane__1();
        return res;
    }

    inline function get_jTabbedPane__0():org.aswing.JTabbedPane {
        /* declarations/demo/view/FrameView.xml:22 characters: 5-16 */
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
        /* declarations/demo/view/FrameView.xml:22 characters: 18-29 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        res.appendTabInfo(get_tabInfo__0());
        res.appendTabInfo(get_tabInfo__1());
        res.appendTabInfo(get_tabInfo__2());
        return res;
    }

    function set_loginDialog(value:jive.Dialog):jive.Dialog {
        loginDialog_initialized = true;
        return loginDialog = value;
    }

    inline function get_jTextField__0():org.aswing.JTextField {
        /* declarations/demo/view/FrameView.xml:62 characters: 17-27 */
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
        /* declarations/demo/view/FrameView.xml:62 characters: 29-36 */
        res.columns = 13;
        /* declarations/demo/view/FrameView.xml:62 characters: 42-52 */
        res.inlineHint = 'E-mail';
        return res;
    }

    inline function get_jTextField__1():org.aswing.JTextField {
        /* declarations/demo/view/FrameView.xml:63 characters: 17-27 */
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
        /* declarations/demo/view/FrameView.xml:63 characters: 29-36 */
        res.columns = 14;
        /* declarations/demo/view/FrameView.xml:63 characters: 104-121 */
        res.displayAsPassword = true;
        /* declarations/demo/view/FrameView.xml:63 characters: 42-52 */
        res.inlineHint = 'Password';
        return res;
    }

    inline function get_borderLayout__1():org.aswing.BorderLayout {
        /* declarations/demo/view/FrameView.xml:66 characters: 25-37 */
        var res = new org.aswing.BorderLayout();
        /* declarations/demo/view/FrameView.xml:66 characters: 39-43 */
        res.hgap = 30;
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/demo/view/FrameView.xml:70 characters: 29-46 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/FrameView.xml:70 characters: 48-53 */
        res.width = 150;
        /* declarations/demo/view/FrameView.xml:70 characters: 60-66 */
        res.height = -1;
        return res;
    }

    inline function get_string__0():String {
        /* declarations/demo/view/FrameView.xml:74 characters: 33-41 */
        var res = 'Administrator';
        return res;
    }

    inline function get_string__1():String {
        /* declarations/demo/view/FrameView.xml:75 characters: 33-41 */
        var res = 'Moderator';
        return res;
    }

    inline function get_string__2():String {
        /* declarations/demo/view/FrameView.xml:76 characters: 33-41 */
        var res = 'User';
        return res;
    }

    inline function get_vectorListModel__0():org.aswing.VectorListModel {
        /* declarations/demo/view/FrameView.xml:73 characters: 29-44 */
        var res = new org.aswing.VectorListModel();
        res.append(get_string__0());
        res.append(get_string__1());
        res.append(get_string__2());
        return res;
    }

    inline function get_jComboBox__0():org.aswing.JComboBox {
        /* declarations/demo/view/FrameView.xml:68 characters: 21-30 */
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
        /* declarations/demo/view/FrameView.xml:68 characters: 32-43 */
        res.constraints = org.aswing.BorderLayout.WEST;
        /* declarations/demo/view/FrameView.xml:69 characters: 25-38 */
        res.preferredSize = get_intDimension__0();
        /* declarations/demo/view/FrameView.xml:72 characters: 25-30 */
        res.model = get_vectorListModel__0();
        return res;
    }

    inline function get_jCheckBox__0():org.aswing.JCheckBox {
        /* declarations/demo/view/FrameView.xml:80 characters: 21-30 */
        var res = new org.aswing.JCheckBox();
        /* declarations/demo/view/FrameView.xml:80 characters: 32-36 */
        res.text = 'Remember me';
        /* declarations/demo/view/FrameView.xml:80 characters: 53-64 */
        res.constraints = org.aswing.BorderLayout.EAST;
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/demo/view/FrameView.xml:64 characters: 17-23 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/FrameView.xml:65 characters: 21-27 */
        res.layout = get_borderLayout__1();
        res.append(get_jComboBox__0());
        res.append(get_jCheckBox__0());
        return res;
    }

    inline function get_flowLayout__0():org.aswing.FlowLayout {
        /* declarations/demo/view/FrameView.xml:84 characters: 25-35 */
        var res = new org.aswing.FlowLayout();
        /* declarations/demo/view/FrameView.xml:84 characters: 37-42 */
        res.align = org.aswing.FlowLayout.RIGHT;
        return res;
    }

    inline function get_jButton__1():org.aswing.JButton {
        /* declarations/demo/view/FrameView.xml:86 characters: 21-28 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/FrameView.xml:86 characters: 30-34 */
        res.text = 'Sign up';
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/demo/view/FrameView.xml:87 characters: 45-62 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/FrameView.xml:87 characters: 64-69 */
        res.width = 10;
        /* declarations/demo/view/FrameView.xml:87 characters: 75-81 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/demo/view/FrameView.xml:87 characters: 21-28 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/FrameView.xml:87 characters: 30-43 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/demo/view/FrameView.xml:90 characters: 29-36 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/FrameView.xml:90 characters: 38-41 */
        res.rgb = 0x1abc9c;
        return res;
    }

    inline function get_jButton__2():org.aswing.JButton {
        /* declarations/demo/view/FrameView.xml:88 characters: 21-28 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/FrameView.xml:88 characters: 30-34 */
        res.text = 'Sign in';
        /* declarations/demo/view/FrameView.xml:89 characters: 25-35 */
        res.background = get_aSColor__0();
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* declarations/demo/view/FrameView.xml:82 characters: 17-23 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/FrameView.xml:83 characters: 21-27 */
        res.layout = get_flowLayout__0();
        res.append(get_jButton__1());
        res.append(get_jSpacer__0());
        res.append(get_jButton__2());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/FrameView.xml:61 characters: 13-20 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/FrameView.xml:61 characters: 22-25 */
        res.gap = 20;
        res.append(get_jTextField__0());
        res.append(get_jTextField__1());
        res.append(get_jPanel__1());
        res.append(get_jPanel__2());
        return res;
    }

    function get_loginDialog():jive.Dialog {
        /* declarations/demo/view/FrameView.xml:55 characters: 5-16 */
        if (loginDialog_initialized) return loginDialog;
        loginDialog_initialized = true;
        this.loginDialog = new jive.Dialog();
        var res = this.loginDialog;
        if (null != dataContext) { res.visibility = this.dataContext.isLoginDialogShowed; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.visibility = this.dataContext.isLoginDialogShowed;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.isLoginDialogShowed, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.isLoginDialogShowed, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.visibility = this.dataContext.isLoginDialogShowed;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.isLoginDialogShowed = res.visibility;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.visibility, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.isLoginDialogShowed = res.visibility;
                                }
                            });
        /* declarations/demo/view/FrameView.xml:58 characters: 13-18 */
        res.title = 'Login into your account';
        /* declarations/demo/view/FrameView.xml:59 characters: 13-18 */
        res.modal = true;
        /* declarations/demo/view/FrameView.xml:60 characters: 9-16 */
        res.content = get_softBox__0();
        return res;
    }

    public function new() {
        /* declarations/demo/view/FrameView.xml:2 characters: 1-7 */
        super();
        /* declarations/demo/view/FrameView.xml:11 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_jLabel__0());
        this.append(get_jTabbedPane__0());
        loginDialog.owner = null;
    }
}
