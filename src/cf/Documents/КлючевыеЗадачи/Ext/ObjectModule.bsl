﻿
Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	//{{__КОНСТРУКТОР_ВВОД_НА_ОСНОВАНИИ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Этапы") Тогда
		// Заполнение шапки
		Цель = ДанныеЗаполнения.Цель;
		Основание = ДанныеЗаполнения.Ссылка;
		Этап = ДанныеЗаполнения.Ссылка;
		ОписаниеЭтапа = ДанныеЗаполнения.Описание;
	КонецЕсли;
	//}}__КОНСТРУКТОР_ВВОД_НА_ОСНОВАНИИ
КонецПроцедуры
