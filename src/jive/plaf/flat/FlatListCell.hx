package jive.plaf.flat;

import jive.plaf.flat.border.TextCellComponentBorder;
import org.aswing.Component;
import org.aswing.JList;
import org.aswing.AbstractListCell;

class FlatListCell extends AbstractListCell {

    public var cellComponent(get, null): TextCellComponent;
    private var _cellComponent: TextCellComponent;
    private function get_cellComponent(): TextCellComponent {
        if (null == _cellComponent) {
            _cellComponent = new TextCellComponent();
            initCellComponent();
        }
        return _cellComponent;
    }

    //To override in subclasses
    private function initCellComponent() {}

    public function new() { super(); }

    override public function setListCellStatus(list : JList, isSelected : Bool, index:Int) : Void{
        super.setListCellStatus(list, isSelected, index);
        cellComponent.isLast = index == list.model.getSize()-1;
        cellComponent.isFirst = 0 == index;
    }

    override public function setCellValue(value:Dynamic) : Void{
        super.setCellValue(value);
        cellComponent.value = getStringValue(value);
    }

    /**
	 * Override this if you need other value->string translator
	 */
    private function getStringValue(value:Dynamic):String{
        return value + "";
    }

    override public function getCellComponent() : Component {
        return cellComponent;
    }
}
