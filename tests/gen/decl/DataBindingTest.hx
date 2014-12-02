package decl;

class DataBindingTest extends org.aswing.ExtendedComponent implements jive.DataContextControllable<jive.DataBindingModel> {

    public function new() {
        /* tests/declarations/decl/DataBindingTest.xml:2 characters: 1-18 */
        super();
        if (null != dataContext) { this.s = this.dataContext.s; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
    						if (!programmaticalyChange) {
    							programmaticalyChange = true;
    							this.s = this.dataContext.s;
    							programmaticalyChange = false;
    						}
    					};
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.s, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
    							if (null != old) { bindx.Bind.unbindx(old.s, sourcePropertyListener);}
    							if (null != this.dataContext) {
    								this.s = this.dataContext.s;
    								bindSourceListener();
    							}
    						});
    					
        if (null != dataContext) { this.i = this.dataContext.i; }
        var programmaticalyChange = false;
        var sourcePropertyListener = function(_,_) {
    						if (!programmaticalyChange) {
    							programmaticalyChange = true;
    							this.i = this.dataContext.i;
    							programmaticalyChange = false;
    						}
    					};
        var bindSourceListener = function() { bindx.Bind.bindx(this.dataContext.i, sourcePropertyListener); }
        if (null != dataContext) { bindSourceListener(); }
        bindx.Bind.bindx(this.dataContext, function(old,_) {
    							if (null != old) { bindx.Bind.unbindx(old.i, sourcePropertyListener);}
    							if (null != this.dataContext) {
    								this.i = this.dataContext.i;
    								bindSourceListener();
    							}
    						});
    					
        var propertyListener = function(_,_) {
    							if (!programmaticalyChange && null != this.dataContext) {
    								programmaticalyChange = true;
    								this.dataContext.i = this.i;
    								programmaticalyChange = false;
    							}
    						};
        bindx.Bind.bindx(this.i, propertyListener);
        bindx.Bind.bindx(this.dataContext, function(old,_) {
    						 	if (null != this.dataContext) {
    								this.dataContext.i = this.i;
    							}
    						});
    }
}
