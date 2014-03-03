package 
{
	import flash.events.*;
	import flash.display.Loader
	import flash.net.URLLoader
	import flash.net.URLRequest
	/**
	 * ...
	 * @author mibgheda
	 */
	
	public class Model {
		private var myXML:XML
		private var myLoader:URLLoader
		private var xmlPath:String = "config.xml"
		private var view:MainView;
		
		
		public function Model(_view:MainView) {
			view = _view;
			getXML()
		}	
		private function getXML():void{
			myXML = new XML();
			view.preloader();
			myLoader = new URLLoader();
			myLoader.addEventListener("complete", onCompleteXML);
			myLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler)
			myLoader.addEventListener(ErrorEvent.ERROR, onError)
			myLoader.load(new URLRequest(xmlPath));
		}
		private function onError(event:ErrorEvent):void {
			trace("Ошибка загрузки конфига xml")
			view.error();
			
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void{
			trace("httpStatusHandler: " + event);
            trace("status: " + event.status);
		}
		private function onCompleteXML(event:Event):void{
			
			Main.data=XML(myLoader.data);
			Main.run();
			
		}
		
	}
}