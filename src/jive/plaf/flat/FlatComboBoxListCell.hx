package jive.plaf.flat;

import org.aswing.Component;
import org.aswing.JList;
import flash.events.MouseEvent;
import org.aswing.ASColor;

class FlatComboBoxListCell extends FlatListCell {
    private var rolloverBackground:ASColor;
    private var rolloverForeground:ASColor;
    private var realBackground:ASColor;
    private var realForeground:ASColor;

    public function new(){
        super();
    }

    override private function initCellComponent() {
        super.initCellComponent();
        _cellComponent.addEventListener(MouseEvent.ROLL_OVER, __labelRollover, false, 0, false);
        _cellComponent.addEventListener(MouseEvent.ROLL_OUT, __labelRollout, false, 0, false);
    }

    override public function setListCellStatus(list:JList, isSelected:Bool, index:Int):Void{
        super.setListCellStatus(list, isSelected, index);
        var com:Component = getCellComponent();
        if(isSelected)	{
            com.setBackground((realBackground = list.getSelectionBackground()));
            com.setForeground((realForeground = list.getSelectionForeground()));
        }else{
            com.setBackground((realBackground = list.getBackground()));
            com.setForeground((realForeground = list.getForeground()));
        }
        com.setFont(list.getFont());
        rolloverBackground = list.getSelectionBackground().offsetHLS(0, 0.05, -0.1);
        rolloverForeground = list.getSelectionForeground();
    }

    private function __labelRollover(e:MouseEvent):Void{
        if(rolloverBackground!=null)	{
            cellComponent.setBackground(rolloverBackground);
            cellComponent.setForeground(rolloverForeground);
        }
    }

    private function __labelRollout(e:MouseEvent):Void{
        if(realBackground!=null)	{
            cellComponent.setBackground(realBackground);
            cellComponent.setForeground(realForeground);
        }
    }

}
