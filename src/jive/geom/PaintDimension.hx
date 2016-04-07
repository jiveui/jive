package jive.geom;

enum PaintDimension {
    none;
    absolute(v: IntDimension);
    prefferedSize(v: IntDimension);
}