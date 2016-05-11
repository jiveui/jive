package jive.state;

import motion.easing.Linear;
import motion.Actuate;

using jive.tools.TypeTools;

class StateManager {
    public static function changeTo(object: Statefull, stateName: String) {
        var prevState: State = object.states.get(object.state);
        var state: State = object.states.get(stateName);
        if (null == state) return;

        var count = 0;
        var onComplete = function() {
            count -= 1;
            if (count <= 0) {
                object.state = stateName;
            }
        }

        object.state = State.CHANGING;

        for (t in state.transformations) {
            count += 1;
            startTransformation(object, t, onComplete);
        }
    }

    private static function startTransformation(object: Statefull, t: Transformation, onComplete: Void -> Void) {
        var o = if (null != t.object) object.lastObjectOfChain(t.object) else object;

        if (o == null) {
            onComplete();
            return;
        }

        Actuate
            .tween(
                o,
                t.duration,
                t.getPropertiesObject())
            .ease(if (t.ease != null) t.ease else Linear.easeNone)
            .onComplete(function() {
                if (t.after != null) {
                    startTransformation(object, t.after, onComplete);
                } else {
                    onComplete();
                }
            });
    }
}
