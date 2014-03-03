package  {

	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.lights.DirectionalLight;
	import alternativa.engine3d.lights.OmniLight;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	
	
	import alternativa.engine3d.primitives.Box;
	
	import net.redefy.alternativa3D.primitives.Cylinder;

	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gs.*;

	/**
	 * Alternativa3D "Hello world!" application. 
	 * Создание простейшего трёхмерного приложения.
	 */
	public class View3D extends Sprite {
		
		private var rootContainer:Object3D = new Object3D();
		private var justContainer:Object3D = new Object3D();
		private var cameraContainer:Object3D = new Object3D();
		
		private var camera:Camera3D;
		private var stage3D:Stage3D;
		
		
		public var container:Sprite = new Sprite();
		private var white:Number = 0xFFFFFF
		
		private var isDrag:Boolean = false
		
		private var light:DirectionalLight
		
		private var scale:Number = 1
		
		private var close:DisplayObject;
		private var hint:DisplayObject;
		private var hint2:DisplayObject;
		private var hintName:HintName
		public var pauseBtn:TugglePause
		private var printBtn:PrintButton;
		
		[Embed(source = "../assets/nuclear_graph.swf", symbol = "$Back")] private static const CloseBtn:Class;	
		[Embed(source = "../assets/nuclear_graph.swf", symbol = "$Hint")] private static const Hint:Class;	
		[Embed(source = "../assets/nuclear_graph.swf", symbol = "$Hint2")] private static const Hint2:Class;	
		
		public var isPause:Boolean
		
		private var controller:SimpleObjectController
		
		public function View3D() {
			run()
			visible = false
		}
		public function run():void {
			Main.stage.align = StageAlign.TOP_LEFT;
			Main.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addChild(container);
			// Camera and view
			// Создание камеры и вьюпорта
			
			camera = new Camera3D(0.4, 10000);
			
			camera.z = 400;
			camera.y = -800;
			camera.rotationX = -120*Math.PI/180;
			
			
			camera.view = new View(Main.stage.stageWidth, Main.stage.stageHeight, false, 0xE2F9FF, 0, 4);
			camera.view.antiAlias = 14;  
			camera.view.hideLogo();
			camera.view.renderToBitmap = true;
			container.addChild(camera.view);
			
		
			cameraContainer.addChild(camera);
			rootContainer.addChild(justContainer);
			rootContainer.addChild(cameraContainer);
			
			controller = new SimpleObjectController(Main.stage, cameraContainer, 400);
			controller.lookAtXYZ(0, 0, 0);
			controller.unbindAll();
			
				
			//свет
			light = new DirectionalLight(white);  
            light.z = 400;  
            light.y = -800;
			light.rotationX = -120*Math.PI/180; 
            light.lookAt(0, 0, 0);  
            light.intensity = 2;  
            cameraContainer.addChild(light);
			
			
			var light2:DirectionalLight = new DirectionalLight(white);  
            light2.z = -400;  
            light2.y = 800;
            light2.lookAt(0, 0, 0);  
            light2.intensity = 2;  
            cameraContainer.addChild(light2);
			
			close = new CloseBtn
			close.x = Main.stage.stageWidth - close.width - 20
			close.y = 20
			CloseBtn(close).mouseChildren = false
			CloseBtn(close).buttonMode = true
			addChild(close)
			
			hint = new Hint
			
			hint.x = Main.stage.stageWidth - hint.width - 20
			hint.y = Main.stage.stageHeight - hint.height- 20
			addChild(hint)
			
			Hint(hint).close_btn.addEventListener(MouseEvent.CLICK, onCloseHint);
			
			hint2 = new Hint2
			hint2.x = 20
			hint2.y = Main.stage.stageHeight - hint2.height- 20
			addChild(hint2)
			
			Hint2(hint2).close_btn.addEventListener(MouseEvent.CLICK, onCloseHint2);
			
			hintName = new HintName
			hintName.x = 20
			hintName.y = 20
			addChild(hintName)
			
			pauseBtn = new TugglePause(this);
			pauseBtn.x =  Main.stage.stageWidth - close.width - 20 - 60
			pauseBtn.y =  20
			addChild(pauseBtn)
			
			printBtn = new PrintButton(this, container);
			printBtn.x =  Main.stage.stageWidth - close.width - 20 - 60 - 60
			printBtn.y =  20
			addChild(printBtn)
			
		}
		public function init(data:XML, parentdata:XML):void {

			isPause = false
			pauseBtn.refresh();
			
			var formula:String = data.@formula
			hintName.init(data, parentdata)
			visible = true
			//hint.visible = true
			//hint2.visible = true
			
			justContainer.scaleX = 0.1
			justContainer.scaleY = 0.1
			justContainer.scaleZ = 0.1
			
			//добавляем нуклид
			createNuclid(formula, data.@pPosition, data.@dPosition)
			
			
			stage3D = Main.stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreate);
			stage3D.requestContext3D();
			
		}
		
		
		private function createNuclid(formula:String, pPos:String, dPos:String):void {
			
				justContainer.addChild(new Nuclide(formula, Object(pPos), Object(dPos)))
			
		}
		
		
		
		private function onContextCreate(e:Event):void {
			for each (var resource:Resource in rootContainer.getResources(true)) {
				resource.upload(stage3D.context3D);
			}
			
			
			// Listeners

			// Подписка на события
			Main.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			Main.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			Main.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			Main.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			Main.stage.addEventListener(MouseEvent.DOUBLE_CLICK, onDouble);
			Main.stage.addEventListener(Event.RESIZE, resize)
			close.addEventListener(MouseEvent.CLICK, onClose);
			
			resize();
			scale = 0.5
			TweenFilterLite.to(justContainer, 1, { scaleX:scale, scaleY:scale, scaleZ:scale, onComplete:function():void { isDrag = false } } )
		}
		
		
		private function onEnterFrame(e:Event):void {
			
			
			camera.render(stage3D);
			controller.update();
			
			
			if (!isPause){
			// Rotation
			if (!isDrag){
				//justContainer.rotationX -= 0.01;
				justContainer.rotationY -= 0.01;
				justContainer.rotationZ -= 0.01;
			}
			
			}
		}
		
		public function stopRendering():void { 
			TweenFilterLite.killTweensOf(justContainer);
			Main.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onMouseDown(e:MouseEvent):void {
			isDrag = true
			Main.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseUp(e:MouseEvent):void {
			isDrag = false
			Main.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		private function onMouseMove(e:MouseEvent):void {
				justContainer.rotationX -= 0.01;
				//justContainer.rotationZ -= 0.01;
				//camera.rotationX += 0.001
				
		}
		private function onMouseWheel(e:MouseEvent):void {
			isDrag = true
			scale += 0.01 * e.delta
			TweenFilterLite.to(justContainer, 0.3, { scaleX:scale, scaleY:scale, scaleZ:scale, onComplete:function():void { isDrag = false } } )
		}
		private function onDouble(e:MouseEvent):void {
			isDrag = true
		}
		
		private function onClose(e:MouseEvent):void {
			destroy()
			visible = false
			
			clear(justContainer);
			Main.mainController.close3D();
		}
		
		private function onCloseHint(e:MouseEvent):void {
			hint.visible = false
		}
		private function onCloseHint2(e:MouseEvent):void {
			hint2.visible = false
		}
		public function destroy():void {
			Main.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			Main.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			Main.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			Main.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			Main.stage.removeEventListener(MouseEvent.DOUBLE_CLICK, onDouble);
			Main.stage.removeEventListener(Event.RESIZE, resize)
			Main.stage.removeEventListener(MouseEvent.CLICK, onClose);
		}
		private function clear(item:*):void {
			while (item.numChildren>0) item.removeChildAt(0)
		}
		private function resize(e:Event=null):void {
			//ресайз
			camera.view.width = Main.stage.stageWidth;
			camera.view.height = Main.stage.stageHeight;
			
			close.x = Main.stage.stageWidth - close.width - 20
			close.y = 20	
			
			hint.x = Main.stage.stageWidth - hint.width - 20
			hint.y = Main.stage.stageHeight - hint.height - 20
			
			
			hint2.y = Main.stage.stageHeight - hint2.height - 20
			
			pauseBtn.x =  Main.stage.stageWidth - close.width - 20 - 60
			
			printBtn.x =  Main.stage.stageWidth - close.width - 20 - 60 - 60
		}
	}
}

