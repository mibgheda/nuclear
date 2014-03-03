package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent
	import gs.*
	/**
	 * ...
	 * @author mibgheda
	 */
	public class PopUpItem extends MovieClip 
	{
		[Embed(source = "../assets/nuclear_graph.swf", symbol = "$PopUpItem")] private static const Nuc:Class;
		[Embed(source = "../assets/nuclear_graph.swf", symbol = "$FPart")] private static const FPart:Class;
		private var part:DisplayObject
		private var nuc:DisplayObject
		private var data:XML
		private var parentdata:XML
		private	var formula:Array 
		private	var w:Number
		
		private var radoiactiveSymbols:Array
		
		public function PopUpItem($data:XML, $parentdata:XML):void {
			
			
			
			parentdata = $parentdata
			data = $data
			
			
			nuc =  new Nuc()
			addChild(nuc)
			
			Nuc(nuc).mouseChildren	= false
			Nuc(nuc).buttonMode		= true
			
			Nuc(nuc).gly.elem_id.text = data.@zaryad
			Nuc(nuc).gly.elem_name.text = parentdata.@glyph
			Nuc(nuc).gly.elem_weight.text = data.@mass
			
			Nuc(nuc).gly.elem_weight.x = 23 + Nuc(nuc).gly.elem_name.textWidth;
			/*
			radoiactiveSymbols = []
			radoiactiveSymbols["alpha"] = Nuc(nuc).alpha_
			radoiactiveSymbols["beta-"] = Nuc(nuc).beta_minus
			radoiactiveSymbols["beta+"] = Nuc(nuc).beta_plus
			
			
			Nuc(nuc).gly.elem_name.text = parentdata.@name
			Nuc(nuc).gly.elem_sup.text  = data.@id
			
			
			if (data.@formula && data.@formula!="" && data.@formula!=" "){
				var subscr:Array = String(data.@formula).split(":")
				var proton:Array = String(subscr[0]).split("+")
				w = 0
				
			
				
				for (var i:int = 0; i < proton.length; i++) {
					formula = String(proton[i]).split("*")
					part = new FPart
					part.x = w
					Nuc(nuc).formula.addChild(part)
					FPart(part).tf.text = formula[0]+formula[1]
					FPart(part).tf_sup.text = formula[2]
					FPart(part).tf_sup.x = FPart(part).tf.textWidth + 1
					
					w += (part.width-10)
				}
				
			} 

			
			if (data.@radioactive.toString()!='') {
				
				var rad:Array = String(data.@radioactive).split(",")
				var w:Number = Nuc(nuc).formula.width+60
				
				for (var j:int = 0; j < rad.length; j++ ) { 
					radoiactiveSymbols[rad[j]].alpha = 1
					radoiactiveSymbols[rad[j]].x = w
					w += radoiactiveSymbols[rad[j]].width+5
				}
				
			}
			*/
			Nuc(nuc).addEventListener(MouseEvent.CLICK, onClick)
			Nuc(nuc).addEventListener(MouseEvent.MOUSE_OVER, onOver)
			Nuc(nuc).addEventListener(MouseEvent.MOUSE_OUT, onOut)
		}
		private function onClick(e:MouseEvent):void {
			//открываем 3демодель
			Main.mainController.open3D(data, parentdata);
		}
		private function onOver(e:MouseEvent):void {
			TweenFilterLite.to(Nuc(nuc).bg, 0.5, { alpha:1 } );
			TweenFilterLite.to(Nuc(nuc).gly, 0.5, { tint:0x333333 } );
			//TweenFilterLite.to(Nuc(nuc).formula, 0.5, { tint:0x666666} );
			TweenFilterLite.to(Nuc(nuc).strelka, 0.5, {tint:0x7BA7D2} );
		}
		private function onOut(e:MouseEvent):void {
			TweenFilterLite.to(Nuc(nuc).bg, 0.5, { alpha:0 } );
			TweenFilterLite.to(Nuc(nuc).gly, 0.5, { tint:null } );
			//TweenFilterLite.to(Nuc(nuc).formula, 0.5, { tint:null } );
			TweenFilterLite.to(Nuc(nuc).strelka, 0.5, {tint:null} );
		}
		
	}
	
}