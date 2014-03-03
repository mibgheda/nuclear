package  {
	import flash.display.MovieClip;
	import gs.*
	
	public class TabElem  extends MovieClip{

		var color:Number
		
		public function TabElem(data:XML) {
			// constructor code
			
			var pos:Array = String(data.@pos).split(",")
			x = pos[0]*(65+1)
			y = pos[1]*(42+1)
			
			sigh.htmlText = "<b>"+data.@glyph+"</b>"
			name_tf.htmlText = data.@name
			numb.htmlText = "<b>"+data.@id+"</b>"
			
			if (data.@color=="red") color = 0xF85881//e46e7e
			if (data.@color=="yellow") color = 0xFFCC00//ebc75d
			if (data.@color=="blue") color = 0x7DCCF7//7babd6
			
			TweenFilterLite.to(p, 0.2, {tint:color});
			
		}

	}
	
}
