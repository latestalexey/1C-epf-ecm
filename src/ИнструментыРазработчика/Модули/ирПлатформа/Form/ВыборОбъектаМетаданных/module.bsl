﻿Перем мОтображатьВиртуальныеТаблицы;
Перем мОтображатьТаблицыИзменений;
Перем мОтображатьТабличныеЧасти;
Перем мОтображатьРегистры;
Перем мОтображатьПоследовательности;
Перем мОтображатьОтчетыОбработки;
Перем мОтображатьСсылочныеОбъекты;
Перем мОтображатьВыборочныеТаблицы;
Перем мОтображатьКонстанты;
Перем мДоступныеОбъекты; // Соответствие полных имен метаданных
Перем мМножественныйВыбор;
Перем мКорневыеТипы;
Перем мСтрокаТипаТабличнойЧасти;
Перем мСтрокаТипаВнешнегоИсточникаДанных;
Перем мОтображатьКоличество;
Перем мМассивДоступныхОбъектов;
Перем мРезультатПакетаКоличестваСтрок;
Перем мТолькоПомеченные;
Перем мТипТаблицы;
Перем мСтруктураКлючаТаблицы;

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ ОБЩЕГО НАЗНАЧЕНИЯ 

// Процедура передает сделанные настройки в главную форму отчета.
//
Процедура мВыбрать()

	Если Не мМножественныйВыбор Тогда 
		Если Истина 
			//И ЭлементыФормы.ДеревоИсточников.ТекущаяСтрока.Строки.Количество() = 0 
			И ЭлементыФормы.ДеревоИсточников.ТекущаяСтрока.Уровень() > 0  
			И ЗначениеЗаполнено(ЭлементыФормы.ДеревоИсточников.ТекущаяСтрока.ПолноеИмяОбъекта)
		Тогда
			Результат = Новый Структура("ПолноеИмяОбъекта, Представление");
			Если ЭлементыФормы.ДеревоИсточников.ТекущаяСтрока <> Неопределено Тогда
				СтрТабличноеПоле = ЭлементыФормы.ДеревоИсточников.ТекущаяСтрока;
				Результат.ПолноеИмяОбъекта = СтрТабличноеПоле.ПолноеИмяОбъекта;
				Результат.Представление = СтрТабличноеПоле.Представление;
			КонецЕсли;
		КонецЕсли; 
	Иначе
		Результат = НачальноеЗначениеВыбора;
	КонецЕсли;
	Если Результат <> Неопределено Тогда
		ирОбщий.ПрименитьИзмененияИЗакрытьФормуЛкс(ЭтаФорма, Результат);
	КонецЕсли; 

КонецПроцедуры // мВыбрать()

Функция ПолучитьКлючиПомеченныхСтрок(ТолькоПервыйКлюч = Ложь) 
	
	НайденныеСтроки = ДеревоИсточников.Строки.НайтиСтроки(Новый Структура("Пометка", 1), Истина);
	Результат = Новый массив;
	Для Каждого СтрокаДерева Из НайденныеСтроки Цикл
		//Если ЛиКлючТаблицыПодходит(СтрокаДерева) Тогда
		Если Истина
			И ЗначениеЗаполнено(СтрокаДерева.ПолноеИмяОбъекта) 
			И СтрокаДерева.Строки.НайтиСтроки(Новый Структура("Пометка", 1), Истина).Количество() = 0
		Тогда
			Результат.Добавить(СтрокаДерева.ПолноеИмяОбъекта);
			Если ТолькоПервыйКлюч Тогда
				Прервать;
			КонецЕсли; 
		КонецЕсли; 
		//КонецЕсли;
	КонецЦикла;
	Возврат Результат;

КонецФункции

///////////////////////////////////////////////////////////////////////////////
// ОБРАБОТЧИКИ СОБЫТИЙ

// Процедура - обработчик события "При открытии" формы.
//
Процедура ПриОткрытии()

	лРежимИмяСиноним = ВосстановитьЗначение("ВыборОбъектаМетаданных.РежимИмяСиноним");
	Если лРежимИмяСиноним <> Неопределено Тогда
		РежимИмяСиноним = лРежимИмяСиноним;
		ЭлементыФормы.ДействияФормы.Кнопки.ИмяСиноним.Пометка = РежимИмяСиноним;
	КонецЕсли; 
	ирОбщий.ТабличноеПоле_ОбновитьКолонкиИмяСинонимЛкс(ЭлементыФормы.ДеревоИсточников, РежимИмяСиноним);
	РежимВыбора = Истина;
	Если Истина
		И Не МодальныйРежим
		И ТипЗнч(ВладелецФормы) = Тип("Форма")
	Тогда
		ВладелецФормы.Панель.Доступность = Ложь;
	КонецЕсли; 

	СтруктураПараметров = НачальноеЗначениеВыбора;

	МассивДоступныхОбъектов = Неопределено;
	Если ТипЗнч(СтруктураПараметров) = Тип("Структура") Тогда
		НачальноеЗначениеВыбора = Неопределено;
		СтруктураПараметров.Свойство("КорневыеТипы", мКорневыеТипы);
		СтруктураПараметров.Свойство("МножественныйВыбор", мМножественныйВыбор);
		СтруктураПараметров.Свойство("ОтображатьВиртуальныеТаблицы", мОтображатьВиртуальныеТаблицы);
		СтруктураПараметров.Свойство("ОтображатьТаблицыИзменений", мОтображатьТаблицыИзменений);
		СтруктураПараметров.Свойство("ОтображатьТабличныеЧасти", мОтображатьТабличныеЧасти);
		СтруктураПараметров.Свойство("ОтображатьРегистры", мОтображатьРегистры);
		СтруктураПараметров.Свойство("ОтображатьПоследовательности", мОтображатьПоследовательности);
		СтруктураПараметров.Свойство("ОтображатьОтчетыОбработки", мОтображатьОтчетыОбработки);
		СтруктураПараметров.Свойство("ОтображатьСсылочныеОбъекты", мОтображатьСсылочныеОбъекты);
		СтруктураПараметров.Свойство("ОтображатьКонстанты", мОтображатьКонстанты);
		СтруктураПараметров.Свойство("ОтображатьКоличество", мОтображатьКоличество);
		СтруктураПараметров.Свойство("ОтображатьВыборочныеТаблицы", мОтображатьВыборочныеТаблицы);
		СтруктураПараметров.Свойство("ДоступныеОбъекты", мМассивДоступныхОбъектов);
		СтруктураПараметров.Свойство("НачальноеЗначениеВыбора", НачальноеЗначениеВыбора);
	КонецЕсли; 
	
	Если мМножественныйВыбор = Неопределено Тогда
		мМножественныйВыбор = Ложь;
	КонецЕсли; 
	ЭлементыФормы.ДействияФормы.Кнопки.СнятьФлажки.Доступность = мМножественныйВыбор;
	ЭлементыФормы.ДействияФормы.Кнопки.УстановитьФлажки.Доступность = мМножественныйВыбор;
	ЭлементыФормы.ДействияФормы.Кнопки.ТолькоПомеченные.Доступность = мМножественныйВыбор;
	
	Если ТипЗнч(НачальноеЗначениеВыбора) = Тип("Массив") Тогда
		Если НачальноеЗначениеВыбора.Количество() > 0 Тогда
			ПолноеИмяТекущейСтроки = НачальноеЗначениеВыбора[0];
		КонецЕсли; 
	Иначе
		ПолноеИмяТекущейСтроки = НачальноеЗначениеВыбора;
	КонецЕсли;
	
	мТолькоПомеченные = Истина
		//И мМножественныйВыбор
		И ТипЗнч(НачальноеЗначениеВыбора) = Тип("Массив")
		И НачальноеЗначениеВыбора.Количество() > 0;
	ЗаполнитьДеревоИсточников(, ?(мТолькоПомеченные, НачальноеЗначениеВыбора, Неопределено));
	
	НоваяТекущаяСтрока = ДеревоИсточников.Строки.Найти(ПолноеИмяТекущейСтроки, "ПолноеИмяОбъекта", Истина);
	Если НоваяТекущаяСтрока <> Неопределено Тогда
		ЭлементыФормы.ДеревоИсточников.ТекущаяСтрока = НоваяТекущаяСтрока;
	КонецЕсли;

КонецПроцедуры // ПриОткрытии()

// Процедура - обработчик выбора строки таблицы.
//
Процедура ДеревоВыбор(Элемент, ВыбраннаяСтрока, Колонка, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Если мМножественныйВыбор Тогда 
		Элемент.ТекущаяСтрока.Пометка = Истина;
		НачальноеЗначениеВыбора = ПолучитьКлючиПомеченныхСтрок();
	КонецЕсли; 
	мВыбрать();

КонецПроцедуры // ТабличноеПолеВыбор()

Процедура ПриЗакрытии()
	
	Если Истина
		И Не МодальныйРежим
		И ТипЗнч(ВладелецФормы) = Тип("Форма")
	Тогда
		ВладелецФормы.Панель.Доступность = Истина;
	КонецЕсли; 
	
КонецПроцедуры

Функция ДобавитьСтрокуТабличнойЧасти(ГлавнаяСтрока, ПолноеИмяТаблицы, Имя, Представление, ИмяТекущейКолонки, Подстроки) 
	
	СтруктураСвойств = ирОбщий.ПолучитьСтруктуруСвойствОбъектаЛкс(ГлавнаяСтрока);
	СтруктураСвойств.Имя = Имя;
	СтруктураСвойств.Представление = Представление;
	Если Ложь
		Или Не ирОбщий.ЛиСтрокаСодержитВсеПодстрокиЛкс(СтруктураСвойств[ИмяТекущейКолонки], Подстроки) 
		Или (Истина
			И мДоступныеОбъекты <> Неопределено
			И мДоступныеОбъекты[ПолноеИмяТаблицы] = Неопределено)
	Тогда
		Возврат Неопределено;
	КонецЕсли; 
	ДочерняяТаблица = ГлавнаяСтрока.Строки.Добавить();
	ЗаполнитьЗначенияСвойств(ДочерняяТаблица, СтруктураСвойств); 
	ДочерняяТаблица.ПолноеИмяОбъекта = ПолноеИмяТаблицы;
	ИндексКартинки = мСтрокаТипаТабличнойЧасти.ИндексКартинкиЕдинственное;
	ДочерняяТаблица.ИндексКартинки = ИндексКартинки;
	ДочерняяТаблица.КоличествоСтрок = "?";
	ЗаполнитьСтрокуДерева(ДочерняяТаблица);
	Возврат ДочерняяТаблица;
	
КонецФункции

Процедура ЗаполнитьСтрокуДерева(СтрокаДерева)
	
	Если Истина
		И мМножественныйВыбор
		И ТипЗнч(НачальноеЗначениеВыбора) = Тип("Массив")
		И НачальноеЗначениеВыбора.Найти(СтрокаДерева.ПолноеИмяОбъекта) <> Неопределено
	Тогда
		СтрокаДерева.Пометка = Истина;
		ПроверитьУстановитьФильтрПоТипуТаблицы(СтрокаДерева);
		ирОбщий.УстановитьПометкиРодителейЛкс(СтрокаДерева.Родитель); // Неоптимально
	КонецЕсли; 
	
КонецПроцедуры

// Процедура предназначена для заполнения дерева таблиц, которые
// могут служить источниками данных.
//
Процедура ЗаполнитьДеревоИсточников(Знач Фильтр = Неопределено, МассивДоступныхОбъектов = Неопределено) Экспорт
	
	Если МассивДоступныхОбъектов = Неопределено Тогда
		Если мМножественныйВыбор Тогда
			ПомеченныеСтроки = ПолучитьКлючиПомеченныхСтрок();
			Для Каждого ПолноеИмяМД Из ПомеченныеСтроки Цикл
				Если НачальноеЗначениеВыбора.Найти(ПолноеИмяМД) = Неопределено Тогда
					НачальноеЗначениеВыбора.Добавить(ПолноеИмяМД);
				КонецЕсли; 
			КонецЦикла;
		КонецЕсли;
		Если мТолькоПомеченные Тогда
			МассивДоступныхОбъектов = НачальноеЗначениеВыбора;
		Иначе
			МассивДоступныхОбъектов = мМассивДоступныхОбъектов;
		КонецЕсли;
	КонецЕсли;
	ЭлементыФормы.ДействияФормы.Кнопки.ТолькоПомеченные.Пометка = мТолькоПомеченные;
	мДоступныеОбъекты = Неопределено;
	Если МассивДоступныхОбъектов <> Неопределено Тогда
		мДоступныеОбъекты = Новый Соответствие();
		Для Каждого ДоступныйОбъект Из МассивДоступныхОбъектов Цикл
			мДоступныеОбъекты.Вставить(ДоступныйОбъект, 1);
		КонецЦикла; 
	КонецЕсли; 
	Если Фильтр = Неопределено Тогда
		Фильтр = ФильтрИмен;
	КонецЕсли;
	
	ТабличноеПолеДерева = ЭлементыФормы.ДеревоИсточников;
	Если ТабличноеПолеДерева.ТекущаяСтрока <> Неопределено Тогда
		КлючТекущейСтроки = ТабличноеПолеДерева.ТекущаяСтрока.ПолноеИмяОбъекта;
	КонецЕсли; 
	ПодстрокиФильтра = ирОбщий.ПолучитьМассивИзСтрокиСРазделителемЛкс(НРег(Фильтр), " ", Истина);
	ТекущаяКолонкаТП = ирОбщий.ОпределитьВедущуюСтроковуюКолонкуТабличногоПоляЛкс(ТабличноеПолеДерева);
	ИмяТекущейКолонки = ТекущаяКолонкаТП.Данные;
	
	ДеревоИсточников.Строки.Очистить();
	КоллекцияКорневыхТипов = Новый Массив;
	СтрокиМетаОбъектов = ирКэш.Получить().ТаблицаТиповМетаОбъектов.НайтиСтроки(Новый Структура("Категория", 0));
	Для Каждого СтрокаТаблицыМетаОбъектов Из СтрокиМетаОбъектов Цикл
		Единственное = СтрокаТаблицыМетаОбъектов.Единственное;
		Если Ложь
			Или (Истина
				И мОтображатьПоследовательности = Истина
				И Единственное = "Последовательность")
			Или (Истина
				И мОтображатьВыборочныеТаблицы = Истина
				И (Ложь
					//Или Единственное = "КритерийОтбора" // там обязательный параметр
					Или Единственное = "ЖурналДокументов"))
			Или (Истина
				И мОтображатьСсылочныеОбъекты = Истина
				И ирОбщий.ЛиКорневойТипОбъектаБДЛкс(Единственное))
			Или (Истина
				И мОтображатьРегистры = Истина
				И ирОбщий.ЛиКорневойТипРегистраБДЛкс(Единственное))
		Тогда
			КоллекцияКорневыхТипов.Добавить(Единственное);
		КонецЕсли;
	КонецЦикла;
	Если ирКэш.Получить().ВерсияПлатформы >= 802014 Тогда
		Если Ложь
			Или мОтображатьСсылочныеОбъекты = Истина
			Или мОтображатьРегистры = Истина
		Тогда
			Для Каждого МетаВнешнийИсточникДанных Из Метаданные.ВнешниеИсточникиДанных Цикл
				КоллекцияКорневыхТипов.Добавить(МетаВнешнийИсточникДанных);
			КонецЦикла; 
		КонецЕсли; 
	КонецЕсли; 
	Если мОтображатьОтчетыОбработки = Истина Тогда
		КоллекцияКорневыхТипов.Добавить("Обработка");
		КоллекцияКорневыхТипов.Добавить("Отчет");
	КонецЕсли;
	Если мОтображатьКонстанты = Истина Тогда
		КоллекцияКорневыхТипов.Добавить("Константа");
	КонецЕсли;
		
	Для Каждого КорневойТип Из КоллекцияКорневыхТипов Цикл
		СтрокаКорневогоТипа = ПолучитьСтрокуТипаМетаОбъектов(КорневойТип);
		Если СтрокаКорневогоТипа = Неопределено Тогда
			СтрокаКорневогоТипа = мСтрокаТипаВнешнегоИсточникаДанных;
			МножественноеКорневогоТипа = СтрокаКорневогоТипа.Множественное;
			КоллекцияМетаданных = Метаданные.ВнешниеИсточникиДанных[КорневойТип.Имя].Таблицы;
			ПредставлениеКатегории = КорневойТип.Представление();
		Иначе
			МножественноеКорневогоТипа = СтрокаКорневогоТипа.Множественное;
			КоллекцияМетаданных = Метаданные[МножественноеКорневогоТипа];
			ПредставлениеКатегории = ирОбщий.ПолучитьПредставлениеИзИдентификатораЛкс(МножественноеКорневогоТипа);
		КонецЕсли; 
		//Если мДоступныеОбъекты <> Неопределено Тогда
		//	ДоступныеОбъектыТипа = мДоступныеОбъекты[НРег(СтрокаКорневогоТипа.Единственное)];
		//	Если ДоступныеОбъектыТипа = Неопределено Тогда
		//		Продолжить;
		//	КонецЕсли; 
		//КонецЕсли; 
		Если КоллекцияМетаданных.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;
		НовыйИсточник = ДеревоИсточников.Строки.Добавить();
		НовыйИсточник.Представление = ПредставлениеКатегории;
		НовыйИсточник.Имя = МножественноеКорневогоТипа;
		НовыйИсточник.ИндексКартинки = СтрокаКорневогоТипа.ИндексКартинкиМножественное;
		НовыйИсточник.КоличествоСтрок = "?";
		Для Каждого МетаИсточник Из КоллекцияМетаданных Цикл
			ПолноеИмяМД = МетаИсточник.ПолноеИмя();
			//Если ДоступныеОбъектыТипа <> Неопределено Тогда
			//	Если ДоступныеОбъектыТипа[НРег(МетаИсточник.Имя)] = Неопределено Тогда
			//		Продолжить;
			//	КонецЕсли; 
			//КонецЕсли;
			//
			Если Ложь
				Или (Истина
					И мОтображатьСсылочныеОбъекты <> Истина
					И ирОбщий.ЛиСсылочныйОбъектМетаданных(МетаИсточник))
				Или (Истина
					И мОтображатьРегистры <> Истина
					И ирОбщий.ЛиРегистровыйОбъектМетаданных(МетаИсточник))
			Тогда
				Продолжить;
			КонецЕсли;
			ГлавнаяСтрока = НовыйИсточник.Строки.Добавить();
			ГлавнаяСтрока.ПолноеИмяОбъекта = ПолноеИмяМД;
			ГлавнаяСтрока.Имя = МетаИсточник.Имя;
			ГлавнаяСтрока.Представление = МетаИсточник.Представление();
			ГлавнаяСтрока.ИндексКартинки = СтрокаКорневогоТипа.ИндексКартинкиЕдинственное;
			ГлавнаяСтрока.КоличествоСтрок = "?";
			ЗаполнитьСтрокуДерева(ГлавнаяСтрока);
			
			Если мОтображатьТабличныеЧасти = Истина Тогда
				Если ирОбщий.ЛиКорневойТипОбъектаБДЛкс(КорневойТип) Тогда
					СтруктураТЧ = ирОбщий.ПолучитьТабличныеЧастиОбъектаЛкс(МетаИсточник);
					Для Каждого КлючИЗначение Из СтруктураТЧ Цикл
						ДобавитьСтрокуТабличнойЧасти(ГлавнаяСтрока, ГлавнаяСтрока.ПолноеИмяОбъекта + "." + КлючИЗначение.Ключ,
							КлючИЗначение.Ключ, КлючИЗначение.Значение, ИмяТекущейКолонки, ПодстрокиФильтра);
					КонецЦикла;
				КонецЕсли; 
			КонецЕсли;
			Если мОтображатьТаблицыИзменений = Истина Тогда
				Если ирОбщий.ЕстьТаблицаИзмененийОбъектаМетаданных(МетаИсточник)	Тогда
					ДобавитьСтрокуТабличнойЧасти(ГлавнаяСтрока, ПолноеИмяМД + ".Изменения", МетаИсточник.Имя + ".Изменения",
						МетаИсточник.Представление() + ".Изменения", ИмяТекущейКолонки, ПодстрокиФильтра) 
				КонецЕсли;
			КонецЕсли;
			
			Если мОтображатьВиртуальныеТаблицы = Истина Тогда
				Если КорневойТип = "РегистрСведений" Тогда 
					Если МетаИсточник.ПериодичностьРегистраСведений <> Метаданные.СвойстваОбъектов.ПериодичностьРегистраСведений.Непериодический Тогда
						ДобавитьСтрокуТабличнойЧасти(ГлавнаяСтрока, МетаИсточник.ПолноеИмя() + ".СрезПоследних", МетаИсточник.Имя + ".СрезПоследних",
							МетаИсточник.Представление() + ": срез последних", ИмяТекущейКолонки, ПодстрокиФильтра) 
					КонецЕсли;
				ИначеЕсли КорневойТип = "РегистрНакопления" Тогда 
					ДочерняяТаблица = ГлавнаяСтрока.Строки.Добавить();
					ДочерняяТаблица.ПолноеИмяОбъекта = МетаИсточник.ПолноеИмя() + ".Обороты";
					ДочерняяТаблица.Имя = МетаИсточник.Имя + "." + "Обороты";
					ДочерняяТаблица.Представление = МетаИсточник.Представление() + ": обороты";
					ДочерняяТаблица.ИндексКартинки = мСтрокаТипаТабличнойЧасти.ИндексКартинкиЕдинственное;

					Если МетаИсточник.ВидРегистра = Метаданные.СвойстваОбъектов.ВидРегистраНакопления.Остатки Тогда
						ДочерняяТаблица = ГлавнаяСтрока.Строки.Добавить();
						ДочерняяТаблица.ПолноеИмяОбъекта = МетаИсточник.ПолноеИмя() + ".Остатки";
						ДочерняяТаблица.Имя = МетаИсточник.Имя + "." + "Остатки";
						ДочерняяТаблица.Представление = МетаИсточник.Представление() + ": остатки";
						ДочерняяТаблица.ИндексКартинки = мСтрокаТипаТабличнойЧасти.ИндексКартинкиЕдинственное;
						
						ДочерняяТаблица = ГлавнаяСтрока.Строки.Добавить();
						ДочерняяТаблица.ПолноеИмяОбъекта = МетаИсточник.ПолноеИмя() + ".ОстаткиИОбороты";
						ДочерняяТаблица.Имя = МетаИсточник.Имя + "." + "ОстаткиИОбороты";
						ДочерняяТаблица.Представление = МетаИсточник.Представление() + ": остатки и обороты";
						ДочерняяТаблица.ИндексКартинки = мСтрокаТипаТабличнойЧасти.ИндексКартинкиЕдинственное;
					КонецЕсли;
					
				ИначеЕсли КорневойТип = "РегистрБухгалтерии" Тогда 
					ДочерняяТаблица = ГлавнаяСтрока.Строки.Добавить();
					ДочерняяТаблица.ПолноеИмяОбъекта = МетаИсточник.ПолноеИмя() + ".Обороты";
					ДочерняяТаблица.Имя = МетаИсточник.Имя + "." + "Обороты";
					ДочерняяТаблица.Представление = МетаИсточник.Представление()+": обороты";
					ДочерняяТаблица.ИндексКартинки = мСтрокаТипаТабличнойЧасти.ИндексКартинкиЕдинственное;
					
					Если МетаИсточник.Корреспонденция Тогда
						ДочерняяТаблица = ГлавнаяСтрока.Строки.Добавить();
						ДочерняяТаблица.ПолноеИмяОбъекта = МетаИсточник.ПолноеИмя() + ".ОборотыДтКт";
						ДочерняяТаблица.Имя = МетаИсточник.Имя + "." + "ОборотыДтКт";
						ДочерняяТаблица.Представление = МетаИсточник.Представление() + ": обороты с корреспонденцией";
						ДочерняяТаблица.ИндексКартинки = мСтрокаТипаТабличнойЧасти.ИндексКартинкиЕдинственное;
					КонецЕсли;
					
					ДочерняяТаблица = ГлавнаяСтрока.Строки.Добавить();
					ДочерняяТаблица.ПолноеИмяОбъекта = МетаИсточник.ПолноеИмя() + ".ДвиженияССубконто";
					ДочерняяТаблица.Имя = МетаИсточник.Имя + "." + "ДвиженияССубконто";
					ДочерняяТаблица.Представление = МетаИсточник.Представление() + ": движения с субконто";
					ДочерняяТаблица.ИндексКартинки = мСтрокаТипаТабличнойЧасти.ИндексКартинкиЕдинственное;

					ДочерняяТаблица =ГлавнаяСтрока.Строки.Добавить();
					ДочерняяТаблица.ПолноеИмяОбъекта = МетаИсточник.ПолноеИмя() + ".Остатки";
					ДочерняяТаблица.Имя = МетаИсточник.Имя + "." + "Остатки";
					ДочерняяТаблица.Представление = МетаИсточник.Представление() + ": остатки";
					ДочерняяТаблица.ИндексКартинки = мСтрокаТипаТабличнойЧасти.ИндексКартинкиЕдинственное;

					ДочерняяТаблица = ГлавнаяСтрока.Строки.Добавить();
					ДочерняяТаблица.ПолноеИмяОбъекта = МетаИсточник.ПолноеИмя() + ".ОстаткиИОбороты";
					ДочерняяТаблица.Имя = МетаИсточник.Имя + "." + "ОстаткиИОбороты";
					ДочерняяТаблица.Представление = МетаИсточник.Представление() + ": остатки и обороты";
					ДочерняяТаблица.ИндексКартинки = мСтрокаТипаТабличнойЧасти.ИндексКартинкиЕдинственное;
				ИначеЕсли КорневойТип = "Последовательность" Тогда 
					ДочерняяТаблица = ГлавнаяСтрока.Строки.Добавить();
					ДочерняяТаблица.ПолноеИмяОбъекта = МетаИсточник.ПолноеИмя() + ".Границы";
					ДочерняяТаблица.Имя = МетаИсточник.Имя + "." + "Границы";
					ДочерняяТаблица.Представление = МетаИсточник.Представление()+": Границы";
					ДочерняяТаблица.ИндексКартинки = мСтрокаТипаТабличнойЧасти.ИндексКартинкиЕдинственное;
				КонецЕсли;
			КонецЕсли;
			Если ГлавнаяСтрока.Строки.Количество() = 0 Тогда
				Если Ложь
					Или Не ирОбщий.ЛиСтрокаСодержитВсеПодстрокиЛкс(ГлавнаяСтрока[ИмяТекущейКолонки], ПодстрокиФильтра) 
					Или (Истина
						И мДоступныеОбъекты <> Неопределено
						И мДоступныеОбъекты[ПолноеИмяМД] = Неопределено)
				Тогда
					ГлавнаяСтрока.Родитель.Строки.Удалить(ГлавнаяСтрока);
				КонецЕсли; 
			КонецЕсли; 
		КонецЦикла;
		Если Истина
			И НовыйИсточник.Строки.Количество() = 0
			//И Не ирОбщий.ЛиСтрокаСодержитВсеПодстрокиЛкс(НовыйИсточник[ИмяТекущейКолонки], ПодстрокиФильтра) 
		Тогда
			ДеревоИсточников.Строки.Удалить(НовыйИсточник);
		КонецЕсли; 
	КонецЦикла;
	Если мОтображатьКоличество = Истина Тогда
		ирОбщий.ОбновитьКоличествоСтрокТаблицВДеревеМетаданныхЛкс(ДеревоИсточников);
	КонецЕсли;
	ТекущаяСтрокаУстановлена = Ложь;
	Если КлючТекущейСтроки <> Неопределено Тогда
		НоваяТекущаяСтрока = ДеревоИсточников.Строки.Найти(КлючТекущейСтроки, "ПолноеИмяОбъекта", Истина);
		Если НоваяТекущаяСтрока <> Неопределено Тогда
			ЭлементыФормы.ДеревоИсточников.ТекущаяСтрока = НоваяТекущаяСтрока;
			ТекущаяСтрокаУстановлена = Истина;
		КонецЕсли; 
	КонецЕсли;
	СортироватьДерево();
	
	ирОбщий.ТабличноеПолеДеревоЗначений_АвтоРазвернутьВсеСтрокиЛкс(ТабличноеПолеДерева, , ТекущаяСтрокаУстановлена);
	Если мРезультатПакетаКоличестваСтрок <> Неопределено Тогда
		ирОбщий.ЗаполнитьКоличествоСтрокТаблицВДеревеМетаданныхЛкс(ДеревоИсточников, мРезультатПакетаКоличестваСтрок);
	КонецЕсли; 
	
КонецПроцедуры // ЗаполнитьДеревоИсточников()

Процедура СортироватьДерево()
	
	Если РежимИмяСиноним Тогда
		ИмяКолонкиСортировки = "Имя";
	Иначе
		ИмяКолонкиСортировки = "Представление";
	КонецЕсли;
	ДеревоИсточников.Строки.Сортировать(ИмяКолонкиСортировки, Истина);
	//Для Каждого КорневаяСтрока Из ДеревоИсточников.Строки Цикл
	//	КорневаяСтрока.Строки.Сортировать(ИмяКолонкиСортировки);
	//КонецЦикла;

КонецПроцедуры

Процедура ДеревоИсточниковПриИзмененииФлажка(Элемент, Колонка)
	
	ТекущаяСтрока = Элемент.ТекущиеДанные;
	ИмяКолонкиПометки = "Пометка";
	НовоеЗначениеПометки = ТекущаяСтрока[ИмяКолонкиПометки];
	НовоеЗначениеПометки = НовоеЗначениеПометки -1;
	Если НовоеЗначениеПометки < 0 Тогда
		НовоеЗначениеПометки = 1;
	КонецЕсли;
	УстановитьФлажокСтроки(ТекущаяСтрока, НовоеЗначениеПометки);
	Если мМножественныйВыбор Тогда
		НачальноеЗначениеВыбора = ПолучитьКлючиПомеченныхСтрок();
	КонецЕсли; 
	
КонецПроцедуры

Процедура УстановитьФлажокСтроки(ТекущаяСтрока, НовоеЗначениеПометки, ОбновлятьРодителя = Неопределено)
	
	ИмяКолонкиПометки = "Пометка";
	КлючСовпадает = ЛиКлючТаблицыПодходит(ТекущаяСтрока);
	Если КлючСовпадает Тогда
		ТекущаяСтрока[ИмяКолонкиПометки] = НовоеЗначениеПометки;
		Если ОбновлятьРодителя = Неопределено Тогда
			ирОбщий.УстановитьПометкиРодителейЛкс(ТекущаяСтрока.Родитель);
		Иначе
			ОбновлятьРодителя = Истина;
		КонецЕсли; 
		Если ТекущаяСтрока.Уровень() > 0 Тогда
			Если НовоеЗначениеПометки = 0 Тогда
				КлючПомеченных = ПолучитьКлючиПомеченныхСтрок(Истина);
				Если КлючПомеченных.Количество() = 0 Тогда
					мТипТаблицы = Неопределено;
				КонецЕсли;
			Иначе
				ПроверитьУстановитьФильтрПоТипуТаблицы(ТекущаяСтрока);
			КонецЕсли; 
		КонецЕсли; 
	КонецЕсли; 
	ОбновлятьРодителяСнизу = Ложь;
	Для Каждого СтрокаДерева Из ТекущаяСтрока.Строки Цикл
		УстановитьФлажокСтроки(СтрокаДерева, НовоеЗначениеПометки, ОбновлятьРодителяСнизу);
	КонецЦикла;  
	Если ОбновлятьРодителяСнизу Тогда
		ирОбщий.УстановитьПометкиРодителейЛкс(ТекущаяСтрока);
	КонецЕсли; 

КонецПроцедуры

Функция ПроверитьУстановитьФильтрПоТипуТаблицы(ТекущаяСтрока)

	Если мТипТаблицы = Неопределено Тогда
		мТипТаблицы = ирОбщий.ПолучитьТипТаблицыБДЛкс(ТекущаяСтрока.ПолноеИмяОбъекта);
		мСтруктураКлючаТаблицы = ирОбщий.ПолучитьСтруктуруКлючаТаблицыБДЛкс(ТекущаяСтрока.ПолноеИмяОбъекта);
	КонецЕсли; 

	Возврат Неопределено;

КонецФункции

Функция ЛиКлючТаблицыПодходит(СтрокаДерева)

	КлючСовпадает = Истина;
	Если мТипТаблицы <> Неопределено Тогда
		КлючСовпадает = Ложь;
		Если мТипТаблицы = ирОбщий.ПолучитьТипТаблицыБДЛкс(СтрокаДерева.ПолноеИмяОбъекта) Тогда
			КлючСовпадает = Истина;
			СтруктураКлючаТаблицы = ирОбщий.ПолучитьСтруктуруКлючаТаблицыБДЛкс(СтрокаДерева.ПолноеИмяОбъекта);
			Если мСтруктураКлючаТаблицы.Количество() <> СтруктураКлючаТаблицы.Количество() Тогда
				КлючСовпадает = Ложь;
			Иначе
				Для Каждого КлючИзначение Из СтруктураКлючаТаблицы Цикл
					Если Не мСтруктураКлючаТаблицы.Свойство(КлючИзначение.Ключ) Тогда
						КлючСовпадает = Ложь;
						Прервать;
					КонецЕсли; 
				КонецЦикла; 
			КонецЕсли; 
		КонецЕсли; 
	КонецЕсли;

	Возврат КлючСовпадает;

КонецФункции

Процедура ДеревоИсточниковПриВыводеСтроки(Элемент, ОформлениеСтроки, ДанныеСтроки)
	
	ирОбщий.ТабличноеПоле_ОформитьЯчейкиИмяСинонимЛкс(Элемент, ОформлениеСтроки,,,, ?(мМножественныйВыбор, "Пометка", ""));
	Если ДанныеСтроки.Строки.Количество() = 0 Тогда
		КлючСовпадает = ЛиКлючТаблицыПодходит(ДанныеСтроки);
	Иначе
		КлючСовпадает = Истина;
	КонецЕсли; 
	Если Не КлючСовпадает Тогда
		ОформлениеСтроки.Ячейки.Представление.ОтображатьФлажок = Ложь;
		ОформлениеСтроки.Ячейки.Имя.ОтображатьФлажок = Ложь;
	КонецЕсли; 
	
КонецПроцедуры

Процедура ДействияФормыОбновить(Кнопка)
	
	мРезультатПакетаКоличестваСтрок = ирОбщий.ВычислитьКоличествоСтрокТаблицВДеревеМетаданныхЛкс(ДеревоИсточников);
	ирОбщий.ЗаполнитьКоличествоСтрокТаблицВДеревеМетаданныхЛкс(ДеревоИсточников, мРезультатПакетаКоличестваСтрок);
	ЭлементыФормы.ДеревоИсточников.Колонки.КоличествоСтрок.Видимость = Истина;
	
КонецПроцедуры

Процедура ДействияФормыФормаСписка(Кнопка)
	
	ТекущаяСтрока = ЭлементыФормы.ДеревоИсточников.ТекущаяСтрока;
	Если ТекущаяСтрока <> Неопределено Тогда
		ТипТаблицы = ирОбщий.ПолучитьТипТаблицыБДЛкс(ТекущаяСтрока.ПолноеИмяОбъекта);
		Если Ложь
			Или ирОбщий.ЛиКорневойТипОбъектаБДЛкс(ТипТаблицы) 
			Или ирОбщий.ЛиКорневойТипРегистраБДЛкс(ТипТаблицы)
		Тогда
			ОткрытьФорму(ТекущаяСтрока.ПолноеИмяОбъекта + ".ФормаСписка");
		КонецЕсли; 
	КонецЕсли; 
	
КонецПроцедуры

Процедура ДействияФормыУстановитьФлажки(Кнопка)
	
	Для Каждого Строка Из ДеревоИсточников.Строки Цикл
		УстановитьФлажокСтроки(Строка, Истина);
	КонецЦикла;
	Если мМножественныйВыбор Тогда
		НачальноеЗначениеВыбора = ПолучитьКлючиПомеченныхСтрок();
	КонецЕсли; 
	
КонецПроцедуры

Процедура ДействияФормыСнятьФлажки(Кнопка)
	
	ирОбщий.УстановитьЗначениеКолонкиДереваЛкс(ДеревоИсточников,, Ложь);
	мТипТаблицы = Неопределено;

КонецПроцедуры

Процедура ДействияФормыОтборПоПодсистеме(Кнопка)
	
	//ФормаВыбора = ирОбщий.ПолучитьФормуЛкс("Обработка.ирПлатформа.Форма.ВыборПодсистемы");
	//ФормаВыбора.РежимВыбора = Истина;
	//ВыбранноеЗначение = ФормаВыбора.ОткрытьМодально();
	
КонецПроцедуры

Процедура ДействияФормыИмяСиноним(Кнопка)
	
	РежимИмяСиноним = Не Кнопка.Пометка;
	СохранитьЗначение("ВыборОбъектаМетаданных.РежимИмяСиноним", РежимИмяСиноним);
	Кнопка.Пометка = РежимИмяСиноним;
	ирОбщий.ТабличноеПоле_ОбновитьКолонкиИмяСинонимЛкс(ЭлементыФормы.ДеревоИсточников, РежимИмяСиноним);
	ЗаполнитьДеревоИсточников();
	
КонецПроцедуры

Процедура ФильтрИменПриИзменении(Элемент)
	
	СтандартнаяОбработка = Ложь;
	//ирОбщий.НайтиСтрокуТабличногоПоляДереваЗначенийСоСложнымФильтромЛкс(ЭлементыФормы.ДеревоИсточников, ЭлементыФормы.ФильтрИмен);
	ЗаполнитьДеревоИсточников();
	ирОбщий.ПолеВводаСИсториейВыбора_ПриИзмененииЛкс(Элемент, "ВыборОбъектаМетаданных");

КонецПроцедуры

Процедура ФильтрИменНачалоВыбораИзСписка(Элемент, СтандартнаяОбработка)
	
	ирОбщий.ПолеВводаСИсториейВыбора_НачалоВыбораИзСпискаЛкс(Элемент, "ВыборОбъектаМетаданных");
	
КонецПроцедуры

Процедура ФильтрИменОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	//ирОбщий.НайтиСтрокуТабличногоПоляДереваЗначенийСоСложнымФильтромЛкс(ЭлементыФормы.ДеревоИсточников, ЭлементыФормы.ФильтрИмен);
	ЗаполнитьДеревоИсточников();
	
КонецПроцедуры

Процедура ФильтрИменАвтоПодборТекста(Элемент, Текст, ТекстАвтоПодбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	//ирОбщий.НайтиСтрокуТабличногоПоляДереваЗначенийСоСложнымФильтромЛкс(ЭлементыФормы.ДеревоИсточников, ЭлементыФормы.ФильтрИмен, Текст);
	ЗаполнитьДеревоИсточников(Текст);
	
КонецПроцедуры

Процедура КоманднаяПанель1НайтиСледующее(Кнопка)
	
	ирОбщий.НайтиСтрокуТабличногоПоляДереваЗначенийСоСложнымФильтромЛкс(ЭлементыФормы.ДеревоИсточников, ЭлементыФормы.ФильтрИмен);
	
КонецПроцедуры

Процедура КнопкаОкНажатие(Кнопка)
	
	мВыбрать();
	
КонецПроцедуры

Процедура ДействияФормыТолькоПомеченные(Кнопка)
	
	мТолькоПомеченные = Не Кнопка.Пометка;
	ЗаполнитьДеревоИсточников();
	
КонецПроцедуры

Процедура СтруктураКоманднойПанелиНажатие(Кнопка)
	
	ирОбщий.ОткрытьСтруктуруКоманднойПанелиЛкс(ЭтаФорма, Кнопка);
	
КонецПроцедуры

ирОбщий.ИнициализироватьФормуЛкс(ЭтаФорма, "Обработка.ирПлатформа.Форма.ВыборОбъектаМетаданных");

мОтображатьСсылочныеОбъекты = Истина;
мОтображатьРегистры = Истина;
мОтображатьПоследовательности = Истина;
мОтображатьТабличныеЧасти = Истина;
мСтрокаТипаТабличнойЧасти = ПолучитьСтрокуТипаМетаОбъектов("ТабличнаяЧасть", , 2);
мСтрокаТипаВнешнегоИсточникаДанных = ПолучитьСтрокуТипаМетаОбъектов("ВнешнийИсточникДанных", , 0);

//ДеревоИсточников.Колонки.Добавить("Пометка", Новый ОписаниеТипов("Число"));
//ДеревоИсточников.Колонки.Добавить("ПолноеИмяОбъекта");
