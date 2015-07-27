package jive;

import org.aswing.ListCell;
import org.aswing.AsWingUtils;
import org.aswing.Component;

@:generic class TemplateListCell extends org.aswing.AbstractListCell {

    private var cellComponent: Component;

    public function new(cellComponentType: Class<Dynamic>) {
        super();
        var c = Type.createInstance(cellComponentType, []);
        cellComponent = AsWingUtils.as(c, Component);
        cellComponent.visibility = false;
    }

    override public function setCellValue(value:Dynamic) : Void {
        super.setCellValue(value);
        Reflect.setProperty(cellComponent, "dataContext", value);
    }

    override public function getCellComponent() : Component {
        return cast(cellComponent, Component);
    }
}
