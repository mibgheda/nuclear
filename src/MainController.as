package 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author mibgheda
	 */
	public class MainController extends MovieClip
	{
		public function MainController():void {
			
		}
		public function addPopup(data:XML):void {
			Main.mainView.items["mt"].lock()
			Main.mainView.addChild(Main.mainView.items["popup"])
			Main.mainView.items["popup"].init(data);
			//инит нового попапа
		}	
		
		public function removePopup():void {
			Main.mainView.items["mt"].unlock()
			Main.mainView.removeChild(Main.mainView.items["popup"])
		}	
		
		public function open3D(data:XML, parentdata:XML):void {
			Main.mainView.items["mt"].visible = false
			Main.mainView.items["popup"].visible = false
			Main.mainView.items["view3D"].init(data, parentdata);
		}
		public function close3D():void {
			Main.mainView.items["mt"].visible = true
			Main.mainView.items["popup"].visible = true
			
		}
		public function clear(item:*):void {
			while (item.numChildren>0) item.removeChildAt(0)
		}
	}
	
}