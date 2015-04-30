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
        res.bottom = 30;
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

    inline function get_emptyBorder__1():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/ButtonsView.xml:25 characters: 29-47 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/ButtonsView.xml:25 characters: 49-52 */
        res.top = 30;
        return res;
    }

    inline function get_emptyBorder__2():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/ButtonsView.xml:31 characters: 41-59 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/ButtonsView.xml:31 characters: 61-64 */
        res.top = 20;
        /* declarations/demo/view/ButtonsView.xml:31 characters: 92-97 */
        res.right = 20;
        /* declarations/demo/view/ButtonsView.xml:31 characters: 80-86 */
        res.bottom = 20;
        /* declarations/demo/view/ButtonsView.xml:31 characters: 70-74 */
        res.left = 20;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/demo/view/ButtonsView.xml:34 characters: 41-48 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/ButtonsView.xml:34 characters: 50-53 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/demo/view/ButtonsView.xml:29 characters: 33-50 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/demo/view/ButtonsView.xml:29 characters: 66-71 */
        res.round = 5;
        /* declarations/demo/view/ButtonsView.xml:29 characters: 52-61 */
        res.thickness = 1;
        /* declarations/demo/view/ButtonsView.xml:30 characters: 37-52 */
        res.interior = get_emptyBorder__2();
        /* declarations/demo/view/ButtonsView.xml:33 characters: 37-49 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/demo/view/ButtonsView.xml:41 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ButtonsView.xml:41 characters: 68-87 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ButtonsView.xml:41 characters: 45-49 */
        res.text = 'Basic buttons';
        return res;
    }

    function set_defButton(value:org.aswing.JButton):org.aswing.JButton {
        defButton_initialized = true;
        return defButton = value;
    }

    function get_defButton():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:43 characters: 41-48 */
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
                        
        /* declarations/demo/view/ButtonsView.xml:43 characters: 65-69 */
        res.text = 'Default button';
        return res;
    }

    inline function get_jButton__0():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:44 characters: 41-48 */
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
                        
        /* declarations/demo/view/ButtonsView.xml:44 characters: 50-54 */
        res.text = 'Button';
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/demo/view/ButtonsView.xml:42 characters: 37-43 */
        var res = new org.aswing.JPanel();
        res.append(defButton);
        res.append(get_jButton__0());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/ButtonsView.xml:40 characters: 33-40 */
        var res = new org.aswing.SoftBox();
        res.append(get_jLabel__1());
        res.append(get_jPanel__0());
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ButtonsView.xml:47 characters: 58-75 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ButtonsView.xml:47 characters: 77-82 */
        res.width = 10;
        /* declarations/demo/view/ButtonsView.xml:47 characters: 88-94 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/demo/view/ButtonsView.xml:47 characters: 33-40 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/ButtonsView.xml:47 characters: 42-55 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/demo/view/ButtonsView.xml:49 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ButtonsView.xml:49 characters: 70-89 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ButtonsView.xml:49 characters: 45-49 */
        res.text = 'Disabled button';
        return res;
    }

    inline function get_jButton__1():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:51 characters: 41-48 */
        var res = new org.aswing.JButton();
        /* declarations/demo/view/ButtonsView.xml:51 characters: 75-82 */
        res.enabled = false;
        /* declarations/demo/view/ButtonsView.xml:51 characters: 50-54 */
        res.text = 'Disabled button';
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/demo/view/ButtonsView.xml:50 characters: 37-43 */
        var res = new org.aswing.JPanel();
        res.append(get_jButton__1());
        return res;
    }

    inline function get_softBox__1():org.aswing.SoftBox {
        /* declarations/demo/view/ButtonsView.xml:48 characters: 33-40 */
        var res = new org.aswing.SoftBox();
        res.append(get_jLabel__2());
        res.append(get_jPanel__1());
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* declarations/demo/view/ButtonsView.xml:39 characters: 29-35 */
        var res = new org.aswing.JPanel();
        res.append(get_softBox__0());
        res.append(get_jSpacer__0());
        res.append(get_softBox__1());
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ButtonsView.xml:56 characters: 54-71 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ButtonsView.xml:56 characters: 73-78 */
        res.width = 10;
        /* declarations/demo/view/ButtonsView.xml:56 characters: 84-90 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__1():org.aswing.JSpacer {
        /* declarations/demo/view/ButtonsView.xml:56 characters: 29-36 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/ButtonsView.xml:56 characters: 38-51 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_jLabel__3():org.aswing.JLabel {
        /* declarations/demo/view/ButtonsView.xml:58 characters: 29-35 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/ButtonsView.xml:58 characters: 65-84 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/ButtonsView.xml:58 characters: 37-41 */
        res.text = 'Buttons with icons';
        return res;
    }

    inline function get_assetIcon__0():org.aswing.AssetIcon {
        /* declarations/demo/view/ButtonsView.xml:62 characters: 41-50 */
        var res = new org.aswing.AssetIcon();
        /* declarations/demo/view/ButtonsView.xml:62 characters: 52-63 */
        res.bitmapAsset = 'messages.png';
        /* declarations/demo/view/ButtonsView.xml:62 characters: 81-86 */
        res.width = 30;
        /* declarations/demo/view/ButtonsView.xml:62 characters: 92-98 */
        res.height = 30;
        /* declarations/demo/view/ButtonsView.xml:62 characters: 104-109 */
        res.scale = true;
        return res;
    }

    inline function get_jButton__2():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:60 characters: 33-40 */
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
                        
        /* declarations/demo/view/ButtonsView.xml:60 characters: 42-46 */
        res.text = 'Messages';
        /* declarations/demo/view/ButtonsView.xml:61 characters: 37-41 */
        res.icon = get_assetIcon__0();
        return res;
    }

    inline function get_assetIcon__1():org.aswing.AssetIcon {
        /* declarations/demo/view/ButtonsView.xml:67 characters: 41-50 */
        var res = new org.aswing.AssetIcon();
        /* declarations/demo/view/ButtonsView.xml:67 characters: 52-63 */
        res.bitmapAsset = 'weather.png';
        /* declarations/demo/view/ButtonsView.xml:67 characters: 80-85 */
        res.width = 30;
        /* declarations/demo/view/ButtonsView.xml:67 characters: 91-97 */
        res.height = 30;
        /* declarations/demo/view/ButtonsView.xml:67 characters: 103-108 */
        res.scale = true;
        return res;
    }

    inline function get_jButton__3():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:65 characters: 33-40 */
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
                        
        /* declarations/demo/view/ButtonsView.xml:65 characters: 42-46 */
        res.text = 'Wheather in Abakan';
        /* declarations/demo/view/ButtonsView.xml:66 characters: 37-41 */
        res.icon = get_assetIcon__1();
        return res;
    }

    inline function get_assetIcon__2():org.aswing.AssetIcon {
        /* declarations/demo/view/ButtonsView.xml:72 characters: 41-50 */
        var res = new org.aswing.AssetIcon();
        /* declarations/demo/view/ButtonsView.xml:72 characters: 52-63 */
        res.bitmapAsset = 'calendar.png';
        /* declarations/demo/view/ButtonsView.xml:72 characters: 81-86 */
        res.width = 30;
        /* declarations/demo/view/ButtonsView.xml:72 characters: 92-98 */
        res.height = 30;
        /* declarations/demo/view/ButtonsView.xml:72 characters: 104-109 */
        res.scale = true;
        return res;
    }

    inline function get_jButton__4():org.aswing.JButton {
        /* declarations/demo/view/ButtonsView.xml:70 characters: 33-40 */
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
                        
        /* declarations/demo/view/ButtonsView.xml:71 characters: 37-41 */
        res.icon = get_assetIcon__2();
        return res;
    }

    inline function get_jPanel__3():org.aswing.JPanel {
        /* declarations/demo/view/ButtonsView.xml:59 characters: 29-35 */
        var res = new org.aswing.JPanel();
        res.append(get_jButton__2());
        res.append(get_jButton__3());
        res.append(get_jButton__4());
        return res;
    }

    inline function get_softBox__2():org.aswing.SoftBox {
        /* declarations/demo/view/ButtonsView.xml:27 characters: 25-32 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/ButtonsView.xml:28 characters: 29-35 */
        res.border = get_lineBorder__0();
        res.append(get_jPanel__2());
        res.append(get_jSpacer__1());
        res.append(get_jLabel__3());
        res.append(get_jPanel__3());
        return res;
    }

    inline function get_intDimension__2():org.aswing.geom.IntDimension {
        /* declarations/demo/view/ButtonsView.xml:79 characters: 33-50 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/ButtonsView.xml:79 characters: 52-57 */
        res.width = 0;
        /* declarations/demo/view/ButtonsView.xml:79 characters: 62-68 */
        res.height = 200;
        return res;
    }

    inline function get_jTextArea__0():org.aswing.JTextArea {
        /* declarations/demo/view/ButtonsView.xml:81 characters: 29-38 */
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
                        
        /* declarations/demo/view/ButtonsView.xml:81 characters: 40-48 */
        res.editable = false;
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/demo/view/ButtonsView.xml:77 characters: 25-36 */
        var res = new org.aswing.JScrollPane();
        /* declarations/demo/view/ButtonsView.xml:78 characters: 29-42 */
        res.preferredSize = get_intDimension__2();
        res.append(get_jTextArea__0());
        return res;
    }

    inline function get_softBox__3():org.aswing.SoftBox {
        /* declarations/demo/view/ButtonsView.xml:26 characters: 21-28 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/ButtonsView.xml:26 characters: 30-34 */
        res.axis = org.aswing.SoftBoxLayout.Y_AXIS;
        /* declarations/demo/view/ButtonsView.xml:26 characters: 69-72 */
        res.gap = 15;
        res.append(get_softBox__2());
        res.append(get_jScrollPane__0());
        return res;
    }

    inline function get_softBox__4():org.aswing.SoftBox {
        /* declarations/demo/view/ButtonsView.xml:24 characters: 17-24 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/ButtonsView.xml:25 characters: 21-27 */
        res.border = get_emptyBorder__1();
        res.append(get_softBox__3());
        return res;
    }

    inline function get_tabInfo__0():org.aswing.TabInfo {
        /* declarations/demo/view/ButtonsView.xml:22 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ButtonsView.xml:22 characters: 18-23 */
        res.title = 'Demo';
        /* declarations/demo/view/ButtonsView.xml:23 characters: 13-20 */
        res.content = get_softBox__4();
        return res;
    }

    inline function get_hmlRegExRules__0():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/ButtonsView.xml:93 characters: 29-53 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__0():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/ButtonsView.xml:91 characters: 21-54 */
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
                        
        /* declarations/demo/view/ButtonsView.xml:91 characters: 83-102 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/ButtonsView.xml:92 characters: 25-41 */
        res.rules = get_hmlRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__1():org.aswing.JScrollPane {
        /* declarations/demo/view/ButtonsView.xml:90 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__0());
        return res;
    }

    inline function get_tabInfo__1():org.aswing.TabInfo {
        /* declarations/demo/view/ButtonsView.xml:88 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ButtonsView.xml:88 characters: 18-23 */
        res.title = 'View (XML source)';
        /* declarations/demo/view/ButtonsView.xml:89 characters: 13-20 */
        res.content = get_jScrollPane__1();
        return res;
    }

    inline function get_haxeRegExRules__0():jive.formatting.HaxeRegExRules {
        /* declarations/demo/view/ButtonsView.xml:104 characters: 29-54 */
        var res = new jive.formatting.HaxeRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__1():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/ButtonsView.xml:102 characters: 21-54 */
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
                        
        /* declarations/demo/view/ButtonsView.xml:102 characters: 84-103 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/ButtonsView.xml:103 characters: 25-41 */
        res.rules = get_haxeRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__2():org.aswing.JScrollPane {
        /* declarations/demo/view/ButtonsView.xml:101 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__1());
        return res;
    }

    inline function get_tabInfo__2():org.aswing.TabInfo {
        /* declarations/demo/view/ButtonsView.xml:99 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/ButtonsView.xml:99 characters: 18-23 */
        res.title = 'View Model (Haxe source)';
        /* declarations/demo/view/ButtonsView.xml:100 characters: 13-20 */
        res.content = get_jScrollPane__2();
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
