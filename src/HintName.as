package 
{
	import alternativa.engine3d.objects.Sprite3D;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import gs.*
	import gs.easing.*
	
	
	/**
	 * ...
	 * @author mibgheda
	 */
	public class HintName extends MovieClip
	{
		[Embed(source = "../assets/nuclear_graph.swf", symbol = "$NucName")] private static const Pad:Class;	
		[Embed(source = "../assets/nuclear_graph.swf", symbol = "$FPart")] private static const FPart:Class;
		private var pad:DisplayObject
		private var col:Number
		private var part:DisplayObject
		private var formula:Array
		private var w:Number = 0
		
		private var pformula:Sprite = new Sprite
		private var nformula:Sprite = new Sprite
		
		
		private var i:int
		
		private var neutron:Array
		private var proton:Array
		
		private var radoiactiveSymbols:Array
		
		public function HintName():void {
			pad = new Pad
			addChild(pad)
			
			pformula.x = 95
			pformula.y = 145
			
			nformula.x = 95
			nformula.y = 170
			
			
				
			addChild(pformula)
			addChild(nformula)
			
			
		}
		public function init(data:XML, parentdata:XML):void {
			clear(pformula)
			clear(nformula)
			
			neutron = null
			proton  = null
			
			//настраиваем элемент	
			Pad(pad).sigh.htmlText = "<b>"+parentdata.@glyph+"</b>"
			Pad(pad).name_tf.htmlText = parentdata.@name
			Pad(pad).mass.htmlText = "<b>" + data.@mass + "</b>"
			Pad(pad).numb.htmlText = "<b>" + parentdata.@id + "</b>"
			
			Pad(pad).zaryad.text = data.@zaryad;
			Pad(pad).raspad.text = data.@raspad;
			
			Pad(pad).zaryad.x = 14-Pad(pad).sigh.textWidth/2
			
			if (parentdata.@color=="red") 		col = 0xF85881
			if (parentdata.@color=="yellow") 	col = 0xFFCC33
			if (parentdata.@color== "blue") 	col = 0x7DCCF7
			
			TweenFilterLite.to(Pad(pad).p, 0, { tint:col } );
			
			
				
			
			
			if (data.@formula && data.@formula!="" && data.@formula!=" "){
				var subscr:Array = String(data.@formula).split(":")
				
				if (subscr[0] != null) {
					//trace(subscr[0])
					proton = String(subscr[0]).split("+")

				}
				if (subscr[1] != "null" && subscr[1] != "revert") {
					
					neutron = String(subscr[1]).split("+")
				} else if (subscr[1] == "revert") {
					subscr[1] = "1*s*1"
					neutron = String(subscr[1]).split("+")
				}
		
				w = 0
				if (proton){
				for (i = 0; i < proton.length; i++) {
				
					formula = String(proton[i]).split("*")
					
					if (formula.length>0){
					part = new FPart
					part.x = w
					pformula.addChild(part)
					
					FPart(part).tf.text = formula[0]+formula[1]
					FPart(part).tf_sup.text = formula[2]
					FPart(part).tf_sup.x = FPart(part).tf.textWidth + 1
					
					w += (part.width - 10)
					
					if (formula.length > 4) {

						part = new FPart
						part.x = w
						pformula.addChild(part)
						FPart(part).tf.text = formula[3]+formula[1]
						FPart(part).tf_sup.text = formula[5]
						FPart(part).tf_sup.x = FPart(part).tf.textWidth + 1
						
						w += (part.width - 10)
					}
					}
				
				}
				}
				
				if (neutron){
					w = 0
			
					for (i = 0; i < neutron.length; i++) {
					
						if (String(neutron[i])!="null"){
							formula = String(neutron[i]).split("*")
					
							part = new FPart
							part.x = w
							nformula.addChild(part)
							FPart(part).tf.text = formula[0]+formula[1]
							FPart(part).tf_sup.text = formula[2]
							FPart(part).tf_sup.x = FPart(part).tf.textWidth + 1
					
							w += (part.width - 10)
					
							if (formula.length > 3) {
								//trace("двойно пэ")
								part = new FPart
								part.x = w
								nformula.addChild(part)
								FPart(part).tf.text = formula[3]+formula[1]
								FPart(part).tf_sup.text = formula[5]
								FPart(part).tf_sup.x = FPart(part).tf.textWidth + 1
					
								w += (part.width - 10)
							}
						} else {
						
						}
					}
				}
			}
			
		}
		
		private function clear(item:*):void {
				while (item.numChildren>0) item.removeChildAt(0)
			}
	}
	
}