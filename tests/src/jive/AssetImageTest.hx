package jive;

import jive.geom.IntDimension;
import jive.geom.IntRequest;
import jive.geom.DimensionRequest;
import jive.geom.IntDimension;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import massive.munit.util.Timer;

using jive.geom.MetricHelper;

class AssetImageTest {
    @:access(jive.Component)
    @Test
    public function testImageSize(factory: AsyncFactory) {
        Jive.start();

        var w: AssetImageWindow = new AssetImageWindow();
        w.opened = true;
        w.paint(new IntDimension(w.absoluteWidth(), w.absoluteHeight()));

        Assert.areEqual(w.children.length, 1);
        Assert.areEqual(w.sprite.numChildren, 1);
        Assert.areEqual(w.sprite.getChildAt(0), w.image.sprite);

        Assert.isFalse(w.needsPaint);

        Assert.areEqual(0, w.image.absoluteWidth());
        Assert.areEqual(0, w.image.absoluteHeight());

        Assert.areEqual(4096, w.image.bitmapData.width);
        Assert.areEqual(4096, w.image.bitmapData.height);

        Assert.areEqual(4096, w.image.getPreferredSize(new DimensionRequest(IntRequest.auto, IntRequest.auto)).width);
        Assert.areEqual(4096, w.image.getPreferredSize(new DimensionRequest(IntRequest.auto, IntRequest.auto)).height);

        Assert.areEqual(500, w.image.sprite.width);
        Assert.areEqual(500, w.image.sprite.height);
    }
}
