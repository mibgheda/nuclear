package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.xml.XMLNode;
	import gs.*
	import gs.easing.*
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author mibgheda
	 */
	public class PopupWindow extends MovieClip
	{
	
	[Embed(source = "../assets/nuclear_graph.swf", symbol = "$PopUp")] private static const PopUp:Class;	
	
	private var container:Sprite;
	private var pi:PopUpItem;
	private var pop:DisplayObject
	private var color:Number
	private var count:Number
	private var row:Number
	private var oldX:Number
	private var oldY:Number
	private var oldW:Number
	private var oldH:Number
	private var columns:int = 6;
	
	public function PopupWindow():void {
		
		pop = new PopUp
		addChild(pop)
		
		
		var closeMc:MovieClip = new MovieClip
		closeMc.addChild(PopUp(pop).close_btn)
		addChild(closeMc)
		closeMc.mouseChildren = false
		closeMc.buttonMode = true
		closeMc.addEventListener(MouseEvent.CLICK, onClose)
		closeMc.addEventListener(MouseEvent.MOUSE_OVER, onCloseOver)
		closeMc.addEventListener(MouseEvent.MOUSE_OUT, onCloseOut)
		
		container = new Sprite();
		container.x = 228
		container.y = 50
		addChild(container);
		
		Main.stage.addEventListener(Event.RESIZE, resize)
		resize()
	}
		
	public function init(data:XML):void {
		
		//чистим
		Main.mainController.clear(container)
		count = 0
		row = 0
		
		
		
		
		//настраиваем элемент	
		PopUp(pop).sigh.htmlText = "<b>"+data.@glyph+"</b>"
		PopUp(pop).name_tf.htmlText = data.@name
		PopUp(pop).numb.htmlText = "<b>" + data.@id + "</b>"
		
		if (data.@color=="red") color = 0xF85881//e46e7e
		if (data.@color=="yellow") color = 0xFFCC33//ebc75d
		if (data.@color == "blue") color = 0x7DCCF7//7babd6
			
			
		TweenFilterLite.to(PopUp(pop).p, 0, { tint:color } );
		if (data.@formula!=""){
			var subscr:Array = String(data.@formula).split("&")
			PopUp(pop).sup.f.text = subscr[0]
			PopUp(pop).sup.f_sup.text = subscr[1]
			//подровнять
		} else {
			PopUp(pop).sup.f.text = ""
			PopUp(pop).sup.f_sup.text = ""
		}
		
		/*if (data.nuc.length() < 10){
			columns = 4;
		} else {
			columns = 6;
		}*/
		if (data.nuc.length() < 6) {
			columns = 4;
		} else {
			columns = Math.floor(data.nuc.length() / 2)
		}
		
		//выкатываем нуклиды
		for each (var nuc:XML in data.nuc) {
			pi = new PopUpItem(nuc, data)
			
			pi.y = count * 30
			pi.x = row * 150
			
			count++
			
			if (count > columns) {
				count = 0
				row++
			}
			container.addChild(pi)
		}
		
		PopUp(pop).bg.scale9Grid = new Rectangle(60, 60, 100, 100);
		PopUp(pop).bg.height = Math.max(200, container.height + 80)
		
		
		//уводим в ноль
		
		alpha = 0
		
		oldX = x
		oldY = y
		oldW = width
		oldH = height
		
		x  = Main.stage.stageWidth / 2
		y  = Main.stage.stageHeight /2
		
		width  = 1
		height = 1
		
		show()
	
	}
	private function show():void {
		TweenFilterLite.to(this, 0.6, {alpha:1, width:oldW, height:oldH, x:oldX, y:oldY, ease:Cubic.easeOut});	
	}
	private function resize(e:Event = null):void {
		x = (Main.stage.stageWidth - width) / 2
		y = (Main.stage.stageHeight-height)/2
	}
	private function onClose(e:MouseEvent = null):void {
		//закрыть попуп
		Main.mainController.removePopup();
	}
	private function onCloseOver(e:MouseEvent = null):void {
		TweenFilterLite.to(e.currentTarget, 0.1, {alpha:0.7} );
	}
	private function onCloseOut(e:MouseEvent = null):void {
		TweenFilterLite.to(e.currentTarget, 0.1, {alpha:1} );
	}
	}
	
}