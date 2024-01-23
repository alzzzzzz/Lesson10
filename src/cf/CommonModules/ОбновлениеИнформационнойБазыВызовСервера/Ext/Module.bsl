﻿#Если НЕ МобильноеПриложениеСервер И НЕ МобильноеПриложениеКлиент Тогда

///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Для интеграции с подсистемой "Обновление конфигурации".
// См. макет МакетФайлаОбновленияКонфигурации обработки УстановкаОбновлений.
//
Функция ВыполнитьОбновлениеИнформационнойБазы(ВыполнятьОтложенныеОбработчики = Ложь) Экспорт
	
	ДатаНачала = ТекущаяДатаСеанса();
	Результат = ОбновлениеИнформационнойБазы.ВыполнитьОбновлениеИнформационнойБазы(ВыполнятьОтложенныеОбработчики);
	ДатаОкончания = ТекущаяДатаСеанса();
	ОбновлениеИнформационнойБазыСлужебный.ЗаписатьВремяВыполненияОбновления(ДатаНачала, ДатаОкончания);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
#КонецЕсли