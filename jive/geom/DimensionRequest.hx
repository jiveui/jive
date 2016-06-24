package jive.geom;

import jive.geom.IntRequest;
class DimensionRequest {

    public var width: IntRequest;
    public var height: IntRequest;

    public function new(width: IntRequest, height: IntRequest) {
        this.width = width;
        this.height = height;
    }

    public function toIntDimension(substituteWidth: Int, substituteHeight: Int): IntDimension {
        return new IntDimension(
            switch (width) {
                case IntRequest.int(v): v;
                case IntRequest.auto: substituteWidth;
            },
            switch (height) {
                case IntRequest.int(v): v;
                case IntRequest.auto: substituteHeight;
            }
        );
    }
}
