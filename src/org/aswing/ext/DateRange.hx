package org.aswing.ext;
import org.aswing.error.Error;
import org.aswing.util.DateAs;
/**
 * The definition of a date range.
 * For a single day, you can set rangeStart and rangeEnd to be a same date, 
 * If rangeStart == null, means all date before rangeEnd(included) is in range,  
 * If rangeEnd == null, means all date after rangeStart(included) is in range.
 * @author paling (Burstyx Studio)
 */
class DateRange{
	
	private var rangeStart:DateAs;
	private var rangeEnd:DateAs;
	
	public function new(rangeStart:DateAs, rangeEnd:DateAs){
		this.rangeStart = rangeStart;
		this.rangeEnd = rangeEnd;
		resetInDay(this.rangeStart);
		resetInDay(this.rangeEnd); 
		if(rangeStart!=null && rangeEnd!=null){
			if(rangeStart.getTime() > rangeEnd.getTime()){
				throw new Error("rangeStart can not be later than rangeEnd.");  
			}
		}
	}
	
	public static function singleDay(day:DateAs):DateRange{
		return new DateRange(day, day);
	} 
	
	public function getStart():DateAs{
		return rangeStart;
	}
	
	public function getStartMonth():DateAs {
 
		return resetInMonth(  DateAs.fromTime( rangeStart.getTime()) );
	}
	
	public function getEnd():DateAs{
		return rangeEnd;
	}
	
	public function getEndMonth():DateAs{
		return resetInMonth(DateAs.fromTime(rangeEnd.getTime()));
	}
	
	public function isInRange(date:DateAs):Bool{
		resetInDay(date); //reset the day
		if(rangeStart!=null && rangeEnd!=null){
			return date.getTime() >= rangeStart.getTime() && date.getTime() <= rangeEnd.getTime();
		}else if(null == rangeStart){
			return date.getTime() <= rangeEnd.getTime();
		}else if(null == rangeEnd){
			return date.getTime() >= rangeStart.getTime();
		}
		return true;
	}
	
	public static function resetInMonth(date:DateAs):DateAs{
	 	date.setDate(1); 
		resetInDay(date);
		return date;
	}
	
	public static function resetInDay(date:DateAs):DateAs {
		 
		if(date!=null)	{
	 	 date.setHours(0);
		 date.setMinutes(0);
		 date.setSeconds(0); 
		 
		
		}
		return date;
	}
}
