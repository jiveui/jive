package jive;


import org.aswing.DefaultListCell;
import org.aswing.ListCell;

class TemplateListCellFactory implements org.aswing.ListCellFactory{

    public var templateClass: Class<Dynamic>;
    public var shareCelles:Bool;
    public var cellHeight:Int;
    public var sameHeight:Bool;

    public function new(templateClass:Class<Dynamic> = null, shareCelles:Bool=true, sameHeight:Bool=true, height:Int=0){
        this.shareCelles = shareCelles;
        this.sameHeight = sameHeight;
        cellHeight = height;
    }

    public function createNewCell(): ListCell {
        return new TemplateListCell(templateClass);
    }

    public function isAllCellHasSameHeight(): Bool {
        return sameHeight;
    }

    public function isShareCells(): Bool {
        return shareCelles;
    }

    public function setCellHeight(h:Int): Void {
        cellHeight = h;
    }

    public function getCellHeight(): Int {
        return cellHeight;
    }

}