﻿#Если НЕ МобильноеПриложениеСервер И НЕ МобильноеПриложениеКлиент Тогда
///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// См. СтандартныеПодсистемыСервер.ПараметрРаботыРасширения.
// 
// Возвращаемое значение:
//   см. СтандартныеПодсистемыСервер.ПараметрРаботыРасширения
//
Функция ПараметрРаботыРасширения(ИмяПараметра, БезУчетаВерсииРасширений = Ложь) Экспорт
	
	ВерсияРасширений = ?(БезУчетаВерсииРасширений, Справочники.ВерсииРасширений.ПустаяСсылка(), ПараметрыСеанса.ВерсияРасширений);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ВерсияРасширений", ВерсияРасширений);
	Запрос.УстановитьПараметр("ИмяПараметра", ИмяПараметра);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПараметрыРаботыВерсийРасширений.ХранилищеПараметра
	|ИЗ
	|	РегистрСведений.ПараметрыРаботыВерсийРасширений КАК ПараметрыРаботыВерсийРасширений
	|ГДЕ
	|	ПараметрыРаботыВерсийРасширений.ВерсияРасширений = &ВерсияРасширений
	|	И ПараметрыРаботыВерсийРасширений.ИмяПараметра = &ИмяПараметра";
	
	УстановитьОтключениеБезопасногоРежима(Истина);
	УстановитьПривилегированныйРежим(Истина);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Возврат Выборка.ХранилищеПараметра.Получить();
	КонецЕсли;
	УстановитьПривилегированныйРежим(Ложь);
	УстановитьОтключениеБезопасногоРежима(Ложь);
	
	Возврат Неопределено;
	
КонецФункции

// См. СтандартныеПодсистемыСервер.УстановитьПараметрРаботыРасширения.
Процедура УстановитьПараметрРаботыРасширения(ИмяПараметра, Значение, БезУчетаВерсииРасширений = Ложь) Экспорт
	
	ВерсияРасширений = ?(БезУчетаВерсииРасширений, Справочники.ВерсииРасширений.ПустаяСсылка(), ПараметрыСеанса.ВерсияРасширений);
	
	НаборЗаписей = СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.ВерсияРасширений.Установить(ВерсияРасширений);
	НаборЗаписей.Отбор.ИмяПараметра.Установить(ИмяПараметра);
	
	НоваяЗапись = НаборЗаписей.Добавить();
	НоваяЗапись.ВерсияРасширений   = ВерсияРасширений;
	НоваяЗапись.ИмяПараметра       = ИмяПараметра;
	НоваяЗапись.ХранилищеПараметра = Новый ХранилищеЗначения(Значение);
	
	НаборЗаписей.ОбменДанными.Загрузка = Истина;
	НаборЗаписей.Записать();
	
КонецПроцедуры

// Вызывает принудительное заполнение всех параметров работы для текущей версии расширений.
Процедура ЗаполнитьВсеПараметрыРаботыРасширений() Экспорт
	
	Если Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		Возврат;
	КонецЕсли;
	
	// Заполнить идентификаторы объектов метаданных расширений.
	Если ЗначениеЗаполнено(ПараметрыСеанса.ПодключенныеРасширения) Тогда
		Обновить = Справочники.ИдентификаторыОбъектовРасширений.ИдентификаторыОбъектовТекущейВерсииРасширенийЗаполнены();
		СтандартныеПодсистемыПовтИсп.ИдентификаторыОбъектовМетаданныхПроверкаИспользования(Истина, Истина);
	Иначе
		Обновить = Истина;
	КонецЕсли;
	
	Если Обновить Тогда
		Справочники.ИдентификаторыОбъектовРасширений.ОбновитьДанныеСправочника();
	КонецЕсли;
	
	ИнтеграцияПодсистемБСП.ПриЗаполненииВсехПараметровРаботыРасширений();
	
	ИмяПараметра = "СтандартныеПодсистемы.БазоваяФункциональность.ДатаПоследнегоЗаполненияВсехПараметровРаботыРасширений";
	СтандартныеПодсистемыСервер.УстановитьПараметрРаботыРасширения(ИмяПараметра, ТекущаяДатаСеанса(), Истина);
	
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступомСлужебный = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступомСлужебный");
		МодульУправлениеДоступомСлужебный.УстановитьОбновлениеДоступа(Истина);
	КонецЕсли;
	
КонецПроцедуры

// Возвращает дату последнего заполнения параметров работы версии расширений.
// 
// Возвращаемое значение:
//  Дата
//
Функция ДатаПоследнегоЗаполненияВсехПараметровРаботыРасширений() Экспорт
	
	ИмяПараметра = "СтандартныеПодсистемы.БазоваяФункциональность.ДатаПоследнегоЗаполненияВсехПараметровРаботыРасширений";
	ДатаОбновления = СтандартныеПодсистемыСервер.ПараметрРаботыРасширения(ИмяПараметра, Истина);
	
	Если ТипЗнч(ДатаОбновления) <> Тип("Дата") Тогда
		ДатаОбновления = '00010101';
	КонецЕсли;
	
	Возврат ДатаОбновления;
	
КонецФункции

// Вызывает принудительную очистку всех параметров работы для текущей версии расширений.
// Очищаются только регистры, справочники не изменяются. Вызывается, чтобы вызвать
// перезаполнение параметров работы расширений, например, при использовании параметра
// запуска ЗапуститьОбновлениеИнформационнойБазы.
// 
// Общий регистр ПараметрыРаботыВерсийРасширений очищается автоматически. Если используются
// собственные регистры сведений, которых хранят версии кэшей объектов метаданных расширений,
// тогда требуется подключиться к событию ПриОчисткеВсехПараметровРаботыРасширений
// общего модуля ИнтеграцияПодсистемБСП.
//
Процедура ОчиститьВсеПараметрыРаботыРасширений() Экспорт
	
	Если Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	НачатьТранзакцию();
	Попытка
		НаборЗаписей = РегистрыСведений.ИдентификаторыОбъектовВерсийРасширений.СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ВерсияРасширений.Установить(ПараметрыСеанса.ВерсияРасширений);
		НаборЗаписей.ОбменДанными.Загрузка = Истина;
		НаборЗаписей.Записать();
		
		НаборЗаписей = СоздатьНаборЗаписей();
		НаборЗаписей.Отбор.ВерсияРасширений.Установить(ПараметрыСеанса.ВерсияРасширений);
		НаборЗаписей.ОбменДанными.Загрузка = Истина;
		НаборЗаписей.Записать();
		
		ИнтеграцияПодсистемБСП.ПриОчисткеВсехПараметровРаботыРасширений();
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
	ОбновитьПовторноИспользуемыеЗначения();
	
КонецПроцедуры

// Для общей формы Расширения.
Процедура ЗаполнитьВсеПараметрыРаботыРасширенийФоновоеЗадание(Параметры) Экспорт
	
	ТекстОшибки = "";
	НеподключенныеРасширения = "";
	
	Если Параметры.ИмяКонфигурации    <> Метаданные.Имя
	 Или Параметры.ВерсияКонфигурации <> Метаданные.Версия Тогда
		ТекстОшибки =
			НСтр("ru = 'Не удалось обновить все параметры работы расширений, так как
			           |изменилось имя или версия конфигурации - требуется перезапуск сеанса.'");
	КонецЕсли;
	
	Если Параметры.УстановленныеРасширения.Основные    <> ПараметрыСеанса.УстановленныеРасширения.Основные
	 Или Параметры.УстановленныеРасширения.Исправления <> ПараметрыСеанса.УстановленныеРасширения.Исправления Тогда
		ТекстОшибки =
			НСтр("ru = 'Не удалось обновить все параметры работы расширений,
			           |так как указанный состав расширений отличается от текущего.'");
	КонецЕсли;
	
	Если ТипЗнч(Параметры.ПроверяемыеРасширения) = Тип("Соответствие") Тогда
		Расширения = РасширенияКонфигурации.Получить(, ИсточникРасширенийКонфигурации.СеансАктивные); // Массив из РасширениеКонфигурации -
		ПодключенныеРасширения = Новый Соответствие;
		Для Каждого Расширение Из Расширения Цикл
			ПодключенныеРасширения[Расширение.Имя] = Истина;
		КонецЦикла;
		Для Каждого ПроверяемоеРасширение Из Параметры.ПроверяемыеРасширения Цикл
			Если ПодключенныеРасширения[ПроверяемоеРасширение.Ключ] = Неопределено Тогда
				НеподключенныеРасширения = НеподключенныеРасширения
					 + ?(НеподключенныеРасширения = "", "", ", ") + ПроверяемоеРасширение.Значение;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ТекстОшибки) Тогда
		Попытка
			ЗаполнитьВсеПараметрыРаботыРасширений();
		Исключение
			ИнформацияОбОшибке = ИнформацияОбОшибке();
			ТекстОшибки = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке);
		КонецПопытки;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Параметры.ТекстДляАсинхронногоВызова) Тогда
		Если ЗначениеЗаполнено(ТекстОшибки) Тогда
			ВызватьИсключение Параметры.ТекстДляАсинхронногоВызова + ":" + Символы.ПС + ТекстОшибки;
		Иначе
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("ТекстОшибки",              ТекстОшибки);
	Результат.Вставить("НеподключенныеРасширения", НеподключенныеРасширения);
	
	ПоместитьВоВременноеХранилище(Результат, Параметры.АдресРезультата);
	
КонецПроцедуры

Процедура ОбновитьПараметрыРаботыРасширений(ПроверяемыеРасширения = Неопределено, НеподключенныеРасширения = "", ТекстДляАсинхронногоВызова = "") Экспорт
	
	Если Не ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыВыполнения = Новый Структура;
	ПараметрыВыполнения.Вставить("ИмяКонфигурации",         Метаданные.Имя);
	ПараметрыВыполнения.Вставить("ВерсияКонфигурации",      Метаданные.Версия);
	ПараметрыВыполнения.Вставить("УстановленныеРасширения", Справочники.ВерсииРасширений.УстановленныеРасширения());
	ПараметрыВыполнения.Вставить("ПроверяемыеРасширения",   ПроверяемыеРасширения);
	ПараметрыВыполнения.Вставить("АдресРезультата",         ПоместитьВоВременноеХранилище(Неопределено));
	ПараметрыВыполнения.Вставить("ТекстДляАсинхронногоВызова", ТекстДляАсинхронногоВызова);
	ПараметрыПроцедуры = Новый Массив;
	ПараметрыПроцедуры.Добавить(ПараметрыВыполнения);
	
	ФоновоеЗадание = РасширенияКонфигурации.ВыполнитьФоновоеЗаданиеСРасширениямиБазыДанных(
		"СтандартныеПодсистемыСервер.ЗаполнитьВсеПараметрыРаботыРасширенийФоновоеЗадание", ПараметрыПроцедуры);
	Если ЗначениеЗаполнено(ТекстДляАсинхронногоВызова) Тогда
		Возврат;
	КонецЕсли;
	ФоновоеЗадание.ОжидатьЗавершенияВыполнения();
	Отбор = Новый Структура("УникальныйИдентификатор", ФоновоеЗадание.УникальныйИдентификатор);
	ФоновоеЗадание = ФоновыеЗадания.ПолучитьФоновыеЗадания(Отбор)[0];
	Если ФоновоеЗадание.ИнформацияОбОшибке <> Неопределено Тогда
		ВызватьИсключение ПодробноеПредставлениеОшибки(ФоновоеЗадание.ИнформацияОбОшибке);
	КонецЕсли;
	
	Результат = ПолучитьИзВременногоХранилища(ПараметрыВыполнения.АдресРезультата);
	Если ТипЗнч(Результат) <> Тип("Структура") Тогда
		ВызватьИсключение НСтр("ru = 'Фоновое задание подготовки расширений не вернуло результат.'");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Результат.ТекстОшибки) Тогда
		ВызватьИсключение Результат.ТекстОшибки;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Результат.НеподключенныеРасширения) Тогда
		НеподключенныеРасширения = Результат.НеподключенныеРасширения;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
#КонецЕсли