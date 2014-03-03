package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import gs.*
	/**
	 * ...
	 * @author mibgheda
	 */
	public class TableElem extends MovieClip 
	{
		[Embed(source = "../assets/nuclear_graph.swf", symbol = "$TabElem")] private static const Elem:Class;	
		private var color:Number
		private var elem:DisplayObject
		private var data:XML
		
		public function TableElem(_data:XML) {
			data = _data
			
			var pos:Array = String(data.@pos).split(",")
			x = pos[0]*(65+1)
			y = pos[1] * (42 + 1)
			
			elem = new Elem
			addChild(elem)
			
			Elem(elem).sigh.htmlText = "<b>"+data.@glyph+"</b>"
			Elem(elem).name_tf.htmlText = data.@name
			Elem(elem).numb.htmlText = "<b>"+data.@id+"</b>"
			
			
			if (data.@color=="red") color = 0xF85881//e46e7e
			if (data.@color=="yellow") color = 0xFFCC33//ebc75d
			if (data.@color == "blue") color = 0x7DCCF7//7babd6
			
			
			TweenFilterLite.to(Elem(elem).p, 0, { tint:color } );
			
			//добавим функционал
			buttonMode = true
			mouseChildren = false
			addEventListener(MouseEvent.CLICK, onClick)
			addEventListener(MouseEvent.MOUSE_OVER, onOver)
			addEventListener(MouseEvent.MOUSE_OUT, onOut)
			
			//var str = "2s&16&"
			if (data.@formula!=""){
				var subscr:Array = String(data.@formula).split("&")
				Elem(elem).sup.f.text = subscr[0]
				Elem(elem).sup.f_sup.text = subscr[1]
				//подровнять
			} else {
				Elem(elem).sup.f.text = ""
				Elem(elem).sup.f_sup.text = ""
			}
			
			
		}
		private function onClick(e:MouseEvent):void {
			//открываем попуп
			Main.mainController.addPopup(data);
		}
		private function onOver(e:MouseEvent):void {
			TweenFilterLite.to(Elem(elem).blik, 0.5, {alpha:1} );
			TweenFilterLite.to(Elem(elem).p, 0.5, { tint:color-0x002020} );
		}
		private function onOut(e:MouseEvent):void {
			TweenFilterLite.to(Elem(elem).blik, 0.5, {alpha:0.5} );
			TweenFilterLite.to(Elem(elem).p, 0.5, { tint:color} );
		}
	}
	
}