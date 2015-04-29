package demo.view;

class ButtonsView extends org.aswing.JPanel implements jive.DataContextControllable<demo.viewmodel.ButtonsViewModel> {

    var defButton_initialized:Bool = false;

    @:isVar public var defButton(get, set):org.aswing.JButton;

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/demo/view/ButtonsView.xml:10 characters: 9-21 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/demo/view/ButtonsView.xml:14 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/ButtonsView.xml:14 characters: 51-55 */
        res.size = 30;
        /* declarations/demo/view/ButtonsView.xml:14 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/ButtonsView.xml:17 characters: 13-31 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/ButtonsView.xml:17 characters: 33-39 */
        res.bottom = 15;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/demo/view/ButtonsView.xml:12 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ButtonsView.xml:12 characters: 30-49 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ButtonsView.xml:12 characters: 13-17 */
        res.text = 'Buttons';
        /* declarations/demo/view/ButtonsView.xml:12 characters: 84-95 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/demo/view/ButtonsView.xml:13 characters: 9-13 */
        res.font = get_aSFont__0();
        /* declarations/demo/view/ButtonsView.xml:16 characters: 9-15 */
        res.border = get_emptyBorder__0();
        return res;
    }

    inline function get_centerLayout__0():org.aswing.CenterLayout {
        /* declarations/demo/view/ButtonsView.xml:26 characters: 25-37 */
        var res = new org.aswing.CenterLayout();
        return res;
    }

    inline function get_emptyBorder__1():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/ButtonsView.xml:33 characters: 41-59 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/ButtonsView.xml:33 characters: 61-64 */
        res.top = 30;
        /* declarations/demo/view/ButtonsView.xml:33 characters: 92-97 */
        res.right = 30;
        /* declarations/demo/view/ButtonsView.xml:33 characters: 80-86 */
        res.bottom = 30;
        /* declarations/demo/view/ButtonsView.xml:33 characters: 70-74 */
        res.left = 30;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/demo/view/ButtonsView.xml:36 characters: 41-48 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/ButtonsView.xml:36 characters: 50-53 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/demo/view/ButtonsView.xml:31 characters: 33-50 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/demo/view/ButtonsView.xml:31 characters: 66-71 */
        res.round = 5;
        /* declarations/demo/view/ButtonsView.xml:31 characters: 52-61 */
        res.thickness = 1;
        /* declarations/demo/view/ButtonsView.xml:32 characters: 37-52 */
        res.interior = get_emptyBorder__1();
        /* declarations/demo/view/ButtonsView.xml:35 characters: 37-49 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/demo/view/ButtonsView.xml:41 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ButtonsView.xml:41 characters: 60-79 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ButtonsView.xml:41 characters: 37-41 */
        res.text = 'Basic buttons';
        return res;
    }

    function set_defButton(value:org.aswing.JButton):org.aswing.JButton {
        defButton_initialized = true;
        return defButton = value;
    }

    function get_defButton():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:43 characters: 33-40 */
        if (defButton_initialized) return defButton;
        defButton_initialized = true;
        this.defButton = new org.aswing.JButton();
        var res = this.defButton;
        if (null != dataContext) { res.command = this.dataContext.defaultButtonCommand; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.command = this.dataContext.defaultButtonCommand;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.defaultButtonCommand, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.defaultButtonCommand, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.command = this.dataContext.defaultButtonCommand;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/ButtonsView.xml:43 characters: 57-61 */
        res.text = 'Default button';
        return res;
    }

    inline function get_jButton__0():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:44 characters: 33-40 */
        var res = new org.aswing.JButton();
        if (null != dataContext) { res.command = this.dataContext.basicButtonCommand; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.command = this.dataContext.basicButtonCommand;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.basicButtonCommand, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.basicButtonCommand, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.command = this.dataContext.basicButtonCommand;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/ButtonsView.xml:44 characters: 42-46 */
        res.text = 'Button';
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/demo/view/ButtonsView.xml:42 characters: 29-35 */
        var res = new org.aswing.JPanel();
        res.append(defButton);
        res.append(get_jButton__0());
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ButtonsView.xml:47 characters: 54-71 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ButtonsView.xml:47 characters: 73-78 */
        res.width = 10;
        /* declarations/demo/view/ButtonsView.xml:47 characters: 84-90 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/demo/view/ButtonsView.xml:47 characters: 29-36 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/ButtonsView.xml:47 characters: 38-51 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/demo/view/ButtonsView.xml:49 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ButtonsView.xml:49 characters: 62-81 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ButtonsView.xml:49 characters: 37-41 */
        res.text = 'Disabled button';
        return res;
    }

    inline function get_jButton__1():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:51 characters: 33-40 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/ButtonsView.xml:51 characters: 67-74 */
        res.enabled = false;
        /* declarations/demo/view/ButtonsView.xml:51 characters: 42-46 */
        res.text = 'Disabled button';
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/demo/view/ButtonsView.xml:50 characters: 29-35 */
        var res = new org.aswing.JPanel();
        res.append(get_jButton__1());
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ButtonsView.xml:54 characters: 54-71 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ButtonsView.xml:54 characters: 73-78 */
        res.width = 10;
        /* declarations/demo/view/ButtonsView.xml:54 characters: 84-90 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__1():org.aswing.JSpacer {
        /* declarations/demo/view/ButtonsView.xml:54 characters: 29-36 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/ButtonsView.xml:54 characters: 38-51 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_jLabel__3():org.aswing.JLabel {
        /* declarations/demo/view/ButtonsView.xml:56 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ButtonsView.xml:56 characters: 65-84 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ButtonsView.xml:56 characters: 37-41 */
        res.text = 'Buttons with icons';
        return res;
    }

    inline function get_assetIcon__0():org.aswing.AssetIcon {
        /* declarations/demo/view/ButtonsView.xml:60 characters: 41-50 */
        var res = new org.aswing.AssetIcon();
        /* declarations/demo/view/ButtonsView.xml:60 characters: 52-63 */
        res.bitmapAsset = 'messages.png';
        /* declarations/demo/view/ButtonsView.xml:60 characters: 81-86 */
        res.width = 30;
        /* declarations/demo/view/ButtonsView.xml:60 characters: 92-98 */
        res.height = 30;
        /* declarations/demo/view/ButtonsView.xml:60 characters: 104-109 */
        res.scale = true;
        return res;
    }

    inline function get_jButton__2():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:58 characters: 33-40 */
        var res = new org.aswing.JButton();
        if (null != dataContext) { res.command = this.dataContext.messagesButtonCommand; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.command = this.dataContext.messagesButtonCommand;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.messagesButtonCommand, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.messagesButtonCommand, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.command = this.dataContext.messagesButtonCommand;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/ButtonsView.xml:58 characters: 42-46 */
        res.text = 'Messages';
        /* declarations/demo/view/ButtonsView.xml:59 characters: 37-41 */
        res.icon = get_assetIcon__0();
        return res;
    }

    inline function get_assetIcon__1():org.aswing.AssetIcon {
        /* declarations/demo/view/ButtonsView.xml:65 characters: 41-50 */
        var res = new org.aswing.AssetIcon();
        /* declarations/demo/view/ButtonsView.xml:65 characters: 52-63 */
        res.bitmapAsset = 'weather.png';
        /* declarations/demo/view/ButtonsView.xml:65 characters: 80-85 */
        res.width = 30;
        /* declarations/demo/view/ButtonsView.xml:65 characters: 91-97 */
        res.height = 30;
        /* declarations/demo/view/ButtonsView.xml:65 characters: 103-108 */
        res.scale = true;
        return res;
    }

    inline function get_jButton__3():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:63 characters: 33-40 */
        var res = new org.aswing.JButton();
        if (null != dataContext) { res.command = this.dataContext.weatherButtonCommand; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.command = this.dataContext.weatherButtonCommand;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.weatherButtonCommand, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.weatherButtonCommand, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.command = this.dataContext.weatherButtonCommand;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/ButtonsView.xml:63 characters: 42-46 */
        res.text = 'Wheather';
        /* declarations/demo/view/ButtonsView.xml:64 characters: 37-41 */
        res.icon = get_assetIcon__1();
        return res;
    }

    inline function get_assetIcon__2():org.aswing.AssetIcon {
        /* declarations/demo/view/ButtonsView.xml:70 characters: 41-50 */
        var res = new org.aswing.AssetIcon();
        /* declarations/demo/view/ButtonsView.xml:70 characters: 52-63 */
        res.bitmapAsset = 'calendar.png';
        /* declarations/demo/view/ButtonsView.xml:70 characters: 81-86 */
        res.width = 30;
        /* declarations/demo/view/ButtonsView.xml:70 characters: 92-98 */
        res.height = 30;
        /* declarations/demo/view/ButtonsView.xml:70 characters: 104-109 */
        res.scale = true;
        return res;
    }

    inline function get_jButton__4():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:68 characters: 33-40 */
        var res = new org.aswing.JButton();
        if (null != dataContext) { res.command = this.dataContext.calendarButtonCommand; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.command = this.dataContext.calendarButtonCommand;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.calendarButtonCommand, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.calendarButtonCommand, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.command = this.dataContext.calendarButtonCommand;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/ButtonsView.xml:69 characters: 37-41 */
        res.icon = get_assetIcon__2();
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* declarations/demo/view/ButtonsView.xml:57 characters: 29-35 */
        var res = new org.aswing.JPanel();
        res.append(get_jButton__2());
        res.append(get_jButton__3());
        res.append(get_jButton__4());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/ButtonsView.xml:29 characters: 25-32 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/ButtonsView.xml:30 characters: 29-35 */
        res.border = get_lineBorder__0();
        res.append(get_jLabel__1());
        res.append(get_jPanel__0());
        res.append(get_jSpacer__0());
        res.append(get_jLabel__2());
        res.append(get_jPanel__1());
        res.append(get_jSpacer__1());
        res.append(get_jLabel__3());
        res.append(get_jPanel__2());
        return res;
    }

    inline function get_intDimension__2():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ButtonsView.xml:77 characters: 33-50 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ButtonsView.xml:77 characters: 52-57 */
        res.width = 300;
        /* declarations/demo/view/ButtonsView.xml:77 characters: 64-70 */
        res.height = 0;
        return res;
    }

    inline function get_jTextArea__0():org.aswing.JTextArea {
        /* declarations/demo/view/ButtonsView.xml:75 characters: 25-34 */
        var res = new org.aswing.JTextArea();
        if (null != dataContext) { res.text = this.dataContext.buttonsLog; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.buttonsLog;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.buttonsLog, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.buttonsLog, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.buttonsLog;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/ButtonsView.xml:75 characters: 36-44 */
        res.editable = false;
        /* declarations/demo/view/ButtonsView.xml:76 characters: 29-42 */
        res.preferredSize = get_intDimension__2();
        return res;
    }

    inline function get_softBox__1():org.aswing.SoftBox {
        /* declarations/demo/view/ButtonsView.xml:28 characters: 21-28 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/ButtonsView.xml:28 characters: 30-34 */
        res.axis = org.aswing.SoftBoxLayout.X_AXIS;
        /* declarations/demo/view/ButtonsView.xml:28 characters: 69-72 */
        res.gap = 30;
        res.append(get_softBox__0());
        res.append(get_jTextArea__0());
        return res;
    }

    inline function get_jPanel__3():org.aswing.JPanel {
        /* declarations/demo/view/ButtonsView.xml:24 characters: 17-23 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/ButtonsView.xml:25 characters: 21-27 */
        res.layout = get_centerLayout__0();
        res.append(get_softBox__1());
        return res;
    }

    inline function get_tabInfo__0():org.aswing.TabInfo {
        /* declarations/demo/view/ButtonsView.xml:22 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ButtonsView.xml:22 characters: 18-23 */
        res.title = 'Demo';
        /* declarations/demo/view/ButtonsView.xml:23 characters: 13-20 */
        res.content = get_jPanel__3();
        return res;
    }

    inline function get_hmlRegExRules__0():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/ButtonsView.xml:90 characters: 29-53 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__0():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/ButtonsView.xml:88 characters: 21-54 */
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
                        
        /* declarations/demo/view/ButtonsView.xml:88 characters: 83-102 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/ButtonsView.xml:89 characters: 25-41 */
        res.rules = get_hmlRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/demo/view/ButtonsView.xml:87 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__0());
        return res;
    }

    inline function get_tabInfo__1():org.aswing.TabInfo {
        /* declarations/demo/view/ButtonsView.xml:85 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ButtonsView.xml:85 characters: 18-23 */
        res.title = 'View (XML source)';
        /* declarations/demo/view/ButtonsView.xml:86 characters: 13-20 */
        res.content = get_jScrollPane__0();
        return res;
    }

    inline function get_haxeRegExRules__0():jive.formatting.HaxeRegExRules {
        /* declarations/demo/view/ButtonsView.xml:101 characters: 29-54 */
        var res = new jive.formatting.HaxeRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__1():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/ButtonsView.xml:99 characters: 21-54 */
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
                        
        /* declarations/demo/view/ButtonsView.xml:99 characters: 84-103 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/ButtonsView.xml:100 characters: 25-41 */
        res.rules = get_haxeRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__1():org.aswing.JScrollPane {
        /* declarations/demo/view/ButtonsView.xml:98 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__1());
        return res;
    }

    inline function get_tabInfo__2():org.aswing.TabInfo {
        /* declarations/demo/view/ButtonsView.xml:96 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ButtonsView.xml:96 characters: 18-23 */
        res.title = 'View Model (Haxe source)';
        /* declarations/demo/view/ButtonsView.xml:97 characters: 13-20 */
        res.content = get_jScrollPane__1();
        return res;
    }

    inline function get_jTabbedPane__0():org.aswing.JTabbedPane {
        /* declarations/demo/view/ButtonsView.xml:20 characters: 5-16 */
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
        /* declarations/demo/view/ButtonsView.xml:20 characters: 18-29 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        res.appendTabInfo(get_tabInfo__0());
        res.appendTabInfo(get_tabInfo__1());
        res.appendTabInfo(get_tabInfo__2());
        return res;
    }

    public function new() {
        /* declarations/demo/view/ButtonsView.xml:2 characters: 1-7 */
        super();
        /* declarations/demo/view/ButtonsView.xml:9 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_jLabel__0());
        this.append(get_jTabbedPane__0());
    }
}
