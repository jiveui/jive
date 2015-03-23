package view;

class ButtonsView extends org.aswing.SoftBox implements jive.DataContextControllable<viewmodel.ButtonsViewModel> {

    var defButton_initialized:Bool = false;

    @:isVar public var defButton(get, set):org.aswing.JButton;

    public function destroyHml():Void {
        
    }
    

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/view/ButtonsView.xml:10 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/view/ButtonsView.xml:10 characters: 51-55 */
        res.size = 30;
        /* declarations/view/ButtonsView.xml:10 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/view/ButtonsView.xml:8 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/view/ButtonsView.xml:8 characters: 30-49 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/ButtonsView.xml:8 characters: 13-17 */
        res.text = 'Buttons';
        /* declarations/view/ButtonsView.xml:9 characters: 9-13 */
        res.font = get_aSFont__0();
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/view/ButtonsView.xml:18 characters: 25-43 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/view/ButtonsView.xml:18 characters: 45-48 */
        res.top = 30;
        /* declarations/view/ButtonsView.xml:18 characters: 76-81 */
        res.right = 30;
        /* declarations/view/ButtonsView.xml:18 characters: 64-70 */
        res.bottom = 30;
        /* declarations/view/ButtonsView.xml:18 characters: 54-58 */
        res.left = 30;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/view/ButtonsView.xml:21 characters: 25-32 */
        var res = new org.aswing.ASColor();
        /* declarations/view/ButtonsView.xml:21 characters: 34-37 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/view/ButtonsView.xml:16 characters: 17-34 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/view/ButtonsView.xml:16 characters: 50-55 */
        res.round = 5;
        /* declarations/view/ButtonsView.xml:16 characters: 36-45 */
        res.thickness = 1;
        /* declarations/view/ButtonsView.xml:17 characters: 21-36 */
        res.interior = get_emptyBorder__0();
        /* declarations/view/ButtonsView.xml:20 characters: 21-33 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/view/ButtonsView.xml:26 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/view/ButtonsView.xml:26 characters: 44-63 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/ButtonsView.xml:26 characters: 21-25 */
        res.text = 'Basic buttons';
        return res;
    }

    function set_defButton(value:org.aswing.JButton):org.aswing.JButton {
        defButton_initialized = true;
        return defButton = value;
    }

    function get_defButton():org.aswing.JButton {
        /* declarations/view/ButtonsView.xml:28 characters: 17-24 */
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
                        
        /* declarations/view/ButtonsView.xml:28 characters: 41-45 */
        res.text = 'Default button';
        return res;
    }

    inline function get_jButton__0():org.aswing.JButton {
        /* declarations/view/ButtonsView.xml:29 characters: 17-24 */
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
                        
        /* declarations/view/ButtonsView.xml:29 characters: 26-30 */
        res.text = 'Button';
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/view/ButtonsView.xml:27 characters: 13-19 */
        var res = new org.aswing.JPanel();
        res.append(defButton);
        res.append(get_jButton__0());
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/view/ButtonsView.xml:32 characters: 38-55 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/ButtonsView.xml:32 characters: 57-62 */
        res.width = 10;
        /* declarations/view/ButtonsView.xml:32 characters: 68-74 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/view/ButtonsView.xml:32 characters: 13-20 */
        var res = new org.aswing.JSpacer();
        /* declarations/view/ButtonsView.xml:32 characters: 22-35 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/view/ButtonsView.xml:34 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/view/ButtonsView.xml:34 characters: 46-65 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/ButtonsView.xml:34 characters: 21-25 */
        res.text = 'Disabled button';
        return res;
    }

    inline function get_jButton__1():org.aswing.JButton {
        /* declarations/view/ButtonsView.xml:36 characters: 17-24 */
        var res = new org.aswing.JButton();
        /* declarations/view/ButtonsView.xml:36 characters: 51-58 */
        res.enabled = false;
        /* declarations/view/ButtonsView.xml:36 characters: 26-30 */
        res.text = 'Disabled button';
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/view/ButtonsView.xml:35 characters: 13-19 */
        var res = new org.aswing.JPanel();
        res.append(get_jButton__1());
        return res;
    }

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/view/ButtonsView.xml:39 characters: 38-55 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/ButtonsView.xml:39 characters: 57-62 */
        res.width = 10;
        /* declarations/view/ButtonsView.xml:39 characters: 68-74 */
        res.height = 10;
        return res;
    }

    inline function get_jSpacer__1():org.aswing.JSpacer {
        /* declarations/view/ButtonsView.xml:39 characters: 13-20 */
        var res = new org.aswing.JSpacer();
        /* declarations/view/ButtonsView.xml:39 characters: 22-35 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_jLabel__3():org.aswing.JLabel {
        /* declarations/view/ButtonsView.xml:41 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/view/ButtonsView.xml:41 characters: 49-68 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/ButtonsView.xml:41 characters: 21-25 */
        res.text = 'Buttons with icons';
        return res;
    }

    inline function get_assetIcon__0():org.aswing.AssetIcon {
        /* declarations/view/ButtonsView.xml:45 characters: 25-34 */
        var res = new org.aswing.AssetIcon();
        /* declarations/view/ButtonsView.xml:45 characters: 36-47 */
        res.bitmapAsset = 'messages.png';
        /* declarations/view/ButtonsView.xml:45 characters: 65-70 */
        res.width = 30;
        /* declarations/view/ButtonsView.xml:45 characters: 76-82 */
        res.height = 30;
        /* declarations/view/ButtonsView.xml:45 characters: 88-93 */
        res.scale = true;
        return res;
    }

    inline function get_jButton__2():org.aswing.JButton {
        /* declarations/view/ButtonsView.xml:43 characters: 17-24 */
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
                        
        /* declarations/view/ButtonsView.xml:43 characters: 26-30 */
        res.text = 'Messages';
        /* declarations/view/ButtonsView.xml:44 characters: 21-25 */
        res.icon = get_assetIcon__0();
        return res;
    }

    inline function get_assetIcon__1():org.aswing.AssetIcon {
        /* declarations/view/ButtonsView.xml:50 characters: 25-34 */
        var res = new org.aswing.AssetIcon();
        /* declarations/view/ButtonsView.xml:50 characters: 36-47 */
        res.bitmapAsset = 'weather.png';
        /* declarations/view/ButtonsView.xml:50 characters: 64-69 */
        res.width = 30;
        /* declarations/view/ButtonsView.xml:50 characters: 75-81 */
        res.height = 30;
        /* declarations/view/ButtonsView.xml:50 characters: 87-92 */
        res.scale = true;
        return res;
    }

    inline function get_jButton__3():org.aswing.JButton {
        /* declarations/view/ButtonsView.xml:48 characters: 17-24 */
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
                        
        /* declarations/view/ButtonsView.xml:48 characters: 26-30 */
        res.text = 'Wheather in Abakan';
        /* declarations/view/ButtonsView.xml:49 characters: 21-25 */
        res.icon = get_assetIcon__1();
        return res;
    }

    inline function get_assetIcon__2():org.aswing.AssetIcon {
        /* declarations/view/ButtonsView.xml:55 characters: 25-34 */
        var res = new org.aswing.AssetIcon();
        /* declarations/view/ButtonsView.xml:55 characters: 36-47 */
        res.bitmapAsset = 'calendar.png';
        /* declarations/view/ButtonsView.xml:55 characters: 65-70 */
        res.width = 30;
        /* declarations/view/ButtonsView.xml:55 characters: 76-82 */
        res.height = 30;
        /* declarations/view/ButtonsView.xml:55 characters: 88-93 */
        res.scale = true;
        return res;
    }

    inline function get_jButton__4():org.aswing.JButton {
        /* declarations/view/ButtonsView.xml:53 characters: 17-24 */
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
                        
        /* declarations/view/ButtonsView.xml:54 characters: 21-25 */
        res.icon = get_assetIcon__2();
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* declarations/view/ButtonsView.xml:42 characters: 13-19 */
        var res = new org.aswing.JPanel();
        res.append(get_jButton__2());
        res.append(get_jButton__3());
        res.append(get_jButton__4());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/view/ButtonsView.xml:14 characters: 9-16 */
        var res = new org.aswing.SoftBox();
        /* declarations/view/ButtonsView.xml:15 characters: 13-19 */
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
        /* declarations/view/ButtonsView.xml:62 characters: 17-34 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/ButtonsView.xml:62 characters: 36-41 */
        res.width = 300;
        /* declarations/view/ButtonsView.xml:62 characters: 48-54 */
        res.height = 0;
        return res;
    }

    inline function get_jTextArea__0():org.aswing.JTextArea {
        /* declarations/view/ButtonsView.xml:60 characters: 9-18 */
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
                        
        /* declarations/view/ButtonsView.xml:60 characters: 20-28 */
        res.editable = false;
        /* declarations/view/ButtonsView.xml:61 characters: 13-26 */
        res.preferredSize = get_intDimension__2();
        return res;
    }

    inline function get_softBox__1():org.aswing.SoftBox {
        /* declarations/view/ButtonsView.xml:13 characters: 5-12 */
        var res = new org.aswing.SoftBox();
        /* declarations/view/ButtonsView.xml:13 characters: 14-18 */
        res.axis = org.aswing.SoftBoxLayout.X_AXIS;
        /* declarations/view/ButtonsView.xml:13 characters: 53-56 */
        res.gap = 30;
        res.append(get_softBox__0());
        res.append(get_jTextArea__0());
        return res;
    }

    public function new() {
        /* declarations/view/ButtonsView.xml:2 characters: 1-8 */
        super();
        /* declarations/view/ButtonsView.xml:2 characters: 10-13 */
        this.gap = 10;
        this.append(get_jLabel__0());
        this.append(get_softBox__1());
    }
}
