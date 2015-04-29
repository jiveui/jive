package demo.view;

class MainView extends org.aswing.JWindow implements jive.DataContextControllable<demo.viewmodel.MainViewModel> {

    var demoView_initialized:Bool = false;

    @:isVar public var demoView(get, set):demo.view.DemoView;

    public function destroyHml():Void {
        
    }
    

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/MainView.xml:12 characters: 17-35 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/MainView.xml:12 characters: 37-40 */
        res.top = 20;
        /* declarations/demo/view/MainView.xml:12 characters: 68-73 */
        res.right = 20;
        /* declarations/demo/view/MainView.xml:12 characters: 56-62 */
        res.bottom = 20;
        /* declarations/demo/view/MainView.xml:12 characters: 46-50 */
        res.left = 20;
        return res;
    }

    function set_demoView(value:demo.view.DemoView):demo.view.DemoView {
        demoView_initialized = true;
        return demoView = value;
    }

    function get_demoView():demo.view.DemoView {
        /* declarations/demo/view/MainView.xml:14 characters: 13-26 */
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

    inline function get_box__0():org.aswing.Box {
        /* declarations/demo/view/MainView.xml:10 characters: 9-12 */
        var res = new org.aswing.Box();
        /* declarations/demo/view/MainView.xml:11 characters: 13-19 */
        res.border = get_emptyBorder__0();
        res.append(demoView);
        return res;
    }

    public function new() {
        /* declarations/demo/view/MainView.xml:2 characters: 1-8 */
        super();
        /* declarations/demo/view/MainView.xml:6 characters: 10-23 */
        this.defaultButton = demoView.buttonsView.defButton;
        /* declarations/demo/view/MainView.xml:9 characters: 5-12 */
        this.content.append(get_box__0());
    }
}
