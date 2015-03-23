package view;

class MainView extends org.aswing.JWindow implements jive.DataContextControllable<viewmodel.MainViewModel> {

    var buttonsView_initialized:Bool = false;

    @:isVar public var buttonsView(get, set):view.ButtonsView;

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/view/MainView.xml:13 characters: 17-29 */
        var res = new org.aswing.BorderLayout();
        /* declarations/view/MainView.xml:13 characters: 31-35 */
        res.hgap = 20;
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/view/MainView.xml:16 characters: 17-35 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/view/MainView.xml:16 characters: 37-40 */
        res.top = 30;
        /* declarations/view/MainView.xml:16 characters: 68-73 */
        res.right = 30;
        /* declarations/view/MainView.xml:16 characters: 56-62 */
        res.bottom = 30;
        /* declarations/view/MainView.xml:16 characters: 46-50 */
        res.left = 30;
        return res;
    }

    inline function get_assetIcon__0():org.aswing.AssetIcon {
        /* declarations/view/MainView.xml:21 characters: 25-34 */
        var res = new org.aswing.AssetIcon();
        if (null != dataContext) { res.asset = this.dataContext.jiveIcon; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.asset = this.dataContext.jiveIcon;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.jiveIcon, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.jiveIcon, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.asset = this.dataContext.jiveIcon;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/view/MainView.xml:21 characters: 63-68 */
        res.width = 53;
        /* declarations/view/MainView.xml:21 characters: 74-80 */
        res.height = 22;
        return res;
    }

    inline function get_jMenu__0():org.aswing.JMenu {
        /* declarations/view/MainView.xml:19 characters: 17-22 */
        var res = new org.aswing.JMenu();
        /* declarations/view/MainView.xml:19 characters: 24-31 */
        res.enabled = false;
        /* declarations/view/MainView.xml:20 characters: 21-25 */
        res.icon = get_assetIcon__0();
        return res;
    }

    inline function get_jMenu__1():org.aswing.JMenu {
        /* declarations/view/MainView.xml:24 characters: 17-22 */
        var res = new org.aswing.JMenu();
        /* declarations/view/MainView.xml:24 characters: 24-28 */
        res.text = 'Demo';
        return res;
    }

    inline function get_jMenu__2():org.aswing.JMenu {
        /* declarations/view/MainView.xml:25 characters: 17-22 */
        var res = new org.aswing.JMenu();
        /* declarations/view/MainView.xml:25 characters: 24-28 */
        res.text = 'Documentation';
        return res;
    }

    inline function get_jMenu__3():org.aswing.JMenu {
        /* declarations/view/MainView.xml:26 characters: 17-22 */
        var res = new org.aswing.JMenu();
        /* declarations/view/MainView.xml:26 characters: 24-28 */
        res.text = 'Download';
        return res;
    }

    inline function get_jMenu__4():org.aswing.JMenu {
        /* declarations/view/MainView.xml:27 characters: 17-22 */
        var res = new org.aswing.JMenu();
        /* declarations/view/MainView.xml:27 characters: 24-28 */
        res.text = 'Contribute';
        return res;
    }

    inline function get_jMenuBar__0():org.aswing.JMenuBar {
        /* declarations/view/MainView.xml:18 characters: 13-21 */
        var res = new org.aswing.JMenuBar();
        /* declarations/view/MainView.xml:18 characters: 23-34 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        res.addMenu(get_jMenu__0());
        res.addMenu(get_jMenu__1());
        res.addMenu(get_jMenu__2());
        res.addMenu(get_jMenu__3());
        res.addMenu(get_jMenu__4());
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/view/MainView.xml:32 characters: 25-31 */
        var res = new org.aswing.ASFont();
        /* declarations/view/MainView.xml:32 characters: 63-67 */
        res.size = 20;
        /* declarations/view/MainView.xml:32 characters: 33-37 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/view/MainView.xml:30 characters: 17-23 */
        var res = new org.aswing.JLabel();
        /* declarations/view/MainView.xml:30 characters: 48-67 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/MainView.xml:30 characters: 25-29 */
        res.text = 'UI Components';
        /* declarations/view/MainView.xml:31 characters: 21-25 */
        res.font = get_aSFont__0();
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/view/MainView.xml:39 characters: 25-32 */
        var res = new org.aswing.ASColor();
        /* declarations/view/MainView.xml:39 characters: 34-37 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_aSColor__1():org.aswing.ASColor {
        /* declarations/view/MainView.xml:42 characters: 25-32 */
        var res = new org.aswing.ASColor();
        /* declarations/view/MainView.xml:42 characters: 34-37 */
        res.rgb = 0x34495e;
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/view/MainView.xml:45 characters: 25-42 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/MainView.xml:45 characters: 44-49 */
        res.width = 200;
        /* declarations/view/MainView.xml:45 characters: 56-62 */
        res.height = -1;
        return res;
    }

    inline function get_jList__0():org.aswing.JList {
        /* declarations/view/MainView.xml:35 characters: 17-22 */
        var res = new org.aswing.JList();
        if (null != dataContext) { res.model = this.dataContext.menuListModel; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.model = this.dataContext.menuListModel;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.menuListModel, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.menuListModel, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.model = this.dataContext.menuListModel;
                                    bindSourceListener();
                                }
                            });
                        
        if (null != dataContext) { res.selectedIndex = this.dataContext.menuSelectedIndex; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.selectedIndex = this.dataContext.menuSelectedIndex;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.menuSelectedIndex, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.menuSelectedIndex, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.selectedIndex = this.dataContext.menuSelectedIndex;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.menuSelectedIndex = res.selectedIndex;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.selectedIndex, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.menuSelectedIndex = res.selectedIndex;
                                }
                            });
        /* declarations/view/MainView.xml:38 characters: 21-31 */
        res.background = get_aSColor__0();
        /* declarations/view/MainView.xml:41 characters: 21-40 */
        res.selectionBackground = get_aSColor__1();
        /* declarations/view/MainView.xml:44 characters: 21-34 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/view/MainView.xml:29 characters: 13-20 */
        var res = new org.aswing.SoftBox();
        /* declarations/view/MainView.xml:29 characters: 22-33 */
        res.constraints = org.aswing.BorderLayout.WEST;
        res.append(get_jLabel__0());
        res.append(get_jList__0());
        return res;
    }

    inline function get_centerLayout__0():org.aswing.CenterLayout {
        /* declarations/view/MainView.xml:51 characters: 21-33 */
        var res = new org.aswing.CenterLayout();
        return res;
    }

    function set_buttonsView(value:view.ButtonsView):view.ButtonsView {
        buttonsView_initialized = true;
        return buttonsView = value;
    }

    function get_buttonsView():view.ButtonsView {
        /* declarations/view/MainView.xml:54 characters: 21-37 */
        if (buttonsView_initialized) return buttonsView;
        buttonsView_initialized = true;
        this.buttonsView = new view.ButtonsView();
        var res = this.buttonsView;
        if (null != dataContext) { res.dataContext = this.dataContext.buttonsVM; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.dataContext = this.dataContext.buttonsVM;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.buttonsVM, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.buttonsVM, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.dataContext = this.dataContext.buttonsVM;
                                    bindSourceListener();
                                }
                            });
                        
        return res;
    }

    inline function get_textView__0():view.TextView {
        /* declarations/view/MainView.xml:55 characters: 21-34 */
        var res = new view.TextView();
        if (null != dataContext) { res.dataContext = this.dataContext.textVM; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.dataContext = this.dataContext.textVM;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.textVM, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.textVM, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.dataContext = this.dataContext.textVM;
                                    bindSourceListener();
                                }
                            });
                        
        return res;
    }

    inline function get_spot__0():jive.Spot {
        /* declarations/view/MainView.xml:53 characters: 17-26 */
        var res = new jive.Spot();
        if (null != dataContext) { res.selectedIndex = this.dataContext.menuSelectedIndex; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.selectedIndex = this.dataContext.menuSelectedIndex;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.menuSelectedIndex, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.menuSelectedIndex, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.selectedIndex = this.dataContext.menuSelectedIndex;
                                    bindSourceListener();
                                }
                            });
                        
        res.append(buttonsView);
        res.append(get_textView__0());
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/view/MainView.xml:49 characters: 13-19 */
        var res = new org.aswing.JPanel();
        /* declarations/view/MainView.xml:49 characters: 21-32 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        /* declarations/view/MainView.xml:50 characters: 17-23 */
        res.layout = get_centerLayout__0();
        res.append(get_spot__0());
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/view/MainView.xml:11 characters: 9-15 */
        var res = new org.aswing.JPanel();
        /* declarations/view/MainView.xml:12 characters: 13-19 */
        res.layout = get_borderLayout__0();
        /* declarations/view/MainView.xml:15 characters: 13-19 */
        res.border = get_emptyBorder__0();
        res.append(get_jMenuBar__0());
        res.append(get_softBox__0());
        res.append(get_jPanel__0());
        return res;
    }

    public function new() {
        /* declarations/view/MainView.xml:2 characters: 1-8 */
        super();
        /* declarations/view/MainView.xml:8 characters: 9-22 */
        this.defaultButton = buttonsView.defButton;
        /* declarations/view/MainView.xml:10 characters: 5-12 */
        this.content.append(get_jPanel__1());
    }
}
