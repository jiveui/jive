package ;

#if !display
@:autoBuild(DataContextMacros.build())
#end
interface DataContextControllable<T> {
    var dataContext(default, set): T;
}
