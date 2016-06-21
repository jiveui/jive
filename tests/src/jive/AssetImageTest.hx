package jive;

import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import massive.munit.util.Timer;

class AssetImageTest {
    @AsyncTest
    public function testImageSize(factory: AsyncFactory) {
        Jive.start();
        var w: AssetImageWindow = new AssetImageWindow();
        w.opened = true;

        var handler: Dynamic = factory.createHandler(this, function() {
            Assert.areEqual(w.children.length, 1);
            Assert.areEqual(w.displayObjectContainer.numChildren, 1);
            Assert.areEqual(w.displayObjectContainer.getChildAt(0), w.image.sprite);
            Assert.areEqual(4096, w.image.sprite.width);
            Assert.areEqual(4096, w.image.sprite.height);
            Assert.areEqual(4096, w.image.absoluteWidth);
            Assert.areEqual(4096, w.image.absoluteHeight);
        }, 1000);
        Timer.delay(handler, 100);
    }
}
