package 
{
	import flash.display.MovieClip;
	import net.redefy.alternativa3D.primitives.Cylinder;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.core.Object3D;
	import alternativa.physics3dintegration.VertexLightMaterial;
	
	
	/**
	 * ...
	 * @author mibgheda
	 */
	public class Nuclide extends Object3D
	{
		private var red:Number = 0xFF2222
		private var green:Number = 0x00FF22
		private var white:Number = 0xFFFFFF
		private var grey:Number =  0x666666
		private var black:Number = 0x000000
		private var blue:Number = 0x666666//0x00ffff// 
		
		private var color:Number
		
		
		private var baseHeight:Number = 40//20;
		private var baseRadius:Number = 50;
		private var osIndex:Number = 30;
		private var osHeight:Number
		
		private var osDynamicHeightS:Number;
		private var osDynamicHeightP:Number;
		private var osDynamicHeightD:Number;
		
		private var delta:Number = 40//70;
		private var electroIndex:Number = 3//6;
		
		private var eheight:Number 
		
		private var proton:Cylinder;
		private var neutron:Cylinder;
		private var electron:Cylinder;
		private var os:Cylinder;
		private var con:Cylinder;
		
		private var p:Cylinder;
		private var n:Cylinder;
		private var e:Cylinder;
		private var he:Cylinder;//половинка электрона
		private var o:Cylinder;
		
		private var osPquant:int;
		private var osDquant:int;
		
		private var i:int
		private var j:int
		private var k:int
		private var l:int
		private var abs:Number = 1
		
		private var vh:int
		
		
		
		//было
		private var range:Array = [0, 4, 5, 1, 2, 6, 3, 7]
		
		//стало
		private var range2:Array = [5, 1, 2, 6, 3, 7, 0, 4]
		
		//тербий эрбий
		private var range3:Array = [0, 4, 7, 3, 6, 2, 1, 5]
		
		private var oneos:Boolean = false
		private var electroend:Boolean = false
		
		private var revert:Boolean = false
		
		//части формулы
		
		
		private var sflour_p:int;
		private var sindex_p:int;
		private var sindex_n:int;
		private var sflour_n:int;
		
		
		private var pflour_p:int;
		private var pindex_p:int;
		private var pflour_n:int;
		private var pindex_n:int;
		
		private var pflour_p2:int;
		private var pindex_p2:int;
		private var pflour_n2:int;
		private var pindex_n2:int;
		
		private var dflour_p:int;
		private var dindex_p:int;
		private var dflour_n:int;
		private var dindex_n:int;
		
		private var po:int
		

		
		public function Nuclide(formula:String,  exceptionP:Object = null, exceptionD:Object = null) {
			

			if (formula != "") {
				
				revert = false
				
				///////////централь
				os = new Cylinder(1, 1, 10, 30, 1, true, true, true, false)
				os.setMaterialToAllSurfaces(new VertexLightMaterial(black))
				addChild(os)
				os = new Cylinder(1, 1, 10, 30, 1, true, true, true, true)
				os.setMaterialToAllSurfaces(new VertexLightMaterial(black))
				addChild(os)
				
				
				
				
				//////////////////////////////////////////
				///уточнение, если 1 и 1 , луч вниз не идет
				/////////////////////////////////////////
			
				///расковыриваем формулу вида 2*s*2+2*p*8+6*d*1:2*s*2+2*p*8+6*d*1
				var form:Array = formula.split(":")
				
				//протонная часть
				var protonFormula:Array = String(form[0]).split("+")
				//нейтронная часть
				var neutronFormula:Array = String(form[1]).split("+")
				
				
				
				//по буквам
				
				if (protonFormula != null) {
					
					//буква S
					var protonOrbS:Array = String(protonFormula[0]).split("*")
					sflour_p = protonOrbS[0]
					sindex_p = protonOrbS[2]
					
					
					
					if (protonFormula[1]) {
						//буква P
						
						var protonOrbP:Array = String(protonFormula[1]).split("*")
						pflour_p = protonOrbP[0]
						pindex_p = protonOrbP[2]
						
						if (protonOrbP.length > 3) {
							//дополнительная п
							pflour_p2 = protonOrbP[3]
							pindex_p2 = protonOrbP[5]
						}
						
						///if (String(protonFormula[1]).split("^").length>1) trace(protonOrbP.length)
						
					} 
					if (protonFormula[2]) {
						//буква D
						var protonOrbD:Array = String(protonFormula[2]).split("*")
						dflour_p = protonOrbD[0]
						dindex_p = protonOrbD[2]
					}
					 
				} 
				///то же для нейтрона
				if (neutronFormula != null) {
					
						//буква S
						var neutronOrbS:Array = String(neutronFormula[0]).split("*")
						sflour_n = neutronOrbS[0]
						sindex_n = neutronOrbS[2]
					
						if (neutronFormula[1]) {
							//буква P
							var neutronOrbP:Array = String(neutronFormula[1]).split("*")
							pflour_n = neutronOrbP[0]
							pindex_n = neutronOrbP[2]
						
							if (neutronOrbP.length > 3) {
								pflour_n2 = neutronOrbP[3]
								pindex_n2 = neutronOrbP[5]
							}
						} 
						if (neutronFormula.length > 1) {
							//буква D
							var neutronOrbD:Array = String(neutronFormula[2]).split("*")
							dflour_n = neutronOrbD[0]
							dindex_n = neutronOrbD[2]
						}
					if (exceptionP != "revert") {
						revert = false
					} else {
						revert = true
					}
				} 
				
				///////////////////////////////
				/////////S УРОВЕНЬ
				///////////////////////////////
				
				
				////настройки. для S орбитали
				if (neutronFormula[0].toString() == "null" || revert) {
					//в формуле нейтрона вообще пусто
					electroend = true
				} else {
					
					electroend = false
				}
				
				//Сколько этажей?
				
				
				/////////////////////////////////
				//сколько осей? этаж протона. индекс оси протона.
				if (sflour_p == 1 && sindex_p == 1) {
					oneos = true
				} else {
					oneos = false
				}
				
				if (sflour_n == 1 && sindex_n == 2 && revert) {
					oneos = false;
				}
				
				
				
				if (oneos) {
					osDynamicHeightS = baseHeight * 14
				} else {
					osDynamicHeightS = sflour_p *baseHeight *2.5+baseHeight * electroIndex
					
				}
				
				///////////////////////////
				//////////строим лучи.
				///////////////////////////
				
				
				
				//ось вверх. z true. всегда.
				o = addOs(false, osDynamicHeightS);
				o.z = osDynamicHeightS/2 + delta
				
				con = addCone(false, 1);
				con.z = osDynamicHeightS + delta
				
				//ось вниз. z true. нет для водорода, нет, когда 1s1
				if (!oneos) {
					o = addOs(false, osDynamicHeightS);
					o.z = -(osDynamicHeightS / 2 + delta)
					
					con = addCone(false, -1);
					con.z = -(osDynamicHeightS + delta)
				}
				///////////////////////////////
				//расставляем протоны
				//////////////////////////////
				
				if (!revert){
				for (i = 0; i < sflour_p; i++) {
					//добавляем протоны для каждого этажа
					//протон вверх

					p = addProton(false)
					p.z = delta + baseHeight*2.5*i+baseHeight/2 //2.5 это 1 ч.л. протона, 1 ч.л. нейтрона, 0.5 ч.л. электрона
					
				
					if (!oneos){
						//протон вниз
						//протон на второй оси?
						if (! (sindex_p==1 && i == sflour_p-1) ){
							p = addProton(false)
							p.z = -(delta + baseHeight * 2.5 * i + baseHeight / 2)
						}
					}
					if (i == sflour_p - 1) {
						if (sindex_n){
						if (sindex_n < sindex_p) {
							//не хватает нейтрона
							//закрываем протон длинным электроном
							e = addElectron(false)
							e.z = -(delta + baseHeight * 2.5 * i + baseHeight / 2+(baseHeight * electroIndex+baseHeight)/2)
						} else if (sindex_n > sindex_p) {
							e = addElectron(false)
							e.z = +(delta + baseHeight * 2.5 * i + baseHeight / 2+(baseHeight * electroIndex+baseHeight)/2)
						} else if (sflour_p > sflour_n) {
							
							e = addElectron(false)
							e.z = (delta +  (sflour_p-1)*baseHeight*2.5+baseHeight+baseHeight*electroIndex/2)//+(delta + baseHeight * 2.5 * i + baseHeight / 2 + (baseHeight * electroIndex + baseHeight) / 2)
							
							if (sindex_n==1){
								e = addElectron(false)
								e.z = -(delta +  (sflour_n - 1) * baseHeight * 2.5 + baseHeight + baseHeight * electroIndex / 2)//-(delta + baseHeight * 2.5 * i )
							} else {
								e = addElectron(false)
								e.z = -(delta +  (sflour_p - 1) * baseHeight * 2.5 + baseHeight + baseHeight * electroIndex / 2)//-(delta + baseHeight * 2.5 * i )
							}
						}
						}
					}
				}
				} else {
					p = addProton(false)
					p.z = delta+baseHeight
				}
				///////////////////////////////
				//расставляем нейтроны. нейтронов нет? электрон.
				//////////////////////////////
				
				
				
				
				if (electroend) {
					//электрон вверх
					e = addElectron(false)
					if (!revert){
						e.z = delta + (baseHeight * electroIndex + baseHeight) / 2+baseHeight/2
					} else {
						e.z = delta + (baseHeight * electroIndex + baseHeight) / 2+baseHeight
					}
					
					if (!oneos) {
						//электрон вниз
						if (!revert){
							e = addElectron(false)
							e.z = -delta -  (baseHeight * electroIndex + baseHeight) / 2 - baseHeight / 2
						}
					}
					
				} else {
					
					//нейтроны
					for (i = 0; i < sflour_n; i++) {
						
						//нейтрон вверх
						n = addNeutron(false)
						n.z = delta + baseHeight * 2.5 * i + baseHeight * 1.5 + baseHeight / 2
						trace("нейтрон вверх")
						//перед каждым нейтроном добавим электрон
						he = addElectron(false, baseHeight/2)
						he.z = delta + baseHeight * 2.5 * i + baseHeight + baseHeight / 4
						
						if (!oneos){
							trace("нейтрон вниз")
							//на скольки осях нейтроны? TODO:
							if (!(sindex_n == 1 && i == (sflour_n - 1))) {
								//trace("нейтрон вниз")
								n = addNeutron(false)	
								n.z = -(delta + baseHeight * 2.5 * i + baseHeight * 1.5 + baseHeight / 2)
								
								//if (!electroend) {// && i != (sflour_p-1)
								//прослойка из половинок электронов
								he = addElectron(false, baseHeight/2)
								he.z = -(delta + baseHeight * 2.5 * i + baseHeight + baseHeight / 4)
								//}
							}
						}
					}
				}
				//исключение для водорода
				if (revert) {
					//добавили в начало 1 нейтрон
					n = addNeutron(false)
					n.z = delta
					//добавили в начало 2 нейтрона
					if (sindex_n == 2) {
						n = addNeutron(false)
						n.z = -delta
					}
				}
				///////////////////////////////
				
				///////////////////////////////
				/////////P УРОВЕНЬ
				///////////////////////////////
				
				//////////////////////////////
				////настройки
				/////////////////////////////
				
				
				
				
				
				
				var osTemptation:Array = []
				
				//противоположные
				osTemptation[0] = { x:0, y: -1, rotationZ:0, color:red, mod:1 }
				osTemptation[1] = { x:0, y: 1, rotationZ:0,  mod:-1 }
				
				//под углом 90 противоположные
				osTemptation[2] = { x:1, y:0, rotationZ: 270 * Math.PI / 180, mod:-1, color:green}
				osTemptation[3] = { x:-1, y:0, rotationZ:270 * Math.PI / 180, mod:1}
				
				//-45 градусов
				osTemptation[4] = { x:Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:-1 }
				osTemptation[5] = { x:-Math.cos(45 * Math.PI / 180), y:-Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:1  }
				
				//45 градусов
				osTemptation[6] = { x:Math.cos(45 * Math.PI / 180), y:-Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:1 }
				osTemptation[7] = { x:-Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:-1}
				
				
				
				var os3Temptation:Array = []
				//нулевая
				os3Temptation[0] = { x:0, y: -1, rotationZ:0, color:black, mod:1 }
				os3Temptation[1] = { x:Math.sin(120 * Math.PI / 180), y: -Math.cos(120 * Math.PI / 180), rotationZ:120 * Math.PI / 180, color:blue, mod:1 }
				os3Temptation[2] = { x:Math.sin(240 * Math.PI / 180), y: -Math.cos(240 * Math.PI / 180), rotationZ:240 * Math.PI / 180, color:red, mod:1 }
				
				//для мышьяка, искл 1
				var osEx1Temptation:Array = []
				//противоположные
				osEx1Temptation[0] = { x:0, y: -1, rotationZ:0, color:red, mod:1 }
				osEx1Temptation[1] = { x:0, y: 1, rotationZ:0, color:green, mod: -1 }
				//быв~6
				osEx1Temptation[2] = { x:Math.cos(45 * Math.PI / 180), y:-Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:1 }
				//быв~3 та же
				osEx1Temptation[3] = { x: -1, y:0, rotationZ:270 * Math.PI / 180, mod:1 }
				//быв~4 та же
				osEx1Temptation[4] = { x:Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:-1 }
				//быв~2
				osEx1Temptation[5] = { x:1, y:0, rotationZ: 270 * Math.PI / 180, mod: -1 }
				//быв~5 
				osEx1Temptation[6] = { x: -Math.cos(45 * Math.PI / 180), y: -Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:1  }
				//быв~7 та же
				osEx1Temptation[7] = { x: -Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod: -1 }
				
				//для селена искл 2
				var osEx2Temptation:Array = []
				
				//противоположные
				osEx2Temptation[0] = { x:0, y: -1, rotationZ:0, color:red, mod:1 }
				osEx2Temptation[1] = { x:0, y: 1, rotationZ:0,  mod:-1 }
				
				//под углом 90 противоположные
				osEx2Temptation[2] = { x:Math.cos(45 * Math.PI / 180), y: -Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:1 }
				osEx2Temptation[3] = { x:-Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:-1}
				
				
				//-45 градусов
				osEx2Temptation[4] = { x:Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:-1 }
				osEx2Temptation[5] = { x:-Math.cos(45 * Math.PI / 180), y:-Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:1  }
				
				//45 градусов
				
				osEx2Temptation[6] = { x:1, y:0, rotationZ: 270 * Math.PI / 180, mod: -1, color:green }
				osEx2Temptation[7] = { x: -1, y:0, rotationZ:270 * Math.PI / 180, mod:1 }
				
				
				//для фтора20 искл 3
				var osEx3Temptation:Array = []
				
				//противоположные
				osEx3Temptation[0] = { x:1, y:0, rotationZ: 270 * Math.PI / 180, mod: -1, color:green }
				osEx3Temptation[1] = { x:0, y: 1, rotationZ:0,  mod:-1 }
				
				//под углом 90 противоположные
				osEx3Temptation[2] = { x:Math.cos(45 * Math.PI / 180), y: -Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:1 }
				osEx3Temptation[3] = { x:-Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:-1}
				
				
				//-45 градусов
				osEx3Temptation[4] = { x:Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:-1 }
				osEx3Temptation[5] = { x:-Math.cos(45 * Math.PI / 180), y:-Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:1  }
				
				//45 градусов
				
				osEx3Temptation[6] = { x:0, y: -1, rotationZ:0, color:red, mod:1 }
				osEx3Temptation[7] = { x: -1, y:0, rotationZ:270 * Math.PI / 180, mod:1 }
				
				
				//для натрия24 искл 4
				var osEx4Temptation:Array = []
				
				//противоположные
				osEx4Temptation[0] = { x:0, y: 1, rotationZ:0,  mod:-1 }
				osEx4Temptation[1] = { x:Math.cos(45 * Math.PI / 180), y: -Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:1 }
				
				
				//под углом 90 противоположные
				
				osEx4Temptation[2] = { x: -Math.cos(45 * Math.PI / 180), y: -Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:1  }
				osEx4Temptation[3] = { x:-Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:-1}
				
				
				//-45 градусов
				osEx4Temptation[4] = { x:Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:-1 }
				osEx4Temptation[5] = { x:0, y: -1, rotationZ:0, color:red, mod:1 }
				
				//45 градусов
				
				osEx4Temptation[6] = { x:1, y:0, rotationZ: 270 * Math.PI / 180, mod: -1, color:green }
				osEx4Temptation[7] = { x: -1, y:0, rotationZ:270 * Math.PI / 180, mod:1,   color:blue }
				
				
				
				//для азота16 искл 5
				var osEx5Temptation:Array = []
				
				//противоположные
				osEx5Temptation[0] = { x:0, y: 1, rotationZ:0,  mod:-1 }
				osEx5Temptation[1] = { x:Math.cos(45 * Math.PI / 180), y: -Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:1 }
				
				
				//под углом 90 противоположные
				
				osEx5Temptation[2] = { x: -Math.cos(45 * Math.PI / 180), y: -Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:1  }
				osEx5Temptation[3] = { x:-Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:-1}
				
				
				//-45 градусов
				osEx5Temptation[4] = { x:Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:-1 }
				osEx5Temptation[7] = { x:0, y: -1, rotationZ:0, color:red, mod:1 }
				
				//45 градусов
				
				osEx5Temptation[6] = { x:1, y:0, rotationZ: 270 * Math.PI / 180, mod: -1, color:green }
				osEx5Temptation[5] = { x: -1, y:0, rotationZ:270 * Math.PI / 180, mod:1,   color:blue }
				
				
				
				//для брома, искл 6
				var osEx6Temptation:Array = []
				//противоположные
				osEx6Temptation[0] = { x:0, y: -1, rotationZ:0,  mod:1 }
				osEx6Temptation[1] = { x:0, y: 1, rotationZ:0, mod: -1 }
				
				osEx6Temptation[5] = { x:Math.cos(45 * Math.PI / 180), y:-Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , mod:1 }
				osEx6Temptation[7] = { x: -1, y:0, rotationZ:270 * Math.PI / 180, color:green, mod:1 }
				
				osEx6Temptation[4] = { x:Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180, mod:-1 }
				
				osEx6Temptation[2] = { x:1, y:0, rotationZ: 270 * Math.PI / 180,  mod: -1 }
				
				osEx6Temptation[6] = { x: -Math.cos(45 * Math.PI / 180), y: -Math.cos(45 * Math.PI / 180), rotationZ: -45 * Math.PI / 180,  mod:1  }
				
				osEx6Temptation[3] = { x: -Math.cos(45 * Math.PI / 180), y:Math.cos(45 * Math.PI / 180), rotationZ: 45 * Math.PI / 180 , color:red,  mod: -1 }
				
				osDynamicHeightP = baseHeight * Math.max(pflour_p,  pflour_p2)*2.5 +baseHeight*electroIndex
				osDynamicHeightD =  baseHeight * dflour_p +baseHeight * 10
				var r2:Number = delta + baseHeight*3
				var r:Number  = osDynamicHeightP / 2+r2
				var r3:Number = ((baseHeight * osIndex) / 2 + baseHeight * 2)/2
				
				
				//отстраиваем количество орбит pindex_n по нейтронам
				if (protonOrbP || neutronOrbP) {
					//в формуле есть орбиталь P. строим оси
					
					//сколько нужно? в граммах?
					//если количество этажей 1, то отстраиваем n осей, иначе отстраиваем все 8 осей
				
					pflour_n>1 ? osPquant = 8 : osPquant = pindex_n
					
					//отображаем
					if (osPquant == 3) {
							//три оси под углом 120
							osTemptation = os3Temptation
						} else if (exceptionP != null) {
							
							if (exceptionP=="exception1"){
								osTemptation = osEx1Temptation
							}
							else if (exceptionP == "exception2") {
								osTemptation = osEx2Temptation
							}
							else if (exceptionP == "exception3") {
								osTemptation = osEx3Temptation
							}
							else if (exceptionP == "exception4") {
								osTemptation = osEx4Temptation
							}
							else if (exceptionP == "exception5") {
								osTemptation = osEx5Temptation
							}
							else if (exceptionP == "exception6") {
								osTemptation = osEx6Temptation
							}
						}
					for (i = 0; i < osPquant; i++ ) {
						//построили оси
						
						i % 2 == 0 ? mod = 1 : mod = -1
						
						o = addOs(true, osDynamicHeightP, osTemptation[i].color);
						o.x = r*osTemptation[i].x
						o.y = r*osTemptation[i].y
						o.rotationZ = osTemptation[i].rotationZ
						
						con = addCone(true, osTemptation[i].mod);
						con.x = (r2+osDynamicHeightP)*osTemptation[i].x
						con.y = (r2+osDynamicHeightP)*osTemptation[i].y
						con.rotationZ = osTemptation[i].rotationZ
						//цепляем нейтрон.
						//на каждую ось.
						//для каждого полного этажа
						
						for (j = 0; j < pflour_n - 1; j++ ) {
							
							n = addNeutron(true)
							n.x = (r2+j*baseHeight*2.5)*osTemptation[i].x
							n.y = (r2+j*baseHeight*2.5)*osTemptation[i].y
							n.rotationZ = o.rotationZ
						}
						//цепляем протон? для всех полных протонных этажей.
						for (k = 0; k < pflour_p-1; k++ ) {
							p = addProton(true)
							p.x = (r2+k*baseHeight*2.5+baseHeight)*osTemptation[i].x
							p.y = (r2+k*baseHeight*2.5+baseHeight)*osTemptation[i].y
							p.rotationZ = o.rotationZ
						}
						
						//для всех полных этажей
						for (l = 0; l < pflour_p - 1; l++ ) {
							
							if (l == pflour_p - 2) { 
								
								//не все оси получат, только те, на которых есть pindex_n
								if (i < Math.max(pindex_p, pindex_n)) {
									trace('полуэлектрон1')
									he = addElectron(true, baseHeight/2)
									he.x = (r2+l*baseHeight*2.5-baseHeight/4+baseHeight*2)*osTemptation[i].x
									he.y = (r2+l*baseHeight*2.5-baseHeight/4+baseHeight*2)*osTemptation[i].y
									he.rotationZ = o.rotationZ
								} else {
									//по идее завершим ряд электроном. вроде правильно
									
									//и опять же, если цепанули лишний нейтрон
									if ((l < j)&&(pflour_n>pflour_p)) {
										trace(pflour_p+'не завершать ряд электроном, половинка'+pflour_n)
										he = addElectron(true, baseHeight/2)
										he.x = (r2+(pflour_p-1)*baseHeight*2.5-baseHeight/4-baseHeight/2)*osTemptation[i].x
										he.y = (r2+(pflour_p-1)*baseHeight*2.5-baseHeight/4-baseHeight/2)*osTemptation[i].y
										he.rotationZ = osTemptation[i].rotationZ
									} else {
										trace('завершить ряд электроном')
										e = addElectron(true)
										e.x = (r2+pflour_p*baseHeight*2.5-baseHeight*electroIndex/2-baseHeight/2)*osTemptation[i].x
										e.y = (r2+pflour_p*baseHeight*2.5-baseHeight*electroIndex/2-baseHeight/2)*osTemptation[i].y
										e.rotationZ = osTemptation[i].rotationZ
									}
								}
								
							} else {
								trace('полуэлектрон2')
								he = addElectron(true, baseHeight/2)
								he.x = (r2+l*baseHeight*2.5-baseHeight/4+baseHeight*2)*osTemptation[i].x
								he.y = (r2+l*baseHeight*2.5-baseHeight/4+baseHeight*2)*osTemptation[i].y
								he.rotationZ = o.rotationZ
							}
						}
					
						
					}
					
					//работаем с первым неполным этажом
				
					for (j = 0; j < pindex_n; j++ ) {
						//добавим нейтрон
						trace(pindex_n + " от 0 до")
						n = addNeutron(true, blue)
						n.x = (r2+(pflour_n-1)*baseHeight*2.5)*osTemptation[j].x
						n.y = (r2+(pflour_n-1)*baseHeight*2.5)*osTemptation[j].y
						
						n.rotationZ = osTemptation[j].rotationZ
					}
					
					for (k = 0; k < pindex_p; k++ ) {
						//добавим протон
						p = addProton(true)
						p.x = (r2+(pflour_p-1)*baseHeight*2.5+baseHeight)*osTemptation[k].x
						p.y = (r2+(pflour_p-1)*baseHeight*2.5+baseHeight)*osTemptation[k].y
						p.rotationZ = osTemptation[k].rotationZ
					}
					
					
					//но на этом мы не останавливаемся
					
					if (pflour_n2) {
						//дополнительные нейтронные этажи
						//собсно этаж
						for (i = pflour_n; i < pflour_n2; i++ ) {
								for (j = 0; j < pindex_n2; j++ ) {
									//добавим нейтрон
									
									n = addNeutron(true)
									n.x = (r2+(i)*baseHeight*2.5)*osTemptation[j].x
									n.y = (r2+(i)*baseHeight*2.5)*osTemptation[j].y
									n.rotationZ = osTemptation[j].rotationZ
									
									//а если есть нейтрон, перед ним электрнчиком закроется протон
									trace('полуэлектрон3')
									he = addElectron(true, baseHeight/2)
									he.x = (r2+(i)*baseHeight*2.5-baseHeight/4-baseHeight/2)*osTemptation[j].x
									he.y = (r2+(i)*baseHeight*2.5-baseHeight/4-baseHeight/2)*osTemptation[j].y
									he.rotationZ = osTemptation[j].rotationZ
								}
						}
						//тожсамое для протона
						for (i = pflour_p; i < pflour_p2; i++ ) {
								for (j = 0; j < pindex_p2; j++ ) {
									//добавим протон
									p = addProton(true)
									p.x = (r2+(i)*baseHeight*2.5+baseHeight)*osTemptation[j].x
									p.y = (r2+(i)*baseHeight*2.5+baseHeight)*osTemptation[j].y
									p.rotationZ = osTemptation[j].rotationZ
									
								
								}
								
						}
						//закроем электроны у 2х этажей
						for (i = 0; i < pindex_p2; i++ ) {
							trace('электрон2')
							e = addElectron(true)
							e.x = (r2+pflour_p*baseHeight*2.5+baseHeight*1.5+baseHeight*electroIndex/2)*osTemptation[i].x
							e.y = (r2+pflour_p*baseHeight*2.5+baseHeight*1.5+baseHeight*electroIndex/2)*osTemptation[i].y
							e.rotationZ = osTemptation[i].rotationZ
						}
						//закроем у первых
						for (l = pindex_n2; l < pindex_p ; l++ ) {
							
							//косяк здесь. электрона просто не должно быть
							trace('электрон3')
							e = addElectron(true)
							e.x = (r2+pflour_p*baseHeight*2.5+baseHeight*electroIndex/2-baseHeight)*osTemptation[l].x
							e.y = (r2+pflour_p*baseHeight*2.5+baseHeight*electroIndex/2-baseHeight)*osTemptation[l].y
							e.rotationZ = osTemptation[l].rotationZ
						}
						
						
					} else {
						//закроем электроны у этажей 1х доп этажей, потому что 2х нет
						if (pflour_n<=pflour_p){
							for (i = 0; i < pindex_p; i++ ) {
								trace('электрон4')
								e = addElectron(true)
								e.x = (r2+pflour_p*baseHeight*2.5-baseHeight*electroIndex/2+baseHeight*2)*osTemptation[i].x
								e.y = (r2+pflour_p*baseHeight*2.5-baseHeight*electroIndex/2+baseHeight*2)*osTemptation[i].y
								e.rotationZ = osTemptation[i].rotationZ
							}
						} else {
							
							for (i = 1; i < pindex_p; i++ ) {
								
								//в этом месте может быть нейтрон
								
								//trace('номер оси'+ i)
								//trace('нейтроны'+ j)
								
								if (i < j) {
									trace('на этой оси был нейтрон. половинка')
									he = addElectron(true, baseHeight/2)
									he.x = (r2+pflour_p*baseHeight*2.5-baseHeight/4-baseHeight/2)*osTemptation[i].x
									he.y = (r2+pflour_p*baseHeight*2.5-baseHeight/4-baseHeight/2)*osTemptation[i].y
									he.rotationZ = osTemptation[i].rotationZ
								} else {
									trace('добавляем полный электрон')
									e = addElectron(true)
									e.x = (r2+pflour_p*baseHeight*2.5-baseHeight*electroIndex/2+baseHeight*2)*osTemptation[i].x
									e.y = (r2+pflour_p*baseHeight*2.5-baseHeight*electroIndex/2+baseHeight*2)*osTemptation[i].y
									e.rotationZ = osTemptation[i].rotationZ
								}
							}
							
							if (pflour_n > 1) {
								trace('половинка электрона')
								he = addElectron(true, baseHeight/2)
								he.x = (r2+pflour_p*baseHeight*2.5-baseHeight/4-baseHeight/2)*osTemptation[0].x
								he.y = (r2+pflour_p*baseHeight*2.5-baseHeight/4-baseHeight/2)*osTemptation[0].y
								he.rotationZ = osTemptation[0].rotationZ
							}
							
						}
					}
				
				}
			
				//вы готовы к построению д-орбитали?
				//да, капитан!
					///////////////////////////////
				
				///////////////////////////////
				/////////D УРОВЕНЬ
				///////////////////////////////
				
				//////////////////////////////
				////настройки
				/////////////////////////////
				if (exceptionD != null) {
					if (exceptionD=="exception")
						range = range2
					else if (exceptionD == "exception2") {
						range = range3
					}
						
					
				}
				
				//заполняем полноценные этажи
				//если количество этажей 1, то отстраиваем n осей для нейтронов, иначе отстраиваем все 8 осей
				dflour_n>1 ? osDquant = 8 : osDquant = Math.ceil(dindex_n/2)
								
				//
				
				trace("начинаем строить ось D количеством "+osDquant)
				
				//
				
				for (i = 0; i < osDquant; i++ ) {
				
					var mod:Number
					i % 2 == 0 ? mod = 1 : mod = -1
					
					
					//построили оси
					//вверх
					
					o = addOs(false, osDynamicHeightD);
					o.z = (osDynamicHeightD/2+delta) * mod 
					o.x = r3 * Math.cos((67.5*(range[i]*2-1))*Math.PI/180)
					o.y = r3 * Math.sin((67.5 * (range[i] * 2 - 1)) * Math.PI / 180)
					con = addCone(false, 1);
					con.z = osDynamicHeightD + delta
					con.x = r3 * Math.cos((67.5*(range[i]*2-1))*Math.PI/180)
					con.y = r3 * Math.sin((67.5 * (range[i] * 2 - 1)) * Math.PI / 180)
					
					//не строим, если осей нечетное количество ??
					//не строим, если нечетные нейтроны
					if (dindex_n%2 == 0){
						//вниз
						o = addOs(false, osDynamicHeightD);
						o.z = -(osDynamicHeightD/2+delta) * mod 			
						o.x = r3 * Math.cos((67.5*(range[i]*2-1))*Math.PI/180)
						o.y = r3 * Math.sin((67.5 * (range[i] * 2 - 1)) * Math.PI / 180)
						con = addCone(false, -1);
						con.z = -(osDynamicHeightD + delta)
						con.x = r3 * Math.cos((67.5*(range[i]*2-1))*Math.PI/180)
						con.y = r3 * Math.sin((67.5*(range[i]*2-1)) * Math.PI / 180)
					}
					
					//цепляем нейтрон.
					//на каждую ось.
					//для каждого полного этажа
					for (j = 0; j < dflour_n-1; j++ ) {
						//нейтрон вверх
						n = addNeutron(false)
						n.x = r3 * Math.cos((67.5*(range[i]*2-1))*Math.PI/180)
						n.y = r3 * Math.sin((67.5*(range[i]*2-1)) * Math.PI / 180)
						n.z = delta+baseHeight/2 + baseHeight*j*2.5
					
						//нейтрон вниз
						n = addNeutron(false)
						n.x = r3 * Math.cos((67.5*(range[i]*2-1))*Math.PI/180)
						n.y = r3 * Math.sin((67.5*(range[i]*2-1)) * Math.PI / 180)
						n.z = -(delta + baseHeight / 2 + baseHeight * j * 2.5)
						
						
						
						
					}
					
					
						for (j = 0; j < dflour_n - 2; j++ ) {
							//перед каждым нейтроном добавим электрон
							he = addElectron(false, baseHeight/2)
							he.x = r3 * Math.cos((67.5*(range[i]*2-1))*Math.PI/180)
							he.y = r3 * Math.sin((67.5*(range[i]*2-1)) * Math.PI / 180)
							he.z = delta+baseHeight*j*2.5+baseHeight*2+baseHeight/4
							//перед каждым нейтроном добавим электрон вниз
							he = addElectron(false, baseHeight/2)
							he.x = r3 * Math.cos((67.5*(range[i]*2-1))*Math.PI/180)
							he.y = r3 * Math.sin((67.5*(range[i]*2-1)) * Math.PI / 180)
							he.z = -(delta + baseHeight * j * 2.5 + baseHeight * 2 + baseHeight / 4)
						}
					
				
					
					//цепляем протон. для всех полных протонных этажей.
					for (k = 0; k < dflour_p-1; k++ ) {
						//протон вверх
						p = addProton(false)
						p.x = r3 * Math.cos((67.5*(range[i]*2-1))*Math.PI/180)
						p.y = r3 * Math.sin((67.5*(range[i]*2-1)) * Math.PI / 180)
						//!
						p.z = delta+baseHeight/2 + baseHeight*k*2.5+baseHeight
						
						//протон вниз
						p = addProton(false)
						p.x = r3 * Math.cos((67.5*(range[i]*2-1))*Math.PI/180)
						p.y = r3 * Math.sin((67.5*(range[i]*2-1)) * Math.PI / 180)
						p.z = -(delta+baseHeight/2 + baseHeight*k*2.5+baseHeight)
					}
					
				}
				//работаем с неполным этажом
				
				//trace("надстраиваем нечетное, на обе стороны "+dindex_n)
				
				for (j = 0; j < dindex_n; j++ ) {
					
					j % 2 == 0 ? mod = 1 : mod = -1
					
					
					//добавим нейтрон
					var ji:int = j/2
					
					n = addNeutron(false)
					
					//dflour_n==1 ? vh = 0 : vh = dflour_n
					
					n.x = r3 * Math.cos((67.5*(range[ji]*2-1))*Math.PI/180)
					n.y = r3 * Math.sin((67.5 * (range[ji] * 2 - 1)) * Math.PI / 180)
					//коррекция с учетом половинок эелектронов
					n.z = mod * (delta + baseHeight / 2 + baseHeight * (dflour_n - 1) * 2.5)
					
					//перед каждым нейтроном добавим электрон
					
					if (dflour_p>1) {
						he = addElectron(false, baseHeight/2)
						he.x = r3 * Math.cos((67.5*(range[ji]*2-1))*Math.PI/180)
						he.y = r3 * Math.sin((67.5 * (range[ji] * 2 - 1)) * Math.PI / 180)
						he.z = mod * (delta + baseHeight * (dflour_n - 1) * 2.5 + baseHeight * 2 + baseHeight / 4 - baseHeight * 2.5)
					}
					
					
				}
				
				for (j = 0; j < dindex_p; j++ ) {
					
					j % 2 == 0 ? mod = 1 : mod = -1
					
					//добавим протон
					var jj:int = j / 2
					
					//dflour_n == 1 ? vh = 0 : vh = dflour_n;
					
					p = addProton(false)
					p.x = r3 * Math.cos((67.5*(range[jj]*2-1))*Math.PI/180)
					p.y = r3 * Math.sin((67.5 * (range[jj] * 2 - 1)) * Math.PI / 180)
					//коррекция 2 на 2.5
					p.z = mod * (delta+baseHeight/2 + baseHeight*(dflour_n-1)*2.5+baseHeight)
				}
				//закрываем электроны
				//электроны
				
				if  (dflour_p > 0) {
					//закрываем все целые этажи
					if  (dflour_p > 1) {
						for (k = dindex_n; k < osDquant*2; k++ ) {
							var jk:int = k/2
							k % 2 == 0 ? mod = 1 : mod = -1
												
							e = addElectron(false)
							e.x = r3 * Math.cos((67.5*(range[jk]*2-1))*Math.PI/180)
							e.y = r3 * Math.sin((67.5 * (range[jk] * 2 - 1)) * Math.PI / 180)
							//коррекция 2 на 2.5
							e.z = mod * (delta+baseHeight*electroIndex/2 + baseHeight*(dflour_p-1)*2.5-baseHeight/2)
						}
					}
					//теперь неполные закроем.
					//только для протонного ряда.
					
					
					
					for (k = 0; k < dindex_p; k++ ) {
						
						var jf:int = k/2
						
						k % 2 == 0 ? mod = 1 : mod = -1
						e = addElectron(false)
					
						e.x = r3 * Math.cos((67.5*(range[jf]*2-1))*Math.PI/180)
						e.y = r3 * Math.sin((67.5 * (range[jf] * 2 - 1)) * Math.PI / 180)
						//коррекция 2 на 2.5
						e.z = mod * (delta+baseHeight*electroIndex/2 + baseHeight*(dflour_p)*2.5-baseHeight/2)
					}
					
				}
			
			}
		}
		private function addOs(isZ:Boolean, h:Object = null, col:Object = null):Cylinder  {
			if (col == null) { color = black } else { color = black}///color = Number(col) }
			
			if (h == null) { osHeight = baseHeight*osIndex } else { osHeight = Number(h) }
			
			os = new Cylinder(2, 2, osHeight, 30, 1, true, true, true, isZ)
			os.setMaterialToAllSurfaces(new VertexLightMaterial(color))
			addChild(os)
			return os
		}
		private function addCone(isZ:Boolean, right:Object = null):Cylinder  {
			if (right == 1) {
				con = new Cylinder(1, 5, 10, 30, 1, true, true, true, isZ)
			} else {
				con = new Cylinder(5, 1, 10, 30, 1, true, true, true, isZ)
			}
			con.setMaterialToAllSurfaces(new VertexLightMaterial(color))
			addChild(con)
			return con
		}
		private function addProton(isZ:Boolean):Cylinder {
			proton = new Cylinder(baseRadius, baseRadius, baseHeight-1, 30, 1, true, true, true, isZ)
			proton.setMaterialToAllSurfaces(new VertexLightMaterial(red))
			addChild(proton)
			return proton
		}
		private function addNeutron(isZ:Boolean, col:Object = null):Cylinder  {
			if (col == null) {color = grey} else {color = Number(col)}
			neutron = new Cylinder(baseRadius, baseRadius, baseHeight-1, 30, 1, true, true, true, isZ)
			neutron.setMaterialToAllSurfaces(new VertexLightMaterial(color))
			addChild(neutron)
			return neutron
		}
		private function addElectron(isZ:Boolean, height:Object = null, col:Object = null):Cylinder  {
			if (col == null) { color = green } else { color = Number(col) }
			if (height == null) { eheight = baseHeight*electroIndex } else { eheight = Number(height) }
			electron = new Cylinder(baseRadius, baseRadius, eheight, 30, 1, true, true, true, isZ)
			electron.setMaterialToAllSurfaces(new VertexLightMaterial(color))
			addChild(electron)
			return electron
		}
		private function destroy():void {
			while (numChildren>0) removeChildAt(0)
		}
	}
	
}