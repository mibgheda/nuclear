package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author mibgheda
	 */
	public class TugglePause extends MovieClip
	{
		[Embed(source = "../assets/nuclear_graph.swf", symbol = "$Pause")] private static const Pau:Class;
		private var pau:DisplayObject
		private var $parent:View3D
		private var isPause:Boolean = false
	
		
		public function TugglePause($$parent:DisplayObject):void {
			$parent  = View3D($$parent)
			
			pau  = new Pau()
			addChild(pau)
			
			
			Pau(pau).buttonMode = true
			
			addEventListener(MouseEvent.CLICK, onClick)
			
		}
		public function refresh():void {
			if (!$parent.isPause) {
				Pau(pau).play_ico.visible = false
				Pau(pau).stop_ico.visible = true
			
			} else {
				Pau(pau).play_ico.visible = true
				Pau(pau).stop_ico.visible = false
			
			}
		}
		private function onClick(e:MouseEvent):void {
			
			if (!$parent.isPause) {
				$parent.isPause = true
				//остановить
			} else {
				$parent.isPause = false
				//запустить
			}
			refresh()
		}
	}
	
}