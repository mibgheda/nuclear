package 
{
	
	/**
	 * ...
	 * @author mibgheda
	 */
	public class OrbP
	{
		private var pflour_p:Number = 3
		private var pindex_p:Number = 2
		
		private var pflour_p2:Number = 4
		private var pindex_p2:Number = 1
		
		private var i:int
		private var j:int
		private var k:int
		private var l:int
		
		
		public function OrbP() {
			var full_flours = pindex_p - 1
			
			//строим протонную часть
			//количество целых этажей
			for (i = 0; i < full_flours; i++) {
				//на все восемь осей
				for (j = 0; j < 8 ; j++) {
					//добавлям протон
					//координаты протона*i*j
					trace("добавим протон "+i+" на ось "+j)
					//думаем, каким электроном мы будем закрывать протон
					
					//закрываем половинкой, если i!=full_flours (если не последний этаж, то это точно половинка)
					if (i != full_flours-1) {
						trace("закроем протон "+i+" на оси "+j+" половинкой электрона")
					} else {
						//последний целый этаж, подумаем
						var will_end_os = 8 - pindex_p
						if (j > will_end_os) {
							trace("закроем протон "+i+" на оси "+j+" полным электроном")
						} else {
							trace("закроем протон "+i+" на оси "+j+" половинкой электрона")
						}
					}
				} 
			}
			//неполный этаж 1. вместо i исп. pflour_p. вместо osQuant pindex_p
			for (j = 0; j < pindex_p ; j++) {
				trace("добавим протон " + pflour_p + " на ось " + j)
				//думаем, каким электроном мы будем закрывать протон
				if (pflour_p2) {
					if (j < pindex_p2) {
						trace("закроем протон "+pflour_p+" на оси "+j+" полным электроном")
					} else {
						trace("закроем протон "+pflour_p+" на оси "+j+" половинкой электрона")
					}
				}
			}
			//неполный этаж 1. вместо i исп. pflour_p2. вместо osQuant pindex_p2
			for (j = 0; j < pindex_p2 ; j++) {
				trace("добавим протон " + pflour_p2 + " на ось " + j)
				//думаем, каким электроном мы будем закрывать протон
				if (pflour_p2) {
					if (j < pindex_p2) {
						trace("закроем протон "+pflour_p2+" на оси "+j+" полным электроном")
					} else {
						trace("закроем протон "+pflour_p2+" на оси "+j+" половинкой электрона")
					}
				}
			}
		}
	}
	
}