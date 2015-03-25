package view;

class MainView extends org.aswing.JWindow implements jive.DataContextControllable<viewmodel.MainViewModel> {

    var buttonsView_initialized:Bool = false;

    @:isVar public var buttonsView(get, set):view.ButtonsView;

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/view/MainView.xml:14 characters: 17-29 */
        var res = new org.aswing.BorderLayout();
        /* declarations/view/MainView.xml:14 characters: 31-35 */
        res.hgap = 20;
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/view/MainView.xml:17 characters: 17-35 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/view/MainView.xml:17 characters: 37-40 */
        res.top = 30;
        /* declarations/view/MainView.xml:17 characters: 68-73 */
        res.right = 30;
        /* declarations/view/MainView.xml:17 characters: 56-62 */
        res.bottom = 30;
        /* declarations/view/MainView.xml:17 characters: 46-50 */
        res.left = 30;
        return res;
    }

    inline function get_assetIcon__0():org.aswing.AssetIcon {
        /* declarations/view/MainView.xml:22 characters: 25-34 */
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
                        
        /* declarations/view/MainView.xml:22 characters: 63-68 */
        res.width = 53;
        /* declarations/view/MainView.xml:22 characters: 74-80 */
        res.height = 22;
        return res;
    }

    inline function get_jMenu__0():org.aswing.JMenu {
        /* declarations/view/MainView.xml:20 characters: 17-22 */
        var res = new org.aswing.JMenu();
        /* declarations/view/MainView.xml:20 characters: 24-31 */
        res.enabled = false;
        /* declarations/view/MainView.xml:21 characters: 21-25 */
        res.icon = get_assetIcon__0();
        return res;
    }

    inline function get_jMenu__1():org.aswing.JMenu {
        /* declarations/view/MainView.xml:25 characters: 17-22 */
        var res = new org.aswing.JMenu();
        /* declarations/view/MainView.xml:25 characters: 24-28 */
        res.text = 'Demo';
        return res;
    }

    inline function get_jMenu__2():org.aswing.JMenu {
        /* declarations/view/MainView.xml:26 characters: 17-22 */
        var res = new org.aswing.JMenu();
        /* declarations/view/MainView.xml:26 characters: 24-28 */
        res.text = 'Documentation';
        return res;
    }

    inline function get_jMenu__3():org.aswing.JMenu {
        /* declarations/view/MainView.xml:27 characters: 17-22 */
        var res = new org.aswing.JMenu();
        /* declarations/view/MainView.xml:27 characters: 24-28 */
        res.text = 'Download';
        return res;
    }

    inline function get_jMenu__4():org.aswing.JMenu {
        /* declarations/view/MainView.xml:28 characters: 17-22 */
        var res = new org.aswing.JMenu();
        /* declarations/view/MainView.xml:28 characters: 24-28 */
        res.text = 'Contribute';
        return res;
    }

    inline function get_jMenuBar__0():org.aswing.JMenuBar {
        /* declarations/view/MainView.xml:19 characters: 13-21 */
        var res = new org.aswing.JMenuBar();
        /* declarations/view/MainView.xml:19 characters: 23-34 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        res.addMenu(get_jMenu__0());
        res.addMenu(get_jMenu__1());
        res.addMenu(get_jMenu__2());
        res.addMenu(get_jMenu__3());
        res.addMenu(get_jMenu__4());
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/view/MainView.xml:31 characters: 41-58 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/MainView.xml:31 characters: 60-65 */
        res.width = 30;
        /* declarations/view/MainView.xml:31 characters: 71-77 */
        res.height = 30;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/view/MainView.xml:31 characters: 17-24 */
        var res = new org.aswing.JSpacer();
        /* declarations/view/MainView.xml:31 characters: 26-39 */
        res.preferredSize = get_intDimension__0();
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/view/MainView.xml:34 characters: 25-31 */
        var res = new org.aswing.ASFont();
        /* declarations/view/MainView.xml:34 characters: 63-67 */
        res.size = 20;
        /* declarations/view/MainView.xml:34 characters: 33-37 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/view/MainView.xml:32 characters: 17-23 */
        var res = new org.aswing.JLabel();
        /* declarations/view/MainView.xml:32 characters: 48-67 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/view/MainView.xml:32 characters: 25-29 */
        res.text = 'UI Components';
        /* declarations/view/MainView.xml:33 characters: 21-25 */
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

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/view/MainView.xml:45 characters: 25-42 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/MainView.xml:45 characters: 44-49 */
        res.width = 200;
        /* declarations/view/MainView.xml:45 characters: 56-62 */
        res.height = -1;
        return res;
    }

    inline function get_string__0():String {
        /* declarations/view/MainView.xml:49 characters: 29-37 */
        var res = 'Buttons';
        return res;
    }

    inline function get_string__1():String {
        /* declarations/view/MainView.xml:50 characters: 29-37 */
        var res = 'Text fields';
        return res;
    }

    inline function get_string__2():String {
        /* declarations/view/MainView.xml:51 characters: 29-37 */
        var res = 'Progress bar and Slider';
        return res;
    }

    inline function get_string__3():String {
        /* declarations/view/MainView.xml:52 characters: 29-37 */
        var res = 'Combo Box';
        return res;
    }

    inline function get_vectorListModel__0():org.aswing.VectorListModel {
        /* declarations/view/MainView.xml:48 characters: 25-40 */
        var res = new org.aswing.VectorListModel();
        res.append(get_string__0());
        res.append(get_string__1());
        res.append(get_string__2());
        res.append(get_string__3());
        return res;
    }

    inline function get_jList__0():org.aswing.JList {
        /* declarations/view/MainView.xml:37 characters: 17-22 */
        var res = new org.aswing.JList();
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
        res.preferredSize = get_intDimension__1();
        /* declarations/view/MainView.xml:47 characters: 21-26 */
        res.model = get_vectorListModel__0();
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/view/MainView.xml:30 characters: 13-20 */
        var res = new org.aswing.SoftBox();
        /* declarations/view/MainView.xml:30 characters: 22-33 */
        res.constraints = org.aswing.BorderLayout.WEST;
        res.append(get_jSpacer__0());
        res.append(get_jLabel__0());
        res.append(get_jList__0());
        return res;
    }

    inline function get_borderLayout__1():org.aswing.BorderLayout {
        /* declarations/view/MainView.xml:59 characters: 25-37 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_centerLayout__0():org.aswing.CenterLayout {
        /* declarations/view/MainView.xml:63 characters: 29-41 */
        var res = new org.aswing.CenterLayout();
        return res;
    }

    function set_buttonsView(value:view.ButtonsView):view.ButtonsView {
        buttonsView_initialized = true;
        return buttonsView = value;
    }

    function get_buttonsView():view.ButtonsView {
        /* declarations/view/MainView.xml:66 characters: 29-45 */
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
        /* declarations/view/MainView.xml:67 characters: 29-42 */
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

    inline function get_progressView__0():view.ProgressView {
        /* declarations/view/MainView.xml:68 characters: 29-46 */
        var res = new view.ProgressView();
        if (null != dataContext) { res.dataContext = this.dataContext.progressVM; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.dataContext = this.dataContext.progressVM;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.progressVM, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.progressVM, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.dataContext = this.dataContext.progressVM;
                                    bindSourceListener();
                                }
                            });
                        
        return res;
    }

    inline function get_comboBoxView__0():view.ComboBoxView {
        /* declarations/view/MainView.xml:69 characters: 29-46 */
        var res = new view.ComboBoxView();
        if (null != dataContext) { res.dataContext = this.dataContext.comboboxVM; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.dataContext = this.dataContext.comboboxVM;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.comboboxVM, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.comboboxVM, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.dataContext = this.dataContext.comboboxVM;
                                    bindSourceListener();
                                }
                            });
                        
        return res;
    }

    inline function get_spot__0():jive.Spot {
        /* declarations/view/MainView.xml:65 characters: 25-34 */
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
        res.append(get_progressView__0());
        res.append(get_comboBoxView__0());
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/view/MainView.xml:61 characters: 21-27 */
        var res = new org.aswing.JPanel();
        /* declarations/view/MainView.xml:61 characters: 29-40 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        /* declarations/view/MainView.xml:62 characters: 25-31 */
        res.layout = get_centerLayout__0();
        res.append(get_spot__0());
        return res;
    }

    inline function get_intDimension__2():org.aswing.geom.IntDimension {
        /* declarations/view/MainView.xml:74 characters: 29-46 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/MainView.xml:74 characters: 48-53 */
        res.width = 300;
        /* declarations/view/MainView.xml:74 characters: 60-66 */
        res.height = 300;
        return res;
    }

    inline function get_intDimension__3():org.aswing.geom.IntDimension {
        /* declarations/view/MainView.xml:78 characters: 33-50 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/view/MainView.xml:78 characters: 52-57 */
        res.width = 2000;
        /* declarations/view/MainView.xml:78 characters: 65-71 */
        res.height = 1000;
        return res;
    }

    inline function get_jTextArea__0():org.aswing.JTextArea {
        /* declarations/view/MainView.xml:76 characters: 25-34 */
        var res = new org.aswing.JTextArea();
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
                        
        /* declarations/view/MainView.xml:77 characters: 29-42 */
        res.preferredSize = get_intDimension__3();
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/view/MainView.xml:72 characters: 21-32 */
        var res = new org.aswing.JScrollPane();
        /* declarations/view/MainView.xml:72 characters: 34-45 */
        res.constraints = org.aswing.BorderLayout.SOUTH;
        /* declarations/view/MainView.xml:73 characters: 25-38 */
        res.preferredSize = get_intDimension__2();
        res.append(get_jTextArea__0());
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/view/MainView.xml:57 characters: 13-19 */
        var res = new org.aswing.JPanel();
        /* declarations/view/MainView.xml:57 characters: 21-32 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        /* declarations/view/MainView.xml:58 characters: 21-27 */
        res.layout = get_borderLayout__1();
        res.append(get_jPanel__0());
        res.append(get_jScrollPane__0());
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* declarations/view/MainView.xml:12 characters: 9-15 */
        var res = new org.aswing.JPanel();
        /* declarations/view/MainView.xml:13 characters: 13-19 */
        res.layout = get_borderLayout__0();
        /* declarations/view/MainView.xml:16 characters: 13-19 */
        res.border = get_emptyBorder__0();
        res.append(get_jMenuBar__0());
        res.append(get_softBox__0());
        res.append(get_jPanel__1());
        return res;
    }

    public function new() {
        /* declarations/view/MainView.xml:2 characters: 1-8 */
        super();
        /* declarations/view/MainView.xml:9 characters: 9-22 */
        this.defaultButton = buttonsView.defButton;
        /* declarations/view/MainView.xml:11 characters: 5-12 */
        this.content.append(get_jPanel__2());
    }
}
