package jive.plaf.flat;

import org.aswing.DefaultListTextCellFactory;

class FlatComboBoxListCellFactory extends DefaultListTextCellFactory{

    public function new(shareCelles:Bool=true, sameHeight:Bool=true){
        super(FlatComboBoxListCell, shareCelles, sameHeight);
    }
}
