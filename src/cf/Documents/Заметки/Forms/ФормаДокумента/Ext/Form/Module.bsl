﻿
&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	ТекущийОбъект.Хранилище = Новый ХранилищеЗначения(ФорматированныйДокумент);
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	ФорматированныйДокумент = ТекущийОбъект.Хранилище.Получить();	
КонецПроцедуры
