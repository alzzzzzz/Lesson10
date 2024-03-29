﻿
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.МесячныйБюджет") Тогда
		// Заполнение шапки
		Бюджет = ДанныеЗаполнения.Ссылка;
	КонецЕсли;
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)

	// регистр ОстаткиДенежныхСредств Расход
	Движения.ОстаткиДенежныхСредств.Записывать = Истина;
	Для Каждого ТекСтрокаТовары Из Товары Цикл
		Движение = Движения.ОстаткиДенежныхСредств.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Период = Дата;
		Движение.СтатьяЗатрат = ТекСтрокаТовары.СтатьяЗатрат;
		Движение.Сумма = ТекСтрокаТовары.Сумма;
	КонецЦикла;

КонецПроцедуры
