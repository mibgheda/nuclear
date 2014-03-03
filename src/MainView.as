package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	
	/**
	 * ...
	 * @author mibgheda
	 */
	public class MainView extends MovieClip 
	{
		
		public var items:Array
		private var view3D:View3D
		public var mt:MendeleevTable
		public var popup:PopupWindow
		
		
		
		[Embed(source="../assets/nuclear_graph.swf", symbol="$Preloader")] private static const SPreloader:Class;	
		
		public var loader:DisplayObject;
		
		public function MainView() {
			items = []
		}
		
		public function preloader():void {
			loader = new SPreloader();
			loader.x = (stage.stageWidth - loader.width)/2
			loader.y = (stage.stageHeight-loader.height)/2
			addChild(loader);
		}
		
		public function error():void {
			removeChild(loader);
			
			var err:TextField = new TextField();
			err.width = 500;
			err.text = 'Ошибка загрузки конфигурационного файла'
			err.x = (stage.stageWidth - err.textWidth)/2
			err.y = (stage.stageHeight-80)/2
			addChild(err)
		}
		public function init():void {
			
			removeChild(loader);
			
			mt = new MendeleevTable()
			items["mt"] = mt
			addChild(mt)
			
			popup = new PopupWindow()
			items["popup"] = popup
			
			view3D = new View3D();
			items["view3D"] = view3D
			addChild(view3D)
		}
		
		
	}
	
}