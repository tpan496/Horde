--[[
HORDE Translation Guideline
1. Use English as base.
2. Do NOT translate special characters. e.g. {1}, %d. Keep those directly.
3. Keep translations short and concise.
4. Consistency, especially for perks.
increase vs. more: these two descriptions are DIFFERENT!
resistance vs. less damage taken: same as above.
5. Translate AS IS.
--]]

translate.AddLanguage("ru", "Russian")

-- Game Info
LANGUAGE["Game_Ready"] = "Готов"
LANGUAGE["Game_Not Ready"] = "Не готов"
LANGUAGE["Game_Players_Ready"] = "Готовые игроки"
LANGUAGE["Game_Next_Wave_Starts_In"] = "Следующая волна начнется через %d"
LANGUAGE["Game_Difficulty_NORMAL"] = "Нормальный"
LANGUAGE["Game_Difficulty_HARD"] = "Сложный"
LANGUAGE["Game_Difficulty_REALISM"] = "Реалистичный"
LANGUAGE["Game_Difficulty_NIGHTMARE"] = "Кошмарный"
LANGUAGE["Game_Enemies"] = "Враги"
LANGUAGE["Game_HintBottomReady"] = "F2-знания, F3-Магазин/Умение, F4-Готов"
LANGUAGE["Game_HintBottom"] = "F3-Магазин/Умение, V-Выкинуть $"
LANGUAGE["Game_Result_VICTORY"] = "ПОБЕДА!"
LANGUAGE["Game_Result_DEFEAT"] = "ПОРАЖЕНИЕ..."
LANGUAGE["Game_Result_Change Map"] = "Смена карты"
LANGUAGE["Game_Wave"] = "Волна"
LANGUAGE["Game_Wave_Has_Started"] = "Волна %d началась"
LANGUAGE["Game_Wave_Completed"] = "Волна пройдена"
LANGUAGE["Game_Remaining_Time"] = "Время"
LANGUAGE["Game_Vote_Map"] = "Голосование карты"
LANGUAGE["Game_Game_Summary"] = "Итог игры"
LANGUAGE["Game_Most_Damage_Dealt"] = "Наибольшой нанесенный урон"
LANGUAGE["Game_Damage"] = "Урон"
LANGUAGE["Game_Most_Damage_Taken"] = "Наибольшой полученный урон"
LANGUAGE["Game_Damage_Taken"] = "Получен урон"
LANGUAGE["Game_Most_Kills"] = "Наибольшее колличество убийств"
LANGUAGE["Game_Kills"] = "Убийства"
LANGUAGE["Game_Elite_Killer"] = "Убийца элитных"
LANGUAGE["Game_Elite_Kills"] = "Убийства элитных"
LANGUAGE["Game_SharpShooter"] = "Снайпер"
LANGUAGE["Game_Headshots"] = "Выстрелы в голову"
LANGUAGE["Game_Most_Heal"] = "Наибольшие лечение"
LANGUAGE["Game_Healed"] = "Вылечил"
LANGUAGE["Game_Healed_You"] = "Вылечил вас"


-- Ranks
LANGUAGE["Rank_Novice"] = "Новичок"
LANGUAGE["Rank_Amateur"] = "Любитель"
LANGUAGE["Rank_Skilled"] = "Опытный"
LANGUAGE["Rank_Professional"] = "Профессионал"
LANGUAGE["Rank_Expert"] = "Эксперт"
LANGUAGE["Rank_Champion"] = "Чемпион"
LANGUAGE["Rank_Master"] = "Мастер"


-- Shop
-- Categories
LANGUAGE["Shop_Class"] = "Класс"
LANGUAGE["Shop_Cash"] = "Деньги"
LANGUAGE["Shop_Weight"] = "Масса"
LANGUAGE["Shop_Melee"] = "Ближний бой"
LANGUAGE["Shop_Pistol"] = "Пистолеты"
LANGUAGE["Shop_Shotgun"] = "Дробовики"
LANGUAGE["Shop_SMG"] = "ПП"
LANGUAGE["Shop_Rifle"] = "Винтовки"
LANGUAGE["Shop_MG"] = "Пулеметы"
LANGUAGE["Shop_Explosive"] = "Взрывчатки"
LANGUAGE["Shop_Special"] = "Специализированные"
LANGUAGE["Shop_Equipment"] = "Снаряжение"
LANGUAGE["Shop_Attachment"] = "Обвесы"
LANGUAGE["Shop_Gadget"] = "Гаджеты"

-- Attachments
LANGUAGE["Shop_Optic"] = "Прицелы"
LANGUAGE["Shop_Underbarrel"] = "Подствольники"
LANGUAGE["Shop_Tactical"] = "Тактические"
LANGUAGE["Shop_Barrel"] = "Стволы"
LANGUAGE["Shop_Muzzle"] = "Дула"
LANGUAGE["Shop_Magazine"] = "Магазины"
LANGUAGE["Shop_Stock"] = "Приклады"
LANGUAGE["Shop_Ammo Type"] = "Тип патрона"
LANGUAGE["Shop_Perk"] = "Перки"

-- Class Panel
LANGUAGE["Shop_Class/Perks"] = "Класс/Умения"
LANGUAGE["Shop_Select_Class"] = "Выбрать класс (Ваши вещи будут выброшены)"
LANGUAGE["Shop_Show_Perks"] = "Показать умения класса"
LANGUAGE["Shop_Hide_Perks"] = "Скрыть умения класса"
LANGUAGE["Shop_Unlocks_After_Wave"] = "Разблокируется после %d волны"
LANGUAGE["Shop_Buy_Ammo_Clip"] = "Купить обоиму"
LANGUAGE["Shop_Sell_For"] = "Продать за"
LANGUAGE["Shop_Sell_All_For"] = "Продать все за"
LANGUAGE["Shop_Buy_Item"] = "Купить"
LANGUAGE["Shop_OWNED"] = "КУПЛЕНО"
LANGUAGE["Shop_Buy_Secondary_Ammo"] = "Купить вторичный боеприпас"
LANGUAGE["Shop_Primary_Ammo"] = "Основные боеприпасы"
LANGUAGE["Shop_Secondary_Ammo"] = "Вторичные боеприпасы"


-- Classes
LANGUAGE["Class_Survivor"] = "Выживший"
LANGUAGE["Class_Assault"] = "Штурмовик"
LANGUAGE["Class_Heavy"] = "Солдат"
LANGUAGE["Class_Medic"] = "Медик"
LANGUAGE["Class_Demolition"] = "Подрывник"
LANGUAGE["Class_Ghost"] = "Призрак"
LANGUAGE["Class_Engineer"] = "Инженер"
LANGUAGE["Class_Berserker"] = "Берсерк"
LANGUAGE["Class_Warden"] = "Надзиратель"
LANGUAGE["Class_Cremator"] = "Крематор"

-- Default Class Extra Descriptions
LANGUAGE["Class_Description_Survivor"] = [[
Имеет доступ ко всему вооружению, кроме эксклюзивного и специального оружия.
Ограниченный доступ к обвесам.]]

LANGUAGE["Class_Description_Assault"] = [[
Имеет полный доступ к автоматическим винтовкам.]]

LANGUAGE["Class_Description_Heavy"] = [[
Имеет полный доступ к тяжелому вооружению.]]

LANGUAGE["Class_Description_Medic"] = [[
Имеет доступ к легкому вооружению и медицинскими инструментами.]]

LANGUAGE["Class_Description_Demolition"] = [[
Имеет полный доступ к взрывчатке.]]

LANGUAGE["Class_Description_Ghost"] = [[
Имеет доступ к снайперским винтовкам и некоторым легким вооружений.
Имеет доступ к глушителям и снайперским прицелам.]]

LANGUAGE["Class_Description_Engineer"] = [[
Имеет доступ к специальному вооружению и снаряжению.]]

LANGUAGE["Class_Description_Berserker"] = [[
Имеет доступ только к ближному бою.]]

LANGUAGE["Class_Description_Warden"] = [[
Имеет полный доступ к дробовикам и сторожевым вышкам (horde_watchtower).]]

LANGUAGE["Class_Description_Cremator"] = [[
Имеет полный доступ к поджигающему вооружению.]]


-- Default Base Perks
LANGUAGE["Perk_survivor_base"] = [[
Класс Выживший можно превратить в любой класс, чтобы заполнить недостающие роли для команды.
Сложность: ЛЕГКО
Нет бонусов.]]

LANGUAGE["Perk_assault_base"] = [[
Класс Штурмовик это универсальный боец с высокой мобильностью и сосредоточенное на зарядах адреналина.
Сложность: ЛЕГКО
На {1} увеличена скорость передвижения.
Убивая врага вы получаете заряд адреналина.
Заряд адреналина увеличивает урон и скорость передвижения на {2}.]]

LANGUAGE["Perk_heavy_base"] = [[
Класс Солдат это класс танков, обеспечивающий сильную огневую мощь.
Сложность: ЛЕГКО
Добавляет {1} к максимальной весу переноса оружий.
Регенерирует по {2} брони в секунду.
Восстановливает до {3} брони.]]

LANGUAGE["Perk_medic_base"] = [[
Класс Медик это прочный класс поддержки, который фокусируется на лечении и усилении товарищей по команде.
Сложность: СРЕДНЯЯ
Восстановливает {1} здоровьи в секунду.]]

LANGUAGE["Perk_demolition_base"] = [[
Класс Подрывник это класс по борьбе с толпой, который также обеспечивает высокий урон по одиночной цели.
Сложность: СРЕДНЯЯ
На {1} увеличивает сопротивление урону от взрыва.
Восстанавливает {2} осколочную гранату каждый {3} секунд, если у вас ее нет.]]

LANGUAGE["Perk_ghost_base"] = [[
Класс Призрак ориентирован на уничтожение врагов-боссов с помощью камуфляжа.
Сложность: ВЫСОКАЯ
На 25% больше урона в голову.
В приседе активирует камуфляж, дающую 15% к уклонению.
Атака, бег или прыжок убирает камуфляж.]]

LANGUAGE["Perk_engineer_base"] = [[
Класс Инженер это класс, ориентированный на миньонов, которые наносят урон.
Сложность: СРЕДНЯЯ
На {1} увеличено здоровье и урон миньонов.
Турели имеют здоровье в {2} единиц и урон в {3} единиц. ]]

LANGUAGE["Perk_berserker_base"] = [[
Класс Берсеркер это класс, ориентированный на рукопашный бой, которым можно играть как в нападении, так и в защите.
Сложность: ВЫСОКАЯ
На {1} сопротивление к глобальному урону.
На {2} сопротивление к яду. ]]

LANGUAGE["Perk_warden_base"] = [[
Класс Смотритель это класс поддержки, который использует эффекты ауры и структуры для усиления товарищей по команде.
Сложность: СРЕДНЯЯ
Игроки находящие рядом с вами получают эффект ауры Смотритель.
Аура Смотрителя блокирует {1} урона.]]

LANGUAGE["Perk_cremator_base"] = [[
Крематор предпочитает наносить урон Огнём.
На {1} увеличенная защита от Огня.
Атаки имеют {2} шанс Воспламенения противника.
Базовая длительность Воспламенения составляет {3} и наносит постепенный урон в зависимости от нанесённых повреждений.
Урон от огня имеет шанс воспламенения {5}.]]

-- Default Perks: Survivor
LANGUAGE["Perk_Title_Survivor_Tier_1"] = [[Выживание]]
LANGUAGE["Perk_Title_Survivor_Tier_2"] = [[Импровизация]]
LANGUAGE["Perk_Title_Survivor_Tier_3"] = [[Вдохновленное обучение]]

-- Default Perks: Assault
LANGUAGE["Perk_Title_Assault_Tier_1"] = [[Маневрирование]]
LANGUAGE["Perk_Title_assault_ambush"] = [[Засада]]
LANGUAGE["Perk_assault_ambush"] = [[
На {1} увеличен урон в голову.]]

LANGUAGE["Perk_Title_assault_charge"] = [[Заряжение]]
LANGUAGE["Perk_assault_charge"] = [[
Добавляет {1} дополнительных зарядов к адреналину.
Каждый заряд увеличивает урон и скорость передвижения на {2}.]]

LANGUAGE["Perk_Title_Assault_Tier_2"] = [[Адаптация]]
LANGUAGE["Perk_Title_assault_drain"] = [[Осушение]]
LANGUAGE["Perk_assault_drain"] = [[
На {1} увеличен урон в голову при полном здоровье.
Восстанавливаете {2} здоровья за каждого убитого врага.]]

LANGUAGE["Perk_Title_assault_overclock"] = [[Разгон]]
LANGUAGE["Perk_assault_overclock"] = [[
Продолжительность адреналина увеличена на {1}.
Добавляет {2} дополнительных зарядов к адреналину.]]

LANGUAGE["Perk_Title_Assault_Tier_3"] = [[Состояние]]
LANGUAGE["Perk_Title_assault_heightened_reflex"] = [[Повышенный рефлекс]]
LANGUAGE["Perk_assault_heightened_reflex"] = [[
На {1} увеличен урон в голову.
На {2} сопротивление к глобальному урону при полном здоровье.]]

LANGUAGE["Perk_Title_assault_cardiac_overload"] = [[Сердечная перегрузка]]
LANGUAGE["Perk_assault_cardiac_overload"] = [[
{1} шанс добавить 1 заряд адреналина при выстреле в голову.
Добавляет {2} дополнительных зарядов к адреналину.]]

-- Default Perks: Heavy
LANGUAGE["Perk_Title_Heavy_Tier_1"] = [[Подавление]]
LANGUAGE["Perk_Title_heavy_sticky_compound"] = [[Липкое соединение]]
LANGUAGE["Perk_heavy_sticky_compound"] = [[
Противники, пораженные баллистическим уроном, замедляются.
Замедленные враги имеют на {1} пониженную скорость действия.]]

LANGUAGE["Perk_Title_heavy_crude_casing"] = [[Неочищенная обсадная колонна]]
LANGUAGE["Perk_heavy_crude_casing"] = [[
Враги, пораженные баллистическим уроном, ослабляются.
Ослабленные враги наносят на {1} меньший урона.
Ослабленные враги получают на {2} больше урона.]]

LANGUAGE["Perk_Title_Heavy_Tier_2"] = [[Защитная броня]]
LANGUAGE["Perk_Title_heavy_liquid_armor"] = [[Жидкая броня]]
LANGUAGE["Perk_heavy_liquid_armor"] = [[
Пока у вас есть как минимум {1} брони:
  Сопротивление к физическому урону на {2}.]]

LANGUAGE["Perk_Title_heavy_reactive_armor"] = [[Реактивная броня]]
LANGUAGE["Perk_heavy_reactive_armor"] = [[
Пока у вас есть как минимум {1} брони:
  Иммунитет к урону от яда, огня и взрыва.]]

LANGUAGE["Perk_Title_Heavy_Tier_3"] = [[Технология]]
LANGUAGE["Perk_Title_heavy_nanomachine"] = [[Наномашина]]
LANGUAGE["Perk_heavy_nanomachine"] = [[
На {1} увеличено скорость восстановление брони.
Теперь вы можете восстановиливать до {2} брони.]]

LANGUAGE["Perk_Title_heavy_ballistic_shock"] = [[Баллистический шок]]
LANGUAGE["Perk_heavy_ballistic_shock"] = [[
Отрицательные эффекты имеют на {1} усиленный эффект.
Отрицательные эффекты имеют на {2} время действий.]]

-- Default Perks: Medic
LANGUAGE["Perk_Title_Medic_Tier_1"] = [[Медицина]]
LANGUAGE["Perk_Title_medic_antibiotics"] = [[Антибиотики]]
LANGUAGE["Perk_medic_antibiotics"] = [[
Ваше исцеление усилено на {1}.]]

LANGUAGE["Perk_Title_medic_painkillers"] = [[Обезболивающие]]
LANGUAGE["Perk_medic_painkillers"] = [[
Ваше исцеление повышает здоровье игрока на {1}.]]

LANGUAGE["Perk_Title_Medic_Tier_2"] = [[Био-инженерия]]
LANGUAGE["Perk_Title_medic_berserk"] = [[Ярость]]
LANGUAGE["Perk_medic_berserk"] = [[
При лечение игрока, получают эффект ярости в течение {1} секунд.
Эффект ярости увеличивает урон и скорость передвижения на {2}.]]

LANGUAGE["Perk_Title_medic_fortify"] = [[Укрепление]]
LANGUAGE["Perk_medic_fortify"] = [[
При лечение игрока, получают эффект укрепление в течение {1} секунд.
Эффект укрепление уменьшает получаемого урона на {2}.]]

LANGUAGE["Perk_Title_Medic_Tier_3"] = [[Естественный отбор]]
LANGUAGE["Perk_Title_medic_cellular_implosion"] = [[Клеточная имплозия]]
LANGUAGE["Perk_medic_cellular_implosion"] = [[
У убитых вами врагов есть {1} шанс создать исцеляющее облако.]]

LANGUAGE["Perk_Title_medic_xcele"] = [[Фактор ускоренного исцеления]]
LANGUAGE["Perk_medic_xcele"] = [[
На {1} увеличено восстановление здоровья в секунду.
Применяемые вами эффекты на {2} более эффективны.]]

-- Default Perks: Demolition
LANGUAGE["Perk_Title_Demolition_Tier_1"] = [[Граната]]
LANGUAGE["Perk_Title_demolition_frag_impact"] = [[Ударная граната]]
LANGUAGE["Perk_demolition_frag_impact"] = [[
Гранаты взрываются при столкновении с врагом.
Урон от гранат увеличен на {1}.]]

LANGUAGE["Perk_Title_demolition_frag_cluster"] = [[Кассетная граната]]
LANGUAGE["Perk_demolition_frag_cluster"] = [[
Гранаты и SLAM создают {1} мини-гранаты при взрыве.
Мини-гранаты наносят на {2} меньше урона.]]

LANGUAGE["Perk_Title_Demolition_Tier_2"] = [[Подход]]
LANGUAGE["Perk_Title_demolition_fragmentation"] = [[Дробление]]
LANGUAGE["Perk_demolition_fragmentation"] = [[
Враги с полным здоровьем получают на {1} больше урона от взрыва.]]

LANGUAGE["Perk_Title_demolition_napalm"] = [[Напалм]]
LANGUAGE["Perk_demolition_napalm"] = [[
На {1} увеличен урон от огня.
На {2} увеличена огнестойкость.]]

LANGUAGE["Perk_Title_Demolition_Tier_3"] = [[Разрушение]]
LANGUAGE["Perk_Title_demolition_pressurized_warhead"] = [[Герметичная боеголовка]]
LANGUAGE["Perk_demolition_pressurized_warhead"] = [[
На {1} увеличен урон от взрыва по элитным врагам.
Взрывы наносят {2} текущего здоровья врагов в виде дополнительного урона от взрыва.]]

LANGUAGE["Perk_Title_demolition_chain_reaction"] = [[Цепная реакция]]
LANGUAGE["Perk_demolition_chain_reaction"] = [[
Убитые вами враги есть {1} шанс взорваться,
нанося {2} от их максимального здоровья в виде урона от взрыва.]]

-- Default Perks: Ghost
LANGUAGE["Perk_Title_Ghost_Tier_1"] = [[Тактика]]
LANGUAGE["Perk_Title_ghost_headhunter"] = [[Охотник за головами]]
LANGUAGE["Perk_ghost_headhunter"] = [[
Урон в голову умножается до 5 попаданий,
Каждое попадание увеличивает урон в голову на 8%.]]

LANGUAGE["Perk_Title_ghost_sniper"] = [[Снайпер]]
LANGUAGE["Perk_ghost_sniper"] = [[
На 25% увеличено баллистический урон при приседании.]]

LANGUAGE["Perk_Title_Ghost_Tier_2"] = [[Перестановка]]
LANGUAGE["Perk_Title_ghost_phase_walk"] = [[Фазовая ходьба]]
LANGUAGE["Perk_ghost_phase_walk"] = [[
Бег, прыжок не отменяет камуфляж.
На 25% увеличено скорости передвижения в камуфляже.]]

LANGUAGE["Perk_Title_ghost_ghost_veil"] = [[Призрачный покров]]
LANGUAGE["Perk_ghost_ghost_veil"] = [[
Атака не отменяет камуфляж.
На 100% увеличено скорость активации камуфляжа.]]

LANGUAGE["Perk_Title_Ghost_Tier_3"] = [[Утилизация]]
LANGUAGE["Perk_Title_ghost_coup"] = [[Удар милосердия]]
LANGUAGE["Perk_ghost_coup"] = [[
Мгновенно убивает врага с 20% или меньше здоровья.]]

LANGUAGE["Perk_Title_ghost_decapitate"] = [[Обезглавливания]]
LANGUAGE["Perk_ghost_decapitate"] = [[
Когда у вас камуфляж:
  На 25% увеличен баллистический урон.
  На 50% увеличено урон в голову по элите.]]

-- Default Perks: Engineer
LANGUAGE["Perk_Title_Engineer_Tier_1"] = [[Тонкая работа]]
LANGUAGE["Perk_Title_engineer_tinkerer"] = [[Ремесленник]]
LANGUAGE["Perk_engineer_tinkerer"] = [[
При появлении у миньонов на {1} больше здоровья.]]

LANGUAGE["Perk_Title_engineer_pioneer"] = [[Пионер]]
LANGUAGE["Perk_engineer_pioneer"] = [[
На {1} увеличено урон миньонов.]]

LANGUAGE["Perk_Title_Engineer_Tier_2"] = [[Архетип]]
LANGUAGE["Perk_Title_engineer_golem"] = [[Голем]]
LANGUAGE["Perk_engineer_golem"] = [[
Миньоны регенерирует {1} здоровья в секунду.
Атаки миньонов усиливает отбрасывания.]]

LANGUAGE["Perk_Title_engineer_spectre"] = [[Приведение]]
LANGUAGE["Perk_engineer_spectre"] = [[
Миньоны восстанавливают здоровья на {1} от нанесенного урона.
Миньоны наносят на {2} больше урона.]]

LANGUAGE["Perk_Title_Engineer_Tier_3"] = [[Экспериментальные]]
LANGUAGE["Perk_Title_engineer_symbiosis"] = [[Симбиоз]]
LANGUAGE["Perk_engineer_symbiosis"] = [[
При появлении у миньонов на {1} больше здоровья.
На {2} меньше получаете урона за каждого живого миньона.]]

LANGUAGE["Perk_Title_engineer_kamikaze"] = [[Смертники]]
LANGUAGE["Perk_engineer_kamikaze"] = [[
При смерти миньоны наносят {1} от своего максимального здоровья в виде урона от взрыва.]]

-- Default Perks: Berserker
LANGUAGE["Perk_Title_Berserker_Tier_1"] = [[Основы]]
LANGUAGE["Perk_Title_berserker_breathing_technique"] = [[Техника Дыхания]]
LANGUAGE["Perk_berserker_breathing_technique"] = [[
Восстановливает {1} здоровья в секунду.
Иммунитет к урону от яда.]]

LANGUAGE["Perk_Title_berserker_bloodlust"] = [[Кровожадность]]
LANGUAGE["Perk_berserker_bloodlust"] = [[
Восстановливает здоровья на {1} от нанесенного урона в ближнем бою.
Восстановливает здоровья на {2} единиц за удар.]]

LANGUAGE["Perk_Title_Berserker_Tier_2"] = [[Техника]]
LANGUAGE["Perk_Title_berserker_bushido"] = [[Путь воина]]
LANGUAGE["Perk_berserker_bushido"] = [[
На {1} увеличен режущий урон.
На {2} увеличена скорость передвижения.]]

LANGUAGE["Perk_Title_berserker_savagery"] = [[Свирепость]]
LANGUAGE["Perk_berserker_savagery"] = [[
На {1} увеличен урон тупым предметом.
На {2} увеличено максимальное здоровье.]]

LANGUAGE["Perk_Title_Berserker_Tier_3"] = [[Боевые искусства]]
LANGUAGE["Perk_Title_berserker_mindeye"] = [[Духовное око]]
LANGUAGE["Perk_berserker_mindeye"] = [[
Каждая рукопашная атака увеличивает заряд духовного око на 1, вплоть до {1}.
Каждый заряд увеличивает уклонение на {2} и урон на {3} в ближнем бою.
Теряет все заряды, если вы получили удар или превысили максимальное число зарядов.]]

LANGUAGE["Perk_Title_berserker_rip_and_tear"] = [[Разорвать и рвать]]
LANGUAGE["Perk_berserker_rip_and_tear"] = [[
На {1} больше урона в ближнем бою.
Ваша рукопашная атака наносит урон по области.
Урон по области составляет {2} от вашего урона в ближнем бою.]]

-- Default Perks: Warden
LANGUAGE["Perk_Title_Warden_Tier_1"] = [[Выдержка]]
LANGUAGE["Perk_Title_warden_bulwark"] = [[Бастион]]
LANGUAGE["Perk_warden_bulwark"] = [[
Сторожевые башни производят 1 батарея брони каждые {1} секунд.]]

LANGUAGE["Perk_Title_warden_vitality"] = [[Живучесть]]
LANGUAGE["Perk_warden_vitality"] = [[
Аура обеспечивает восстановление {1} ед. здоровья в секунду.]]

LANGUAGE["Perk_Title_Warden_Tier_2"] = [[Использование ресурсов]]
LANGUAGE["Perk_Title_warden_restock"] = [[Быстрое Пополнение]]
LANGUAGE["Perk_warden_restock"] = [[
Время восстановления запасов сторожевых башен уменьшено на {1}.]]

LANGUAGE["Perk_Title_warden_energize"] = [[Зарядка]]
LANGUAGE["Perk_warden_energize"] = [[
Аура добавляет {1} ед. базового урона к атакам.]]

LANGUAGE["Perk_Title_Warden_Tier_3"] = [[Покрытие]]
LANGUAGE["Perk_Title_warden_ex_machina"] = [[Бог из машины]]
LANGUAGE["Perk_warden_ex_machina"] = [[
Сторожевые башни имеют ауру Смотрителя.
Сторожевые башни генерируют ударную волну каждые {1} секунды.
Ударная волна наносит {2} урона от удара.]]

LANGUAGE["Perk_Title_warden_resonance_cascade"] = [[Каскадный резонанс]]
LANGUAGE["Perk_warden_resonance_cascade"] = [[
Эффект ауры увеличен на {1}.
Радиус ауры увеличен на {2}.]]

-- Default Perks: Cremator
LANGUAGE["Perk_Title_Cremator_Tier_1"] = [[Химикаты]]
LANGUAGE["Perk_Title_cremator_methane"] = [[Метан]]
LANGUAGE["Perk_cremator_methane"] = [[
На {1} увеличен урон Огнём Подожённым противникам.]]

LANGUAGE["Perk_Title_cremator_napalm"] = [[Напалм]]
LANGUAGE["Perk_cremator_napalm"] = [[
На {1} увеличен радиус Воспламенения
На {2} увеличнна длительность Воспламенения]]

LANGUAGE["Perk_Title_Cremator_Tier_2"] = [[Поглощение энергии]]
LANGUAGE["Perk_Title_cremator_positron_array"] = [[Позитронный массив]]
LANGUAGE["Perk_cremator_positron_array"] = [[
Иммунитет урону от Огня
Поглащаешь {1} от урона от Огня в качестве здоровья.]]

LANGUAGE["Perk_Title_cremator_entropy_shield"] = [[Энтропийный Щит]]
LANGUAGE["Perk_cremator_entropy_shield"] = [[
Получите щит, который сводит на нет полученный урон.
Щит взрывается при попадании и перезаряжается через {1} секунд..
Взрыв наносит {2} урона от огня.]]

LANGUAGE["Perk_Title_Cremator_Tier_3"] = [[Разряд энергии]]
LANGUAGE["Perk_Title_cremator_firestorm"] = [[Огненный Шторм]]
LANGUAGE["Perk_cremator_firestorm"] = [[
Урон от огня увеличивает силу Взрыва у врагов.
Создает взрыв, когда мощность Взрыва достигает {1}.
Взрыв наносит {2} Взрывной урон.]]

LANGUAGE["Perk_Title_cremator_incineration"] = [[Сжигание]]
LANGUAGE["Perk_cremator_incineration"] = [[
На {1} повышен урон Поджига.
На {2} увеличен шанс поджига.]]

-- Default Config Shop Items
-- Optional
LANGUAGE["Item_Stunstick"] = [[Оглушающая дубинка]]
LANGUAGE["Item_Desc_Stunstick"] = [[
Электрическая дубинка.
]]

LANGUAGE["Item_Crowbar"] = [[Монтировка]]
LANGUAGE["Item_Desc_Crowbar"] = [[
Ржавая монтировка.
]]

LANGUAGE["Item_Combat Knife"] = [[Боевой нож]]
LANGUAGE["Item_Desc_Combat Knife"] = [[
Надежный штык-нож.
ПКМ, чтобы нанести сильный удар.
]]

LANGUAGE["Item_Katana"] = [[Катана]]
LANGUAGE["Item_Desc_Katana"] = [[
Меч ниндзя.
Большая дальность атаки и высокая скорость атаки.
]]

LANGUAGE["Item_Bat"] = [[Бита]]
LANGUAGE["Item_Desc_Bat"] = [[
Прочная бейсбольная бита.
Бьет как грузовик.
]]


LANGUAGE["Item_9mm"] = [[9mm]]
LANGUAGE["Item_Desc_9mm"] = [[
Стандартное вооружение Альянса
]]

LANGUAGE["Item_357"] = [[357]]
LANGUAGE["Item_Desc_357"] = [[
Пистолет Colt python magnum.
Используется охранниками Черной Мезы.
]]

LANGUAGE["Item_Glock"] = [[Glock]]
LANGUAGE["Item_Desc_Glock"] = [[
Glock 18.
Полуавтоматические пистолеты австрийского производства.
]]

LANGUAGE["Item_USP"] = [[USP]]
LANGUAGE["Item_Desc_USP"] = [[
Универсальный самозарядный пистолет.
Полуавтоматический пистолет, разработанный в Германии компанией H&K.
]]

LANGUAGE["Item_P2000"] = [[P2000]]
LANGUAGE["Item_Desc_P2000"] = [[
Heckler & Koch P2000.
Исправный пистолет для первого патрона производства H&K.
]]

LANGUAGE["Item_P250"] = [[P250]]
LANGUAGE["Item_Desc_P250"] = [[
SIG Sauer P250.
Пистолет с низкой отдачей и высокой скорострельностью.
]]

LANGUAGE["Item_R8"] = [[R8]]
LANGUAGE["Item_Desc_R8"] = [[
R8 Revolver.
Выпускает высокоточный и мощный снаряд,
за счет длительного нажатия на спусковой крючок.
]]

LANGUAGE["Item_Deagle"] = [[Deagle]]
LANGUAGE["Item_Desc_Deagle"] = [[
Desert Eagle .50C.
Легендарный пистолет, который сложно освоить.
]]

LANGUAGE["Item_M1911"] = [[M1911]]
LANGUAGE["Item_Desc_M1911"] = [[
Colt M1911.
Стандартное личное оружие для Вооруженных сил США.
]]

LANGUAGE["Item_FiveSeven"] = [[FiveSeven]]
LANGUAGE["Item_Desc_FiveSeven"] = [[
ES Five-seven.
Бельгийский полуавтоматический пистолет производства FN Herstal.
]]

LANGUAGE["Item_CZ75"] = [[CZ75]]
LANGUAGE["Item_Desc_CZ75"] = [[
CZ 75.
Полуавтоматический пистолет, производство Чехия.
]]

LANGUAGE["Item_M9"] = [[M9]]
LANGUAGE["Item_Desc_M9"] = [[
Beretta M9.
Пистолет, используемый вооруженными силами США.
]]

LANGUAGE["Item_Tec-9"] = [[Tec-9]]
LANGUAGE["Item_Desc_Tec-9"] = [[
Полуавтоматический пистолет шведского производства.
Смертельно опасен в непосредственной близости.
]]

LANGUAGE["Item_TMP"] = [[TMP]]
LANGUAGE["Item_Desc_TMP"] = [[
Steyr TMP.
Отборный огнестрельный пистолет-пулемет калибра 9 × 19 мм Parabellum.
]]

LANGUAGE["Item_Anaconda"] = [[Anaconda]]
LANGUAGE["Item_Desc_Anaconda"] = [[
Colt Anaconda.
Под патрон .44 Magnum.
]]


LANGUAGE["Item_SMG1"] = [[SMG1]]
LANGUAGE["Item_Desc_SMG1"] = [[
Компактное, полностью автоматическое огнестрельное оружие.
Вооружен пусковой установкой M203.
]]

LANGUAGE["Item_Mac10"] = [[Mac10]]
LANGUAGE["Item_Desc_Mac10"] = [[
Military Armament Corporation Model 10.
Обладает высокой скорострельностью,
с плохой точностью разброса и высокой отдачей в качестве компромисса.
]]

LANGUAGE["Item_MP9"] = [[MP9]]
LANGUAGE["Item_Desc_MP9"] = [[
Brügger & Thomet MP9.
Произведено в Швейцарии,
MP9 пользуется популярностью у частных охранных фирм по всему миру.
]]

LANGUAGE["Item_MP5K"] = [[MP5K]]
LANGUAGE["Item_Desc_MP5K"] = [[
Heckler & Koch MP5K.
Более совершенная и мобильная версия MP5.
]]

LANGUAGE["Item_MP5"] = [[MP5]]
LANGUAGE["Item_Desc_MP5"] = [[
Heckler & Koch MP5.
Часто подражают, но никогда не равняются,
MP5, пожалуй, самый универсальный пистолет-пулемет в мире.
]]

LANGUAGE["Item_UMP45"] = [[UMP45]]
LANGUAGE["Item_Desc_UMP45"] = [[
KM UMP45.
Более легкий и дешевый преемник MP5.
]]

LANGUAGE["Item_PP Bizon"] = [[PP Bizon]]
LANGUAGE["Item_Desc_PP Bizon"] = [[
PP-19 Bizon.
Предлагает магазин большой емкости, который быстро перезаряжается.
]]

LANGUAGE["Item_P90"] = [[P90]]
LANGUAGE["Item_Desc_P90"] = [[
ES C90.
Бельгийский буллпап PDW с магазином на 50 патронов.
]]

LANGUAGE["Item_Vector"] = [[Vector]]
LANGUAGE["Item_Desc_Vector"] = [[
KRISS Vector Gen I.
Использует нетрадиционную систему отдачи, что обеспечивает высокую скорость стрельбы.
]]


LANGUAGE["Item_Pump-Action"] = [[Дробовик]]
LANGUAGE["Item_Desc_Pump-Action"] = [[
Стандартный дробовик 12-го калибра.
ПКМ, чтобы сделать 2 выстрела одновременно.
]]

LANGUAGE["Item_Nova"] = [[Nova]]
LANGUAGE["Item_Desc_Nova"] = [[
Benelli Nova.
Итальянское помповое ружье 12-го калибра.
]]

LANGUAGE["Item_M870"] = [[M870]]
LANGUAGE["Item_Desc_M870"] = [[
Ружье Remington 870.
Произведено в США.
]]

LANGUAGE["Item_MAG7"] = [[MAG7]]
LANGUAGE["Item_Desc_MAG7"] = [[
Techno Arms MAG-7.
Стреляет специализированным 60-мм снарядом 12-го калибра.
]]

LANGUAGE["Item_XM1014"] = [[XM1014]]
LANGUAGE["Item_Desc_XM1014"] = [[
Benelli M4 Super 90.
Полностью автоматическое ружье.
]]

LANGUAGE["Item_SPAS-12"] = [[SPAS-12]]
LANGUAGE["Item_Desc_SPAS-12"] = [[
Franchi SPAS-12.
Боевой дробовик производства итальянской оружейной компании Franchi.
]]

LANGUAGE["Item_Striker"] = [[Striker]]
LANGUAGE["Item_Desc_Striker"] = [[
Armsel Striker.
Ружье 12-го калибра с вращающимся цилиндром из ЮАР.
]]

LANGUAGE["Item_AA12"] = [[AA12]]
LANGUAGE["Item_Desc_AA12"] = [[
Штурмовой дробовик Атчисона.
Разрушительная огневая мощь на близком и среднем расстоянии.
]]


LANGUAGE["Item_AR15"] = [[AR15]]
LANGUAGE["Item_Desc_AR15"] = [[
Винтовка AR-15 Style.
Легкая полуавтоматическая винтовка на основе конструкции ArmaLite AR-15.
]]

LANGUAGE["Item_FAMAS"] = [[FAMAS]]
LANGUAGE["Item_Desc_FAMAS"] = [[
Автомат FAMAS буллпап.
Признан высокой скорострельностью.
]]

LANGUAGE["Item_Galil"] = [[Galil]]
LANGUAGE["Item_Desc_Galil"] = [[
Galil ACE 22.
Разработано и изготовлено компанией IMI.
]]

LANGUAGE["Item_AK47"] = [[AK47]]
LANGUAGE["Item_Desc_AK47"] = [[
Автомат Калашникова.
Газовая штурмовая винтовка 7,62 × 39 мм, разработанная в Советском Союзе.
]]

LANGUAGE["Item_M4A1"] = [[M4A1]]
LANGUAGE["Item_Desc_M4A1"] = [[
Colt M4.
Газовый карабин НАТО 5.56 × 45 мм с воздушным охлаждением.
]]

LANGUAGE["Item_SG556"] = [[SG556]]
LANGUAGE["Item_Desc_SG556"] = [[
SIG SG 550.
Штурмовая винтовка производства Swiss Arms AG.
]]

LANGUAGE["Item_AUG"] = [[AUG]]
LANGUAGE["Item_Desc_AUG"] = [[
Steyr AUG.
Австрийская штурмовая винтовка булл-пап.
]]

LANGUAGE["Item_F2000"] = [[F2000]]
LANGUAGE["Item_Desc_F2000"] = [[
FN F2000.
Двусторонняя винтовка булл-пап, разработанная FN.
]]

LANGUAGE["Item_Tavor"] = [[Tavor]]
LANGUAGE["Item_Desc_Tavor"] = [[
IWI Tavor-21.
Разработан для максимальной надежности, долговечности и простоты.
]]


LANGUAGE["Item_ACR"] = [[ACR]]
LANGUAGE["Item_Desc_ACR"] = [[
Адаптивная боевая винтовка Remington.
Модульная полуавтоматическая винтовка.
]]

LANGUAGE["Item_AWP"] = [[AWP]]
LANGUAGE["Item_Desc_AWP"] = [[
Винтовка Magnum Ghost.
Серия снайперских винтовок производства Великобритании.
]]

LANGUAGE["Item_SCAR"] = [[SCAR]]
LANGUAGE["Item_Desc_SCAR"] = [[
FN SCAR.
Штурмовая винтовка, разработанная бельгийским производителем FN Herstal.
]]

LANGUAGE["Item_G3"] = [[G3]]
LANGUAGE["Item_Desc_G3"] = [[
Боевая винтовка G3.
Боевая винтовка НАТО 7,62 × 51 мм с возможностью выбора огня, разработанная H&K.
]]

LANGUAGE["Item_Barret AMR"] = [[Barret AMR]]
LANGUAGE["Item_Desc_Barret AMR"] = [[
Снайперская винтовка калибра .50 калибра.
Наносит огромный баллистический урон.
]]


LANGUAGE["Item_SSG08 Medic SR"] = [[SSG08 Medic SR]]
LANGUAGE["Item_Desc_SSG08 Medic SR"] = [[
Снайперская винтовка медика, стреляющая целебными дротиками.
Наносит урон врагам и лечит игроков.
]]

LANGUAGE["Item_Negev"] = [[Negev]]
LANGUAGE["Item_Desc_Negev"] = [[
IWI Negev.
Ручной пулемет 5,56 × 45 мм НАТО, разработанный IWI.
]]

LANGUAGE["Item_M249"] = [[M249]]
LANGUAGE["Item_Desc_M249"] = [[
Ручной пулемет М249.
Оружие поражения с газовым приводом и воздушным охлаждением.
]]

LANGUAGE["Item_MG4"] = [[MG4]]
LANGUAGE["Item_Desc_MG4"] = [[
Heckler & Koch MG4.
5,56-мм ручной пулемет с ленточным питанием, пришедший на смену MG3.
]]


LANGUAGE["Item_Frag Grenade"] = [[Осколочная граната]]
LANGUAGE["Item_Desc_Frag Grenade"] = [[
Стандартная осколочная граната.
Подходит для сдерживания толпы.
]]

LANGUAGE["Item_DamageResistance RPG"] = [[РПУ]]
LANGUAGE["Item_Desc_DamageResistance RPG"] = [[
Ракетная Пусковая Установка с лазерным наведением.
]]

LANGUAGE["Item_RPG-7"] = [[RPG-7]]
LANGUAGE["Item_Desc_RPG-7"] = [[
Ручной Противотанковый Гранатомет.
Противотанковая ракетная установка разработки Советского Союза.
]]

LANGUAGE["Item_SLAM"] = [[ВЛУБ]]
LANGUAGE["Item_Desc_SLAM"] = [[
Выбираемый Легкий Ударный Боеприпас.
ПКМ для взрыва. Прикрепите к стене в активном лазерном режиме.
]]

LANGUAGE["Item_Incendiary Grenade"] = [[Зажигательная граната]]
LANGUAGE["Item_Desc_Incendiary Grenade"] = [[
Создает лужу огня после некоторой задержки.
Поджигает все в пределах своего эффекта.
]]


LANGUAGE["Item_Heat Crossbow"] = [[Тепловой арбалет]]
LANGUAGE["Item_Desc_Heat Crossbow"] = [[
Самодельное снайперское оружие.
Стрельба опаленной арматурой.
]]

LANGUAGE["Item_Turret"] = [[Турель]]
LANGUAGE["Item_Desc_Turret"] = [[
Наблюдающая турель Альянса.
Используется для охраны узких мест и жизненно важных участков.
]]

LANGUAGE["Item_Medic Grenade"] = [[Лечебная Граната]]
LANGUAGE["Item_Desc_Medic Grenade"] = [[
Граната, которая выпускает непрерывные очереди облаков детоксикации.
Лечит игроков и наносит урон врагам.
]]

LANGUAGE["Item_Throwing Knives"] = [[Метательные ножи]]
LANGUAGE["Item_Desc_Throwing Knives"] = [[
Метательные ножи дальнего боя.
Брошенные лезвия можно извлечь.
]]

LANGUAGE["Item_Watchtower"] = [[Сторожевая башня]]
LANGUAGE["Item_Desc_Watchtower"] = [[
Сторожевая башня, обеспечивающая пополнение запасов.
Создает 1 боеприпас каждые 30 секунд.
(Класс сущности: horde_watchtower)
]]


LANGUAGE["Item_Medkit"] = [[Аптечка]]
LANGUAGE["Item_Desc_Medkit"] = [[
Перезаряжаемый аптечка.
ПКМ, чтобы лечить себя, ЛКМ, чтобы лечить других.
]]

LANGUAGE["Item_Health Vial"] = [[Флакон здоровья]]
LANGUAGE["Item_Desc_Health Vial"] = [[
Капсула наполнена липкой зеленой жидкостью.
Мгновенно лечит при поднятии.
]]

LANGUAGE["Item_Kevlar Armor Battery"] = [[Кевларовая пластина]]
LANGUAGE["Item_Desc_Kevlar Armor Battery"] = [[
Пластина брони.
Каждый дает 15 брони. Только для личного пользования.
]]

LANGUAGE["Item_Full Kevlar Armor"] = [[ Полный комплект кевларовой брони]]
LANGUAGE["Item_Desc_Full Kevlar Armor"] = [[
Полный комплект кевларовой брони.
Заполняет 100% вашей панели брони.
]]

LANGUAGE["Item_Watchtower MKII"] = [[Сторожевая башня - Модель II]]
LANGUAGE["Item_Desc_Watchtower MKII"] = [[
Сторожевая башня обеспечивающая пополнение припасов.
Генерирует 1 мелкую аптечку каждые 30 секунд.
(Entity Class: horde_watchtower_mk2)
]]

LANGUAGE["Item_Watchtower MKIII"] = [[Сторожевая башня - Модель III]]
LANGUAGE["Item_Desc_Watchtower MKIII"] = [[
Башня отпугивающая врагов. Бьёт током каждого противника вблизи каждую секунду.
100 урона током.
(Entity Class: horde_watchtower_mk3)
]]

LANGUAGE["Item_Tau Cannon"] = [[Тау Пушка]]
LANGUAGE["Item_Desc_Tau Cannon"] = [[
Устройство использует электромагнетизм для ионизации частиц.
Зажмите ПКМ для заряда и отпустите для мощного выстрела.
Наносит больше урона при заряде.
Устройство взрывается при избытке заряда.
]]

LANGUAGE["Item_MP7A1 Medic PDW"] = [[MP7A1 PDW Медика]]
LANGUAGE["Item_Desc_MP7A1 Medic PDW"] = [[
Модифицированный для медицинский задач MP7A1.
Зажмите B или ZOOM для стрельбы лечащими дротиками.
Лечащий дротик восстанавливается каждую секунду.
]]

LANGUAGE["Item_Vector Medic PDW"] = [[KRISS Vector PDW Медика]]
LANGUAGE["Item_Desc_Vector Medic PDW"] = [[
KRISS Vector Gen I оснащённый средством запуска лечащих дротиков.
Использует необычную отдачу Vector, обеспечивающую высокую скорость срабатывания.
Зажмите B или ZOOM для стрельбы лечащими дротиками.
Лечащий дротик восстанавливается каждые 1.5 секунд.
]]

LANGUAGE["Item_Chainsaw"] = [[Бензопила]]
LANGUAGE["Item_Desc_Chainsaw"] = [[
Брррррррррррррррррррр
Зажми ПКМ чтобы резать сквозь врагов.
]]

LANGUAGE["Item_Mjollnir"] = [[Мьёльнер]]
LANGUAGE["Item_Desc_Mjollnir"] = [[
Боевой молот заряженный электрической энергией.
Зажмите ПКМ для заряда молота.
Заряженный Мьёльнер создаёт мощный электрический взрыв при ударе.
]]

LANGUAGE["Item_Double Barrel"] = [[Двустволка]]
LANGUAGE["Item_Desc_Double Barrel"] = [[
Двуствольный дробовик
Огромный урон на низком расстоянии.
]]

LANGUAGE["Item_FN FAL"] = [[FN FAL]]
LANGUAGE["Item_Desc_FN FAL"] = [[
FN FAL.
Автоматическая винтовка разработанная в Бельгии и произведённая FN Herstal.
]]

LANGUAGE["Item_AUG HBAR"] = [[AUG HBAR]]
LANGUAGE["Item_Desc_AUG HBAR"] = [[
Steyr AUG HBAR.
Вариант легкого пулемета поддержки штурмовой винтовки AUG.
]]

LANGUAGE["Item_Manhack"] = [[Менхэк]]
LANGUAGE["Item_Desc_Manhack"] = [[
Менхэк регенирирует после смерти.
Менхэк наносит врагам урон своим здоровьем.
Менхэк умирает при ударе.
]]

LANGUAGE["Item_Vortigaunt"] = [[Вортигонт]]
LANGUAGE["Item_Desc_Vortigaunt"] = [[
Зеновские Вортигонты могут вызвать концентрированные взрывы Шоковой энергии.
Энергетические взрывы имеют большую дальность действия и наносят урон по площади.
]]

LANGUAGE["Item_Combat Bot"] = [[Боевой Бот]]
LANGUAGE["Item_Desc_Combat Bot"] = [[
Жизнерадостный гуманоидный робот, предназначенный для прямого столкновения с врагами.
Использует мощные атаки ближнего боя и дальние атаки валунами.
]]

LANGUAGE["Item_Advanced Kevlar Armor"] = [[Продвинутая Кевларовая броня]]
LANGUAGE["Item_Desc_Advanced Kevlar Armor"] = [[
Наилучшая броня Выжившего.
Заполняет 100% вашей полоски брони.
Увеличевает на 5% защиту от Урона.
]]

LANGUAGE["Item_Assault Vest"] = [[Штурмовой жилет]]
LANGUAGE["Item_Desc_Assault Vest"] = [[
Наилучшая броня Штурмовика.
Заполняет 100% вашей полоски брони.
Увеличевает на 8% устойчивость к Баллистическим повреждениям.
]]

LANGUAGE["Item_Bulldozer Suit"] = [[Броня Бульдозер]]
LANGUAGE["Item_Desc_Bulldozer Suit"] = [[
Наилучшая Тяжёлая броня.
Заполняет 125% вашей полоски брони.
]]

LANGUAGE["Item_Hazmat Suit"] = [[Костюм Химзащиты]]
LANGUAGE["Item_Desc_Hazmat Suit"] = [[
Наилучшая броня Медика.
Заполняет 100% вашей полоски брони.
Увеличевает на 8% устойчивость к Ядовитым повреждениям.
]]

LANGUAGE["Item_Bomb Suit"] = [[Костюм Подрывника]]
LANGUAGE["Item_Desc_Bomb Suit"] = [[
Наилучшая Броня для сноса.
Заполняет 100% вашей полоски брони.
Увеличевает на 8% устойчивость к повреждениям от Взрыва.
]]

LANGUAGE["Item_Assassin's Cloak"] = [[Плащ Наёмника]]
LANGUAGE["Item_Desc_Assassin's Cloak"] = [[
Наилучшая броня Призрака.
Заполняет 100% вашей полоски брони.
Увеличевает на 5% увеличенное уклонение.
]]

LANGUAGE["Item_Defense Matrix"] = [[Защитная Матрица]]
LANGUAGE["Item_Desc_Defense Matrix"] = [[
Наилучшая броня Инженера.
Заполняет 100% вашей полоски брони.
Увеличевает на 5% устойчивость к повреждениям.
]]

LANGUAGE["Item_Riot Armor"] = [[Броня Революции]]
LANGUAGE["Item_Desc_Riot Armor"] = [[
Наилучшая броня Надзирателя.
Заполняет 100% вашей полоски брони.
Увеличевает на 8% устойчивость к Шоковым и Звуковым повреждениям.
]]

LANGUAGE["Item_Molten Armor"] = [[Плавящаяся Броня]]
LANGUAGE["Item_Desc_Molten Armor"] = [[
Наилучшая броня Крематор.
Заполняет 100% вашей полоски брони.
Увеличевает на 8% устойчивость к Огневым повреждениям.
]]

LANGUAGE["Item_Battle Vest"] = [[Боевой Желет]]
LANGUAGE["Item_Desc_Battle Vest"] = [[
Наилучшая броня Берсерка.
Заполняет 100% вашей полоски брони.
Увеличевает на 8% устойчивость к повреждениям в Ближнем бою.
]]

-- Gadgets
LANGUAGE["Gadget_gadget_blast_plating"] = [[Покрытие от Взрывов]]
LANGUAGE["Gadget_Desc_gadget_blast_plating"] = [[
На 20% увеличенна устойчивость к повреждениям от взрыва.
]]

LANGUAGE["Gadget_gadget_shock_plating"] = [[Изоляционное покрытие]]
LANGUAGE["Gadget_Desc_gadget_shock_plating"] = [[
На 20% увеличенна устойчивость к молния повреждениям.
]]

LANGUAGE["Gadget_gadget_heat_plating"] = [[Термостойкое покрытие]]
LANGUAGE["Gadget_Desc_gadget_heat_plating"] = [[
На 20% увеличенна устойчивость к Огневым повреждениям.
]]

LANGUAGE["Gadget_gadget_detoxifier"] = [[Детоксикатор]]
LANGUAGE["Gadget_Desc_gadget_detoxifier"] = [[
На 20% увеличенна устойчивость к Ядовитым повреждениям.
]]

LANGUAGE["Gadget_gadget_diamond_plating"] = [[Алмазное покрытие]]
LANGUAGE["Gadget_Desc_gadget_diamond_plating"] = [[
На 15% увеличенна устойчивость к Физическим повреждениям.
]]

LANGUAGE["Gadget_gadget_corporate_mindset"] = [[Корпоративное Мышление]]
LANGUAGE["Gadget_Desc_gadget_corporate_mindset"] = [[
"Установить цели. Имейте десятилетний план. Инвестируй. Просыпайся Пораньше. Образ мышления ген-директора."
Значительно увеличивает шанс выпадения жетонов черепа.
]]

-- Survivor Gadgets

LANGUAGE["Gadget_gadget_vitality_booster"] = [[Бустер к Жизнеспособности]]
LANGUAGE["Gadget_Desc_gadget_vitality_booster"] = [[
+25 к максимуму здоровья.
]]

LANGUAGE["Gadget_gadget_damage_booster"] = [[Бустер Урона]]
LANGUAGE["Gadget_Desc_gadget_damage_booster"] = [[
На 25% увеличин Урон всего.
]]

-- Assault Gadgets
LANGUAGE["Gadget_gadget_iv_injection"] = [[Внутривенная Инъекция]]
LANGUAGE["Gadget_Desc_iv_injection"] = [[
Восстанавливает 25 ед. здоровья.
]]

LANGUAGE["Gadget_gadget_cortex"] = [[Кора головного мозга]]
LANGUAGE["Gadget_Desc_gadget_cortex"] = [[
За каждого врага рядом с вами получите 1 шприц Адреналина.
Элитные враги предоставляют 2 шприца.
]]

LANGUAGE["Gadget_gadget_neuro_amplifier"] = [[Нейроусилитель]]
LANGUAGE["Gadget_Desc_neuro_amplifier"] = [[
Адреналин увеличивает уклонение на 6 %.
]]

LANGUAGE["Gadget_ouroboros"] = [[Уроборос]]
LANGUAGE["Gadget_Desc_ouroboros"] = [[
Помощник по нервной системе Уроборос.
Убирает ограничения тела для повышения боевых возможностей.
Когда у вас более 50 % здоровья, вы теряете 1 здоровье в секунду.
Когда у вас меньше 50 % здоровья, вы получаете 2 здоровья в секунду.
За каждый потеряный 1% здоровья, урон увеличивается на 0.8%.
]]

-- Heavy Gadgets
LANGUAGE["Gadget_gadget_energy_shield"] = [[Энергитический Щит]]
LANGUAGE["Gadget_Desc_energy_shield"] = [[
Временно даёт 25 ед. здоровья.
]]

LANGUAGE["Gadget_gadget_hardening_injection"] = [[Закаливающая Инъекция]]
LANGUAGE["Gadget_Desc_hardening_injection"] = [[
Скорость движения уменьшена на 50%.
На 25% увеличена вся устойчивость к повреждениям.
На 25% повышена устойчивость к Физическому урону.
]]

LANGUAGE["Gadget_exoskeleton"] = [[Экзоскилет]]
LANGUAGE["Gadget_Desc_exoskeleton"] = [[
Использование активной способности активирует короткий буст.
Ты не можешь бежать.
Пассивно увеличевает на 20% устойчивость к всем повреждениям.
]]

LANGUAGE["Gadget_t_virus"] = [[T-Вирус]]
LANGUAGE["Gadget_Desc_t_virus"] = [[
Преобразует вашу броню в здоровье.
Не удается преобразовать больше 250% здоровья.
]]

-- Medic Gadgets
LANGUAGE["Gadget_gadget_life_diffuser"] = [[Диффузор жизни]]
LANGUAGE["Gadget_Desc_gadget_life_diffuser"] = [[
Запускает импульс, который исцеляет близлежащих игроков.
Исцеляет 20 ед. здоровья.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_heal"] = [[Пушка для снарядов (Лечащая)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_heal"] = [[
Стреляет химическим снарядом.
Снаряд наносит 75 повреждений Ядом.
Снаряд лечит 25 ед. здоровья близлежащих игроков.
]]

LANGUAGE["Gadget_healing_beam"] = [[Лечащий Луч]]
LANGUAGE["Gadget_Desc_gadget_healing_beam"] = [[
Соединяет Лечащий Луч между пользователем и целью.
Если цель - враг, забирают здоровье у цели.
Если целью является союзник, восстанавливает здоровье союзника.
]]

-- Ghost Gadgets
LANGUAGE["Gadget_gadget_optical_camouflage"] = [[Оптический Камуфляж]]
LANGUAGE["Gadget_Desc_optical_camouflage"] = [[
Обеспечивает Маскировку на 5 секунд.
На 50% увеличено Уклонение во время Маскировки.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_ballistic"] = [[Пушка для снарядов (Балистическая)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_ballistic"] = [[
Стреляет баллистическим снарядом.
Снаряд наносит 150 баллистических повреждений.
Оглушает врага при попадании.
]]

LANGUAGE["Gadget_death_mark"] = [[Чёрная Метка]]
LANGUAGE["Gadget_Desc_gadget_death_mark"] = [[
Ставит метку на выбранном враге.
Отмеченный враг получает на 15% больше урона.
Отмеченный враг взрывается при смерти, нанося урон, основанный на его здоровье.
Метка длится 10 секунд.
Вы можете отметить только 1 врага одновременно.
]]

LANGUAGE["Gadget_gunslinger"] = [[Ковбой]]
LANGUAGE["Gadget_Desc_gadget_gunslinger"] = [[
На 25% больше урона от Пистолета.
На 25% больше урона от Выстрела в Голову из Пистолета.
]]

-- Demolition Gadgets
LANGUAGE["Gadget_gadget_proximity_defense"] = [[Защита от близости]]
LANGUAGE["Gadget_Desc_proximity_defense"] = [[
Вызывает взрыв, который оглушает ближайших врагов.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_blast"] = [[Пушка для снарядов  (Взрывная)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_blast"] = [[
Стреляет Взрывным Снарядом.
Снаряд наносит 100 ед. урона от взрыва.
Генерирует 3 дополнительных взрыва после небольшой задержки.
]]

LANGUAGE["Gadget_nitrous_propellor"] = [[Азотистый Пропеллер]]
LANGUAGE["Gadget_Desc_gadget_nitrous_propellor"] = [[
Подталкивает вас вперед и вверх с помощью химического взрыва.
]]

LANGUAGE["Gadget_ied"] = [[СВУ]]
LANGUAGE["Gadget_Desc_gadget_ied"] = [[
Бросает на землю Самодельное Взрывное Устройство.
СВУ взрывается, когда враг приближается на расстояние выстрела.
У вас есть 5 зарядов СВУ.
СВУ перезаряжается после детонации.
]]

-- Engineer Gadgets
LANGUAGE["Gadget_displacer"] = [[Вытеснитель]]
LANGUAGE["Gadget_Desc_gadget_displacer"] = [[
Мгновенно перемещает выделенного миньона на вашу сторону.
]]

LANGUAGE["Gadget_gadget_turret_pack"] = [[Комплект Турелей]]
LANGUAGE["Gadget_Desc_gadget_turret_pack"] = [[
Развертывает временную Турель.
У Турели на 50% меньше здоровья.
Турель уничтожается по истечении срока действия.
]]

LANGUAGE["Gadget_gadget_e_parasite"] = [[E-Паразит]]
LANGUAGE["Gadget_Desc_gadget_e_parasite"] = [[
Проецирует капсулу с E-Паразитами, которая заражает врагов при контакте.
E-Паразит считается минионом.
E-Паразит наносит непрерывный урон врагам.
Вы получаете здоровье от урона, нанесенного E-Паразитом.
Враги, убитые будучи заражеными Е-Паразитом, взрываются при смерти.
]]

-- Berserker Gadgets
LANGUAGE["Gadget_gadget_berserk_armor"] = [[Броня Берсерка]]
LANGUAGE["Gadget_Desc_gadget_berserk_armor"] = [[
Урон увеличен на 25%.
На 25% увеличена общая устойчивость к повреждениям.
На 25% увеличена скорость передвижения.
]]

LANGUAGE["Gadget_gadget_flash"] = [[Флеш]]
LANGUAGE["Gadget_Desc_flash"] = [[
Импульс вперед, нанося 100 Рубящего урона всем врагам на пути.
Даёт короткое окно неуязвимости.
]]

LANGUAGE["Gadget_gadget_aerial_guard"] = [[Воздушная защита]]
LANGUAGE["Gadget_Desc_aerial_guard"] = [[
Находясь в воздухе, получаете на 65% меньше физического урона.
]]

LANGUAGE["Gadget_gadget_hemocannon"] = [[Гемоцианин]]
LANGUAGE["Gadget_Desc_hemocannon"] = [[
Стреляет снарядом ценой 10 здоровья.
Снаряд пролетает небольшое расстояние и взрывается.
Взрыв наносит 100 Режущих повреждений.
Имеет максимум 5 зарядов.
Перезаряжается через 5 секунд.
]]

-- Warden Gadgets
LANGUAGE["Gadget_gadget_solar_array"] = [[Solar Array]]
LANGUAGE["Gadget_Desc_gadget_solar_array"] = [[
Drops an armor battery.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_shock"] = [[Пушка для снарядов (Шоковый)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_shock"] = [[
Стреляет магнитным снарядом, который пронзает врагов.
Генерирует ударную волну каждый раз, когда снаряд попадает во врага.
Ударная волна наносит 125 молния урона.
]]

LANGUAGE["Gadget_watchtower_pack"] = [[Комплект Сторожевых башен]]
LANGUAGE["Gadget_Desc_gadget_watchtower_pack"] = [[
Развертывает дополнительную сторожевую башню.
]]

LANGUAGE["Gadget_shock_nova"] = [[Шоковая звезда]]
LANGUAGE["Gadget_Desc_gadget_shock_nova"] = [[
Аура Надзирателя быстро генерирует серию шоковых волн.
Каждая шоковая волна наносит 50 урона молния.
]]

-- Cremator Gadgets
LANGUAGE["Gadget_gadget_butane_can"] = [[Баллон с Бутаном]]
LANGUAGE["Gadget_Desc_gadget_butane_can"] = [[
Роняет Баллон с Бутаном, который взрывается при физическом воздействии.
Взрыв наносит 375 урона Огнём.
За один раз можно кинуть только 1 Баллон.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_fire"] = [[Пушка для снарядов  (Огненный)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_fire"] = [[
Стреляет Горящим снарядом.
Воспламеняет всех врагов, попавших в зону взрыва.
Наносит 20 урона Огнём.
]]

LANGUAGE["Gadget_barbeque"] = [[Барбекю]]
LANGUAGE["Gadget_Desc_gadget_barbeque"] = [[
Воспламененные враги, убитые вами, сбрасывают съедобные конечности.
Каждая конечность восстанавливает 5 единиц здоровья.
]]
