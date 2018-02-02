package jive;

#if !display
@:autoBuild(jive.DataContextMacros.build())
#end
interface DataContextControllable<T> {
    var dataContext(default, set): T;
}
