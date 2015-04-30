package view;

class MainView extends org.aswing.JWindow implements jive.DataContextControllable<viewmodel.MainViewModel> {

    public function destroyHml():Void {
        
    }
    

    inline function get_centerLayout__0():org.aswing.CenterLayout {
        /* declarations/mobile/view/MainView.xml:14 characters: 17-29 */
        var res = new org.aswing.CenterLayout();
        return res;
    }

    inline function get_assetIcon__0():org.aswing.AssetIcon {
        /* declarations/mobile/view/MainView.xml:19 characters: 25-34 */
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
                        
        /* declarations/mobile/view/MainView.xml:19 characters: 63-68 */
        res.width = 240;
        /* declarations/mobile/view/MainView.xml:19 characters: 75-81 */
        res.height = 150;
        /* declarations/mobile/view/MainView.xml:19 characters: 88-93 */
        res.scale = true;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/mobile/view/MainView.xml:17 characters: 17-23 */
        var res = new org.aswing.JLabel();
        /* declarations/mobile/view/MainView.xml:18 characters: 21-25 */
        res.icon = get_assetIcon__0();
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/mobile/view/MainView.xml:22 characters: 17-23 */
        var res = new org.aswing.JLabel();
        /* declarations/mobile/view/MainView.xml:22 characters: 25-29 */
        res.text = 'Cross-platform UI framework for Haxe';
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/mobile/view/MainView.xml:23 characters: 17-23 */
        var res = new org.aswing.JLabel();
        /* declarations/mobile/view/MainView.xml:23 characters: 25-29 */
        res.text = 'The Mobile version is coming!';
        return res;
    }

    inline function get_jButton__0():org.aswing.JButton {
        /* declarations/mobile/view/MainView.xml:24 characters: 17-24 */
        var res = new org.aswing.JButton();
        /* declarations/mobile/view/MainView.xml:24 characters: 26-30 */
        res.text = 'Take a look at GitHub';
        return res;
    }

    inline function get_jLabel__3():org.aswing.JLabel {
        /* declarations/mobile/view/MainView.xml:25 characters: 17-23 */
        var res = new org.aswing.JLabel();
        /* declarations/mobile/view/MainView.xml:25 characters: 25-29 */
        res.text = 'Or use desktop browser, please.';
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/mobile/view/MainView.xml:16 characters: 13-20 */
        var res = new org.aswing.SoftBox();
        res.append(get_jLabel__0());
        res.append(get_jLabel__1());
        res.append(get_jLabel__2());
        res.append(get_jButton__0());
        res.append(get_jLabel__3());
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/mobile/view/MainView.xml:12 characters: 9-15 */
        var res = new org.aswing.JPanel();
        /* declarations/mobile/view/MainView.xml:13 characters: 13-19 */
        res.layout = get_centerLayout__0();
        res.append(get_softBox__0());
        return res;
    }

    public function new() {
        /* declarations/mobile/view/MainView.xml:2 characters: 1-8 */
        super();
        /* declarations/mobile/view/MainView.xml:11 characters: 5-12 */
        this.content.append(get_jPanel__0());
    }
}
