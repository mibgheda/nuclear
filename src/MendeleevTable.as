package 
{
	import flash.display.DisplayObject;
	import flash.display.StageDisplayState;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.FontType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.system.fscommand;
	
	/**
	 * ...
	 * @author mibgheda
	 */
	public class MendeleevTable extends MovieClip
	{
		
		[Embed(source = "../assets/nuclear_graph.swf", symbol = "$TableBg")] private static const TableBg:Class;	
		[Embed(source="../assets/nuclear_graph.swf", symbol="$Rect")] private static const Rect:Class;	
		
		private var container:Sprite;
		private var ti:TableElem;
		public var rect:DisplayObject
		private var prop:Number
		private var tb:DisplayObject
		
		public function MendeleevTable():void {
			
			tb = new TableBg
			addChild(tb)
			
			
			
			container = new Sprite();
			container.x = 63
			container.y = 111
			addChild(container);
			
			createTable();
			
			
			rect = new Rect
			rect.width = tb.width
			rect.height = tb.height
			rect.visible = false
			addChild(rect)
			
			
			prop = 923 / 759
			
			//TableBg(tb).fc.visible = false
			//TableBg(tb).clz.visible = false
			
			
			TableBg(tb).fc.buttonMode = true
			TableBg(tb).fc.mouseChildren = false
			
			TableBg(tb).clz.buttonMode = true
			TableBg(tb).clz.mouseChildren = false
			
			TableBg(tb).fc.addEventListener(MouseEvent.CLICK, onFc) 
			TableBg(tb).clz.addEventListener(MouseEvent.CLICK, onClose)
			
			
			Main.stage.addEventListener(Event.RESIZE, resize)
			resize()
			
			onFc()
			
		}
		private function createTable():void {
			
			for each (var elem:XML in Main.data.elem){
				ti = new TableElem(elem)
				container.addChild(ti)
			}
		}
		private function resize(e:Event = null):void {
			
			
			height = Main.stage.stageHeight
			width = height * prop
			x =  (Main.stage.stageWidth-width)/2
			
		}
		public function lock():void {
			rect.visible = true
			resize()
		}
		public function unlock():void {
			rect.visible = false
		}
		
		private function onFc(e:MouseEvent = null):void {
			
			/*
			if (Main.stage.displayState == StageDisplayState.NORMAL){
				Main.stage.displayState = StageDisplayState.FULL_SCREEN
			} else {
				Main.stage.displayState = StageDisplayState.NORMAL
			}*/
		}
		private function onClose(e:MouseEvent = null):void {
			fscommand("quit");
		}
		
	}
	
}