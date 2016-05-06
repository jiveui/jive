package jive;

#if !display
@:autoBuild(jive.DataContextMacros.build())
#end
interface DataContextControllable<T> extends bindx.IBindable {
    @:bindable var dataContext(default, set):T;
}
