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
        res.hgap = 30;
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

    inline function get_string__4():String {
        /* declarations/demo/view/DemoView.xml:33 characters: 21-29 */
        var res = 'Accordion';
        return res;
    }

    inline function get_string__5():String {
        /* declarations/demo/view/DemoView.xml:34 characters: 21-29 */
        var res = 'Frame/Dialog';
        return res;
    }

    inline function get_vectorListModel__0():org.aswing.VectorListModel {
        /* declarations/demo/view/DemoView.xml:28 characters: 17-32 */
        var res = new org.aswing.VectorListModel();
        res.append(get_string__0());
        res.append(get_string__1());
        res.append(get_string__2());
        res.append(get_string__3());
        res.append(get_string__4());
        res.append(get_string__5());
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

    inline function get_intDimension__1():org.aswing.geom.IntDimension {
        /* declarations/demo/view/DemoView.xml:40 characters: 17-34 */
        var res = new org.aswing.geom.IntDimension();
        /* declarations/demo/view/DemoView.xml:40 characters: 36-41 */
        res.width = 20;
        /* declarations/demo/view/DemoView.xml:40 characters: 47-53 */
        res.height = 20;
        return res;
    }

    inline function get_jSpacer__0():org.aswing.JSpacer {
        /* declarations/demo/view/DemoView.xml:39 characters: 13-20 */
        var res = new org.aswing.JSpacer();
        /* declarations/demo/view/DemoView.xml:39 characters: 22-35 */
        res.preferredSize = get_intDimension__1();
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/demo/view/DemoView.xml:42 characters: 13-19 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/DemoView.xml:42 characters: 38-57 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/DemoView.xml:42 characters: 21-25 */
        res.text = 'Others:';
        return res;
    }

    inline function get_openLinkCommand__0():jive.OpenLinkCommand {
        /* declarations/demo/view/DemoView.xml:45 characters: 21-41 */
        var res = new jive.OpenLinkCommand();
        /* declarations/demo/view/DemoView.xml:45 characters: 43-46 */
        res.url = '/jive/flash.html';
        return res;
    }

    inline function get_jLabelButton__0():org.aswing.JLabelButton {
        /* declarations/demo/view/DemoView.xml:43 characters: 13-25 */
        var res = new org.aswing.JLabelButton();
        /* declarations/demo/view/DemoView.xml:43 characters: 47-66 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/DemoView.xml:43 characters: 27-31 */
        res.text = 'Flash Demo';
        /* declarations/demo/view/DemoView.xml:44 characters: 17-24 */
        res.command = get_openLinkCommand__0();
        return res;
    }

    inline function get_openLinkCommand__1():jive.OpenLinkCommand {
        /* declarations/demo/view/DemoView.xml:50 characters: 21-41 */
        var res = new jive.OpenLinkCommand();
        /* declarations/demo/view/DemoView.xml:50 characters: 43-46 */
        res.url = '/jive/demos/jive-demo.zip';
        return res;
    }

    inline function get_jLabelButton__1():org.aswing.JLabelButton {
        /* declarations/demo/view/DemoView.xml:48 characters: 13-25 */
        var res = new org.aswing.JLabelButton();
        /* declarations/demo/view/DemoView.xml:48 characters: 49-68 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/DemoView.xml:48 characters: 27-31 */
        res.text = 'Windows Demo';
        /* declarations/demo/view/DemoView.xml:49 characters: 17-24 */
        res.command = get_openLinkCommand__1();
        return res;
    }

    inline function get_openLinkCommand__2():jive.OpenLinkCommand {
        /* declarations/demo/view/DemoView.xml:56 characters: 21-41 */
        var res = new jive.OpenLinkCommand();
        /* declarations/demo/view/DemoView.xml:56 characters: 43-46 */
        res.url = '/jive/demos/jive-demo.dmg';
        return res;
    }

    inline function get_jLabelButton__2():org.aswing.JLabelButton {
        /* declarations/demo/view/DemoView.xml:54 characters: 13-25 */
        var res = new org.aswing.JLabelButton();
        /* declarations/demo/view/DemoView.xml:54 characters: 45-64 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/DemoView.xml:54 characters: 27-31 */
        res.text = 'OSX Demo';
        /* declarations/demo/view/DemoView.xml:55 characters: 17-24 */
        res.command = get_openLinkCommand__2();
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/DemoView.xml:38 characters: 9-16 */
        var res = new org.aswing.SoftBox();
        if (null != dataContext) { res.visibility = this.dataContext.areLinksVisible; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.visibility = this.dataContext.areLinksVisible;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.areLinksVisible, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.areLinksVisible, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.visibility = this.dataContext.areLinksVisible;
                                    bindSourceListener();
                                }
                            });
                        
        res.append(get_jSpacer__0());
        res.append(get_jLabel__0());
        res.append(get_jLabelButton__0());
        res.append(get_jLabelButton__1());
        res.append(get_jLabelButton__2());
        return res;
    }

    inline function get_softBox__1():org.aswing.SoftBox {
        /* declarations/demo/view/DemoView.xml:16 characters: 5-12 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/DemoView.xml:16 characters: 14-25 */
        res.constraints = org.aswing.BorderLayout.WEST;
        res.append(get_jList__0());
        res.append(get_softBox__0());
        return res;
    }

    inline function get_boxLayout__0():org.aswing.BoxLayout {
        /* declarations/demo/view/DemoView.xml:66 characters: 13-22 */
        var res = new org.aswing.BoxLayout();
        return res;
    }

    function set_buttonsView(value:demo.view.ButtonsView):demo.view.ButtonsView {
        buttonsView_initialized = true;
        return buttonsView = value;
    }

    function get_buttonsView():demo.view.ButtonsView {
        /* declarations/demo/view/DemoView.xml:68 characters: 9-25 */
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
        /* declarations/demo/view/DemoView.xml:69 characters: 9-22 */
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
        /* declarations/demo/view/DemoView.xml:70 characters: 9-26 */
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
        /* declarations/demo/view/DemoView.xml:71 characters: 9-26 */
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

    inline function get_accordionView__0():demo.view.AccordionView {
        /* declarations/demo/view/DemoView.xml:72 characters: 9-27 */
        var res = new demo.view.AccordionView();
        if (null != dataContext) { res.dataContext = this.dataContext.accordionVM; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.dataContext = this.dataContext.accordionVM;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.accordionVM, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.accordionVM, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.dataContext = this.dataContext.accordionVM;
                                    bindSourceListener();
                                }
                            });
                        
        return res;
    }

    inline function get_frameView__0():demo.view.FrameView {
        /* declarations/demo/view/DemoView.xml:73 characters: 9-23 */
        var res = new demo.view.FrameView();
        if (null != dataContext) { res.dataContext = this.dataContext.frameVM; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.dataContext = this.dataContext.frameVM;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.frameVM, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.frameVM, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.dataContext = this.dataContext.frameVM;
                                    bindSourceListener();
                                }
                            });
                        
        return res;
    }

    inline function get_spot__0():jive.Spot {
        /* declarations/demo/view/DemoView.xml:64 characters: 5-14 */
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
                        
        /* declarations/demo/view/DemoView.xml:64 characters: 60-71 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        /* declarations/demo/view/DemoView.xml:65 characters: 9-15 */
        res.layout = get_boxLayout__0();
        res.append(buttonsView);
        res.append(get_textView__0());
        res.append(get_progressView__0());
        res.append(get_comboBoxView__0());
        res.append(get_accordionView__0());
        res.append(get_frameView__0());
        return res;
    }

    public function new() {
        /* declarations/demo/view/DemoView.xml:2 characters: 1-7 */
        super();
        /* declarations/demo/view/DemoView.xml:11 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_softBox__1());
        this.append(get_spot__0());
    }
}
