package jive.state;

import motion.easing.IEasing;

class Transformation {
    public var object: String;
    public var duration: Float;
    public var ease: IEasing;
    public var properties: Array<jive.state.Item>;
    public var after: Transformation;

    public function getPropertiesObject() {
        var res = {};
        for (p in properties) {
            Reflect.setField(p.name, p.value);
        }
        return res;
    }
}
