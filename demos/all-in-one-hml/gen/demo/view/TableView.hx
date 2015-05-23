package demo.view;

class TableView extends org.aswing.JPanel implements jive.DataContextControllable<demo.viewmodel.TableViewModel> {

    var tableHeader_initialized:Bool = false;

    @:isVar public var tableHeader(get, set):org.aswing.table.JTableHeader;

    var columnModel_initialized:Bool = false;

    @:isVar public var columnModel(get, set):org.aswing.table.DefaultTableColumnModel;

    public function destroyHml():Void {
        
    }
    

    inline function get_borderLayout__0():org.aswing.BorderLayout {
        /* declarations/demo/view/TableView.xml:14 characters: 9-21 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_aSFont__0():org.aswing.ASFont {
        /* declarations/demo/view/TableView.xml:18 characters: 13-19 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/TableView.xml:18 characters: 51-55 */
        res.size = 30;
        /* declarations/demo/view/TableView.xml:18 characters: 21-25 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__0():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/TableView.xml:21 characters: 13-31 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/TableView.xml:21 characters: 33-39 */
        res.bottom = 30;
        return res;
    }

    inline function get_jLabel__0():org.aswing.JLabel {
        /* declarations/demo/view/TableView.xml:16 characters: 5-11 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/TableView.xml:16 characters: 28-47 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/TableView.xml:16 characters: 13-17 */
        res.text = 'Table';
        /* declarations/demo/view/TableView.xml:16 characters: 82-93 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/demo/view/TableView.xml:17 characters: 9-13 */
        res.font = get_aSFont__0();
        /* declarations/demo/view/TableView.xml:20 characters: 9-15 */
        res.border = get_emptyBorder__0();
        return res;
    }

    inline function get_borderLayout__1():org.aswing.BorderLayout {
        /* declarations/demo/view/TableView.xml:30 characters: 25-37 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    inline function get_aSFont__1():org.aswing.ASFont {
        /* declarations/demo/view/TableView.xml:34 characters: 29-35 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/TableView.xml:34 characters: 67-71 */
        res.size = 18;
        /* declarations/demo/view/TableView.xml:34 characters: 37-41 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_emptyBorder__1():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/TableView.xml:37 characters: 29-47 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/TableView.xml:37 characters: 49-52 */
        res.top = 15;
        /* declarations/demo/view/TableView.xml:37 characters: 58-64 */
        res.bottom = 15;
        return res;
    }

    inline function get_jLabel__1():org.aswing.JLabel {
        /* declarations/demo/view/TableView.xml:32 characters: 21-27 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/TableView.xml:32 characters: 78-97 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/TableView.xml:32 characters: 29-33 */
        res.text = 'TIOBE Index for May 2015, www.tiobe.com';
        /* declarations/demo/view/TableView.xml:32 characters: 132-143 */
        res.constraints = org.aswing.BorderLayout.NORTH;
        /* declarations/demo/view/TableView.xml:33 characters: 25-29 */
        res.font = get_aSFont__1();
        /* declarations/demo/view/TableView.xml:36 characters: 25-31 */
        res.border = get_emptyBorder__1();
        return res;
    }

    inline function get_borderLayout__2():org.aswing.BorderLayout {
        /* declarations/demo/view/TableView.xml:42 characters: 29-41 */
        var res = new org.aswing.BorderLayout();
        return res;
    }

    function set_tableHeader(value:org.aswing.table.JTableHeader):org.aswing.table.JTableHeader {
        tableHeader_initialized = true;
        return tableHeader = value;
    }

    function get_tableHeader():org.aswing.table.JTableHeader {
        /* declarations/demo/view/TableView.xml:47 characters: 37-55 */
        if (tableHeader_initialized) return tableHeader;
        tableHeader_initialized = true;
        this.tableHeader = new org.aswing.table.JTableHeader();
        var res = this.tableHeader;
        /* declarations/demo/view/TableView.xml:47 characters: 74-85 */
        res.columnModel = columnModel;
        /* declarations/demo/view/TableView.xml:47 characters: 100-109 */
        res.rowHeight = 40;
        return res;
    }

    function set_columnModel(value:org.aswing.table.DefaultTableColumnModel):org.aswing.table.DefaultTableColumnModel {
        columnModel_initialized = true;
        return columnModel = value;
    }

    inline function get_tableColumn__0():org.aswing.table.TableColumn {
        /* declarations/demo/view/TableView.xml:51 characters: 41-58 */
        var res = new org.aswing.table.TableColumn();
        /* declarations/demo/view/TableView.xml:51 characters: 110-118 */
        res.maxWidth = 80;
        /* declarations/demo/view/TableView.xml:51 characters: 60-70 */
        res.modelIndex = 0;
        /* declarations/demo/view/TableView.xml:51 characters: 96-104 */
        res.minWidth = 80;
        /* declarations/demo/view/TableView.xml:51 characters: 75-86 */
        res.headerValue = '2015';
        return res;
    }

    inline function get_tableColumn__1():org.aswing.table.TableColumn {
        /* declarations/demo/view/TableView.xml:52 characters: 41-58 */
        var res = new org.aswing.table.TableColumn();
        /* declarations/demo/view/TableView.xml:52 characters: 110-118 */
        res.maxWidth = 80;
        /* declarations/demo/view/TableView.xml:52 characters: 60-70 */
        res.modelIndex = 1;
        /* declarations/demo/view/TableView.xml:52 characters: 96-104 */
        res.minWidth = 80;
        /* declarations/demo/view/TableView.xml:52 characters: 75-86 */
        res.headerValue = '2014';
        return res;
    }

    inline function get_tableColumn__2():org.aswing.table.TableColumn {
        /* declarations/demo/view/TableView.xml:53 characters: 41-58 */
        var res = new org.aswing.table.TableColumn();
        /* declarations/demo/view/TableView.xml:53 characters: 60-70 */
        res.modelIndex = 2;
        /* declarations/demo/view/TableView.xml:53 characters: 75-86 */
        res.headerValue = 'Programming language';
        return res;
    }

    inline function get_tableColumn__3():org.aswing.table.TableColumn {
        /* declarations/demo/view/TableView.xml:54 characters: 41-58 */
        var res = new org.aswing.table.TableColumn();
        /* declarations/demo/view/TableView.xml:54 characters: 116-124 */
        res.maxWidth = 120;
        /* declarations/demo/view/TableView.xml:54 characters: 60-70 */
        res.modelIndex = 3;
        /* declarations/demo/view/TableView.xml:54 characters: 101-109 */
        res.minWidth = 120;
        /* declarations/demo/view/TableView.xml:54 characters: 75-86 */
        res.headerValue = 'Rating, %';
        return res;
    }

    inline function get_tableColumn__4():org.aswing.table.TableColumn {
        /* declarations/demo/view/TableView.xml:55 characters: 41-58 */
        var res = new org.aswing.table.TableColumn();
        /* declarations/demo/view/TableView.xml:55 characters: 116-124 */
        res.maxWidth = 120;
        /* declarations/demo/view/TableView.xml:55 characters: 60-70 */
        res.modelIndex = 4;
        /* declarations/demo/view/TableView.xml:55 characters: 101-109 */
        res.minWidth = 120;
        /* declarations/demo/view/TableView.xml:55 characters: 75-86 */
        res.headerValue = 'Change, %';
        return res;
    }

    function get_columnModel():org.aswing.table.DefaultTableColumnModel {
        /* declarations/demo/view/TableView.xml:50 characters: 37-66 */
        if (columnModel_initialized) return columnModel;
        columnModel_initialized = true;
        this.columnModel = new org.aswing.table.DefaultTableColumnModel();
        var res = this.columnModel;
        res.addColumn(get_tableColumn__0());
        res.addColumn(get_tableColumn__1());
        res.addColumn(get_tableColumn__2());
        res.addColumn(get_tableColumn__3());
        res.addColumn(get_tableColumn__4());
        return res;
    }

    inline function get_propertyTableModel__0():org.aswing.table.PropertyTableModel {
        /* declarations/demo/view/TableView.xml:61 characters: 45-69 */
        var res = new org.aswing.table.PropertyTableModel();
        if (null != dataContext) { res.list = this.dataContext.languages; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.list = this.dataContext.languages;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.languages, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.languages, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.list = this.dataContext.languages;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/TableView.xml:64 characters: 53-66 */
        res.columnClasses = ['Number', 'Number', null, 'Number', 'Number'];
        /* declarations/demo/view/TableView.xml:62 characters: 53-68 */
        res.columnsEditable = [false, false, false, false, false];
        /* declarations/demo/view/TableView.xml:63 characters: 53-63 */
        res.properties = ['position', 'prevPosition', 'name', 'rating', 'change'];
        return res;
    }

    inline function get_tableSorter__0():org.aswing.table.sorter.TableSorter {
        /* declarations/demo/view/TableView.xml:59 characters: 37-55 */
        var res = new org.aswing.table.sorter.TableSorter();
        /* declarations/demo/view/TableView.xml:59 characters: 106-117 */
        res.tableHeader = tableHeader;
        /* declarations/demo/view/TableView.xml:59 characters: 57-72 */
        res.columnSortables = [true, true, true, true, true];
        /* declarations/demo/view/TableView.xml:60 characters: 41-58 */
        res.tableModel = get_propertyTableModel__0();
        return res;
    }

    inline function get_jTable__0():org.aswing.JTable {
        /* declarations/demo/view/TableView.xml:45 characters: 29-35 */
        var res = new org.aswing.JTable();
        if (null != dataContext) { res.selectedItem = this.dataContext.selectedItem; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.selectedItem = this.dataContext.selectedItem;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.selectedItem, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.selectedItem, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.selectedItem = this.dataContext.selectedItem;
                                    bindSourceListener();
                                }
                            });
                        
        var propertyListener = function(_,_) {
                                if (!programmaticalyChange && null != this.dataContext) {
                                    programmaticalyChange = true;
                                    this.dataContext.selectedItem = res.selectedItem;
                                    programmaticalyChange = false;
                                }
                            };
        bindx.Bind.bindx(res.selectedItem, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                 if (null != this.dataContext) {
                                    this.dataContext.selectedItem = res.selectedItem;
                                }
                            });
        /* declarations/demo/view/TableView.xml:45 characters: 102-115 */
        res.selectionMode = org.aswing.JTable.SINGLE_SELECTION;
        /* declarations/demo/view/TableView.xml:45 characters: 37-46 */
        res.rowHeight = 40;
        /* declarations/demo/view/TableView.xml:46 characters: 33-44 */
        res.tableHeader = tableHeader;
        /* declarations/demo/view/TableView.xml:49 characters: 33-44 */
        res.columnModel = get_columnModel();
        /* declarations/demo/view/TableView.xml:58 characters: 33-42 */
        res.dataModel = get_tableSorter__0();
        return res;
    }

    inline function get_jScrollPane__0():org.aswing.JScrollPane {
        /* declarations/demo/view/TableView.xml:44 characters: 25-36 */
        var res = new org.aswing.JScrollPane();
        /* declarations/demo/view/TableView.xml:44 characters: 38-49 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        res.append(get_jTable__0());
        return res;
    }

    inline function get_emptyBorder__2():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/TableView.xml:73 characters: 33-51 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/TableView.xml:73 characters: 53-56 */
        res.top = 15;
        return res;
    }

    inline function get_emptyBorder__3():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/TableView.xml:79 characters: 45-63 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/TableView.xml:79 characters: 65-68 */
        res.top = 15;
        /* declarations/demo/view/TableView.xml:79 characters: 96-101 */
        res.right = 15;
        /* declarations/demo/view/TableView.xml:79 characters: 84-90 */
        res.bottom = 15;
        /* declarations/demo/view/TableView.xml:79 characters: 74-78 */
        res.left = 15;
        return res;
    }

    inline function get_aSColor__0():org.aswing.ASColor {
        /* declarations/demo/view/TableView.xml:82 characters: 45-52 */
        var res = new org.aswing.ASColor();
        /* declarations/demo/view/TableView.xml:82 characters: 54-57 */
        res.rgb = 0xe1e1e1;
        return res;
    }

    inline function get_lineBorder__0():org.aswing.border.LineBorder {
        /* declarations/demo/view/TableView.xml:77 characters: 37-54 */
        var res = new org.aswing.border.LineBorder();
        /* declarations/demo/view/TableView.xml:77 characters: 70-75 */
        res.round = 5;
        /* declarations/demo/view/TableView.xml:77 characters: 56-65 */
        res.thickness = 1;
        /* declarations/demo/view/TableView.xml:78 characters: 41-56 */
        res.interior = get_emptyBorder__3();
        /* declarations/demo/view/TableView.xml:81 characters: 41-53 */
        res.color = get_aSColor__0();
        return res;
    }

    inline function get_aSFont__2():org.aswing.ASFont {
        /* declarations/demo/view/TableView.xml:89 characters: 45-51 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/TableView.xml:89 characters: 83-87 */
        res.size = 16;
        /* declarations/demo/view/TableView.xml:89 characters: 53-57 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__2():org.aswing.JLabel {
        /* declarations/demo/view/TableView.xml:87 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/TableView.xml:87 characters: 63-82 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/TableView.xml:87 characters: 45-49 */
        res.text = 'Highest:';
        /* declarations/demo/view/TableView.xml:88 characters: 41-45 */
        res.font = get_aSFont__2();
        return res;
    }

    inline function get_emptyBorder__4():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/TableView.xml:94 characters: 45-63 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/TableView.xml:94 characters: 65-70 */
        res.right = 10;
        return res;
    }

    inline function get_jLabel__3():org.aswing.JLabel {
        /* declarations/demo/view/TableView.xml:92 characters: 37-43 */
        var res = new org.aswing.JLabel();
        if (null != dataContext) { res.text = this.dataContext.highest; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.highest;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.highest, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.highest, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.highest;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/TableView.xml:92 characters: 70-89 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/TableView.xml:93 characters: 41-47 */
        res.border = get_emptyBorder__4();
        return res;
    }

    inline function get_aSFont__3():org.aswing.ASFont {
        /* declarations/demo/view/TableView.xml:100 characters: 45-51 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/TableView.xml:100 characters: 83-87 */
        res.size = 16;
        /* declarations/demo/view/TableView.xml:100 characters: 53-57 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__4():org.aswing.JLabel {
        /* declarations/demo/view/TableView.xml:98 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/TableView.xml:98 characters: 62-81 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/TableView.xml:98 characters: 45-49 */
        res.text = 'Lowest:';
        /* declarations/demo/view/TableView.xml:99 characters: 41-45 */
        res.font = get_aSFont__3();
        return res;
    }

    inline function get_emptyBorder__5():org.aswing.border.EmptyBorder {
        /* declarations/demo/view/TableView.xml:105 characters: 45-63 */
        var res = new org.aswing.border.EmptyBorder();
        /* declarations/demo/view/TableView.xml:105 characters: 65-70 */
        res.right = 10;
        return res;
    }

    inline function get_jLabel__5():org.aswing.JLabel {
        /* declarations/demo/view/TableView.xml:103 characters: 37-43 */
        var res = new org.aswing.JLabel();
        if (null != dataContext) { res.text = this.dataContext.lowest; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.lowest;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.lowest, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.lowest, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.lowest;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/TableView.xml:103 characters: 69-88 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/TableView.xml:104 characters: 41-47 */
        res.border = get_emptyBorder__5();
        return res;
    }

    inline function get_aSFont__4():org.aswing.ASFont {
        /* declarations/demo/view/TableView.xml:111 characters: 45-51 */
        var res = new org.aswing.ASFont();
        /* declarations/demo/view/TableView.xml:111 characters: 83-87 */
        res.size = 16;
        /* declarations/demo/view/TableView.xml:111 characters: 53-57 */
        res.name = 'assets/Lato-Bold.ttf';
        return res;
    }

    inline function get_jLabel__6():org.aswing.JLabel {
        /* declarations/demo/view/TableView.xml:109 characters: 37-43 */
        var res = new org.aswing.JLabel();
        /* declarations/demo/view/TableView.xml:109 characters: 76-95 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        /* declarations/demo/view/TableView.xml:109 characters: 45-49 */
        res.text = 'Language of the year:';
        /* declarations/demo/view/TableView.xml:110 characters: 41-45 */
        res.font = get_aSFont__4();
        return res;
    }

    inline function get_jLabel__7():org.aswing.JLabel {
        /* declarations/demo/view/TableView.xml:114 characters: 37-43 */
        var res = new org.aswing.JLabel();
        if (null != dataContext) { res.text = this.dataContext.languageOfYear; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.text = this.dataContext.languageOfYear;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.languageOfYear, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.languageOfYear, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.text = this.dataContext.languageOfYear;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/TableView.xml:114 characters: 77-96 */
        res.horizontalAlignment = org.aswing.AsWingConstants.LEFT;
        return res;
    }

    inline function get_jPanel__0():org.aswing.JPanel {
        /* declarations/demo/view/TableView.xml:86 characters: 33-39 */
        var res = new org.aswing.JPanel();
        res.append(get_jLabel__2());
        res.append(get_jLabel__3());
        res.append(get_jLabel__4());
        res.append(get_jLabel__5());
        res.append(get_jLabel__6());
        res.append(get_jLabel__7());
        return res;
    }

    inline function get_softBox__0():org.aswing.SoftBox {
        /* declarations/demo/view/TableView.xml:75 characters: 29-36 */
        var res = new org.aswing.SoftBox();
        /* declarations/demo/view/TableView.xml:76 characters: 33-39 */
        res.border = get_lineBorder__0();
        res.append(get_jPanel__0());
        return res;
    }

    inline function get_softBox__1():org.aswing.SoftBox {
        /* declarations/demo/view/TableView.xml:71 characters: 25-32 */
        var res = new org.aswing.SoftBox();
        if (null != dataContext) { res.visibility = this.dataContext.informationPanelVisibility; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
                            if (!programmaticalyChange) {
                                programmaticalyChange = true;
                                res.visibility = this.dataContext.informationPanelVisibility;
                                programmaticalyChange = false;
                            }
                        };
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.informationPanelVisibility, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
                                if (null != old) { bindx.Bind.unbindx(old.informationPanelVisibility, sourcePropertyListener);}
                                if (null != this.dataContext) {
                                    res.visibility = this.dataContext.informationPanelVisibility;
                                    bindSourceListener();
                                }
                            });
                        
        /* declarations/demo/view/TableView.xml:71 characters: 34-45 */
        res.constraints = org.aswing.BorderLayout.SOUTH;
        /* declarations/demo/view/TableView.xml:72 characters: 29-35 */
        res.border = get_emptyBorder__2();
        res.append(get_softBox__0());
        return res;
    }

    inline function get_jPanel__1():org.aswing.JPanel {
        /* declarations/demo/view/TableView.xml:40 characters: 21-27 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/TableView.xml:41 characters: 25-31 */
        res.layout = get_borderLayout__2();
        res.append(get_jScrollPane__0());
        res.append(get_softBox__1());
        return res;
    }

    inline function get_jPanel__2():org.aswing.JPanel {
        /* declarations/demo/view/TableView.xml:28 characters: 17-23 */
        var res = new org.aswing.JPanel();
        /* declarations/demo/view/TableView.xml:29 characters: 21-27 */
        res.layout = get_borderLayout__1();
        res.append(get_jLabel__1());
        res.append(get_jPanel__1());
        return res;
    }

    inline function get_tabInfo__0():org.aswing.TabInfo {
        /* declarations/demo/view/TableView.xml:26 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/TableView.xml:26 characters: 18-23 */
        res.title = 'Demo';
        /* declarations/demo/view/TableView.xml:27 characters: 13-20 */
        res.content = get_jPanel__2();
        return res;
    }

    inline function get_hmlRegExRules__0():jive.formatting.HmlRegExRules {
        /* declarations/demo/view/TableView.xml:128 characters: 29-53 */
        var res = new jive.formatting.HmlRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__0():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/TableView.xml:126 characters: 21-54 */
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
                        
        /* declarations/demo/view/TableView.xml:126 characters: 83-102 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/TableView.xml:127 characters: 25-41 */
        res.rules = get_hmlRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__1():org.aswing.JScrollPane {
        /* declarations/demo/view/TableView.xml:125 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__0());
        return res;
    }

    inline function get_tabInfo__1():org.aswing.TabInfo {
        /* declarations/demo/view/TableView.xml:123 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/TableView.xml:123 characters: 18-23 */
        res.title = 'View (XML source)';
        /* declarations/demo/view/TableView.xml:124 characters: 13-20 */
        res.content = get_jScrollPane__1();
        return res;
    }

    inline function get_haxeRegExRules__0():jive.formatting.HaxeRegExRules {
        /* declarations/demo/view/TableView.xml:139 characters: 29-54 */
        var res = new jive.formatting.HaxeRegExRules();
        return res;
    }

    inline function get_regExFormattedTextArea__1():jive.formatting.RegExFormattedTextArea {
        /* declarations/demo/view/TableView.xml:137 characters: 21-54 */
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
                        
        /* declarations/demo/view/TableView.xml:137 characters: 84-103 */
        res.backgroundDecorator = null;
        /* declarations/demo/view/TableView.xml:138 characters: 25-41 */
        res.rules = get_haxeRegExRules__0();
        return res;
    }

    inline function get_jScrollPane__2():org.aswing.JScrollPane {
        /* declarations/demo/view/TableView.xml:136 characters: 17-28 */
        var res = new org.aswing.JScrollPane();
        res.append(get_regExFormattedTextArea__1());
        return res;
    }

    inline function get_tabInfo__2():org.aswing.TabInfo {
        /* declarations/demo/view/TableView.xml:134 characters: 9-16 */
        var res = new org.aswing.TabInfo();
        /* declarations/demo/view/TableView.xml:134 characters: 18-23 */
        res.title = 'View Model (Haxe source)';
        /* declarations/demo/view/TableView.xml:135 characters: 13-20 */
        res.content = get_jScrollPane__2();
        return res;
    }

    inline function get_jTabbedPane__0():org.aswing.JTabbedPane {
        /* declarations/demo/view/TableView.xml:24 characters: 5-16 */
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
        /* declarations/demo/view/TableView.xml:24 characters: 18-29 */
        res.constraints = org.aswing.BorderLayout.CENTER;
        res.appendTabInfo(get_tabInfo__0());
        res.appendTabInfo(get_tabInfo__1());
        res.appendTabInfo(get_tabInfo__2());
        return res;
    }

    public function new() {
        /* declarations/demo/view/TableView.xml:2 characters: 1-7 */
        super();
        /* declarations/demo/view/TableView.xml:13 characters: 5-11 */
        this.layout = get_borderLayout__0();
        this.append(get_jLabel__0());
        this.append(get_jTabbedPane__0());
    }
}
