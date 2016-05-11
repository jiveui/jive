package jive.state;

import motion.easing.IEasing;

class Transformation {
    public var object: String;
    public var duration: Float;
    public var ease: IEasing;
    public var properties: TransformationItems;
    public var after: Transformation;

    public function new() {}

    public function getPropertiesObject() {
        var res = {};
        for (p in properties) {
            Reflect.setField(res, p.name, p.value);
        }
        return res;
    }
}
