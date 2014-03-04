package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.display.Stage;
	import flash.display.StageAlign
	import flash.display.StageScaleMode;
	
	
	/**
	 * ...
	 * @author mibgheda
	 */
	public class Main extends Sprite 
	{
		
		public static var stage:Stage
		public static var mainView:MainView
		public static var mainController:MainController
		public static var model:Model
		public static var isFC:Boolean
		
		public static var data:XML
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Main.stage = this.stage
			Main.stage.align=StageAlign.TOP_LEFT
			//Main.stage.scaleMode=StageScaleMode.NO_SCALE;
			
			Main.data = new XML
			
			mainView = new MainView();
			addChild(mainView)
			
			mainController = new MainController();
			
			model = new Model(mainView)
			
		}
		public static function run():void {
			
			mainView.init();
		}
		
	}
	
}