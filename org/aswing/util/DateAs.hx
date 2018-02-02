package org.aswing.util;

/**
 * ...
 * @author 
 */

 class DateAs 
{

	private var  __gt: Date;
	public function new(year : Int, month : Int, day : Int, hour : Int, min : Int, sec : Int) 
	{ 
		__gt = new Date(year , month , day , hour , min , sec );
		 
	}
	static public function fromTime( t : Float ) : DateAs
	{
		 var d:Date = Date.fromTime(t);
		 var da:DateAs = new DateAs(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds());
		 return da;
	}

	public function setTime(value: Float):Void {
		__gt =  Date.fromTime(value);
	}
 	 
	public 	function setFullYear(value: Int):Void {
		//__gt= new DateAs( getFullYear(),  getMonth(), getDate(), getHours(), getMinutes(), getSeconds());
		__gt= new Date( value,  getMonth(), getDate(), getHours(), getMinutes(), getSeconds());
	}

		 
	public 	function setMonth(value: Int):Void {
		__gt= new Date( getFullYear(), value, getDate(), getHours(), getMinutes(), getSeconds());
		}
 
	public 	function setDate(value: Int):Void {
		__gt= new Date( getFullYear(),  getMonth(), value, getHours(), getMinutes(), getSeconds());
	}
	public 	function setHours(value: Int):Void {
		__gt= new Date( getFullYear(),  getMonth(), getDate(), value, getMinutes(), getSeconds());
	}

	 
	public 	function setMinutes(value: Int):Void {
		 __gt= new Date( getFullYear(),  getMonth(), getDate(), getHours(), value, getSeconds());
	}

	 
	public 	function setSeconds(value: Int):Void {
		__gt= new Date( getFullYear(),  getMonth(), getDate(), getHours(), getMinutes(), value);
	}



	 public	function getTime() : Float { 
		 return __gt.getTime();
	 }
	 

	/**
		Returns the hours value of the date (0-23 range).
	**/
		public function getHours() : Int{ 
		 return __gt.getHours();
	 }

	/**
		Returns the minutes value of the date (0-59 range).
	**/
		public function getMinutes() : Int{ 
		  return __gt.getMinutes();
	 }

	/**
		Returns the seconds of the date (0-59 range).
	**/
	public function getSeconds() : Int{ 
		  return __gt.getSeconds();
	 }

	/**
		Returns the full year of the date.
	**/
	public function getFullYear() : Int{ 
		  return __gt.getFullYear();
	 }

	/**
		Returns the month of the date (0-11 range).
	**/
	public function getMonth() : Int{ 
		  return __gt.getMonth();
	 }

	/**
		Returns the day of the date (1-31 range).
	**/
	public function getDate() : Int{ 
		  return __gt.getDate();
	 }
 
	public function getDay() : Int{ 
		  return __gt.getDay();
	 }

	/**
		Returns a string representation for the Date, by using the
		standard format [YYYY-MM-DD HH:MM:SS]. See [DateTools.format] for
		other formating rules.
	**/
	public function toString():String{ 
		   return __gt.toString();
	 }

	/**
		Returns a Date representing the current local time.
	**/
	
}
