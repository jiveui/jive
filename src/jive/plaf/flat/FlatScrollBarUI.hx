package jive.plaf.flat;

import org.aswing.geom.IntDimension;
import org.aswing.event.ReleaseEvent;
import org.aswing.AWSprite;
import org.aswing.plaf.basic.BasicScrollBarUI;

class FlatScrollBarUI extends BasicScrollBarUI {
    public function new() { super(); }

    override private function installComponents():Void{
        super.installComponents();

        incrButton.preferredSize = decrButton.preferredSize = new IntDimension(0,0);
        incrButton.visibility = decrButton.visibility = false;
    }
}
