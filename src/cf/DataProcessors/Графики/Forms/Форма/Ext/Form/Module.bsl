﻿
&НаКлиенте
Процедура ОткрытьГрафик(Команда)                           
	СтрПараметры = Новый Структура;
	СтрПараметры .Вставить("Инструмент",Инструмент);
	СтрПараметры .Вставить("Таймфрейм",Таймфрейм); 
	СтрПараметры.Вставить("ПериодНачало",Период.ДатаНачала);
	СтрПараметры.Вставить("ПериодКонец", Период.ДатаОкончания);
	ОткрытьФорму("ОбщаяФорма.ФормаГрафикаAmChart",СтрПараметры );
КонецПроцедуры
