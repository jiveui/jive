package demo.view;

class DemoView extends org.aswing.JPanel implements jive.DataContextControllable<demo.viewmodel.DemoViewModel> {

    var buttonsView_initialized:Bool = false;

    @:isVar public var buttonsView(get, set):demo.view.ButtonsView;

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/demo/view/DemoView.xml:12 characters: 9-21 */
        var res = new org.aswing.BorderLayout();
        /* declarations/demo/view/DemoView.xml:12 characters: 23-27 */
        res.hgap = 50;
        /* declarations/demo/view/DemoView.xml:12 characters: 33-37 */
        res.vgap = 30;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/demo/view/DemoView.xml:19 characters: 17-24 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/DemoView.xml:19 characters: 26-29 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_aSColor__1():org.aswing.ASColor {
        /* declarations/demo/view/DemoView.xml:22 characters: 17-24 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/DemoView.xml:22 characters: 26-29 */
        res.rgb = 0x34495e;
        return res;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* declarations/demo/view/DemoView.xml:25 characters: 17-34 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/DemoView.xml:25 characters: 36-41 */
        res.width = 200;
        /* declarations/demo/view/DemoView.xml:25 characters: 48-54 */
        res.height = -1;
        return res;
    }

    inline function get_string__0():String {
        /* declarations/demo/view/DemoView.xml:29 characters: 21-29 */
        var res = 'Buttons';
        return res;
    }

    inline function get_string__1():String {
        /* declarations/demo/view/DemoView.xml:30 characters: 21-29 */
        var res = 'Text fields';
        return res;
    }

    inline function get_string__2():String {
        /* declarations/demo/view/DemoView.xml:31 characters: 21-29 */
        var res = 'Progress bar and Slider';
        return res;
    }

    inline function get_string__3():String {
        /* declarations/demo/view/DemoView.xml:32 characters: 21-29 */
        var res = 'Combo Box';
        return res;
    }

    inline function get_vectorListModel__0():org.aswing.VectorListModel {
        /* declarations/demo/view/DemoView.xml:28 characters: 17-32 */
        var res = new org.aswing.VectorListModel();
        res.append(get_string__0());
        res.append(get_string__1());
        res.append(get_string__2());
        res.append(get_string__3());
        return res;
    }

    inline function get_jList__0():org.aswing.JList {
        /* declarations/demo/view/DemoView.xml:17 characters: 9-14 */
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
        /* declarations/demo/view/DemoView.xml:18 characters: 13-23 */
        res.background = get_aSColor__0();
        /* declarations/demo/view/DemoView.xml:21 characters: 13-32 */
        res.selectionBackground = get_aSColor__1();
        /* declarations/demo/view/DemoView.xml:24 characters: 13-26 */
        res.preferredSize = get_intDimension__0();
        /* declarations/demo/view/DemoView.xml:27 characters: 13-18 */
        res.model = get_vectorListModel__0();
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/DemoView.xml:16 characters: 5-12 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/DemoView.xml:16 characters: 14-25 */
        res.constraints = org.aswing.BorderLayout.WEST;
        res.append(get_jList__0());
        return res;
    }

    inline function get_boxLayout__0():org.aswing.BoxLayout {
        /* declarations/demo/view/DemoView.xml:41 characters: 13-22 */
        var res = new org.aswing.BoxLayout();
        return res;
    }

    function set_buttonsView(value:demo.view.ButtonsView):demo.view.ButtonsView {
        buttonsView_initialized = true;
        return buttonsView = value;
    }

    function get_buttonsView():demo.view.ButtonsView {
        /* declarations/demo/view/DemoView.xml:43 characters: 9-25 */
        if (buttonsView_initialized) return buttonsView;
        buttonsView_initialized = true;
        this.buttonsView = new demo.view.ButtonsView();
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

    inline function get_textView__0():demo.view.TextView {
        /* declarations/demo/view/DemoView.xml:44 characters: 9-22 */
        var res = new demo.view.TextView();
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

    inline function get_progressView__0():demo.view.ProgressView {
        /* declarations/demo/view/DemoView.xml:45 characters: 9-26 */
        var res = new demo.view.ProgressView();
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

    inline function get_comboBoxView__0():demo.view.ComboBoxView {
        /* declarations/demo/view/DemoView.xml:46 characters: 9-26 */
        var res = new demo.view.ComboBoxView();
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
        /* declarations/demo/view/DemoView.xml:39 characters: 5-14 */
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
                        
        /* declarations/demo/view/DemoView.xml:39 characters: 60-71 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        /* declarations/demo/view/DemoView.xml:40 characters: 9-15 */
        res.layout = get_boxLayout__0();
        res.append(buttonsView);
        res.append(get_textView__0());
        res.append(get_progressView__0());
        res.append(get_comboBoxView__0());
        return res;
    }

    public function new() {
        /* declarations/demo/view/DemoView.xml:2 characters: 1-7 */
        super();
        /* declarations/demo/view/DemoView.xml:11 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_softBox__0());
        this.append(get_spot__0());
    }
}
