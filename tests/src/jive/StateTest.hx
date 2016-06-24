package jive;

import bindx.Bind;
import jive.state.State;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import massive.munit.util.Timer;

class StateTest {
    public function new() {}

    @Test
    public function test(factory: AsyncFactory) {
        Jive.start();
        var w: StateWindow = new StateWindow();
        w.opened = true;

        w.state = "invisible";
        Assert.areEqual(State.CHANGING, w.state);

        Bind.bind(w.state, function(_, _) {
            Assert.areEqual("invisible", w.state);
            Assert.areEqual(1.0, w.svg1.alpha);
        });
    }
}
