package jive.plaf.flat;

import org.aswing.DefaultListTextCellFactory;

class FlatListCellFactory extends DefaultListTextCellFactory{
    public function new(shareCelles:Bool=true, sameHeight:Bool=true){
        super(FlatListCell, shareCelles, sameHeight);
    }
}
