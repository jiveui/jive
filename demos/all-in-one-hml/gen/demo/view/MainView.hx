package demo.view;

class MainView extends org.aswing.JWindow implements jive.DataContextControllable<demo.viewmodel.MainViewModel> {

    var demoView_initialized:Bool = false;

    @:isVar public var demoView(get, set):demo.view.DemoView;

    public function destroyHml():Void {
        
    }
    

    function set_demoView(value:demo.view.DemoView):demo.view.DemoView {
        demoView_initialized = true;
        return demoView = value;
    }

    function get_demoView():demo.view.DemoView {
        /* declarations/demo/view/MainView.xml:9 characters: 9-22 */
        if (demoView_initialized) return demoView;
        demoView_initialized = true;
        this.demoView = new demo.view.DemoView();
        var res = this.demoView;
        if (null != dataContext) { res.dataContext = this.dataContext.demoVM; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.dataContext = this.dataContext.demoVM;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.demoVM, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.demoVM, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.dataContext = this.dataContext.demoVM;
                                    bindSourceListener();
                                }
                            });
                        
        return res;
    }

    public function new() {
        /* declarations/demo/view/MainView.xml:2 characters: 1-8 */
        super();
        /* declarations/demo/view/MainView.xml:5 characters: 10-23 */
        this.defaultButton = demoView.buttonsView.defButton;
        /* declarations/demo/view/MainView.xml:8 characters: 5-12 */
        this.content.append(demoView);
    }
}
