package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.display.BitmapData;
	import flash.printing.PrintJob;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author mibgheda
	 */
	public class PrintButton extends MovieClip
	{
		[Embed(source = "../assets/nuclear_graph.swf", symbol = "$Print")] private static const Prn:Class;
		private var prn:DisplayObject
		private var $parent:View3D
		
		private var view:Sprite;
	
		
		public function PrintButton($$parent:DisplayObject, _view:Sprite):void {
			$parent  = View3D($$parent)
			
			view = _view;
			
			prn  = new Prn()
			addChild(prn)
			
			
			Prn(prn).buttonMode = true
			
			addEventListener(MouseEvent.CLICK, onClick)
			
		}
	
		private function onClick(e:MouseEvent):void {
			
			$parent.isPause = true;
			$parent['pauseBtn'].refresh();
			//$parent.stopRendering()
			
			
			var jpgSource:BitmapData = new BitmapData (3200, 3200)
				jpgSource.draw(view); 
				
				
			
			var bitmap:Bitmap = new Bitmap(jpgSource);
				bitmap.x = 200
			
			var printSprite:Sprite = new Sprite();
				printSprite.addChild(bitmap);
				printSprite.scaleX = printSprite.scaleY = 0.30;
				
				
		
			
			var myPrintJob:PrintJob = new PrintJob();
			
			/*var myScale:Number;
				myScale = Math.min(myPrintJob.pageWidth/printSprite.width, myPrintJob.pageHeight/printSprite.height);
				printSprite.scaleX = printSprite.scaleY = myScale;
			var printArea:Rectangle = new Rectangle(0, 0, myPrintJob.pageWidth / myScale, myPrintJob.pageHeight / myScale);*/
	
			trace("Скриншот!"+printSprite);
			
			
			
				myPrintJob.start();
				
				myPrintJob.addPage(printSprite);
				myPrintJob.send();
				
		}
	}
	
}