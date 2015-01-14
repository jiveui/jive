package ;

class EventPanel extends org.aswing.JPanel implements jive.DataContextControllable<view.EventPanelModel> {

    var title_initialized:Bool = false;

    @:isVar public var title(get, set):org.aswing.JTextField;

    var dateText_initialized:Bool = false;

    @:isVar public var dateText(get, set):org.aswing.JTextField;

    var datePopup_initialized:Bool = false;

    @:isVar public var datePopup(get, set):org.aswing.JPopup;

    var date_initialized:Bool = false;

    @:isVar public var date(get, set):org.aswing.ext.DateChooser;

    var category_initialized:Bool = false;

    @:isVar public var category(get, set):org.aswing.JComboBox;

    var notes_initialized:Bool = false;

    @:isVar public var notes(get, set):org.aswing.JTextArea;

    var notes1_initialized:Bool = false;

    @:isVar public var notes1(get, set):org.aswing.JTextArea;

    public function destroyHml():Void {
        
    }
    

    inline function get_gridLayout__0():org.aswing.GridLayout {
        /* view/EventPanel.xml:10 characters: 13-23 */
        var res = new org.aswing.GridLayout();
        /* view/EventPanel.xml:10 characters: 34-41 */
        res.columns = 3;
        /* view/EventPanel.xml:10 characters: 46-50 */
        res.hgap = 20;
        /* view/EventPanel.xml:10 characters: 56-60 */
        res.vgap = 20;
        /* view/EventPanel.xml:10 characters: 25-29 */
        res.rows = 3;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* view/EventPanel.xml:12 characters: 9-15 */
        var res = new org.aswing.JLabel();
        /* view/EventPanel.xml:12 characters: 17-21 */
        res.text = 'Название';
        return res;
    }

    function set_title(value:org.aswing.JTextField):org.aswing.JTextField {
        title_initialized = true;
        return title = value;
    }

    function get_title():org.aswing.JTextField {
        /* view/EventPanel.xml:13 characters: 9-19 */
        if (title_initialized) return title;
        title_initialized = true;
        this.title = new org.aswing.JTextField();
        var res = this.title;
        if (null != dataContext) { res.columns = this.dataContext.columns; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.columns = this.dataContext.columns;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.columns, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.columns, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.columns = this.dataContext.columns;
                                    bindSourceListener();
                                }
                            });
                        
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* view/EventPanel.xml:15 characters: 9-15 */
        var res = new org.aswing.JLabel();
        /* view/EventPanel.xml:15 characters: 17-21 */
        res.text = 'Дата';
        return res;
    }

    function set_dateText(value:org.aswing.JTextField):org.aswing.JTextField {
        dateText_initialized = true;
        return dateText = value;
    }

    function get_dateText():org.aswing.JTextField {
        /* view/EventPanel.xml:16 characters: 9-19 */
        if (dateText_initialized) return dateText;
        dateText_initialized = true;
        this.dateText = new org.aswing.JTextField();
        var res = this.dateText;
        /* view/EventPanel.xml:16 characters: 35-42 */
        res.columns = 10;
        return res;
    }

    inline function get_mouseDown__0():flash.events.MouseEvent -> StdTypes.Void {
        /* view/EventPanel.xml:17 characters: 41-50 */
        var res = function (event:flash.events.MouseEvent):StdTypes.Void { datePopup.show(); };
        return res;
    }

    inline function get_jButton__0():org.aswing.JButton {
        /* view/EventPanel.xml:17 characters: 9-16 */
        var res = new org.aswing.JButton();
        if (null != dataContext) { res.text = this.dataContext.notes; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.notes;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.notes, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.notes, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.notes;
                                    bindSourceListener();
                                }
                            });
                        
        res.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, get_mouseDown__0());
        return res;
    }

    function set_datePopup(value:org.aswing.JPopup):org.aswing.JPopup {
        datePopup_initialized = true;
        return datePopup = value;
    }

    inline function get_intDimension__0():org.aswing.geom.IntDimension {
        /* view/EventPanel.xml:20 characters: 26-43 */
        var res = new org.aswing.geom.IntDimension();
        /* view/EventPanel.xml:20 characters: 45-50 */
        res.width = 250;
        /* view/EventPanel.xml:20 characters: 57-63 */
        res.height = 250;
        return res;
    }

    function set_date(value:org.aswing.ext.DateChooser):org.aswing.ext.DateChooser {
        date_initialized = true;
        return date = value;
    }

    function get_date():org.aswing.ext.DateChooser {
        /* view/EventPanel.xml:22 characters: 17-32 */
        if (date_initialized) return date;
        date_initialized = true;
        this.date = new org.aswing.ext.DateChooser();
        var res = this.date;
        return res;
    }

    inline function get_mouseDown__1():flash.events.MouseEvent -> StdTypes.Void {
        /* view/EventPanel.xml:23 characters: 41-50 */
        var res = function (event:flash.events.MouseEvent):StdTypes.Void { datePopup.hide(); };
        return res;
    }

    inline function get_jButton__1():org.aswing.JButton {
        /* view/EventPanel.xml:23 characters: 17-24 */
        var res = new org.aswing.JButton();
        /* view/EventPanel.xml:23 characters: 26-30 */
        res.text = 'Close';
        res.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, get_mouseDown__1());
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* view/EventPanel.xml:21 characters: 13-19 */
        var res = new org.aswing.JPanel();
        res.append(date);
        res.append(get_jButton__1());
        return res;
    }

    function get_datePopup():org.aswing.JPopup {
        /* view/EventPanel.xml:19 characters: 9-15 */
        if (datePopup_initialized) return datePopup;
        datePopup_initialized = true;
        this.datePopup = new org.aswing.JPopup();
        var res = this.datePopup;
        /* view/EventPanel.xml:20 characters: 13-24 */
        res.currentSize = get_intDimension__0();
        res.append(get_jPanel__0());
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* view/EventPanel.xml:11 characters: 5-11 */
        var res = new org.aswing.JPanel();
        res.append(get_jLabel__0());
        res.append(title);
        res.append(get_jLabel__1());
        res.append(dateText);
        res.append(get_jButton__0());
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* view/EventPanel.xml:28 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* view/EventPanel.xml:28 characters: 13-17 */
        res.text = 'Категория';
        return res;
    }

    function set_category(value:org.aswing.JComboBox):org.aswing.JComboBox {
        category_initialized = true;
        return category = value;
    }

    function get_category():org.aswing.JComboBox {
        /* view/EventPanel.xml:29 characters: 5-14 */
        if (category_initialized) return category;
        category_initialized = true;
        this.category = new org.aswing.JComboBox();
        var res = this.category;
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* view/EventPanel.xml:32 characters: 17-35 */
        var res = new org.aswing.border.EmptyBorder();
        /* view/EventPanel.xml:32 characters: 37-40 */
        res.top = 20;
        /* view/EventPanel.xml:32 characters: 68-73 */
        res.right = 20;
        /* view/EventPanel.xml:32 characters: 56-62 */
        res.bottom = 20;
        /* view/EventPanel.xml:32 characters: 46-50 */
        res.left = 20;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* view/EventPanel.xml:33 characters: 21-28 */
        var res = new org.aswing.ASColor();
        /* view/EventPanel.xml:33 characters: 45-50 */
        res.alpha = 0.5;
        /* view/EventPanel.xml:33 characters: 30-33 */
        res.rgb = 0x00ff00;
        return res;
    }

    inline function get_jLabel__3():org.aswing.JLabel {
        /* view/EventPanel.xml:35 characters: 9-15 */
        var res = new org.aswing.JLabel();
        /* view/EventPanel.xml:35 characters: 17-21 */
        res.text = 'Заметки';
        return res;
    }

    function set_notes(value:org.aswing.JTextArea):org.aswing.JTextArea {
        notes_initialized = true;
        return notes = value;
    }

    function get_notes():org.aswing.JTextArea {
        /* view/EventPanel.xml:36 characters: 9-18 */
        if (notes_initialized) return notes;
        notes_initialized = true;
        this.notes = new org.aswing.JTextArea();
        var res = this.notes;
        if (null != dataContext) { res.text = this.dataContext.notes; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.notes;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.notes, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.notes, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.notes;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.notes = res.text;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.text, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.notes = res.text;
                                }
                            });
        /* view/EventPanel.xml:36 characters: 31-38 */
        res.columns = 60;
        /* view/EventPanel.xml:36 characters: 44-48 */
        res.rows = 10;
        return res;
    }

    function set_notes1(value:org.aswing.JTextArea):org.aswing.JTextArea {
        notes1_initialized = true;
        return notes1 = value;
    }

    function get_notes1():org.aswing.JTextArea {
        /* view/EventPanel.xml:37 characters: 9-18 */
        if (notes1_initialized) return notes1;
        notes1_initialized = true;
        this.notes1 = new org.aswing.JTextArea();
        var res = this.notes1;
        if (null != dataContext) { res.text = this.dataContext.notes; }
        /* view/EventPanel.xml:37 characters: 32-39 */
        res.columns = 10;
        /* view/EventPanel.xml:37 characters: 45-49 */
        res.rows = 5;
        return res;
    }

    inline function get_mouseDown__2():flash.events.MouseEvent -> StdTypes.Void {
        /* view/EventPanel.xml:38 characters: 18-27 */
        var res = function (event:flash.events.MouseEvent):StdTypes.Void { trace('dataContext.notes=' + dataContext.notes); };
        return res;
    }

    inline function get_jButton__2():org.aswing.JButton {
        /* view/EventPanel.xml:38 characters: 9-16 */
        var res = new org.aswing.JButton();
        /* view/EventPanel.xml:38 characters: 78-82 */
        res.text = 'Show dataContext.notes on the error console';
        res.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, get_mouseDown__2());
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* view/EventPanel.xml:31 characters: 5-11 */
        var res = new org.aswing.JPanel();
        /* view/EventPanel.xml:31 characters: 52-57 */
        res.alpha = 0.5;
        /* view/EventPanel.xml:31 characters: 27-32 */
        res.width = 200;
        /* view/EventPanel.xml:31 characters: 39-45 */
        res.height = 300;
        /* view/EventPanel.xml:31 characters: 13-14 */
        res.x = 10;
        /* view/EventPanel.xml:31 characters: 20-21 */
        res.y = 20;
        /* view/EventPanel.xml:32 characters: 9-15 */
        res.border = get_emptyBorder__0();
        /* view/EventPanel.xml:33 characters: 9-19 */
        res.background = get_aSColor__0();
        /* view/EventPanel.xml:34 characters: 9-15 */
        res.opaque = true;
        res.append(get_jLabel__3());
        res.append(notes);
        res.append(notes1);
        res.append(get_jButton__2());
        return res;
    }

    public function new() {
        /* view/EventPanel.xml:2 characters: 1-7 */
        super();
        /* view/EventPanel.xml:10 characters: 5-11 */
        this.layout = get_gridLayout__0();
        this.append(get_jPanel__1());
        this.append(get_jLabel__2());
        this.append(category);
        this.append(get_jPanel__2());
    }
}
