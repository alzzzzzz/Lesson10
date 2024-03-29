﻿
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	//{{__КОНСТРУКТОР_ВВОД_НА_ОСНОВАНИИ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	Если ТипЗнч(ДанныеЗаполнения) = Тип("ДокументСсылка.Сделка") Тогда
		// Заполнение шапки
		Основание = ДанныеЗаполнения.Ссылка;
		Инструмент = ДанныеЗаполнения.Инструмент;
		Коментарий = ДанныеЗаполнения.Коментарий;
		НаправлениеСделки = ?(Основание.НаправлениеСделки = Перечисления.НаправлениеСделки.Покупка,Перечисления.НаправлениеСделки.Продажа,Перечисления.НаправлениеСделки.Покупка);
		СерияТестирования = ДанныеЗаполнения.СерияТестирования;
		СпособСовершенияСделки = ДанныеЗаполнения.СпособСовершенияСделки;
		
		Счет = ДанныеЗаполнения.Счет;
		
		Для Каждого ТекСтрокаПараметры Из ДанныеЗаполнения.Параметры Цикл
			НоваяСтрока = Параметры.Добавить();
			НоваяСтрока.Дата = ТекСтрокаПараметры.Дата;
			НоваяСтрока.Количество = ТекСтрокаПараметры.Количество;
			НоваяСтрока.КомиссияБиржи = ТекСтрокаПараметры.КомиссияБиржи;
			НоваяСтрока.КомиссияБрокера = ТекСтрокаПараметры.КомиссияБрокера;
			НоваяСтрока.НомерСделки = ТекСтрокаПараметры.НомерСделки;
			НоваяСтрока.Сумма = ТекСтрокаПараметры.Сумма;
			НоваяСтрока.Цена = ТекСтрокаПараметры.Цена;
			НоваяСтрока.ЦенаСтопПриказа = ТекСтрокаПараметры.ЦенаСтопПриказа;
		КонецЦикла;
	КонецЕсли;
	//}}__КОНСТРУКТОР_ВВОД_НА_ОСНОВАНИИ
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ПрибылиУбытки Расход
	Движения.ПрибылиУбытки.Записывать = Истина;
	Движение = Движения.ПрибылиУбытки.Добавить();
	Если Основание.НаправлениеСделки = Перечисления.НаправлениеСделки.Покупка Тогда	
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;	
	Иначе	
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
	КонецЕсли;
	
	Движение.Период = Дата;
	Движение.Основание = Основание;
	Движение.Инструмент = Инструмент;
	Движение.Счет = Счет;
	Движение.СпособСовершенияСделки = СпособСовершенияСделки;
	Движение.СерияТестирования = СерияТестирования;
	Движение.НаправлениеСделки = НаправлениеСделки;
	
	Для каждого Строка Из Параметры Цикл
		Движение.Сумма = Движение.Сумма +Строка.Сумма ;	
	КонецЦикла;

	
	// регистр ОткрытыеПозиции Расход
	
		
	Движения.ОткрытыеПозиции.Записывать = Истина;
	
	Движение = Движения.ОткрытыеПозиции.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
	Движение.Период = Дата;
	Движение.Инструмент = Инструмент;
	Для каждого Строка Из  Параметры Цикл		
		Движение.Количество = Движение.Количество + Строка.Количество;			
	КонецЦикла;
		
	Движение.Счет = Счет;
   	Движение.СерияТестирования = СерияТестирования;



	
	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры
