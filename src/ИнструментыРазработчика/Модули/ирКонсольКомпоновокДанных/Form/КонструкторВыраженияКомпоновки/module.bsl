﻿Перем ирПортативный Экспорт;
Перем ирОбщий Экспорт;
Перем ирСервер Экспорт;
Перем ирКэш Экспорт;
Перем ирПривилегированный Экспорт;

Перем ПредставленияИмена;

// @@@.КЛАСС.ПолеТекстовогоДокументаСКонтекстнойПодсказкой
Процедура КлсПолеТекстовогоДокументаСКонтекстнойПодсказкойНажатие(Кнопка)
	
	Если Кнопка = ирОбщий.ПолучитьКнопкуКоманднойПанелиЭкземпляраКомпонентыЛкс(ПодсказкаПоляТекстаВыражения, "ПерейтиКОпределению") Тогда
		ТекущееВыражение = ПодсказкаПоляТекстаВыражения.ПолучитьТекущееОбъектноеВыражение();
		Если Лев(ТекущееВыражение, 1) = "&" Тогда
			ИмяПараметра = Сред(ТекущееВыражение, 2);
			ДоступныйПараметр = ЭлементыФормы.ДоступныеПоля.Значение.НайтиПоле(Новый ПолеКомпоновкиДанных("ПараметрыДанных.ИмяПараметра"));
			Если ДоступныйПараметр <> Неопределено Тогда
				ЭлементыФормы.ДоступныеПоля.ТекущаяСтрока = ДоступныйПараметр;
				ПараметрСхемы = СхемаКомпоновки.Параметры.Найти(ирОбщий.ПолучитьПоследнийФрагментЛкс(ДоступныйПараметр.Поле));
				Если ПараметрСхемы <> Неопределено Тогда
					Если ПараметрСхемы.Выражение <> "" Тогда
						Попытка 
							ЗначениеПараметра = Вычислить(ПараметрСхемы.Выражение);
							ОткрытьЗначение(ЗначениеПараметра);
						Исключение
							ирОбщий.СообщитьСУчетомМодальностиЛкс("Ошибка при вычислении параметра """ + ПараметрСхемы.ИмяПараметра + """"
								+ Символы.ПС + ОписаниеОшибки(), МодальныйРежим, СтатусСообщения.Важное);
						КонецПопытки;
					Иначе
						ЗначениеПараметра = ПараметрСхемы.Значение;
						ОткрытьЗначение(ЗначениеПараметра);
					КонецЕсли;
				КонецЕсли; 
			КонецЕсли;
			Возврат;
		Иначе
			ДоступноеПоле = ЭлементыФормы.ДоступныеПоля.Значение.НайтиПоле(Новый ПолеКомпоновкиДанных(ТекущееВыражение));
			Если ДоступноеПоле <> Неопределено Тогда
				ЭлементыФормы.ДоступныеПоля.ТекущаяСтрока = ДоступноеПоле;
			КонецЕсли; 
		КонецЕсли; 
	КонецЕсли;
	ПодсказкаПоляТекстаВыражения.ВнешниеФункцииКомпоновкиДанных = ВнешниеФункцииРазрешены;
	ПодсказкаПоляТекстаВыражения.Нажатие(Кнопка);
	
КонецПроцедуры

Процедура ОбновитьДоступныеПоля()

	ВременнаяСхема = ирОбщий.ПолучитьКопиюОбъектаЛкс(СхемаКомпоновки);
	Если ВременнаяСхема = Неопределено Тогда
		ВременнаяСхема = Новый СхемаКомпоновкиДанных;
	КонецЕсли; 
	#Если _ Тогда
		ВременнаяСхема = Новый СхемаКомпоновкиДанных
	#КонецЕсли 
	Если ТипВыражения = "Параметр" Тогда
		ВременнаяСхема.НаборыДанных.Очистить();
		ВременнаяСхема.ВычисляемыеПоля.Очистить();
		ВременнаяСхема.ПоляИтога.Очистить();
	ИначеЕсли ТипВыражения = "ВычисляемоеПоле" Тогда
		ВременнаяСхема.ВычисляемыеПоля.Очистить();
	КонецЕсли; 
	КомпоновщикНастроек.Инициализировать(Новый ИсточникДоступныхНастроекКомпоновкиДанных(ВременнаяСхема));
	ПодсказкаПоляТекстаВыражения.ОчиститьТаблицуСловЛокальногоКонтекста();
	Для Каждого ДоступноеПоле Из КомпоновщикНастроек.Настройки.ДоступныеПоляВыбора.Элементы Цикл
		НрегПервыйФрагмент = ирОбщий.ПолучитьПервыйФрагментЛкс(НРег(ДоступноеПоле.Поле));
		Если НрегПервыйФрагмент = НРег("ПараметрыДанных") Тогда
			Для Каждого ДоступныйПараметр Из ДоступноеПоле.Элементы Цикл
				ИмяСвойства = "&" + ирОбщий.ПолучитьПоследнийФрагментЛкс(ДоступныйПараметр.Поле);
				ПодсказкаПоляТекстаВыражения.ДобавитьСловоЛокальногоКонтекста(ИмяСвойства, "Свойство", , ДоступныйПараметр,,,, "СтрокаТаблицы");
			КонецЦикла; 
		Иначе
			ПодсказкаПоляТекстаВыражения.ДобавитьСловоЛокальногоКонтекста("" + ДоступноеПоле.Поле, "Свойство",, ДоступноеПоле,,,, "СтрокаТаблицы");
		КонецЕсли; 

	КонецЦикла; 

КонецПроцедуры // ОбновитьДоступныеПоля()

Процедура ПриОткрытии()
	
	ирКэш.Получить().ИнициализацияОписанияМетодовИСвойств();
	// +++.КЛАСС.ПолеТекстовогоДокументаСКонтекстнойПодсказкой
	ПодсказкаПоляТекстаВыражения.Инициализировать(,
		ЭтаФорма, ЭлементыФормы.ПолеТекстаВыражения, ЭлементыФормы.КоманднаяПанельТекста,
		2, "ВычислитьВФорме", ЭтаФорма, "Выражение");
	// ---.КЛАСС.ПолеТекстовогоДокументаСКонтекстнойПодсказкой
	
	Если НачальноеЗначениеВыбора <> Неопределено Тогда
		ЭтаФорма.ТипВыражения = НачальноеЗначениеВыбора.ТипВыражения;
		ЭлементыФормы.ТипВыражения.ТолькоПросмотр = Истина;
		ЭтаФорма.Выражение = НачальноеЗначениеВыбора.Выражение;
	КонецЕсли; 
	ирПлатформа = ирКэш.Получить();
	СтруктураТипаКонтекста = ирПлатформа.ПолучитьНовуюСтруктуруТипа();
	СтруктураТипаКонтекста.ИмяОбщегоТипа = "Локальный контекст";
	ТаблицаСлов = ирПлатформа.ПолучитьВнутреннююТаблицуПредопределенныхСлов(СтруктураТипаКонтекста,,,,2);
	//ТаблицаСлов = ирПлатформа.ПолучитьВнутреннююТаблицуПредопределенныхСлов(СтруктураТипа, 2);
	Для Каждого СтрокаСлова Из ТаблицаСлов Цикл
		Если Не ирОбщий.СтрокиРавныЛкс(СтрокаСлова.ТипСлова, "Метод") Тогда
			Продолжить;
		КонецЕсли; 
		СтрокаФункции = ТаблицаФункций.Добавить();
		СтрокаФункции.Функция = СтрокаСлова.Слово;
		СтрокаФункции.СтруктураТипа = СтрокаСлова.ТаблицаСтруктурТипов[0];
	КонецЦикла;
	ОбновитьДоступныеПоля();
	Если ТипЗнч(ВладелецФормы) = Тип("Форма") Тогда
		ВладелецФормы.Панель.Доступность = Ложь;
	КонецЕсли;
	ЭлементыФормы.ПолеТекстаВыражения.УстановитьТекст(Выражение);

КонецПроцедуры

Процедура ПриЗакрытии()
	
	// +++.КЛАСС.ПолеТекстовогоДокументаСКонтекстнойПодсказкой
	ПодсказкаПоляТекстаВыражения.Уничтожить();
	// ---.КЛАСС.ПолеТекстовогоДокументаСКонтекстнойПодсказкой
	
	Если ТипЗнч(ВладелецФормы) = Тип("Форма") Тогда
		ВладелецФормы.Панель.Доступность = Истина;
	КонецЕсли;
	
КонецПроцедуры

Функция СохранитьИзменения()

	Если Не ПодсказкаПоляТекстаВыражения.ПроверитьПрограммныйКод() Тогда 
		Ответ = Вопрос("Выражение содержит ошибки. Продолжить?", РежимДиалогаВопрос.ОКОтмена);
		Если Ответ <> КодВозвратаДиалога.ОК Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли; 
	Текст = ЭлементыФормы.ПолеТекстаВыражения.ПолучитьТекст();
	Если Не МодальныйРежим Тогда
		ирОбщий.ПоместитьТекстВБуферОбменаОСЛкс(Текст);
	КонецЕсли;
	Модифицированность = Ложь;
	Закрыть(Текст);
	Возврат Истина;

КонецФункции // СохранитьИзменения()

Процедура ОсновныеДействияФормыОК(Кнопка)
	
	СохранитьИзменения();
	
КонецПроцедуры

// Выполняет программный код в контексте.
//
// Параметры:
//  ТекстДляВыполнения – Строка;
//  *ЛиСинтаксическийКонтроль - Булево, *Ложь - признак вызова только для синтаксического контроля.
//
Функция ВычислитьВФорме(ТекстДляВыполнения, ЛиСинтаксическийКонтроль = Ложь) Экспорт
	
	ПроверочнаяСхема = ирОбщий.ПолучитьКопиюОбъектаЛкс(СхемаКомпоновки);
	#Если _ Тогда
		ПроверочнаяСхема = Новый СхемаКомпоновкиДанных
	#КонецЕсли
	//Компоновщик = Новый КомпоновщикНастроекКомпоновкиДанных;
	НастройкаКомпоновки = Новый НастройкиКомпоновкиДанных;
	Группировка = НастройкаКомпоновки.Структура.Добавить(Тип("ГруппировкаКомпоновкиДанных"));
	ВыбранноеПоле = Группировка.Выбор.Элементы.Добавить(Тип("ВыбранноеПолеКомпоновкиДанных"));
	лВыражение = ?(ТекстДляВыполнения = "", "0", ТекстДляВыполнения); // Пустую строку заменяем на 0, чтобы компоновщик не спотыкался;
	ИмяПоля = "_" + СтрЗаменить("" + Новый УникальныйИдентификатор, "-", "");
	ВыбранноеПоле.Поле = Новый ПолеКомпоновкиДанных(ИмяПоля);
	Если Найти(ТипВыражения, "ВычисляемоеПоле") = 1 Тогда
		лПоле = ПроверочнаяСхема.ВычисляемыеПоля.Добавить();
		лПоле.Заголовок = ИмяПоля;
		лПоле.ПутьКДанным = ИмяПоля;
		лПоле.Выражение = "0";
		//Если ТипВыражения = "ВычисляемоеПоле.Выражение" Тогда 
			лПоле.Выражение = лВыражение;
		//ИначеЕсли ТипВыражения = "ВычисляемоеПоле.Представление" Тогда
		//	лПоле.ВыражениеПредставления = лВыражение;
		//ИначеЕсли ТипВыражения = "ВычисляемоеПоле.Упорядочивание" Тогда
		//	ПолеПорядка = Группировка.Порядок.Элементы.Добавить(Тип("ЭлементПорядкаКомпоновкиДанных"));
		//	ПолеПорядка.Поле = Новый ПолеКомпоновкиДанных(лПоле.ПутьКДанным);
		//	ВыражениеУпорядочивания = лПоле.ВыраженияУпорядочивания.Добавить();
		//	ВыражениеУпорядочивания.Выражение = лВыражение;
		//КонецЕсли; 
	//ИначеЕсли Найти(ТипВыражения, "Поле") = 1 Тогда
	//	ИсточникДанных = ПроверочнаяСхема.ИсточникиДанных.Добавить();
	//	ИсточникДанных.Имя = "Local";
	//	ИсточникДанных.ТипИсточникаДанных =  "Local";
	//	НаборДанных = ПроверочнаяСхема.НаборыДанных.Добавить(Тип("НаборДанныхЗапросСхемыКомпоновкиДанных"));
	//	НаборДанных.ИсточникДанных = "Local";
	//	НаборДанных.Запрос = "Выбрать 1 КАК Поле1";
	//	лПоле = НаборДанных.Поля.Добавить(Тип("ПолеНабораДанныхСхемыКомпоновкиДанных"));
	//	лПоле.Поле = "Поле1";
	//	лПоле.ПутьКДанным = ИмяПоля;
	//	Если ТипВыражения = "Поле.Представление" Тогда
	//		лПоле.ВыражениеПредставления = лВыражение;
	//	ИначеЕсли ТипВыражения = "Поле.Упорядочивание" Тогда
	//		ВыражениеУпорядочивания = лПоле.ВыраженияУпорядочивания.Добавить();
	//		ВыражениеУпорядочивания.Выражение = лВыражение;
	//	КонецЕсли; 
	ИначеЕсли ТипВыражения = "Параметр" Тогда
		лПоле = ПроверочнаяСхема.Параметры.Добавить();
		лПоле.Имя = ИмяПоля;
		лПоле.ОграничениеИспользования = Истина;
		лПоле.Выражение = лВыражение;
		ВыбранноеПоле.Поле = Новый ПолеКомпоновкиДанных("ПараметрыДанных." + ИмяПоля);
	ИначеЕсли ТипВыражения = "ПолеИтога" Тогда
		лПоле = ПроверочнаяСхема.ПоляИтога.Добавить();
		лПоле.ПутьКДанным = ИмяПоля;
		лПоле.Выражение = лВыражение;
	//ИначеЕсли Найти(ТипВыражения, "ПользовательскоеПоле") = 1 Тогда
	//	лПоле = Компоновщик.Настройки.ПользовательскиеПоля.Элементы.Добавить(Тип("ПользовательскоеПолеВыражениеКомпоновкиДанных"));
	//	ИмяПоля = лПоле.ПутьКДанным;
	//	//Если ТипВыражения = "ПользовательскоеПоле.Детали" Тогда
	//		лПоле.УстановитьВыражениеДетальныхЗаписей(лВыражение);
	//	//ИначеЕсли ТипВыражения = "ПользовательскоеПоле.Итоги" Тогда
	//	//	лПоле.УстановитьВыражениеИтоговыхЗаписей(лВыражение);
	//	//КонецЕсли; 
	//	ВыбранноеПоле.Поле = Новый ПолеКомпоновкиДанных(ИмяПоля);
	КонецЕсли; 
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
	// От(ПроверочнаяСхема, НастройкаКомпоновки);
	ВнешниеНаборыДанных = ирОбщий.ДополнитьСтруктуруВнешихНаборовДанныхПустышкамиЛкс(СхемаКомпоновки);
	МакетКомпоновки = КомпоновщикМакета.Выполнить(ПроверочнаяСхема, НастройкаКомпоновки); // Здесь будет возникать ошибка
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, ВнешниеНаборыДанных,, ВнешниеФункцииРазрешены);

КонецФункции // ВычислитьВФорме()

Процедура ДоступныеПоляНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	НрегПервыйФрагмент = ирОбщий.ПолучитьПервыйФрагментЛкс(НРег(Элемент.ТекущаяСтрока.Поле));
	Если НрегПервыйФрагмент = НРег("ПараметрыДанных") Тогда
		ПараметрыПеретаскивания.Значение = "&" + ирОбщий.ПолучитьПоследнийФрагментЛкс(Элемент.ТекущаяСтрока.Поле);
	ИначеЕсли Истина
		И ТипВыражения <> "ПолеИтога"
		И НрегПервыйФрагмент = НРег("СистемныеПоля") 
	Тогда
		ПараметрыПеретаскивания.ДопустимыеДействия = ДопустимыеДействияПеретаскивания.НеОбрабатывать;
	Иначе
		ПараметрыПеретаскивания.Значение = Элемент.ТекущаяСтрока.Поле;
	КонецЕсли; 
	
КонецПроцедуры

Процедура КоманднаяПанельТекстаСсылкаНаОбъектБД(Кнопка)
	
	//ПолеВстроенногоЯзыка.ВставитьСсылкуНаОбъектБД(СхемаКомпоновки, "");
	
КонецПроцедуры

Процедура ДоступныеПоляПриВыводеСтроки(Элемент, ОформлениеСтроки, ДанныеСтроки)
	
	Если Не ПредставленияИмена Тогда
		ОформлениеСтроки.Ячейки.Заголовок.УстановитьТекст(ирОбщий.ПолучитьПоследнийФрагментЛкс("" + ДанныеСтроки.Поле));
	КонецЕсли; 
	
КонецПроцедуры

Процедура КоманднаяПанельТекстаПредставленияИмена(Кнопка)
	
	ПредставленияИмена = Не Кнопка.Пометка;
	Кнопка.Пометка = ПредставленияИмена;
	ЭлементыФормы.ДоступныеПоля.ОбновитьСтроки();
	
КонецПроцедуры

Процедура ПередЗакрытием(Отказ, СтандартнаяОбработка)
	
	Если Модифицированность Тогда
		Ответ = Вопрос("Выражение было изменено. Сохранить изменения?", РежимДиалогаВопрос.ДаНетОтмена);
		Если Ответ = КодВозвратаДиалога.Да Тогда
			Отказ = Не СохранитьИзменения();
		ИначеЕсли Ответ = КодВозвратаДиалога.Отмена Тогда
			Отказ = Истина;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Процедура КоманднаяПанельТекстаВнешниеФункции(Кнопка)
	
	ЭтаФорма.ВнешниеФункцииРазрешены = Не Кнопка.Пометка;
	Кнопка.Пометка = ВнешниеФункцииРазрешены;

КонецПроцедуры

Процедура ТипВыраженияПриИзменении(Элемент)
	
	ОбновитьДоступныеПоля();

КонецПроцедуры

Процедура КонтекстноеМенюФункцийСинтаксПомощник(Кнопка)
	
	ТекущаяСтрокаФункций = ЭлементыФормы.ТаблицаФункций.ТекущаяСтрока;
	Если ТекущаяСтрокаФункций = Неопределено Тогда
		Возврат;
	КонецЕсли;
	СтруктураТипа = ТекущаяСтрокаФункций.СтруктураТипа;
	Если СтруктураТипа <> Неопределено Тогда
		СтрокаОписания = СтруктураТипа.СтрокаОписания;
		Если СтрокаОписания <> Неопределено Тогда
			ирОбщий.ОткрытьСтраницуСинтаксПомощникаЛкс(СтрокаОписания.ПутьКОписанию, , ЭтаФорма);
		КонецЕсли; 
	КонецЕсли; 

КонецПроцедуры

Процедура ТаблицаФункцийНачалоПеретаскивания(Элемент, ПараметрыПеретаскивания, Выполнение)
	
	ПараметрыПеретаскивания.Значение = Элемент.ТекущаяСтрока.Функция + "()";
	
КонецПроцедуры

Процедура ПриПолученииДанныхДоступныхПолей(Элемент, ОформленияСтрок)

	ирОбщий.ПриПолученииДанныхДоступныхПолейКомпоновкиЛкс(ОформленияСтрок);

КонецПроцедуры // ПриПолученииДанныхДоступныхПолей()

#Если Клиент Тогда
Контейнер = Новый Структура();
Оповестить("ирПолучитьБазовуюФорму", Контейнер);
Если Не Контейнер.Свойство("ирПортативный", ирПортативный) Тогда
	ПолноеИмяФайлаБазовогоМодуля = ВосстановитьЗначение("ирПолноеИмяФайлаОсновногоМодуля");
	ирПортативный = ВнешниеОбработки.ПолучитьФорму(ПолноеИмяФайлаБазовогоМодуля);
КонецЕсли; 
ирОбщий = ирПортативный.ПолучитьОбщийМодульЛкс("ирОбщий");
ирКэш = ирПортативный.ПолучитьОбщийМодульЛкс("ирКэш");
ирСервер = ирПортативный.ПолучитьОбщийМодульЛкс("ирСервер");
ирПривилегированный = ирПортативный.ПолучитьОбщийМодульЛкс("ирПривилегированный");
#КонецЕсли

ирОбщий.ПодключитьОбработчикиСобытийДоступныхПолейКомпоновкиЛкс(ЭлементыФормы.ДоступныеПоля);

ПредставленияИмена = Ложь;
ВнешниеФункцииРазрешены = Истина;
ТипВыражения = "ПолеИтога";
//ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("Поле.Представление", "Поле.Представление");
//ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("Поле.Упорядочивание", "Поле.Упорядочивание");
//ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("ВычисляемоеПоле.Выражение", "Вычисляемое поле.Выражение");
//ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("ВычисляемоеПоле.Представление", "Вычисляемое поле.Представление");
//ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("ВычисляемоеПоле.Упорядочивание", "Вычисляемое поле.Упорядочивание");
//ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("Параметр.Выражение", "Параметр.Выражение");
//ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("ПолеИтога.Выражение", "Поле итога.Выражение");
//ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("ПользовательскоеПоле.Детали", "Пользовательское поле.Детали");
//ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("ПользовательскоеПоле.Итоги", "Пользовательское поле.Итоги");
ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("ВычисляемоеПоле", "Вычисляемое поле");
ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("Параметр", "Параметр");
ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("ПолеИтога", "Поле итога");
//ЭлементыФормы.ТипВыражения.СписокВыбора.Добавить("ПользовательскоеПоле", "Пользовательское поле");

ТаблицаФункций.Колонки.Добавить("СтруктураТипа");

ирОбщий.ИнициализироватьФормуЛкс(ЭтаФорма, "Отчет.ирКонсольКомпоновокДанных.Форма.КонструкторВыраженияКомпоновки");
