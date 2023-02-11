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
LANGUAGE["Game_Spectate"] = "Наблюдение"
LANGUAGE["Game_Players_Ready"] = "Готовые игроки"
LANGUAGE["Game_Next_Wave_Starts_In"] = "Следующая волна начнется через %d"
LANGUAGE["Game_Difficulty_NORMAL"] = "НОРМАЛЬНО"
LANGUAGE["Game_Difficulty_HARD"] = "СЛОЖНО"
LANGUAGE["Game_Difficulty_REALISM"] = "РЕАЛИЗМ"
LANGUAGE["Game_Difficulty_NIGHTMARE"] = "КОШМАР"
LANGUAGE["Game_Difficulty_APOCALYPSE"] = "АПОКАЛИПСИС"
LANGUAGE["Game_Enemies"] = "Враги"
LANGUAGE["Game_HintBottomReady"] = "F2 - Инфо/Конфиг, F3 - Магазин/Умение, F4 - Готов"
LANGUAGE["Game_HintBottom"] = "F2 - Инфо/Конфиг, F3 - Магазин/Умение, V - Выкинуть $"
LANGUAGE["Game_Result_VICTORY"] = "ПОБЕДА"
LANGUAGE["Game_Result_DEFEAT"] = "ПОРАЖЕНИЕ"
LANGUAGE["Game_Result_Change Map"] = "Смена карты"
LANGUAGE["Game_Wave"] = "Волна"
LANGUAGE["Game_Wave_Has_Started"] = "Волна %d началась"
LANGUAGE["Game_Wave_Completed"] = "Волна пройдена"
LANGUAGE["Game_Remaining_Time"] = "Времени осталось"
LANGUAGE["Game_Vote_Map"] = "Голосование карты"
LANGUAGE["Game_Game_Summary"] = "Итог игры"
LANGUAGE["Game_Most_Damage_Dealt"] = "Наибольшее нанесение урона"
LANGUAGE["Game_Damage"] = "Урона"
LANGUAGE["Game_Most_Damage_Taken"] = "Наибольшее получение урона"
LANGUAGE["Game_Damage_Taken"] = "Получено урона"
LANGUAGE["Game_Most_Kills"] = "Наибольшее кол-во убийств"
LANGUAGE["Game_Kills"] = "Убийства"
LANGUAGE["Game_Elite_Killer"] = "Убийца элитных"
LANGUAGE["Game_Elite_Kills"] = "Убийств элитных"
LANGUAGE["Game_SharpShooter"] = "Меткий стрелок"
LANGUAGE["Game_Headshots"] = "Выстрелов в голову"
LANGUAGE["Game_Most_Heal"] = "Командный целитель"
LANGUAGE["Game_Healed"] = "Вылечил"
LANGUAGE["Game_Healed_You"] = "Вылечил вас"
LANGUAGE["Game_Preparing..."] = "Подготовка..."
LANGUAGE["Game_WAVE "] = "ВОЛНА "
LANGUAGE["Class_Change_Subclass"] = "Сменить подкласс"
LANGUAGE["Class_Change_Warning"] = "Смена класса уберёт все ваши вещи!"
LANGUAGE["Class_Change_Headline"] = "Смена класса"
LANGUAGE["Class_Change_Yes"] = "Да"
LANGUAGE["Class_Change_No"] = "Нет"
LANGUAGE["Sell_Warning"] = "Продать предмет?!"
LANGUAGE["Sell_Headline"] = "Продажа"
LANGUAGE["Subclass_Unlock_Warning"] = "Разблокировать?"
LANGUAGE["Subclass_Unlock_Headline"] = "Открытие подкласса"
LANGUAGE["Subclass_Change_Warning"] = "Сменить подкласс?"
LANGUAGE["Subclass_Change_Headline"] = "Смена подкласса"
LANGUAGE["Button_Yes"] = "Да"
LANGUAGE["Button_No"] = "Нет"

-- Subclass Buttons
LANGUAGE["Subclass_Title_Survivor"] = "Выживший"
LANGUAGE["Subclass_Title_Assault"] = "Штурмовик"
LANGUAGE["Subclass_Title_Heavy"] = "Тяжеловес"
LANGUAGE["Subclass_Title_Medic"] = "Медик"
LANGUAGE["Subclass_Title_Demolition"] = "Подрывник"
LANGUAGE["Subclass_Title_Ghost"] = "Призрак"
LANGUAGE["Subclass_Title_Engineer"] = "Инженер"
LANGUAGE["Subclass_Title_Berserker"] = "Берсеркер"
LANGUAGE["Subclass_Title_Warden"] = "Надзиратель"
LANGUAGE["Subclass_Title_Cremator"] = "Крематор"
LANGUAGE["Subclass_Title_Samurai"] = "Самурай"
LANGUAGE["Subclass_Title_SpecOps"] = "Спецназ"
LANGUAGE["Subclass_Title_Gunslinger"] = "Стрелок"
LANGUAGE["Subclass_Title_Artificer"] = "Артифайсер"
LANGUAGE["Subclass_Title_Necromancer"] = "Некромант"
LANGUAGE["Subclass_Title_Psycho"] = "Псих"
LANGUAGE["Subclass_Title_Warlock"] = "Чародей"
LANGUAGE["Subclass_Title_Carcass"] = "Туша"
LANGUAGE["Subclass_Title_Hatcher"] = "Инкубатор"

-- Infusion
LANGUAGE["Game_Infusion"] = "Инфузия"
LANGUAGE["No infusion selected."] = "Не выбрана инфузия."
LANGUAGE["Infusion_None"] = "Нету"
LANGUAGE["Infusion_Hemo"] = "Гемо"
LANGUAGE["Infusion_Quality"] = "Качественная"
LANGUAGE["Infusion_Rejuvenating"] = "Омолаживающая"
LANGUAGE["Infusion_Quicksilver"] = "Ртутная"
LANGUAGE["Infusion_Chrono"] = "Хроно"
LANGUAGE["Infusion_Impaling"] = "Пронзающая"
LANGUAGE["Infusion_Septic"] = "Септическая"
LANGUAGE["Infusion_Flaming"] = "Пылающая"
LANGUAGE["Infusion_Arctic"] = "Арктическая"
LANGUAGE["Infusion_Galvanizing"] = "Гальванизированная"
LANGUAGE["Infusion_Siphoning"] = "Перекачивающая"
LANGUAGE["Infusion_Titanium"] = "Титановая"
LANGUAGE["Infusion_Concussive"] = "Сотрясающая"
LANGUAGE["Infusion_Ruination"] = "Разрушительная"
LANGUAGE["Game_No_Infusion_Selected"] = "Инфузия не выбрана."
LANGUAGE["Infusion_Not_Enough_Money"] = "Не достаточно денег (Требуется "
LANGUAGE["Shop_Infused"] = "ИНФУЗ-НО"
LANGUAGE["Game_Infused"] = "Инфузированно"
LANGUAGE["Infusion_Remove"] = "Убрать инфузию"

LANGUAGE["Infusion_Description_None"] = [[
Нет эффекта.
]]

LANGUAGE["Infusion_Description_Hemo"] = [[
Преобразует 75% урона от оружия в рубящий урон.

Оружие наносит только рубящий урон.

Урон от оружия увеличивает накопление кровотечения.
]]

LANGUAGE["Infusion_Description_Concussive"] = [[
Преобразует 75% урона от оружия в тупой урон.

Оружие наносит только тупой урон.

Урон от оружия увеличивает накопление оглушения.
]]

LANGUAGE["Infusion_Description_Septic"] = [[
Преобразует 75% урона от оружия в урон от яда.

Оружие наносит только ядовитый урон.

Урон от оружия увеличивает накопление разрыва.
]]

LANGUAGE["Infusion_Description_Flaming"] = [[
Преобразует 75% урона от оружия в урон от огня.

Оружие наносит только огненный урон.

Оружие воспламеняет врагов при попадании.
]]

LANGUAGE["Infusion_Description_Arctic"] = [[
Преобразует 75% урона от оружия в урон от холода.

Оружие наносит только холодный урон.

Урон от оружия увеличивает накопление обморожения.
]]

LANGUAGE["Infusion_Description_Galvanizing"] = [[
Преобразует 75% урона от оружия в урон от молнии.

Оружие наносит только электрический урон.

Урон от оружия увеличивает накопление шока.
]]

LANGUAGE["Infusion_Description_Quality"] = [[
Урон от оружия увеличен на 20%.

На урон от оружия не влияют перки или гаджеты.
(То есть ваши перки становятся бесполезными для этого оружия.)
]]

LANGUAGE["Infusion_Description_Impaling"] = [[
Урон от выстрела в голову увеличен на 25%.

На 25% меньше урона от оружия, не нанесенного выстрелом в голову.
]]

LANGUAGE["Infusion_Description_Rejuvenating"] = [[
Усиливает исцеление оружия/высасывание здоровья на 25%.

На 25% меньше урона от оружия.
]]

LANGUAGE["Infusion_Description_Quicksilver"] = [[
Увеличивает/уменьшает урон от оружия в зависимости от доступного веса игрока.

<= 15% веса -> увеличение урона на 30%
<= 30% веса -> увеличение урона на 25% 
<= 40% веса -> увеличение урона на 15% 
>40% веса -> 25% уменьшения урона
]]

LANGUAGE["Infusion_Description_Titanium"] = [[
Уменьшает наносимый игроку урон в зависимости от веса оружия.

На 1% уменьшен наносимый урон за каждый 1 вес оружия.

На 25% меньше урона от оружия.
]]

LANGUAGE["Infusion_Description_Siphoning"] = [[ 
+1 здоровья, когда вы убиваете врага.

На 25% меньше урона от оружия.
]]

LANGUAGE["Infusion_Description_Chrono"] = [[
Чем дольше оружие находится в руках пользователя, тем Увеличивает урон от оружия тем дольше, чем дольше оружие находится в руках пользователя.

Увеличение урона на 6% за волну, удерживаемую пользователем.

Увеличены капы на 50%.

Урон от оружия уменьшен на 20%.
]]

LANGUAGE["Infusion_Description_Ruination"] = [[
Увеличивается урон от оружия в зависимости от вашего текущего накопления некроза.
Увеличение урона на 5% за 10 накоплений некроза, до 25%.

Увеличивается количество некроза на 10 единиц в секунду, удерживая это оружие.
]]

-- Ranks
LANGUAGE["Rank_Novice"] = "Новичок"
LANGUAGE["Rank_Amateur"] = "Любитель"
LANGUAGE["Rank_Skilled"] = "Опытный"
LANGUAGE["Rank_Professional"] = "Профессионал"
LANGUAGE["Rank_Expert"] = "Эксперт"
LANGUAGE["Rank_Champion"] = "Чемпион"
LANGUAGE["Rank_Master"] = "Мастер"
LANGUAGE["Rank_Not_Met"] = "Требование(-я) к рангу не выполнены"

-- Scoreboard
LANGUAGE["Scoreboard_Name"] = "Имя"
LANGUAGE["Scoreboard_Class"] = "Класс"
LANGUAGE["Scoreboard_Perks"] = "Перки"
LANGUAGE["Scoreboard_Gadget"] = "Гаджет"
LANGUAGE["Scoreboard_Money"] = "Деньги"
--LANGUAGE["Scoreboard_Kill"] = "Убийства"
--LANGUAGE["Scoreboard_Death"] = "Смерти"
--LANGUAGE["Scoreboard_Ping"] = "Пинг"

-- Shop
LANGUAGE["Shop_Not_Enough_Money_Or_Carrying_Capacity"] = "Недостаточно денег или грузоподъемности!"
LANGUAGE["Shop_You_Are_Dead"] = "Вы мертвы."

-- Categories
LANGUAGE["Shop_Class"] = "Класс"
LANGUAGE["Shop_Cash"] = "Деньги"
LANGUAGE["Shop_Weight"] = "Масса"
LANGUAGE["Shop_Melee"] = "Ближний бой"
LANGUAGE["Shop_Pistol"] = "Пистолеты"
LANGUAGE["Shop_Shotgun"] = "Дробовики"
LANGUAGE["Shop_SMG"] = "ПП"
LANGUAGE["Shop_Rifle"] = "Винтовки"
LANGUAGE["Shop_MG"] = "Пулемёты"
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
LANGUAGE["Shop_Class/Perks"] = "Классы/Умения"
LANGUAGE["Shop_Select_Class"] = "Выбрать класс (Ваши вещи будут выброшены)"
LANGUAGE["Shop_Show_Perks"] = "Показать умения класса"
LANGUAGE["Shop_Hide_Perks"] = "Скрыть умения класса"
LANGUAGE["Shop_Unlocks_After_Wave"] = "Разблокируется после %d волны"
LANGUAGE["Shop_Buy_Ammo_Clip"] = "Купить обоиму"
LANGUAGE["Shop_Sell_For"] = "Продать за"
LANGUAGE["Shop_Sell_All_For"] = "Продать все за"
LANGUAGE["Shop_Buy_Item"] = "Купить"
LANGUAGE["Shop_OWNED"] = "КУПЛЕНО"
LANGUAGE["Item_Owned"] = "Куплено"
LANGUAGE["Shop_Upgrade"] = "Повысить до +"
LANGUAGE["Shop_Damage_Type"] = "Тип урона: "
LANGUAGE["Shop_Buy_Secondary_Ammo"] = "Купить вторичный боеприпас"
LANGUAGE["Shop_Primary_Ammo"] = "Основные боеприпасы"
LANGUAGE["Shop_Secondary_Ammo"] = "Вторичные боеприпасы"


-- Classes
LANGUAGE["Class_Survivor"] = "Выживший"
LANGUAGE["Class_Assault"] = "Штурмовик"
LANGUAGE["Class_Heavy"] = "Тяжеловес"
LANGUAGE["Class_Medic"] = "Медик"
LANGUAGE["Class_Demolition"] = "Подрывник"
LANGUAGE["Class_Ghost"] = "Призрак"
LANGUAGE["Class_Engineer"] = "Инженер"
LANGUAGE["Class_Berserker"] = "Берсеркер"
LANGUAGE["Class_Warden"] = "Надзиратель"
LANGUAGE["Class_Cremator"] = "Крематор"
LANGUAGE["Class_Samurai"] = "Самурай"
LANGUAGE["Class_SpecOps"] = "Спецназ"
LANGUAGE["Class_Gunslinger"] = "Стрелок"
LANGUAGE["Class_Artificer"] = "Артифайсер"
LANGUAGE["Class_Necromancer"] = "Некромант"
LANGUAGE["Class_Psycho"] = "Псих"
LANGUAGE["Class_Warlock"] = "Чародей"
LANGUAGE["Class_Carcass"] = "Туша"
LANGUAGE["Class_Hatcher"] = "Инкубатор"


-- Gadgets
LANGUAGE["Gadget_Activation"] = "Нажмите T чтобы активировать"
LANGUAGE["Gadget_Cooldown"] = "Перезарядка"
LANGUAGE["Gadget_Duration"] = "Длительность"
LANGUAGE["Gadget_Owned_Warning"] = "Только 1 гаджет может быть КУПЛЕН"
LANGUAGE["Gadget_Seconds"] = "секунд(-ы)"
LANGUAGE["Gadget_Consumed"] = "Этот гаджет ПОГЛАЩАЕТСЯ после активации."

-- Default Class Extra Descriptions
LANGUAGE["Class_Description_Survivor"] = [[
Имеет доступ ко всему вооружению, кроме эксклюзивного и специального оружия.
Ограниченный доступ к обвесам.]]

LANGUAGE["Class_Description_Assault"] = [[
Имеет полный доступ к автоматическим винтовкам.]]

LANGUAGE["Class_Description_Heavy"] = [[
Имеет полный доступ к тяжелому вооружению.]]

LANGUAGE["Class_Description_Medic"] = [[
Имеет доступ к лёгкому вооружению и медицинскими инструментами.]]

LANGUAGE["Class_Description_Demolition"] = [[
Имеет полный доступ к взрывчатке.]]

LANGUAGE["Class_Description_Ghost"] = [[
Имеет доступ к снайперским винтовкам и некоторому лёгкому вооружению.
Имеет доступ к глушителям и снайперским прицелам.]]

LANGUAGE["Class_Description_Engineer"] = [[
Имеет доступ к специальному вооружению и снаряжению.]]

LANGUAGE["Class_Description_Berserker"] = [[
Имеет доступ только к ближнему бою.]]

LANGUAGE["Class_Description_Warden"] = [[
Имеет полный доступ к дробовикам и сторожевым вышкам (horde_watchtower).]]

LANGUAGE["Class_Description_Cremator"] = [[
Имеет полный доступ к поджигающему вооружению.]]

LANGUAGE["Class_Description_Samurai"] = [[
Имеет доступ только к ближнему бою.]]

LANGUAGE["Class_Description_SpecOps"] = [[
Имеет полный доступ к автоматическим винтовкам.]]

LANGUAGE["Class_Description_Gunslinger"] = [[
Имеет доступ к снайперским винтовкам и выбранным лёгким оружиям.

Имеет доступ к глушителям и снайперским прицелам.]]

LANGUAGE["Class_Description_Artificer"] = [[
Имеет полный доступ к поджигающему вооружению.]]

LANGUAGE["Class_Description_Necromancer"] = [[
Имеет доступ к специальному вооружению и снаряжению.]]

LANGUAGE["Class_Description_Warlock"] = [[
Имеет полный доступ к взрывному оружию.]]

LANGUAGE["Class_Description_Psycho"] = [[
Ограниченный доступ к обвесам.]]

LANGUAGE["Class_Description_Carcass"] = [[
Имеет полный доступ к пулемётам и тяжелому вооружению.]]

LANGUAGE["Class_Description_Hatcher"] = [[
Имеет доступ к большинству лёгкому вооружению и медицинским инструментам.]]


-- Default Base Perks
LANGUAGE["Perk_survivor_base"] = [[
Класс "Выживший" может быть включен в любой класс, чтобы занять недостающие роли для команды.
Cложность: ЛЁГКАЯ

Бонусов нету.]]

LANGUAGE["Perk_assault_base"] = [[
Класс "Штурмовик" - это универсальный боец, обладающий высокой мобильностью и ориентированный на выброс адреналина.
Cложность: ЛЁГКАЯ

На {1} увеличена скорость передвижения. ({2} за каждый уровень, до {3}).

Вы получаете адреналин, когда убиваете врага.
Адреналин увеличивает урон и скорость на {4}.]]

LANGUAGE["Perk_heavy_base"] = [[
Класс "Тяжеловес" это класс танка, обеспечивающий сильную огневую мощь подавления.
Cложность: ЛЁГКАЯ

Регенерирует {1} брони за секунду.
Регенерирует до {2} брони. ({3} + {4} за каждый уровень, до {5})]]

LANGUAGE["Perk_medic_base"] = [[
Класс "Медик" - это класс долговременной поддержки, который фокусируется на исцелении и усилении товарищей по команде.
Cложность: СРЕДНЯЯ

Усиливает исцеление на {1}. ({2} за каждый уровень, до {3}).

Восстанавливает {4} здоровья за секунду.]]

LANGUAGE["Perk_demolition_base"] = [[
Класс "Подрывник" - это класс контроля толпы, который также может наносить высокий урон по одной цели.
Cложность: СРЕДНЯЯ

На {1} повышена устойчивость ко взрыву. ({2} + {3} за каждый уровень, до {4}).

Создается {5} осколочная граната каждые {6} секунд, если у вас её нету.]]

LANGUAGE["Perk_ghost_base"] = [[
Класс "Призрак" сосредоточен на уничтожение боссов используя Камуфляж.
Cложность: ВЫСОКАЯ

На {1} больше урона в голову. ({2} за каждый уровень, до {3}).

Присядьте, чтобы активировать Камуфляж, предоставляющий {4} уклонения.
Атака или бег СНИМАЮТ Камуфляж.]]

LANGUAGE["Perk_engineer_base"] = [[
Класс "Инженер" - это класс, сосредоточенный на миньонов, который наносит урон с помощью миньонов.
Cложность: СРЕДНЯЯ

На {1} увеличен урон от миньонов. ({2} за каждый уровень, до {3}).

У турелей имеется {4} базового здоровья и наносят {5} базового урона.]]

LANGUAGE["Perk_berserker_base"] = [[
Класс "Берсеркер" - это класс, сосредоточенный на ближний бой, за которого можно играть и нападая, и обороняясь.
Cложность: ВЫСОКАЯ

На {1} увеличен урон от рубящих и тупых ударов. ({2} за каждый уровень, до {3}).
На {4} увеличена устойчивость к любому урону. ({5} за каждый уровень, до {6}).

Воздушное парирование: Прыгните, чтобы уменьшить физический урон на {7}.]]

LANGUAGE["Perk_warden_base"] = [[
"Надзиратель" - это класс поддержки, который использует эффекты и структуры ауры для усиления товарищей по команде.
Cложность: СРЕДНЯЯ

На {1} увеличен радиус Ауры Надзирателя. ({2} за каждый уровень, до {3}).

Игроки рядом с вами получают влияние от Ауры Надзирателя.
Аура Надзирателя блокирует {4} урона.]]

LANGUAGE["Perk_cremator_base"] = [[
Класс "Крематор" строит своё нападение и защиту за счёт огненного урона.
Cложность: ЛЁГКАЯ

На {1} увеличена устойчивость к огненному урону. ({2} + {3} за каждый уровень, до {4}).
У атак имеется {5} шанс поджечь врагов.

Базовая продолжительность горения составляет {6} и наносит урон всё время в зависимости от попадания.
Урон огнём имеет {7} шанс поджога.]]

LANGUAGE["Perk_samurai_base"] = [[
СЛОЖНОСТЬ: ВЫСОКАЯ

Наносит нарастающее кровотечение на {1} от базового урона в ближнем бою. ({2} + {3} за каждый уровень, до {4}).
На {5} увеличена устойчивость к любому урону. ({6} за каждый уровень, до {7}).

SHIFT+E чтобы активировать рывок.
Вы мчитесь в направлении движения.
На 100% увеличено уклонение при рывке.
]]

LANGUAGE["Perk_specops_base"] = [[
Класс "Спецназ" фокусируется на эффектах своего уникального тактического режима.
СЛОЖНОСТЬ: СРЕДНЯЯ

Нажмите на F, чтобы войти в тактический режим, заменяющий ваш фонарь.
У вас имеется ночное видение в тактическом режиме.
Вы не можете бегать в тактическом режиме.
На 50% понижена скорость передвижения в тактическом режиме.

На {1} увеличена скорость передвижения в тактическом режиме. ({2} за каждый уровень, до {3})
На {1} увеличен урон при подании в голову в тактическом режиме. ({2} за каждый уровень, до {3})]]

--[[LANGUAGE["Perk_gunslinger_base"] = [[
На {1} увеличен урон от пистолета. ({2} за каждый уровень, до {3}).

Нажмите SHIFT+E чтобы нанести метку охотника на врага.
Метка охотника длится в течение 5 секунд.
Вы можете нанести 1 метку охотника за раз.
Враги, убитые под меткой охотника, имеют {4} шанс сбросить дополнительные деньги.

Ваши пистолеты могут быть прокачаны для увеличения урона.
Имеет доступ ко всем пистолетам.

Имеет доступ к снайперской винтовке и избранным лёгким оружиям.]]--

LANGUAGE["Perk_artificer_base"] = [[
СЛОЖНОСТЬ: СРЕДНЯЯ

Наносит нарастающий шок на {1} от базового урона от молнии. ({2} за каждый уровень, до {3}).
На {1} увеличен урон от огня и молний. ({2} за каждый уровень, до {3}).

Вооружен солнечной печатью. Можно улучшить в магазине.
ЛКМ: Солнечный шар (5/10/20 энергии)
Выпускает снаряд, который наносит урон от огня.
УДЕРЖИВАЙТЕ ЛКМ для получения различных эффектов.

ПКМ: Солнечная буря (5/10/20 энергии)
Выпускает мощный молниеносный удар по цели.
УДЕРЖИВАЙТЕ ПКМ для получения различных эффектов.]]

LANGUAGE["Perk_necromancer_base"] = [[
СЛОЖНОСТЬ: СРЕДНЯЯ

Наносит нарастающее обморожение на {1} от базового урона от холода. ({2} + {3} за каждый уровень, до {4}).
На {5} увеличена устойчивость к урону от холода. ({6} за каждый уровень, до {7}).

Вооружен Проектором Пустоты. Можно улучшить в магазине.
Улучшение Проектора Пустоты увеличивает его урон.

ЛКМ: Копье Пустоты (5/10/20 энергии)
Выпускает снаряд, который наносит урон от холода и наносит нарастающее обморожение.
УДЕРЖИВАЙТЕ ЛКМ для получения различных эффектов.

ПКМ: Призыв Призрака (40 энергии)
Призывает Призрака-миньона.
Призрак-миньон наносит физический урон и наносит нарастающее обморожение.
УДЕРЖИВАЙТЕ ПКМ, чтобы призвать Призраков на свою сторону.]]


LANGUAGE["Perk_psycho_base"] = [[
{1} шанс нанести критическое попадание. ({2} + {3} за каждый уровень, до {4}).
Вы наносите на 50% больше урона при критическом попадании.

Нажмите F чтобы войти в режим безумия, заменяющий ваш фонарь.
Вы теряете 1 здоровье каждые 0.2 секунды в режиме безумия, до 1.
На {6} увеличен шанс критического удара в режиме безумия.
На {7} увеличено восстановление здоровья в режиме безумия.
Имеет доступ ко всему оружию, кроме эксклюзивного и специального оружия.]]

LANGUAGE["Perk_warlock_base"] = [[
СЛОЖНОСТЬ: ВЫСОКАЯ

На {1} увеличена максимальная энергия. ({2} за каждый уровень, до {3}).

Вооружен Астральной реликвией. Можно улучшить в магазине.
ЛКМ: Астральный Пульсар (10 энергии)
Освобождает самонаводящийся объект, который прикрепляется к врагам и наносит физический урон со временем.
У вас может быть не более 2 активных Астральных Пульсаров.
УДЕРЖИВАЙТЕ ЛКМ чтобы взорвать все активные Астральные Пульсары.

ПКМ: Астральный Остаток (5 энергии)
Устанавливаются энергетические тела, которые взрываются, когда враги находятся поблизости, нанося физический урон.
У вас может быть не более 5 активных Астральных Остатков.
УДЕРЖИВАЙТЕ ПКМ чтобы зарядить и обновить продолжительность всех активных Астральных Остатков.]]

LANGUAGE["Perk_carcass_base"] = [[
Класс "Туша" использует свое высокое здоровье и регенерацию для различных эффектов.
СЛОЖНОСТЬ: ВЫСОКАЯ

На {1} увеличено максимальное здоровье. ({2} за каждый уровень, до {3}).

{4} шанс получить Гипертрофию когда вы ударяете врага ({5} шанс при попадании в голову).
100% шанс получить Гипертрофию когда вас ударили.
Гипертрофия понижает полученный физический урон на {6}.
Гипертрофия предоставляет 2% регенерации здоровья в секунду.

Вооружен Биосистемой Туши.
Нельзя использовать никакое другое оружие, кроме аптечек, потому что вы рукожоп.
ЛКМ: Удар
Удерживайте для мощного удара, который нанесёт повышенный урон по области.]]

LANGUAGE["Perk_hatcher_base"] = [[
Класс "Инкубатор" использует муравьиных львов, чтобы обеспечить уникальную поддержку для команды.
СЛОЖНОСТЬ: ВЫСОКАЯ

На {1} увеличена скорость эволюции муравьиных львов. ({2} за каждый уровень, до {3}).
На {1} увеличен урон от яда. ({2} за каждый уровень, до {3}).

Вооружен Фероподом. Можно улучшить в магазине.
Улучшение Феропода увеличивает базовое здоровье и урон муравьиного льва.

ЛКМ: Бросить капсулу
Кидает Феропод в цель, заставляя муравьиных львов совершать дальние атаки по цели.
Капсулы также исцеляют муравьиных львав на 5% здоровья.

ПКМ: Призыв муравьиного льва (40 энергии)
Призывает муравьиного льва, который следует за тобой повсюду. Исцеляйте муравьиного льва чтобы ускорить эволюцию.
ЗАДЕРЖИТЕ ПКМ, чтобы заставить муравьиных львов переместиться в ваше местоположение.
Муравьиные львы получают новые эффекты в каждой стадии:
- Стадия I:
     - Импульс жука: Каждые 5 секунд, создает импульс, который исцеляет игроков вблизи на 5% здоровья.
- Стадия II:
     - Увеличено здоровье и урон.
	 - Увеличен радиус ароматического импульса и понижена перезарядка импульса жука.
	 - На 50% увеличено сопротивление к урону от яда.
- Стадия III:
     - Увеличено здоровье, урон и скорость атаки.
	 - Увеличен радиус ароматического импульса и понижена перезарядка импульса жука.
	 - Иммунитет к урону от яда и разрыва.
]]

-- Default Perks: Survivor
LANGUAGE["Perk_Title_Survivor_Tier_1"] = [[Выживание]]
LANGUAGE["Perk_Title_Survivor_Tier_2"] = [[Импровизация]]
LANGUAGE["Perk_Title_Survivor_Tier_3"] = [[Защита]]
LANGUAGE["Perk_Title_Survivor_Tier_4"] = [[Вдохновенное обучение]]

-- Default Perks: Assault
LANGUAGE["Perk_Title_Assault_Tier_1"] = [[Маневренность]]
LANGUAGE["Perk_Title_assault_ambush"] = [[Засада]]
LANGUAGE["Perk_assault_ambush"] = [[
На {1} увеличен урон в голову.]]

LANGUAGE["Perk_Title_assault_charge"] = [[Заряд]]
LANGUAGE["Perk_assault_charge"] = [[
Добавляет {1} максимальный стак адреналина.
(Каждый стак адреналина увеличивает урон и скорость на {2}.)]]

LANGUAGE["Perk_Title_Assault_Tier_2"] = [[Адаптивность]]
LANGUAGE["Perk_Title_assault_drain"] = [[Потребление]]
LANGUAGE["Perk_assault_drain"] = [[
На {1} увеличен урон в голову при полном запасе здоровья.
Восстанавливает {2} здоровья за каждого противника, которого вы убили.]]

LANGUAGE["Perk_Title_assault_overclock"] = [[Разгон]]
LANGUAGE["Perk_assault_overclock"] = [[
Добавляет {1} максимальных стака адреналина.]]

LANGUAGE["Perk_Title_Assault_Tier_3"] = [[Агрессия]]

LANGUAGE["Perk_Title_assault_cardiac_resonance"] = [[Сердечный резонанс]]
LANGUAGE["Perk_assault_cardiac_resonance"] = [[
Каждый раз когда вы убиваете противника противника,
Игроки поблизости так же получают {1} адреналин, до {2}.
Добавляет {3} максимальный стак адреналина.]]

LANGUAGE["Perk_Title_assault_cardiac_overload"] = [[Перегрузка сердца]]
LANGUAGE["Perk_assault_cardiac_overload"] = [[
Длительность адреналина увеличена на {1}.
Добавляет {2} максимальный стак адреналина.]]

LANGUAGE["Perk_Title_Assault_Tier_4"] = [[Кондиционирование]]
LANGUAGE["Perk_Title_assault_heightened_reflex"] = [[Повышенный Рефлекс]]
LANGUAGE["Perk_assault_heightened_reflex"] = [[
На {1} увеличен урон в голову.
На {2} увеличена устойчивость к любому урону при максимальном адреналине.]]

LANGUAGE["Perk_Title_assault_merciless_assault"] = [[Беспощадное нападение]]
LANGUAGE["Perk_assault_merciless_assault"] = [[
{1} шанс к добавлению 1 стака адреналина при выстреле в голову.
Добавляет {2} максимальных стака адреналина.]]

-- Default Perks: Heavy
LANGUAGE["Perk_Title_Heavy_Tier_1"] = [[Подавление]]
LANGUAGE["Perk_Title_heavy_sticky_compound"] = [[Липкий состав]]
LANGUAGE["Perk_heavy_sticky_compound"] = [[
Враги, которых вы поражаете баллистическим уроном, получают скованность.
Скованные враги наносят на {1} меньше физического урона.]]

LANGUAGE["Perk_Title_heavy_crude_casing"] = [[Сырая оболочка]]
LANGUAGE["Perk_heavy_crude_casing"] = [[
Враги, в которых вы попадаете Баллистическим уроном, ослабляются.
Ослабленные враги получают на {1} больше урона.]]

LANGUAGE["Perk_Title_Heavy_Tier_2"] = [[Резервирование]]
LANGUAGE["Perk_Title_heavy_repair_catalyst"] = [[Восстановительный катализатор]]
LANGUAGE["Perk_heavy_repair_catalyst"] = [[
Добавляет {1} к максимальной регенерации брони.]]

LANGUAGE["Perk_Title_heavy_floating_carrier"] = [[Плавучий перевозчик]]
LANGUAGE["Perk_heavy_floating_carrier"] = [[
Добавляет +5 к максимальному весу.]]

LANGUAGE["Perk_Title_Heavy_Tier_3"] = [[Броневая защита]]
LANGUAGE["Perk_Title_heavy_liquid_armor"] = [[Жидкая броня]]
LANGUAGE["Perk_heavy_liquid_armor"] = [[
Пока у вас есть хотя-бы {1} брони:
  На {2} меньше полученного физического урона.]]

LANGUAGE["Perk_Title_heavy_reactive_armor"] = [[Реактивная броня]]
LANGUAGE["Perk_heavy_reactive_armor"] = [[
Пока у вас есть хотя-бы {1} брони:
  Иммунитет к урону от огня и взрыва.]]

LANGUAGE["Perk_Title_Heavy_Tier_4"] = [[Технологии]]
LANGUAGE["Perk_Title_heavy_nanomachine"] = [[Наномашины]]
LANGUAGE["Perk_heavy_nanomachine"] = [[
На {1} увеличена скорость регенерации брони.]]

LANGUAGE["Perk_Title_heavy_ballistic_shock"] = [[Баллистический удар]]
LANGUAGE["Perk_heavy_ballistic_shock"] = [[
Применяемые вами дебаффы увеличивают эффект на {1}.
Применяемые вами дебаффы на {2} более длительны.]]

-- Default Perks: Medic
LANGUAGE["Perk_Title_Medic_Tier_1"] = [[Медицина]]
LANGUAGE["Perk_Title_medic_antibiotics"] = [[Антибиотики]]
LANGUAGE["Perk_medic_antibiotics"] = [[
Ваше исцеление усилено на {1}.]]

LANGUAGE["Perk_Title_medic_painkillers"] = [[Обезболивающее]]
LANGUAGE["Perk_medic_painkillers"] = [[
Вы можете увеличить максимальное здоровье игрока на {1}.]]

LANGUAGE["Perk_Title_Medic_Tier_2"] = [[Биоинженерия]]
LANGUAGE["Perk_Title_medic_berserk"] = [[Берсерк]]
LANGUAGE["Perk_medic_berserk"] = [[
Игроки, которых вы исцелили, получают Берсерка на {1} секунд.
На {2} увеличен урон, пока у вас имеется Берсерк.]]

LANGUAGE["Perk_Title_medic_fortify"] = [[Укрепление]]
LANGUAGE["Perk_medic_fortify"] = [[
Игроки, которых вы исцелили, получают укрепление на {1} секунд.
На {2} меньше полученного урона, пока вы укреплены.]]

LANGUAGE["Perk_Title_Medic_Tier_3"] = [[Совершенствование]]
LANGUAGE["Perk_Title_medic_purify"] = [[Очищение]]
LANGUAGE["Perk_medic_purify"] = [[
Ваше исцеление уменьшает нарастание кровотечения, разрыва и оглушения.]]

LANGUAGE["Perk_Title_medic_haste"] = [[Спешка]]
LANGUAGE["Perk_medic_haste"] = [[
Игроки, которых вы исцелили, получают спешку на {1} секунд.
На {2} увеличена скорость передвижения, пока у вас имеется спешка.]]

LANGUAGE["Perk_Title_Medic_Tier_4"] = [[Естественный Отбор]]
LANGUAGE["Perk_Title_medic_cellular_implosion"] = [[Клеточная Имплозия]]
LANGUAGE["Perk_medic_cellular_implosion"] = [[
Враги, которых вы убили, имеют {1} шанс создать исцеляющее облако.]]

LANGUAGE["Perk_Title_medic_xcele"] = [[Ускоренный Фактор Заживления]]
LANGUAGE["Perk_medic_xcele"] = [[
Применяемые вами баффы на {1} более эффективны.
Применяемые вами баффы на {2} более длительны.]]

-- Default Perks: Demolition
LANGUAGE["Perk_Title_Demolition_Tier_1"] = [[Граната]]
LANGUAGE["Perk_Title_demolition_frag_impact"] = [[Ударная граната]]
LANGUAGE["Perk_demolition_frag_impact"] = [[
На {1} увеличен урон от гранаты при ударе.
Граната взрывается при ударе.
Ударные взрывы увеличивают нарастающее оглушение.]]

LANGUAGE["Perk_Title_demolition_frag_cluster"] = [[Кассетная граната]]
LANGUAGE["Perk_demolition_frag_cluster"] = [[
Гранаты и ВЛУБы спавнят {1} мини-надов при детонации.
У мини-надов на {2} меньше урона.]]

LANGUAGE["Perk_Title_Demolition_Tier_2"] = [[Вооружение]]
LANGUAGE["Perk_Title_demolition_direct_hit"] = [[Прямое попадание]]
LANGUAGE["Perk_demolition_direct_hit"] = [[
На {1} увеличен урон от взрыва против врагов, близких к взрывам.]]

LANGUAGE["Perk_Title_demolition_seismic_wave"] = [[Сейсмическая волна]]
LANGUAGE["Perk_demolition_seismic_wave"] = [[
Разрывные снаряды создают дополнительный отложенный взрыв при детонации.
Отложенный взрыв наносит {1} урона от взрыва как физический урон.]]

LANGUAGE["Perk_Title_Demolition_Tier_3"] = [[Подход]]
LANGUAGE["Perk_Title_demolition_fragmentation"] = [[Фрагментация]]
LANGUAGE["Perk_demolition_fragmentation"] = [[
На {1} увеличен урон от взрыва.]]

LANGUAGE["Perk_Title_demolition_knockout"] = [[Нокаут]]
LANGUAGE["Perk_demolition_knockout"] = [[
Урон от взрыва увеличивает нарастание оглушения.
Враги, пораженные оглушением, парализуются на {1} секунд.
Перезарядка оглушения составляет {2} секунд.]]

LANGUAGE["Perk_Title_Demolition_Tier_4"] = [[Разрушение]]
LANGUAGE["Perk_Title_demolition_pressurized_warhead"] = [[Боеголовка под давлением]]
LANGUAGE["Perk_demolition_pressurized_warhead"] = [[
На {1} увеличен урон от взрыва против элитных врагов.
Взрывы наносят от {2} до {3} урона от текущего здоровья
врагов в качестве дополнительного урона от взрыва.]]

LANGUAGE["Perk_Title_demolition_chain_reaction"] = [[Цепная реакция]]
LANGUAGE["Perk_demolition_chain_reaction"] = [[
Враги, которых вы убили, имеют {1} шанс взорваться, нанося
{2} урона от их максимального здоровья в качестве урона от взрыва.]]

-- Default Perks: Ghost
LANGUAGE["Perk_Title_Ghost_Tier_1"] = [[Тактики]]
LANGUAGE["Perk_Title_ghost_headhunter"] = [[Охотник за головами]]
LANGUAGE["Perk_ghost_headhunter"] = [[
Урон от выстрела в голову добавляет стак до {1} раз.
Каждый стак увеличивает на {2} урон в голову.]]

LANGUAGE["Perk_Title_ghost_sniper"] = [[Снайпер]]
LANGUAGE["Perk_ghost_sniper"] = [[
На 25% увеличен Баллистический урон, когда вы присаживаетесь.]]

LANGUAGE["Perk_Title_Ghost_Tier_2"] = [[Перемещение]]
LANGUAGE["Perk_Title_ghost_phase_walk"] = [[Фаза ходьбы]]
LANGUAGE["Perk_ghost_phase_walk"] = [[
Бег не отменяет ваш камуфляж.
На {1} увеличена скорость передвижения, когда у вас имеется Камуфляж.
На {2} увеличено уклонение, когда у вас имеется Камуфляж.]]

LANGUAGE["Perk_Title_ghost_ghost_veil"] = [[Призрачная вуаль]]
LANGUAGE["Perk_ghost_ghost_veil"] = [[
Атака не отменяет ваш камуфляж
На {1} увеличена скорость ходьбы, когда у вас имеется камуфляж.
На {2} увеличен Баллистический урон, когда у вас имеется камуфляж.]]

LANGUAGE["Perk_Title_Ghost_Tier_3"] = [[Траектория]]
LANGUAGE["Perk_Title_ghost_brain_snap"] = [[Щелчок мозга]]
LANGUAGE["Perk_ghost_brain_snap"] = [[
Выстрелы в голову увеличивают нарастающее обморожение на основе урона.
Враги, затронутые обморожением, становятся неподвижными на {1} сек.
Перезарядка обморожения составляет {2} секунд.]]

LANGUAGE["Perk_Title_ghost_kinetic_impact"] = [[Кинетический удар]]
LANGUAGE["Perk_ghost_kinetic_impact"] = [[
Увеличивается баллистический урон в зависимости от расстояния.
Увеличивается на {1} урон за каждые {2} единиц.
Увеличивается кап на {3}.]]

LANGUAGE["Perk_Title_Ghost_Tier_4"] = [[Удаление]]
LANGUAGE["Perk_Title_ghost_coup"] = [[Смертельный удар]]
LANGUAGE["Perk_ghost_coup"] = [[
Вы мгновенно убиваете врагов с менее чем 20% здоровья.]]

LANGUAGE["Perk_Title_ghost_decapitate"] = [[Обезглавить]]
LANGUAGE["Perk_ghost_decapitate"] = [[
Когда у вас имеется камуфляж:
  На {1} увеличен баллистический урон.
  На {2} увеличен урон в голову против элитных врагов.]]

-- Default Perks: Engineer
LANGUAGE["Perk_Title_Engineer_Tier_1"] = [[Мастерство]]
LANGUAGE["Perk_Title_engineer_tinkerer"] = [[Изобретатель]]
LANGUAGE["Perk_engineer_tinkerer"] = [[
На {1} больше здоровья у миньонов.]]

LANGUAGE["Perk_Title_engineer_pioneer"] = [[Пионер]]
LANGUAGE["Perk_engineer_pioneer"] = [[
На {1} увеличен урон у миньонов.]]

LANGUAGE["Perk_Title_Engineer_Tier_2"] = [[Ядро]]
LANGUAGE["Perk_Title_engineer_fusion"] = [[Слияние]]
LANGUAGE["Perk_engineer_fusion"] = [[
Миньоны восстанавливают {1} здоровья в секунду.
На {2} увеличен урон миньонов, когда у них полное здоровье.]]

LANGUAGE["Perk_Title_engineer_metabolism"] = [[Метаболизм]]
LANGUAGE["Perk_engineer_metabolism"] = [[
Миньоны высасывают {1} от нанесенного урона, до {2} ед. здоровья за удар.
На {3} увеличен урон у миньонов, когда они исцеляются.]]

LANGUAGE["Perk_Title_Engineer_Tier_3"] = [[Манипуляция]]
LANGUAGE["Perk_Title_engineer_antimatter_shield"] = [[Антивещественный щит]]
LANGUAGE["Perk_engineer_antimatter_shield"] = [[
Нажмите Shift+E, чтобы активировать щит на наведенного миньона. 
Щит поглощает урон до {1} от здоровья миньона.
Щит взрывается при истощении и имеет время перезарядки {2} секунды.]]

LANGUAGE["Perk_Title_engineer_displacer"] = [[Вытеснитель]]
LANGUAGE["Perk_engineer_displacer"] = [[
Нажмите SHIFT+E, чтобы телепортировать наведенного миньона к себе.
Вы восстанавливаете {1} здоровья от телепортированного миньона.
Вытеснитель имеет время перезарядки на {2} секунды.]]

LANGUAGE["Perk_Title_Engineer_Tier_4"] = [[Экспериментальный]]
LANGUAGE["Perk_Title_engineer_symbiosis"] = [[Симбиоз]]
LANGUAGE["Perk_engineer_symbiosis"] = [[
У миньонов на {1} больше здоровья при спавне.
На {2} меньше полученного урона за каждого живого миньона.]]

LANGUAGE["Perk_Title_engineer_kamikaze"] = [[Камикадзе]]
LANGUAGE["Perk_engineer_kamikaze"] = [[
При смерти, миньоны наносят {1} урона от своего макс. здоровья
в качестве урона от взрыва.]]

-- Default Perks: Berserker
LANGUAGE["Perk_Title_Berserker_Tier_1"] = [[Основы]]
LANGUAGE["Perk_Title_berserker_breathing_technique"] = [[Дыхательная техника]]
LANGUAGE["Perk_berserker_breathing_technique"] = [[
Восстанавливается {1} здоровья за секунду.
Иммунитет к урону от яда.]]

LANGUAGE["Perk_Title_berserker_bloodlust"] = [[Жажда крови]]
LANGUAGE["Perk_berserker_bloodlust"] = [[
Вы высасываете {1} от урона ближнего боя, до {2} ед. здоровья за удар.
Иммунитет к кровотечению.]]

LANGUAGE["Perk_Title_Berserker_Tier_2"] = [[Техника]]
LANGUAGE["Perk_Title_berserker_bushido"] = [[Бусидо]]
LANGUAGE["Perk_berserker_bushido"] = [[
На {1} увеличен рубящий урон.
На {2} увеличена скорость передвижения.]]

LANGUAGE["Perk_Title_berserker_savagery"] = [[Дикость]]
LANGUAGE["Perk_berserker_savagery"] = [[
На {1} увеличен тупой урон в ближнем бою.
На {2} увеличено максимальное здоровье.]]

LANGUAGE["Perk_Title_Berserker_Tier_3"] = [[Парирование]]
LANGUAGE["Perk_Title_berserker_graceful_guard"] = [[Изящный страж]]
LANGUAGE["Perk_berserker_graceful_guard"] = [[
При успешном воздушном парировании:
  - Снимает все дебаффы и нарастающие дебаффы
  - Восстанавливает {1} ед. здоровья.]]

LANGUAGE["Perk_Title_berserker_unwavering_guard"] = [[Непоколебимый страж]]
LANGUAGE["Perk_berserker_unwavering_guard"] = [[
При успешном воздушном парировании:
  - На {1} увеличен физический урон на {3} секунд.
  - На {2} меньше получаемого урона на {3} секунд.]]

LANGUAGE["Perk_Title_Berserker_Tier_4"] = [[Боевые искусства]]
LANGUAGE["Perk_Title_berserker_phalanx"] = [[Фаланга]]
LANGUAGE["Perk_berserker_phalanx"] = [[
Вы получаете 1 стак фаланги каждые 2 секунды, до {1}.
Каждый стак увеличивает на {2} устойчивость от физ. урона и на {3} урон в ближнем бою.
Теряются стаки при атаке.]]

LANGUAGE["Perk_Title_berserker_rip_and_tear"] = [[Рвать и терзать]]
LANGUAGE["Perk_berserker_rip_and_tear"] = [[
На {1} больше урона в ближнем бою.
Ваша атака ближним боем теперь имеет сплэш.
Урон сплэшем является {2} от вашего урона в ближнем бою.]]

-- Default Perks: Warden
LANGUAGE["Perk_Title_Warden_Tier_1"] = [[Поддерживать]]
LANGUAGE["Perk_Title_warden_bulwark"] = [[Бастион]]
LANGUAGE["Perk_warden_bulwark"] = [[
Сторожевые башни создают 1 броневую батарею каждые {1} секунд.]]

LANGUAGE["Perk_Title_warden_vitality"] = [[Жизнеспособность]]
LANGUAGE["Perk_warden_vitality"] = [[
Аура обеспечивает регенерацию {1} ед. здоровья в секунду.]]

LANGUAGE["Perk_Title_Warden_Tier_2"] = [[Использование ресурсов]]
LANGUAGE["Perk_Title_warden_restock"] = [[Быстрое пополнение запасов]]
LANGUAGE["Perk_warden_restock"] = [[
Время восстановления запасов у сторожевых башен уменьшено на {1}.]]

LANGUAGE["Perk_Title_warden_energize"] = [[Возбуждать]]
LANGUAGE["Perk_warden_energize"] = [[
Аура добавляет {1} базового урона к атакам.]]

LANGUAGE["Perk_Title_Warden_Tier_3"] = [[Охрана]]
LANGUAGE["Perk_Title_warden_rejection_pulse"] = [[Импульс отклонения]]
LANGUAGE["Perk_warden_rejection_pulse"] = [[
Сторожевые башни создают ударную волну каждые {1} секунд.
Ударная волна наносит {2} урона от электричества.]]

LANGUAGE["Perk_Title_warden_inoculation"] = [[Инокуляция]]
LANGUAGE["Perk_warden_inoculation"] = [[
Аура занижает {1} получение накопления
от воспламенения, шока и обморожения.]]

LANGUAGE["Perk_Title_Warden_Tier_4"] = [[Покрытие]]
LANGUAGE["Perk_Title_warden_ex_machina"] = [[Бог из машины]]
LANGUAGE["Perk_warden_ex_machina"] = [[
У сторожевых башен теперь есть Аура Надзирателя.]]

LANGUAGE["Perk_Title_warden_resonance_cascade"] = [[Каскадный резонанс]]
LANGUAGE["Perk_warden_resonance_cascade"] = [[
Эффект от ауры увеличен на {1}.
Радиус ауры увеличен на {2}.]]

-- Default Perks: Cremator
LANGUAGE["Perk_Title_Cremator_Tier_1"] = [[Химикаты]]
LANGUAGE["Perk_Title_cremator_methane"] = [[Метан]]
LANGUAGE["Perk_cremator_methane"] = [[
На {1} увеличен урон от огня против горящих врагов.]]

LANGUAGE["Perk_Title_cremator_napalm"] = [[Напалм]]
LANGUAGE["Perk_cremator_napalm"] = [[
Длительность воспламенения увеличена на {1}.]]

LANGUAGE["Perk_Title_Cremator_Tier_2"] = [[Поглощение энергии]]
LANGUAGE["Perk_Title_cremator_positron_array"] = [[Позитронная решетка]]
LANGUAGE["Perk_cremator_positron_array"] = [[
Иммунитет к урону от огня.
Вы впитываете {1} получаемого урона от огня в качестве здоровья.]]

LANGUAGE["Perk_Title_cremator_entropy_shield"] = [[Энтропийный щит]]
LANGUAGE["Perk_cremator_entropy_shield"] = [[
Вы получаете щит, который сводит на нет урон, наносимый врагами.
Щит взрывается при ударе и перезаряжается через {1} секунд.
Взрыв наносит {2} урона от огня.]]

LANGUAGE["Perk_Title_Cremator_Tier_3"] = [[Тепловые манипуляции]]
LANGUAGE["Perk_Title_cremator_hyperthermia"] = [[Гипертермия]]
LANGUAGE["Perk_cremator_hyperthermia"] = [[
Увеличивается урон от огня в зависимости от близости врага к вам.
Увеличивается кап на {1}.]]

LANGUAGE["Perk_Title_cremator_ionization"] = [[Ионизация]]
LANGUAGE["Perk_cremator_ionization"] = [[
Воспламеняющий урон увеличен на {1}.
Урон от огня игнорирует устойчивость к огню у врага.]]

LANGUAGE["Perk_Title_Cremator_Tier_4"] = [[Энергетический разряд]]
LANGUAGE["Perk_Title_cremator_firestorm"] = [[Огненный шторм]]
LANGUAGE["Perk_cremator_firestorm"] = [[
Урон от огня увеличивает нарастание взрыва у врагов.
Если нарастание взрыва заполнена, то создается взрыв.
Взрыв наносит {1} урона.]]

LANGUAGE["Perk_Title_cremator_incineration"] = [[Сжигание]]
LANGUAGE["Perk_cremator_incineration"] = [[
Воспламеняющий урон увеличен на {1}.]]

-- Default Perks: Samurai
LANGUAGE["Perk_Title_Samurai_Tier_1"] = [[Техника]]
LANGUAGE["Perk_Title_samurai_focus_slash"] = [[Рубящий фокус]]
LANGUAGE["Perk_samurai_focus_slash"] = [[
Добавляется 1 максимальный заряд к рывку.
На {1} увеличен урон в ближнем бою во время рывка.]]

LANGUAGE["Perk_Title_samurai_flesh_bloom"] = [[Цветение плоти]]
LANGUAGE["Perk_samurai_flesh_bloom"] = [[
Урон в ближнем бою наносит нарастающее кровотечение по области.]]

LANGUAGE["Perk_Title_Samurai_Tier_2"] = [[Сокрушать]]
LANGUAGE["Perk_Title_samurai_demon_stomp"] = [[Топот демона]]
LANGUAGE["Perk_samurai_demon_stomp"] = [[
Добавляется 1 максимальный заряд к рывку.
Активация рывка создаёт ударную волну, наносящая {1} физ. урона.
Восстанавливается {2} здоровья за каждого противника, пораженного удар. волной.]]

LANGUAGE["Perk_Title_samurai_exsanguinate"] = [[Обескровить]]
LANGUAGE["Perk_samurai_exsanguinate"] = [[
На {1} увеличено нарастающее кровотечение.
Восстанавливается здоровье вблизи, истекающих кровью, врагов.
Иммунитет к кровотечению.]]

LANGUAGE["Perk_Title_Samurai_Tier_3"] = [[Ум]]
LANGUAGE["Perk_Title_samurai_foresight"] = [[Предвидение]]
LANGUAGE["Perk_samurai_foresight"] = [[
Добавляется {1} максимальный заряд к рывку.
Дается предвидение, сводящий на нет полученный физический урон.
Предвидение заканчивается при ударе и отражает полученный урон.]]

LANGUAGE["Perk_Title_samurai_resolution"] = [[Решимость]]
LANGUAGE["Perk_samurai_resolution"] = [[
Уменьшается ваш максимальный вес до 7.
На {1} больше урона в ближнем бою.
+3 блок урона.]]

LANGUAGE["Perk_Title_Samurai_Tier_4"] = [[Искусство войны]]
LANGUAGE["Perk_Title_samurai_blade_dance"] = [[Танец клинка]]
LANGUAGE["Perk_samurai_blade_dance"] = [[
Добавляется 1 максимальный заряд к рывку.
Убийство врага добавляет 2 заряда к рывку.
Продливается длительность эффекта от рывка.]]

LANGUAGE["Perk_Title_samurai_demon_strike"] = [[Удар демона]]
LANGUAGE["Perk_samurai_demon_strike"] = [[
На {1} увеличено нрастающее кровотечение.
На {2} увеличен урон в ближнем бою против, истекающих кровью, врагов.
Забирается {3} полученный урон в ближнем бою во время рывка.]]

-- Default Perks: SpecOps
LANGUAGE["Perk_Title_SpecOps_Tier_1"] = [[Утилита]]
LANGUAGE["Perk_Title_specops_smokescreen"] = [[Дымовая завеса]]
LANGUAGE["Perk_specops_smokescreen"] = [[
Нажмите на Shift+E чтобы развернуть дымовую завесу.
На {1} увеличено уклонение игрокам, попавшим в дымовую завесу.
Эффект длится {2} секунды.]]

LANGUAGE["Perk_Title_specops_flare"] = [[Сигнальная ракета]]
LANGUAGE["Perk_specops_flare"] = [[
Нажмите на Shift+E чтобы развернуть сигнальную ракету.
Сигнальная ракета обеспечивает освещение и привлекает врагов.
Сигнальная ракета длится 3 секунды.]]

LANGUAGE["Perk_Title_SpecOps_Tier_2"] = [[Задействовать]]
LANGUAGE["Perk_Title_specops_tactical_visor"] = [[Тактический визор]]
LANGUAGE["Perk_specops_tactical_visor"] = [[
Пока в тактическом режиме:
  На {1} увеличен баллистический урон.
  На {2} увеличен урон по конечностям]]

LANGUAGE["Perk_Title_specops_neuron_stabilizer"] = [[Стабилизатор нейронов]]
LANGUAGE["Perk_specops_neuron_stabilizer"] = [[
Обеспечивает бонус, зависящий как долго вы будете в тактическом режиме.
На {1} увеличен баллистический урон в секунду, до {2}.
+{3} блок урона за секунду, до {4}]]

LANGUAGE["Perk_Title_SpecOps_Tier_3"] = [[Защита]]
LANGUAGE["Perk_Title_specops_biotic_mask"] = [[Биотическая маска]]
LANGUAGE["Perk_specops_biotic_mask"] = [[
Пока в тактическом режиме:
  Восстанавливается 2% здоровья в секунду.
  На {1} уменьшены нарастания кровотечения, разрыва и некроза.]]

LANGUAGE["Perk_Title_specops_adaptive_coating"] = [[Адаптивное покрытие]]
LANGUAGE["Perk_specops_adaptive_coating"] = [[
Пока в тактическом режиме:
  На {1} увеличена устойчивость к любому урону.
  На {2} уменьшен полученный урон от огня, холода и электричества.]]

LANGUAGE["Perk_Title_SpecOps_Tier_4"] = [[Закат]]
LANGUAGE["Perk_Title_specops_night_stalker"] = [[Ночной сталкер]]
LANGUAGE["Perk_specops_night_stalker"] = [[
Пока в тактическом режиме:
  На {1} увеличена скорость передвижения.
  На {2} увеличен урон в голову.]]

LANGUAGE["Perk_Title_specops_peace_walker"] = [[Мирный ходок]]
LANGUAGE["Perk_specops_peace_walker"] = [[
На {1} уменьшена перезарядка дымовой занавесы/сигнальной ракеты.
Пока в тактическом режиме:
  На {2} увеличен баллистический урон.]]
  
-- Default Perks: Artificer
LANGUAGE["Perk_Title_Artificer_Tier_1"] = [[Внутренняя сила]]
LANGUAGE["Perk_Title_artificer_warmth"] = [[Тепло]]
LANGUAGE["Perk_artificer_warmth"] = [[
Заряженные Солнечные Шары лечат игроков.]]

LANGUAGE["Perk_Title_artificer_purge"] = [[Чистка]]
LANGUAGE["Perk_artificer_purge"] = [[
На {1} увеличено нарастание шока.
На {2} увеличен урон в голову.]]

LANGUAGE["Perk_Title_Artificer_Tier_2"] = [[Возмещение]]
LANGUAGE["Perk_Title_artificer_solar_guard"] = [[Солнечная защита]]
LANGUAGE["Perk_artificer_solar_guard"] = [[
На {1} увеличена регенерация энергии Солнечной Печати.
Используется энергия чтобы уменьшить полученный урон, до {2}.
Занижение урона зависит от оставшиеся энергии.]]

LANGUAGE["Perk_Title_artificer_intensity"] = [[Интенсивность]]
LANGUAGE["Perk_artificer_intensity"] = [[
Дается Интенсивность за каждого убитого вами врага, до {1} стаков.
Каждый стак увеличивает регенерацию энергии на {2}.
Каждый стак уменьшает перезарядку навыка на {3}.]]

LANGUAGE["Perk_Title_Artificer_Tier_3"] = [[Кодекс]]
LANGUAGE["Perk_Title_artificer_floating_chaos"] = [[Парящий хаос]]
LANGUAGE["Perk_artificer_floating_chaos"] = [[
Открывается Парящий Хаос для Солнечной Печати ({1} энергии, клавиша R).
Создается парящий шар, который повторяет твои заклинания]]

LANGUAGE["Perk_Title_artificer_hallowed_bolt"] = [[Освященная молния]]
LANGUAGE["Perk_artificer_hallowed_bolt"] = [[
Открывается Освященная Молния для Солнечной Печати ({1} энергии, клавиша R).
Наносит удар по земле сверху, нанося тяжелый электрический урон по площади.
Восстанавливается здоровье, убийством врага, при помощи освященной молнии.]]

LANGUAGE["Perk_Title_Artificer_Tier_4"] = [[Восхождение]]
LANGUAGE["Perk_Title_artificer_godslayer"] = [[Богоубийца]]
LANGUAGE["Perk_artificer_godslayer"] = [[
Урон от огня игнорирует сопротивление урону от огня врага.
Солнечный Шар наносит на {1} больше урона и получает доп. стадию заряда.
Солнечная Буря может вызвать наземное пламя.]]

LANGUAGE["Perk_Title_artificer_draconic_reckoning"] = [[Драконовская расплата]]
LANGUAGE["Perk_artificer_draconic_reckoning"] = [[
Электрический урон игнорирует сопротивление электричествого урона у врага.
Солнечный Шар имеет область действия урона от электричества.
Солнечная Буря наносит на {1} больше урона и получает доп. стадию заряда.]]

-- Default Perks: Necromancer
LANGUAGE["Perk_Title_Necromancer_Tier_1"] = [[Инициализация]]
LANGUAGE["Perk_Title_necromancer_void_sphere"] = [[Пустотная сфера]]
LANGUAGE["Perk_necromancer_void_sphere"] = [[
Копье Пустоты всегда наносит сплэш урон.
Увеличивает сплэш урон у Копья Пустоты.]]

LANGUAGE["Perk_Title_necromancer_hollow_essence"] = [[Пустотелая сущность]]
LANGUAGE["Perk_necromancer_hollow_essence"] = [[
+{1} к максимальному количеству живых призраков.
На {2} меньше затрат на Призыв Призрака.]]

LANGUAGE["Perk_Title_Necromancer_Tier_2"] = [[Восстановление]]
LANGUAGE["Perk_Title_necromancer_void_siphon"] = [[Пустотный сифон]]
LANGUAGE["Perk_necromancer_void_siphon"] = [[
Восстанавливается энергия при попадании во врагов,
с помощью Копья Пустоты.
Увеличивается урон в зависимости от оставшиеся энергии, до {1}.]]

LANGUAGE["Perk_Title_necromancer_superfluidity"] = [[Сверхтекучесть]]
LANGUAGE["Perk_necromancer_superfluidity"] = [[
На {1} увеличено нарастание обморожения.
Проектор пустоты восстанавливает энергию во время бездействия.]]

LANGUAGE["Perk_Title_Necromancer_Tier_3"] = [[Уничтожение]]
LANGUAGE["Perk_Title_necromancer_void_field"] = [[Пустотное поле]]
LANGUAGE["Perk_necromancer_void_field"] = [[
Копье Пустоты наносит дополнительное нарастание обморожения.
Увеличивается урон Копья Пустоты по его дальности перемещения.]]

LANGUAGE["Perk_Title_necromancer_abyssal_might"] = [[Бездонная мощь]]
LANGUAGE["Perk_necromancer_abyssal_might"] = [[
+{1} к максимальному количеству живых призраков.
Призраки получают доступ к Бездонному Рёву.]]

LANGUAGE["Perk_Title_Necromancer_Tier_4"] = [[Мастерство]]
LANGUAGE["Perk_Title_necromancer_beacon_of_void"] = [[Маяк пустоты]]
LANGUAGE["Perk_necromancer_beacon_of_void"] = [[
Урон от холода игнорирует сопротивление к урону от холода у врага.
Открывается Каскад Пустоты для Проектора Пустоты ({1} энергии, клавиша R).
Бонусы от перков к Копью Пустоты так же применяются на Каскад Пустоты.]]

LANGUAGE["Perk_Title_necromancer_necromastery"] = [[Некромастерия]]
LANGUAGE["Perk_necromancer_necromastery"] = [[
+{1} к максимальному количеству живых призраков.
Открывается умение пожирания для Проектора Пустоты (Клавиша R).
Мгновенно убивает указанного не элитного врага и порождается призрак.]]

-- Default Perks: Gunslinger
LANGUAGE["Perk_Title_Gunslinger_Tier_1"] = [[Точность]]
LANGUAGE["Perk_Title_gunslinger_deadeye"] = [[Меткий стрелок]]
LANGUAGE["Perk_gunslinger_deadeye"] = [[
Выстрел в голову добавляет стак до {1} раз.
Каждый стак увеличивает на {2} урон от пистолетов]]

LANGUAGE["Perk_Title_gunslinger_puncture"] = [[Прокол]]
LANGUAGE["Perk_gunslinger_puncture"] = [[
Дальность метки охотника увеличена на {1}.
Враги под меткой охотника получают на {2} больше урона.]]

LANGUAGE["Perk_Title_Gunslinger_Tier_2"] = [[Перестрелка]]
LANGUAGE["Perk_Title_gunslinger_elusive"] = [[Неуловимый]]
LANGUAGE["Perk_gunslinger_elusive"] = [[
При держании пистолетного оружия:
 На {1} увеличена скорость движения.
 На {2} увеличено уклонение.]]

LANGUAGE["Perk_Title_gunslinger_poach"] = [[Браконьерство]]
LANGUAGE["Perk_gunslinger_poach"] = [[
На {1} добавлена длительность метки охотника.
Враги, убитые под меткой охотника, имеют {2} шанс сбросить поглащ. гаджеты.
Элитные враги имеют {3} дополнительный шанс сбросить гаджет.]]

LANGUAGE["Perk_Title_Gunslinger_Tier_3"] = [[Трюки]]
LANGUAGE["Perk_Title_gunslinger_quickdraw"] = [[Навскидку]]
LANGUAGE["Perk_gunslinger_quickdraw"] = [[
Дается статус "Навскидку" при переключении оружия.
Урон от пистолетов и уклонение при статусе "Навскидку" увеличены на {1}.
Эффект "Навскидку" длится в течение {2} секунд.]]

LANGUAGE["Perk_Title_gunslinger_smuggle"] = [[Контрабандист]]
LANGUAGE["Perk_gunslinger_smuggle"] = [[
Вы получаете дополнительные деньги, когда враги убиты под меткой охотника.
Позволяет вам открыть магазин когда угодно и где угодно.
Время перезарядки - 60 секунд, как только вы откроете лавку контрабандиста.]]

LANGUAGE["Perk_Title_Gunslinger_Tier_4"] = [[Ультиматум]]
LANGUAGE["Perk_Title_gunslinger_phantom_reload"] = [[Фантомная перезарядка]]
LANGUAGE["Perk_gunslinger_phantom_reload"] = [[
При фантомной перезарядки, смена пистолетов сразу перезаряжает оружие.
Использование фантомной перезарядки выбрасывается весь магазин.
Перезарядка фантомной перезарядки составляет {1} секунды.]]

LANGUAGE["Perk_Title_gunslinger_exorcism"] = [[Экзорцизм]]
LANGUAGE["Perk_gunslinger_exorcism"] = [[
Метка охотника снимает мутации с врага на {1} секунд.
Метка охотника наносит {2} урона за каждую снятую мутацию.
Метка охотника имеет {3} шанс сразу убить неэлитного врага.]]

-- Default Perks: Psycho
LANGUAGE["Perk_Title_Psycho_Tier_1"] = [[Насилие]]
LANGUAGE["Perk_Title_psycho_ferocity"] = [[Свирепость]]
LANGUAGE["Perk_psycho_ferocity"] = [[
Добавляет {1} шанс критического попадания.
Добавляет {2} шанс критического попадания в ближнем бою.]]

LANGUAGE["Perk_Title_psycho_savor"] = [[Вкус]]
LANGUAGE["Perk_psycho_savor"] = [[
На {1} увеличен урон при критическом попадании.
Высасывает {2} урона, наносимого при нанесении крит. удара в ближнем бою.
Кап высасывания по 10 единиц здоровья за удар.]]

LANGUAGE["Perk_Title_Psycho_Tier_2"] = [[Садизм]]
LANGUAGE["Perk_Title_psycho_bloodbath"] = [[Кровавая баня]]
LANGUAGE["Perk_psycho_bloodbath"] = [[
Добавляет {1} шанс критического попадания.
Высасывает 1 здоровье при критическом попадании.]]

LANGUAGE["Perk_Title_psycho_disembowel"] = [[Выпотрошить]]
LANGUAGE["Perk_psycho_disembowel"] = [[
На {1} увеличен урон при критическом попадании.
Атаки ближнего боя удаляют мутацию немезиса у врагов.]]

LANGUAGE["Perk_Title_Psycho_Tier_3"] = [[Фатальность]]
LANGUAGE["Perk_Title_psycho_skewering"] = [[Насаживание на шампуры]]
LANGUAGE["Perk_psycho_skewering"] = [[
Враги, которых вы поражаете выстрелами в голову, пронзаются насквозь.
Игроки имеют +{1} шанс критического удара,
Когда они поражают пронзенных врагов.]]

LANGUAGE["Perk_Title_psycho_brutality"] = [[Брутальность]]
LANGUAGE["Perk_psycho_brutality"] = [[
Даётся брутальность поражая врага атаками ближнего боя, до 5 стаков.
Каждый стак брутальности дает {1} шанс критического попадания.
Каждый стак брутальности увеличивает на {2} урон при критическом попадании.]]

LANGUAGE["Perk_Title_Psycho_Tier_4"] = [[Психоз]]
LANGUAGE["Perk_Title_psycho_grudge"] = [[Зависть]]
LANGUAGE["Perk_psycho_grudge"] = [[
На {1} увеличен шанс критического попадания на {2} потерянного здоровья.
На {3} увеличена скорость передвижения на {4} потерянного здоровья, до {5}.]]

LANGUAGE["Perk_Title_psycho_bestial_wrath"] = [[Звериный гнев]]
LANGUAGE["Perk_psycho_bestial_wrath"] = [[
На {1} увеличен урон при критическом попадании.
Наносит сплеш урон ближним боем в режиме безумия.
Восстанавливает 1 здоровье за каждого убитого врага в режиме безумия.]]

-- Default Perks: Warlock
LANGUAGE["Perk_Title_Warlock_Tier_1"] = [[Преображение]]
LANGUAGE["Perk_Title_warlock_celestial_bond"] = [[Небесная связь]]
LANGUAGE["Perk_warlock_celestial_bond"] = [[
+{1} к максимальному количеству активных Астральных Пульсаров.
Позволяет прикреплять Астральный Пульсар к наведенным игрокам.
Астральный Пульсар наносит урон по области, будучи прикрепленным к игроку.]]

LANGUAGE["Perk_Title_warlock_coalesce"] = [[Объединение]]
LANGUAGE["Perk_warlock_coalesce"] = [[
+{1} к максимальному количеству активных Астральных Остатков.
Позволяет нацеливать Астральный Пульсар на Астральные Остатки.
Нацеленный Астральный Остаток прикрепляется к Пульсару при контакте.]]

LANGUAGE["Perk_Title_Warlock_Tier_2"] = [[Направление]]
LANGUAGE["Perk_Title_warlock_magnetar"] = [[Магнетар]]
LANGUAGE["Perk_warlock_magnetar"] = [[
+{1} к максимальному количеству активных Астральных Пульсаров.
Продлевает продолжительность Пульсара, когда он прикрепляется к врагу.]]

LANGUAGE["Perk_Title_warlock_nucleosynthesis"] = [[Нуклеосинтез]]
LANGUAGE["Perk_warlock_nucleosynthesis"] = [[
На {1} увеличена максимальная энергия.
Восстанавливает {2} энергии, которую вы использовали в качестве здоровья.]]

LANGUAGE["Perk_Title_Warlock_Tier_3"] = [[Векторизация]]
LANGUAGE["Perk_Title_warlock_gravity_vacuum"] = [[Гравитационный вакуум]]
LANGUAGE["Perk_warlock_gravity_vacuum"] = [[
Разблокирует грав. вакуум для реликвии преисподней. ({1} энергии, R).
Привлекает все активные Астральные Пульсары к цели.
Привлекает Астральные Остатки поблизости к цели.]]

LANGUAGE["Perk_Title_warlock_negative_burst"] = [[Негативный всплеск]]
LANGUAGE["Perk_warlock_negative_burst"] = [[
Разблокирует негативный всплеск для реликвии преисподней. ({1} энергии, R).
Наносит физ. урон и отбрасывает вас в зависимости от недостающей энергии.
Восстанавливает {2} энергии за каждого врага, убитого негативным всплеском.]]

LANGUAGE["Perk_Title_Warlock_Tier_4"] = [[Уничтожение]]
LANGUAGE["Perk_Title_warlock_starscourge"] = [[Звездный бич]]
LANGUAGE["Perk_warlock_starscourge"] = [[
+{1} к максимальному количеству активных Астральных Пульсаров.
Заставляет ваш первый Пульсар иметь бесконечную продолжительность.
На {2} больше урона Астральным Пульсаром, наносимого элитным врагам.]]

LANGUAGE["Perk_Title_warlock_dirac_sea"] = [[Море Дирака]]
LANGUAGE["Perk_warlock_dirac_sea"] = [[
На {1} увеличено максимальное количество энергии.
Удаляет выпадение урона от взрыва для Пульсара и Остатков.
Заряженные Остатки оставляют позади незаряженные Остатки при взрыве.]]

-- Default Perks: Carcass
LANGUAGE["Perk_Title_Carcass_Tier_1"] = [[Кишка]]
LANGUAGE["Perk_Title_carcass_grappendix"] = [[Захватный Аппендикс]]
LANGUAGE["Perk_carcass_grappendix"] = [[
На {1} увеличено максимальное здоровье.
Нажмите на ПКМ чтобы использовать ваш аппендикс как захватный крюк.
Вы теряете своё здоровье, когда используется.]]

LANGUAGE["Perk_Title_carcass_bio_thruster"] = [[Био Двигатель]]
LANGUAGE["Perk_carcass_bio_thruster"] = [[
Прибавляет +{1} к максимальному количеству Гипертрофических стаков.
ПКМ для продвижения, стоимостью {2} здоровья, и получить 1 стак Б.Д, до 5.
Каждый стак Б.Д увелич. на {3} урон от ближ. боя, но снимает {4} здоровья.]]

LANGUAGE["Perk_Title_Carcass_Tier_2"] = [[Секреция]]
LANGUAGE["Perk_Title_carcass_tactical_spleen"] = [[Тактическая Селезенка]]
LANGUAGE["Perk_carcass_tactical_spleen"] = [[
На {1} увеличено максимальное здоровье.
Предоставляет селезенку, сводящая на нет все дебаффы, когда накопление
завершено. Селезенка восстанавливается каждые {2} секунд.]]

LANGUAGE["Perk_Title_carcass_anabolic_gland"] = [[Анаболическая Железа]]
LANGUAGE["Perk_carcass_anabolic_gland"] = [[
Прибавляет +{1} к максимальному количеству Гипертрофических стаков.
Прибавляет {2} шанс получить Гипертрофию, когда вас ударил враг.]]

LANGUAGE["Perk_Title_Carcass_Tier_3"] = [[Конечности]]
LANGUAGE["Perk_Title_carcass_reinforced_arms"] = [[Усиленные руки]]
LANGUAGE["Perk_carcass_reinforced_arms"] = [[
Прибавляет +{1} к максимальному количеству Гипертрофических стаков.
Ваш удар наносит больше удара в зависимости от вашей скорости.
Мощный удар против поверхностей предоставляет ускорение.]]

LANGUAGE["Perk_Title_carcass_pneumatic_legs"] = [[Пневматические ноги]]
LANGUAGE["Perk_carcass_pneumatic_legs"] = [[
Прибавляет +{1} к максимальному количеству Гипертрофических стаков.
Нажмите ПРОБЕЛ в воздухе для спуска, нанося физ. урон по области,
в зависимости от скорости. На {2} уменьшен полученный урон от падения.]]

LANGUAGE["Perk_Title_Carcass_Tier_4"] = [[Сердце]]
LANGUAGE["Perk_Title_carcass_twin_heart"] = [[Двойное сердце]]
LANGUAGE["Perk_carcass_twin_heart"] = [[
На {1} увеличено максимальное здоровье.
Переключите R, чтобы восстановить своё здоровье с помощью синт. сердца.
Сердце восстанавливает здоровье со временем, до {2} от вашего макс. здоровья.]]

LANGUAGE["Perk_Title_carcass_aas_perfume"] = [[Духи AAS]]
LANGUAGE["Perk_carcass_aas_perfume"] = [[
Прибавляет +{1} к максимальному количеству Гипертрофических стаков.
Нажмите на R, чтобы стрелять спорами, которые обеспечивают Гипертрофией 
игроков по области. Эффект длится в течение {2} сек. и имеет перезарядку {3} сек.]]

-- Default Perks: Hatcher
LANGUAGE["Perk_Title_Hatcher_Tier_1"] = [[Стадия I]]
LANGUAGE["Perk_Title_hatcher_natural_selection"] = [[Естественный отбор]]
LANGUAGE["Perk_hatcher_natural_selection"] = [[
На {1} увеличена скорость эволюции муравьиных львов.]]

LANGUAGE["Perk_Title_hatcher_growth_hormone"] = [[Гормон роста]]
LANGUAGE["Perk_hatcher_growth_hormone"] = [[
На {1} увеличена скорость эволюции муравьиных львов, когда они исцелены.]]

LANGUAGE["Perk_Title_Hatcher_Tier_2"] = [[Стадия II]]
LANGUAGE["Perk_Title_hatcher_sand_cloak"] = [[Песчаный плащ]]
LANGUAGE["Perk_hatcher_sand_cloak"] = [[
Муравьиным львам II стадии предоставляется песчаный плащ через импульс жука.
Песчаный плащ добавляет {1} уклонения.
Песчаный плащ длится в течение {2} секунд.]]

LANGUAGE["Perk_Title_hatcher_bio_barrier"] = [[Биобарьер]]
LANGUAGE["Perk_hatcher_bio_barrier"] = [[
Муравьным львам II стадии предоставляется 20 барьерных через импульс жука.
Барьер использует заряды для поглощ. всех накоплений дебаффа и получ. урона.
Каждый игрок имеет максимум 50 барьерных]]

LANGUAGE["Perk_Title_Hatcher_Tier_3"] = [[Стадия III]]
LANGUAGE["Perk_Title_hatcher_vile_blood"] = [[Мерзкая кровь]]
LANGUAGE["Perk_hatcher_vile_blood"] = [[
Муравьиным львам III стадии предоставляется мерз. кровь через импульс жука.
Мерзкая кровь обеспечивает {1} увеличенной устойчивости к урону от яда.
Мерзкая кровь позволяет игроку вызвать накопление разрыва.]]

LANGUAGE["Perk_Title_hatcher_flesh_eater"] = [[Пожиратель плоти]]
LANGUAGE["Perk_hatcher_flesh_eater"] = [[
Мурав. львам III стадии предоставляется пожир. плоти через ароматич. импульс.
Пожиратель плоти позволяет игроку высасывать {1} урона, до {2} за каждый удар.
Пожиратель плоти позволяет мурав. львам высасывать {2} единиц урона.]]

LANGUAGE["Perk_Title_Hatcher_Tier_4"] = [[Естественный отбор]]
LANGUAGE["Perk_Title_hatcher_swarm"] = [[Рой]]
LANGUAGE["Perk_hatcher_swarm"] = [[
+1 к максимальному количеству муравьиных львов.]]

LANGUAGE["Perk_Title_hatcher_metamorphosis"] = [[Метаморфоза]]
LANGUAGE["Perk_hatcher_metamorphosis"] = [[
Добавляется IV стадия эволюции, превращая мурав. льва в стража мурав. львов.
Страж мурав. львов имеет увелич. здоровье и урон, но больше не контролируется.
Страж муравьиных львов имеет иммунитет к эффектам статусов.]]

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
Надёжный штык-нож.
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
Бьёт, как грузовик.
]]

LANGUAGE["Item_Fireaxe"] = [[Пожарный топор]]
LANGUAGE["Item_Desc_Fireaxe"] = [[
Пожарный топор.
Разрубает врагов пополам.]]

LANGUAGE["Item_Inferno Blade"] = [[Клинок Ада]]
LANGUAGE["Item_Desc_Inferno Blade"] = [[
Сверкающий изогнутый меч со скрытой силой.
Нажмите ПКМ чтобы активировать/деактивировать оружие.
При деактивации оружие наносит рубящий урон.
При активации оружие наносит огненный сплэш урон.
Однако со временем игрок получает урон от огня.]]

LANGUAGE["Item_Carcass Biosystem"] = [[Биосистема туши]]
LANGUAGE["Item_Desc_Carcass Biosystem"] = [[
Только используется подклассом "Туша"
Усовершенствованная боевая биосистема,
которая полностью портит внешний вид своего пользователя.
Оставляет после себя неприятный запах.
  
ЛКМ: Удар
Удерживайте для мощного удара, который нанесёт повышенный урон по области.
]]

LANGUAGE["Item_9mm"] = [[9mm]]
LANGUAGE["Item_Desc_9mm"] = [[
Стандартное вооружение Альянса
]]

LANGUAGE["Item_357"] = [[357]]
LANGUAGE["Item_Desc_357"] = [[
Пистолет Colt python magnum.
Используется охранниками Чёрной Мезы.
]]

LANGUAGE["Item_Glock"] = [[Glock]]
LANGUAGE["Item_Desc_Glock"] = [[
Глок 18.
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
Револьер R8.
Выпускает высокоточный и мощный снаряд,
за счет длительного нажатия на спусковой крючок.
]]

LANGUAGE["Item_Deagle"] = [[Deagle]]
LANGUAGE["Item_Desc_Deagle"] = [[
Night Hawk .50C.
Легендарный пистолет, который сложно освоить.
]]

LANGUAGE["Item_M1911"] = [[M1911]]
LANGUAGE["Item_Desc_M1911"] = [[
Colt 1911.
Стандартное личное оружие для Вооруженных Сил США.
]]

LANGUAGE["Item_FiveSeven"] = [[FiveSeven]]
LANGUAGE["Item_Desc_FiveSeven"] = [[
ES Five-seven.
Бельгийский полуавтоматический пистолет производства FN Herstal.
]]

LANGUAGE["Item_CZ75"] = [[CZ75]]
LANGUAGE["Item_Desc_CZ75"] = [[
CZ 75.
Полуавтоматический пистолет, произведенный в Чешской Республике.
]]

LANGUAGE["Item_M9"] = [[M9]]
LANGUAGE["Item_Desc_M9"] = [[
Beretta M9.
Пистолет, используемый Вооруженными Силами США.
]]

LANGUAGE["Item_Tec-9"] = [[Tec-9]]
LANGUAGE["Item_Desc_Tec-9"] = [[
Полуавтоматический пистолет шведского производства.
Смертельно опасен в непосредственной близости.
]]

LANGUAGE["Item_TMP"] = [[TMP]]
LANGUAGE["Item_Desc_TMP"] = [[
Steyr TMP.
Отборный огнестрельный пистолет-пулемёт калибра 9 × 19 мм Parabellum.
]]

LANGUAGE["Item_Flare Gun"] = [[Ракетница]]
LANGUAGE["Item_Desc_Flare Gun"] = [[
Сигнальная ракета безопасности Orion.
Поджигает врагов и наносит урон от огня.
]]

LANGUAGE["Item_Anaconda"] = [[Анаконда]]
LANGUAGE["Item_Desc_Anaconda"] = [[
Colt Anaconda.
Под патрон .44 Magnum.
]]

LANGUAGE["Item_Welder"] = [[Сварщик]]
LANGUAGE["Item_Desc_Welder"] = [[
Инженер-сварщик.
Наносит урон врагам и лечит миньонов.
]]

LANGUAGE["Item_Rocket Turret"] = [[Ракетная турель]]
LANGUAGE["Item_Desc_Rocket Turret"] = [[
Апертурная научная ракетная турель.
Стреляет мини-ракетами которые наносят урон от взрыва.
Охватывает все углы.
]]

LANGUAGE["Item_Machete"] = [[Мачете]]
LANGUAGE["Item_Desc_Machete"] = [[
Мачете.
]]

LANGUAGE["Item_Astral Relic"] = [[Астральная реликвия]]
LANGUAGE["Item_Desc_Astral Relic"] = [[
Только используется подклассом "Чародей".
Манипулирует отрицательными энергетическими полями.

ЛКМ: Астральный Пульсар (10 энергии)
Освобождает самонаводящийся объект, который прикрепляется к врагам
и наносит физический урон со временем.
У вас может быть не более 2 активных Астральных Пульсаров.
УДЕРЖИВАЙТЕ ЛКМ чтобы взорвать все активные Астральные Пульсары.
  
ПКМ: Астральный Остаток (5 энергии)
Устанавливаются энергетические тела, которые взрываются,
когда враги находятся поблизости, нанося физический урон.
У вас может быть не более 5 активных Астральных Остатков.
УДЕРЖИВАЙТЕ ПКМ чтобы зарядить и обновить продолжительность
всех активных Астральных Остатков.
]]

LANGUAGE["Item_Pheropod"] = [[Феропод]]
LANGUAGE["Item_Desc_Pheropod"] = [[
Только используется подклассом "Инкубатор"
Фероподы, которые могут вылупляться и управлять инопланетными муравьиными львами.

ЛКМ: Бросить капсулу
Кидает Феропод в цель, заставляя муравьиных львов совершать дальние атаки по цели.
Капсулы также исцеляют муравьиных львав на 5% здоровья.

ПКМ: Призыв муравьиного льва (40 энергии)
Призывает муравьиного льва, который следует за тобой повсюду. Исцеляйте муравьиного льва чтобы ускорить эволюцию.
УДЕРЖИВАЙТЕ ПКМ, чтобы заставить муравьиных львов переместиться в ваше местоположение.
Муравьиные львы получают новые эффекты в каждой стадии:
- Стадия I:
     - Импульс жука: Каждые 5 секунд, создает импульс, который исцеляет игроков вблизи на 5% здоровья.
- Стадия II:
     - Увеличено здоровье и урон.
	 - Увеличен радиус ароматического импульса и понижена перезарядка импульса жука.
	 - На 50% увеличено сопротивление к урону от яда.
- Стадия III:
     - Увеличено здоровье, урон и скорость атаки.
	 - Увеличен радиус ароматического импульса и понижена перезарядка импульса жука.
	 - Иммунитет к урону от яда и разрыва.
]]

LANGUAGE["Item_SMG1"] = [[SMG1]]
LANGUAGE["Item_Desc_SMG1"] = [[
Компактное, полностью автоматическое огнестрельное оружие.
Вооружено пусковой установкой M203.
]]

LANGUAGE["Item_Mac10"] = [[Mac10]]
LANGUAGE["Item_Desc_Mac10"] = [[
Корпорации Военного Вооружения модели 10.
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
MP5, пожалуй, самый универсальный пистолет-пулемёт в мире.
]]

LANGUAGE["Item_UMP45"] = [[UMP45]]
LANGUAGE["Item_Desc_UMP45"] = [[
KM UMP45.
Более лёгкий и дешёвый преемник MP5.
]]

LANGUAGE["Item_PP Bizon"] = [[PP Bizon]]
LANGUAGE["Item_Desc_PP Bizon"] = [[
ПП-19 Бизон.
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
Итальянское помповое ружьё 12-го калибра.
]]

LANGUAGE["Item_M870"] = [[M870]]
LANGUAGE["Item_Desc_M870"] = [[
Ружьё Remington 870.
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
Полностью автоматическое ружьё.
]]

LANGUAGE["Item_SPAS-12"] = [[SPAS-12]]
LANGUAGE["Item_Desc_SPAS-12"] = [[
Franchi SPAS-12.
Боевой дробовик производства итальянской оружейной компании Franchi.
]]

LANGUAGE["Item_Striker"] = [[Striker]]
LANGUAGE["Item_Desc_Striker"] = [[
Armsel Striker.
Ружьё 12-го калибра с вращающимся цилиндром из ЮАР.
]]

LANGUAGE["Item_AA12"] = [[AA12]]
LANGUAGE["Item_Desc_AA12"] = [[
Штурмовой дробовик Атчисона.
Разрушительная огневая мощь на близком и среднем расстоянии.
]]

LANGUAGE["Item_AR15"] = [[AR15]]
LANGUAGE["Item_Desc_AR15"] = [[
Винтовка AR-15 Style.
Лёгкая полуавтоматическая винтовка на основе конструкции ArmaLite AR-15.
]]

LANGUAGE["Item_M79 GL"] = [[M79 Г]]
LANGUAGE["Item_Desc_M79 GL"] = [[
M79 Гранатомёт
Стреляет 40х46мм гранатами, взрывающиеся при ударе.
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

LANGUAGE["Item_M240B"] = [[M240B]]
LANGUAGE["Item_Desc_M240B"] = [[
M240 Браво.
Стреляет боеприпасами НАТО калибра 7,62мм.
Оснащен Вооруженными Силами США.
]]

LANGUAGE["Item_L86 LSW"] = [[L86 LSW]]
LANGUAGE["Item_Desc_L86 LSW"] = [[
SA80 L86 LSW
Ручной пулемёт Буллпап.
]]

LANGUAGE["Item_GAU-19"] = [[GAU-19]]
LANGUAGE["Item_Desc_GAU-19"] = [[
GAU-19 роторный крупнокалиберный пулемёт.
Стреляет патроном .50 BMG со скоростью 1,300 выстрелов в минуту.
Удерживайте ПКМ чтобы крутить]]

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
Разработан для максимальной надёжности, долговечности и простоты.
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

LANGUAGE["Item_M16 M203"] = [[M16 M203]]
LANGUAGE["Item_Desc_M16 M203"] = [[
M16A4, оснащенный подствольным гранатометом M203
Дважды нажмите клавишу B или один раз клавишу масштабирования, чтобы оснастить M203.
]]

LANGUAGE["Item_SCAR-L"] = [[SCAR-L]]
LANGUAGE["Item_Desc_SCAR-L"] = [[
FN SCAR-L.
Штурмовая винтовка, разработанная бельгийским производителем FN Herstal.
Лёгкая версия, патронник 5.56x45мм НАТО.
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
Ручной пулемёт 5,56 × 45 мм НАТО, разработанный IWI.
]]

LANGUAGE["Item_M249"] = [[M249]]
LANGUAGE["Item_Desc_M249"] = [[
Ручной пулемёт М249.
Оружие поражения с газовым приводом и воздушным охлаждением.
]]

LANGUAGE["Item_MG4"] = [[MG4]]
LANGUAGE["Item_Desc_MG4"] = [[
Heckler & Koch MG4.
5,56-мм ручной пулемёт с ленточным питанием, пришедший на смену MG3.
]]


LANGUAGE["Item_Frag Grenade"] = [[Осколочная граната]]
LANGUAGE["Item_Desc_Frag Grenade"] = [[
Стандартная осколочная граната.
Подходит для сдерживания толпы.
]]

LANGUAGE["Item_Stun Grenade"] = [[Оглушающая граната]]
LANGUAGE["Item_Desc_Stun Grenade"] = [[
Наносит урон и оглушает врага на 3 секунды.
Время перезарядки оглушения составляет 10 секунд.
]]

LANGUAGE["Item_M67 Grenade"] = [[Граната М67]]
LANGUAGE["Item_Desc_M67 Grenade"] = [[
Осколочно-фугасная граната М67.
Военный класс, наносит крупный урон от взрыва.
]]

LANGUAGE["Item_Sticky Launcher"] = [[Липучкомёт]]
LANGUAGE["Item_Desc_Sticky Launcher"] = [[
Липучкомёт.]]

LANGUAGE["Item_M32 GL"] = [[М32 Г]]
LANGUAGE["Item_Desc_M32 GL"] = [[
Многозарядный гранатомет Milkor.
Лёгкий 40-мм шестизарядный револьверный гранатомет.
]]

LANGUAGE["Item_M72 LAW"] = [[M72 LAW]]
LANGUAGE["Item_Desc_M72 LAW"] = [[
Лёгкое противотанковое оружие M72.
Фокусируется на грубой разрушительной силе, а не на области действия.
]]

LANGUAGE["Item_Resistance RPG"] = [[РПУ]]
LANGUAGE["Item_Desc_Resistance RPG"] = [[
Ракетная Пусковая Установка с лазерным наведением.
]]

LANGUAGE["Item_RPG-7"] = [[РПГ-7]]
LANGUAGE["Item_Desc_RPG-7"] = [[
Ручной Противотанковый Гранатомет.
Противотанковая ракетная установка разработки Советского Союза.
]]

LANGUAGE["Item_SLAM"] = [[ВЛУБ]]
LANGUAGE["Item_Desc_SLAM"] = [[
Выбираемый Лёгкий Ударный Боеприпас.
ПКМ для взрыва. Прикрепите к стене чтобы активировать лазерный режим.
]]

LANGUAGE["Item_Incendiary Grenade"] = [[Зажигательная граната]]
LANGUAGE["Item_Desc_Incendiary Grenade"] = [[
Создаёт лужу огня после некоторой задержки.
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
Сторожевая башня, обеспечивающая пополнение боеприпасов.
Создаёт 1 боеприпас каждые 30 секунд.
(Класс сущности: horde_watchtower)
]]

LANGUAGE["Item_Spore Launcher"] = [[Пусковая установка для спор]]
LANGUAGE["Item_Desc_Spore Launcher"] = [[
Самодельное биологическое оружие.
Стреляет кислотными снарядами, которые взрываются после короткой задержки.
Исцеляет игроков и наносит урон врагам.
]]

LANGUAGE["Item_Medkit"] = [[Аптечка]]
LANGUAGE["Item_Desc_Medkit"] = [[
Перезаряжаемая аптечка.
ПКМ чтобы исцелять себя, ЛКМ чтобы исцелять других.
]]

LANGUAGE["Item_Health Vial"] = [[Флакон для здоровья]]
LANGUAGE["Item_Desc_Health Vial"] = [[
Капсула, наполненная липкой зеленой жидкостью.
Мгновенно лечит при поднятии.
]]

LANGUAGE["Item_Kevlar Armor Battery"] = [[Батарея кевларовой брони]]
LANGUAGE["Item_Desc_Kevlar Armor Battery"] = [[
Пластина брони.
Каждая дает по 15 брони. Только для личного пользования.
]]

LANGUAGE["Item_Full Kevlar Armor"] = [[Полная кевларовая броня]]
LANGUAGE["Item_Desc_Full Kevlar Armor"] = [[
Полный комплект кевларовой брони.
Заполняет 100% вашей брони.
]]

LANGUAGE["Item_Watchtower MKII"] = [[Сторожевая башня - Модель II]]
LANGUAGE["Item_Desc_Watchtower MKII"] = [[
Сторожевая башня, обеспечивающая пополнение припасов.
Создаёт 1 флакон для здоровья каждые 30 секунд.
(Entity Class: horde_watchtower_mk2)
]]

LANGUAGE["Item_Watchtower MKIII"] = [[Сторожевая башня - Модель III]]
LANGUAGE["Item_Desc_Watchtower MKIII"] = [[
Башня, отпугивающая врагов.
Бьёт током одного противника вблизи каждую секунду.
Наносит 80 урона от электричества.
(Entity Class: horde_watchtower_mk3)
]]

LANGUAGE["Item_Dual Glock17"] = [[Двойной Glock17]]
LANGUAGE["Item_Desc_Dual Glock17"] = [[
Двойной Glock 17.
Широко используется правоохранительными органами.
]]
LANGUAGE["Item_Dual M9"] = [[Двойной M9]]
LANGUAGE["Item_Desc_Dual M9"] = [[
Двойная Беретта М9
Огнестрельное оружие, используемое Вооруженными силами США.
]]

LANGUAGE["Item_Dual Deagle"] = [[Двойной Deagle]]
LANGUAGE["Item_Desc_Dual Deagle"] = [[
Двойной ночной ястреб .50С.
Культовый пистолет, которым трудно овладеть.
]]

LANGUAGE["Item_Winchester LAR"] = [[Винчестер ВРД]]
LANGUAGE["Item_Desc_Winchester LAR"] = [[
Винтовка Винчестерского рычажного действия.
Классика всех времен.
]]

LANGUAGE["Item_M200 Obrez"] = [[M200 Обрез]]
LANGUAGE["Item_Desc_M200 Obrez"] = [[
CheyTec M200 Интервенционный Обрез.
Американская снайперская винтовка с затвором.
Обрезанная версия для боя на средней дистанции.
]]

LANGUAGE["Item_SCAR-H"] = [[SCAR-H]]
LANGUAGE["Item_Desc_SCAR-H"] = [[
FN SCAR-H
Штурмовая винтовка, разработанная Белгийским производителем FN Herstal.
]]

LANGUAGE["Item_Barrett AMR"] = [[Барретт АМР]]
LANGUAGE["Item_Desc_Barrett AMR"] = [[
Противотанковая снайперская винтовка калибра .50
Наносит огромное количество баллистического урона.
]]

LANGUAGE["Item_Void Projector"] = [[Проектор Пустоты]]
LANGUAGE["Item_Desc_Void Projector"] = [[
Может использоваться только подклассом "Некромант".
Манипулирует тёмной энергией, вызывая гипотермию и вызывая сущности.

ЛКМ: Копье Пустоты (5/10/20 энергии)
Выпускает снаряд, который наносит урон от холода.
УДЕРЖИВАЙТЕ ЛКМ для получения различных эффектов.

ПКМ: Призыв призрака (40 энергии)
Призывает Призрака-миньона.
Призрак-миньон наносит физический урон и наносит нарастающее обморожение.
УДЕРЖИВАЙТЕ ПКМ, чтобы призвать призраков на свою сторону.
]]

LANGUAGE["Item_Solar Seal"] = [[Солнечная печать]]
LANGUAGE["Item_Desc_Solar Seal"] = [[
Может использоваться только подклассом "Артифайсер".
Манипулирует солнечной энергией, чтобы сеять разрушения.

ЛКМ: Солнечный шар (5/10/20 энергии)
Выпускает снаряд, который наносит урон от огня.
УДЕРЖИВАЙТЕ ЛКМ для получения различных эффектов.

ПКМ: Солнечная буря (5/10/20 энергии)
Выпускает мощный молниеносный удар по цели.
УДЕРЖИВАЙТЕ ПКМ для получения различных эффектов.
]]

LANGUAGE["Item_Hivehand"] = [[Рукоулей]]
LANGUAGE["Item_Desc_Hivehand"] = [[
Органическое оружие, используемое солдатами Ксена.
Имеет бесконечные патроны.
Первичный огонь создаёт самонаводящиеся рикошетирующие выстрелы.
Вторичный огонь быстро разряжает все оружие.
]]

LANGUAGE["Item_Trench Gun"] = [[Траншейное орудие]]
LANGUAGE["Item_Desc_Trench Gun"] = [[
Винчестер Модель 1200.
Стреляет зажигательными гранулами.
]]

LANGUAGE["Item_Incendiary Launcher"] = [[Зажигательная пусковая установка]]
LANGUAGE["Item_Desc_Incendiary Launcher"] = [[
Зажигательный гранатомёт.
Стреляет зажигательными гранатами, которые вспыхивают пламенем при ударе.
]]
LANGUAGE["Item_Molotov"] = [[Молотов]]
LANGUAGE["Item_Desc_Molotov"] = [[
Создаёт лужу огня при ударе.
Поджигает все в пределах своего действия.
]]

LANGUAGE["Item_Gluon Gun"] = [[Глюонная пушка]]
LANGUAGE["Item_Desc_Gluon Gun"] = [[
Квантовый дестабилизатор.
Экспериментальное оружие, которое стреляет разрушительным лазером.
]]

LANGUAGE["Item_M2 Flamethrower"] = [[Огнемет M2]]
LANGUAGE["Item_Desc_M2 Flamethrower"] = [[
Огнемет М2-2.
Американский переносной ранцевый огнемет.
]]

LANGUAGE["Item_Tau Cannon"] = [[Тау Пушка]]
LANGUAGE["Item_Desc_Tau Cannon"] = [[
Устройство использует электромагнетизм для ионизации частиц.
Удерживайте ПКМ для заряда и отпустите для мощного выстрела.
Наносит больше урона при заряде.
Устройство взрывается при избытке заряда.
]]

LANGUAGE["Item_MP7A1 Medic PDW"] = [[MP7A1 Medic PDW]]
LANGUAGE["Item_Desc_MP7A1 Medic PDW"] = [[
Модифицированная версия MP7A1 для медицинских целей.
Нажмите B или ZOOM для стрельбы лечащими дротиками.
Исцеляющий дротик перезаряжается каждую секунду.
]]

LANGUAGE["Item_Medic 9mm"] = [[Медицинский 9mm]]
LANGUAGE["Item_Desc_Medic 9mm"] = [[
Модифицированный 9мм который обеспечивает дальнее исцеление.
Нажмите B или ZOOM чтобы стрелять исцеляющими дротиками.
Исцеляющие дротики восстанавливаются каждую секунду.
]]

LANGUAGE["Item_Vector Medic PDW"] = [[Vector Medic PDW]]
LANGUAGE["Item_Desc_Vector Medic PDW"] = [[
KRISS Vector Gen I оснащённый средством запуска лечащих дротиков.
Использует необычную отдачу Vector, обеспечивающую высокую скорость срабатывания.
Нажмите B или ZOOM для стрельбы лечащими дротиками.
Лечащий дротик восстанавливается каждые 1.5 секунд.
]]

LANGUAGE["Item_Chainsaw"] = [[Бензопила]]
LANGUAGE["Item_Desc_Chainsaw"] = [[
Брррррррррррррррр.


Удерживайте ПКМ, чтобы распиливать врагов насквозь.
]]

LANGUAGE["Item_Mjollnir"] = [[Мьёльнир]]
LANGUAGE["Item_Desc_Mjollnir"] = [[
Боевой молот заряженный электрической энергией.
Нажмите ПКМ для заряда молота.
Заряженный Мьёльнир создаёт мощный электрический взрыв при ударе.
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
Вариант лёгкого пулемёта поддержки штурмовой винтовки AUG.
]]

LANGUAGE["Item_Manhack"] = [[Мэнхэк]]
LANGUAGE["Item_Desc_Manhack"] = [[
Мэнхэк регенирирует после смерти.
Мэнхэк наносит врагам урон своим здоровьем.
Мэнхэк умирает при ударе.
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
Отличительная броня Выжившего.
Заполняет 100% вашей брони.
Обеспечивает на 5% сопротивление к урону.
]]

LANGUAGE["Item_Assault Vest"] = [[Штурмовой жилет]]
LANGUAGE["Item_Desc_Assault Vest"] = [[
Отличительная броня Штурмовика.
Заполняет 100% вашей брони.
Обеспечивает на 8% устойчивость к Баллистическому урону.
]]

LANGUAGE["Item_Bulldozer Suit"] = [[Костюм бульдозериста]]
LANGUAGE["Item_Desc_Bulldozer Suit"] = [[
Отличительная броня Тяжеловеса.
Заполняет 125% вашей брони.
]]

LANGUAGE["Item_Hazmat Suit"] = [[Костюм Химзащиты]]
LANGUAGE["Item_Desc_Hazmat Suit"] = [[
Отличительная броня Медика.
Заполняет 100% вашей брони.
Обеспечивает на 8% устойчивость к урону от яда.
]]

LANGUAGE["Item_Bomb Suit"] = [[Противовзрывной костюм]]
LANGUAGE["Item_Desc_Bomb Suit"] = [[
Отличительная броня Подрывника.
Заполняет 100% вашей брони.
Обеспечивает на 8% устойчивость к урону от взрыва.
]]

LANGUAGE["Item_Assassin's Cloak"] = [[Плащ убийцы]]
LANGUAGE["Item_Desc_Assassin's Cloak"] = [[
Отличительная броня Призрака.
Заполняет 100% вашей брони.
Обеспечивает на 5% увеличенное уклонение.
]]

LANGUAGE["Item_Defense Matrix"] = [[Защитная Матрица]]
LANGUAGE["Item_Desc_Defense Matrix"] = [[
Отличительная броня Инженера.
Заполняет 100% вашей брони.
Обеспечивает на 5% устойчивость к урону.
]]

LANGUAGE["Item_Riot Armor"] = [[Броня для спецназа]]
LANGUAGE["Item_Desc_Riot Armor"] = [[
Отличительная броня Надзирателя.
Заполняет 100% вашей брони.
Обеспечивает на 8% устойчивость к урону от шока и звука.
]]

LANGUAGE["Item_Molten Armor"] = [[Расплавленная броня]]
LANGUAGE["Item_Desc_Molten Armor"] = [[
Отличительная броня Крематора.
Заполняет 100% вашей брони.
Обеспечивает на 8% устойчивость к урону от огня.
]]

LANGUAGE["Item_Battle Vest"] = [[Боевой Жилет]]
LANGUAGE["Item_Desc_Battle Vest"] = [[
Отличительная броня Берсеркера.
Заполняет 100% вашей брони.
Обеспечивает на 8% устойчивость к рубящему и тупому урону.
]]

-- Gadgets
LANGUAGE["Gadget_gadget_arctic_plating"] = [[Арктическое покрытие]]
LANGUAGE["Gadget_Desc_gadget_arctic_plating"] = [[
На 20% увеличена устойчивость к урону от холода.
]]

LANGUAGE["Gadget_gadget_blast_plating"] = [[Взрывное покрытие]]
LANGUAGE["Gadget_Desc_gadget_blast_plating"] = [[
На 20% увеличена устойчивость к урону от взрыва.
]]

LANGUAGE["Gadget_gadget_shock_plating"] = [[Противоударное покрытие]]
LANGUAGE["Gadget_Desc_gadget_shock_plating"] = [[
На 20% увеличена устойчивость к урону от электричества.
]]

LANGUAGE["Gadget_gadget_heat_plating"] = [[Термостойкое покрытие]]
LANGUAGE["Gadget_Desc_gadget_heat_plating"] = [[
На 20% увеличена устойчивость к урону от огня.
]]

LANGUAGE["Gadget_gadget_agility_shard"] = [[Осколок ловкости]]
LANGUAGE["Gadget_Desc_gadget_agility_shard"] = [[
На {1} увеличена скорость в течение 30 секунд.
]]

LANGUAGE["Gadget_gadget_damage_shard"] = [[Осколок урона]]
LANGUAGE["Gadget_Desc_gadget_damage_shard"] = [[
На {1} увеличен любой урон в течение 30 секунд.
]]

LANGUAGE["Gadget_gadget_vitality_shard"] = [[Осколок жизненных сил]]
LANGUAGE["Gadget_Desc_gadget_vitality_shard"] = [[
Восстанавливает {1} здоровья.
]]

LANGUAGE["Gadget_gadget_cleansing_shard"] = [[Очищающий осколок]]
LANGUAGE["Gadget_Desc_gadget_cleansing_shard"] = [[
Восстанавливает {1} единиц здоровья.
Снимает все эффекты статусов.
]]

LANGUAGE["Gadget_gadget_detoxifier"] = [[Детоксикатор]]
LANGUAGE["Gadget_Desc_gadget_detoxifier"] = [[
На 20% увеличена устойчивость к урону от яда.
]]

LANGUAGE["Gadget_gadget_diamond_plating"] = [[Алмазное покрытие]]
LANGUAGE["Gadget_Desc_gadget_diamond_plating"] = [[
На 15% увеличена устойчивость к физическому урону.
]]

LANGUAGE["Gadget_gadget_corporate_mindset"] = [[Корпоративное Мышление]]
LANGUAGE["Gadget_Desc_gadget_corporate_mindset"] = [[
"Устаналивать цели. Иметь десятилетний план. Вкладывать. 
Просыпаться рано. Мышление генерального директора."
Значительно увеличивает шанс выпадения жетонов черепа.
]]

LANGUAGE["Gadget_gadget_hellfire_tincture"] = [[Настойка адского огня]]
LANGUAGE["Gadget_Desc_gadget_hellfire_tincture"] = [[
Каждую секунду:
- Наносит вам урон 5% от вашего максимального здоровья.
- Наносит огненный урон по врагам вблизи 50% от вашего максимального здоровья.
]]

LANGUAGE["Gadget_gadget_hyperfusion"] = [[Гиперфузия]]
LANGUAGE["Gadget_Desc_gadget_hyperfusion"] = [[
Каждая инфузия на оружие предоставляет активную способность:
- Гемо:
- Пылающая: Вы обретаете пылающую ауру которая наносит урон вокруг вас.
- Арктическая: Наносит холодный урон врагам, которые атакуют вас.
- Гальванизированная: Враги взрываются при смерти, нанося электрический урон основанный на их здоровье.
- Септическая:
]]

LANGUAGE["Gadget_gadget_matriarch_womb"] = [[Матка матриарха]]
LANGUAGE["Gadget_Desc_gadget_matriarch_womb"] = [[
Создаст одного дружелюбного хедкраба при использовании.
Хедкраб умирает через 10 секунд.
]]

LANGUAGE["Gadget_gadget_metamorphosis"] = [[Метаморфоза]]
LANGUAGE["Gadget_Desc_gadget_metamorphosis"] = [[
Всякий раз, когда ваши миньоны убивают врага с мутацией,
Они получают эффект этой мутации в течение 10 секунд.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_cryo"] = [[Пушка для снарядов (Крио)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_cryo"] = [[
Стреляет стрелой, смоченной в холодном азоте.
Снаряд наносит 200 холодного урона.
Наносит обморожение при ударе.
]]

LANGUAGE["Gadget_gadget_unstable_injection"] = [[Нестабильная инъекция]]
LANGUAGE["Gadget_Desc_gadget_unstable_injection"] = [[
Даёт вам рандомный эффект из следующего:
- Восстанавливает 20% здоровья.
- Даёт 1 стак Адреналина/Гипертрофии.
- Даёт Укрепление/Берсерк/Спешку.
- Увеличивает накопление статуса распада на 30.
]]

LANGUAGE["Gadget_gadget_elixir"] = [[Эликсир]]
LANGUAGE["Gadget_Desc_gadget_elixir"] = [[
Восстанавливает 100% вашего здоровья.
Удаляет все эффекты статусов.
]]

LANGUAGE["Gadget_gadget_time_alter"] = [[Изменение времени]]
LANGUAGE["Gadget_Desc_gadget_time_alter"] = [[
Удваивает вашу скорость передвижения.
]]

LANGUAGE["Gadget_gadget_specimen_crystal_small"] = [[Образец кристалла (маленький)]]
LANGUAGE["Gadget_Desc_gadget_specimen_crystal_small"] = [[
Кристаллы жизни, образовавшиеся внутри образца.
Используйте, чтобы получить 200 золота.
]]

LANGUAGE["Gadget_gadget_specimen_crystal_medium"] = [[Образец кристалла (средний)]]
LANGUAGE["Gadget_Desc_gadget_specimen_crystal_medium"] = [[
Кристаллы умеренного размера, оставшиеся во вражеских останках.
Используйте, чтобы получить 500 золота.
]]

LANGUAGE["Gadget_gadget_specimen_crystal_large"] = [[Образец кристалла (большой)]]
LANGUAGE["Gadget_Desc_gadget_specimen_crystal_large"] = [[
Чрезвычайно ценные кристаллизованные материалы.
Используйте, чтобы получить 1000 золота.
]]


LANGUAGE["Gadget_gadget_sunder"] = [[Сандер]]
LANGUAGE["Gadget_Desc_gadget_sunder"] = [[
Заряжает себя огромной энергией.
При следующем ударе в ближнем бою:
- Наносит увеличенный на 50% урон цели.
- Наносит базовый урон от оружия всем остальным врагам на пути.
]]

LANGUAGE["Gadget_gadget_weakness_detector"] = [[Детектор слабости]]
LANGUAGE["Gadget_Desc_gadget_weakness_detector"] = [[
Выводит слабости врагов, если таковые имеются.
]]

-- Survivor Gadgets

LANGUAGE["Gadget_gadget_transcendance"] = [[Трансцендентность]]
LANGUAGE["Gadget_Desc_gadget_transcendance"] = [[
Иммунитет к урону.
Преобразует весь полученный вами урон в накопление некроза.
]]

LANGUAGE["Gadget_gadget_vitality_booster"] = [[Усилитель жизненных сил]]
LANGUAGE["Gadget_Desc_gadget_vitality_booster"] = [[
+{1} к максимуму здоровья.
]]

LANGUAGE["Gadget_gadget_damage_booster"] = [[Усилитель урона]]
LANGUAGE["Gadget_Desc_gadget_damage_booster"] = [[
На {1} увеличен любой урон.
]]

LANGUAGE["Gadget_gadget_resistance_booster"] = [[Усилитель сопротивления]]
LANGUAGE["Gadget_Desc_gadget_resistance_booster"] = [[
На {1} увеличено глобальное сопротивление к урону.
]]

LANGUAGE["Gadget_gadget_ultimate_booster"] = [[Предельный усилитель]]
LANGUAGE["Gadget_Desc_gadget_ultimate_booster"] = [[
На {1} увеличена скорость передвижения.
На {1} увеличено максимальное здоровье.
На {1} увеличен любой урон.
На {1} увеличено глобальное сопротивление к урону.
]]

-- Assault Gadgets
LANGUAGE["Gadget_gadget_iv_injection"] = [[Внутривенная Инъекция]]
LANGUAGE["Gadget_Desc_gadget_iv_injection"] = [[
Восстанавливается 25 единиц здоровья.
]]

LANGUAGE["Gadget_gadget_cortex"] = [[Кора головного мозга]]
LANGUAGE["Gadget_Desc_gadget_cortex"] = [[
За каждого врага рядом с вами получите 1 стак Адреналина.
Элитные враги предоставляют 2 стака.
]]

LANGUAGE["Gadget_gadget_neuro_amplifier"] = [[Нейроусилитель]]
LANGUAGE["Gadget_Desc_gadget_neuro_amplifier"] = [[
Адреналин увеличивает уклонение на 6 %.
]]

LANGUAGE["Gadget_gadget_ouroboros"] = [[Уроборос]]
LANGUAGE["Gadget_Desc_gadget_ouroboros"] = [[
Помощник по нервной системе Уроборос.
Убирает ограничения тела для повышения боевых возможностей.
Когда у вас более 50 % здоровья, вы теряете 1 здоровье в секунду.
Когда у вас меньше 50 % здоровья, вы получаете 2 здоровья в секунду.
За каждый потеряный 1% здоровья, урон увеличивается на 0.8%.
]]

LANGUAGE["Gadget_gadget_agility_booster"] = [[Усилитель ловкости]]
LANGUAGE["Gadget_Desc_gadget_agility_booster"] = [[
На {1} увеличена скорость передвижения.
]]

-- Heavy Gadgets
LANGUAGE["Gadget_gadget_energy_shield"] = [[Энергетический Щит]]
LANGUAGE["Gadget_Desc_gadget_energy_shield"] = [[
Временно даёт 25 ед. брони.
]]

LANGUAGE["Gadget_gadget_hardening_injection"] = [[Упрочняющая инъекция]]
LANGUAGE["Gadget_Desc_gadget_hardening_injection"] = [[
Скорость передвижения уменьшена на 50%.
На 25% повышена глобальная устойчивость к урону.
На 25% повышена устойчивость к физическому урону.
]]

LANGUAGE["Gadget_gadget_exoskeleton"] = [[Экзоскелет]]
LANGUAGE["Gadget_Desc_gadget_exoskeleton"] = [[
Использование активной способности активирует короткий буст.
Ты не можешь бежать.
Пассивно обеспечивает на 20% повышенную глобальную устойчивость к урону.
]]

LANGUAGE["Gadget_gadget_ulpa_filter"] = [[ВССП Фильтр]]
LANGUAGE["Gadget_Desc_gadget_ulpa_filter"] = [[
На 50% уменьшено накопление из всех источников, пока у вас есть броня.
Накопления также истощяют вашу броню.
]]

-- Medic Gadgets
LANGUAGE["Gadget_gadget_life_diffuser"] = [[Диффузор жизни]]
LANGUAGE["Gadget_Desc_gadget_life_diffuser"] = [[
Запускает импульс, который исцеляет ближайших игроков.
Исцеляет 20 ед. здоровья.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_heal"] = [[Пушка для снарядов (Лечащая)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_heal"] = [[
Стреляет химическим снарядом.
Снаряд наносит 75 урона от яда.
Снаряд лечит 25 ед. здоровья ближайшим игрокам.
]]

LANGUAGE["Gadget_gadget_healing_beam"] = [[Лечащий Луч]]
LANGUAGE["Gadget_Desc_gadget_healing_beam"] = [[
Соединяет лечащий Луч между игроком и целью.
Если целью является враг, забирает здоровье у цели.
Если целью является союзник, восстанавливает здоровье союзника.
]]

LANGUAGE["Gadget_gadget_steroid"] = [[Стероид]]
LANGUAGE["Gadget_Desc_gadget_steroid"] = [[
Усиливает ваше исцеление на 25%.
]]

-- Ghost Gadgets
LANGUAGE["Gadget_gadget_optical_camouflage"] = [[Оптический Камуфляж]]
LANGUAGE["Gadget_Desc_gadget_optical_camouflage"] = [[
Обеспечивает Маскировку на 5 секунд.
На 50% увеличено Уклонение во время Маскировки.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_ballistic"] = [[Пушка для снарядов (Баллистическая)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_ballistic"] = [[
Стреляет баллистическим снарядом.
Снаряд наносит 150 баллистического урона.
Оглушает врага при попадании.
]]

LANGUAGE["Gadget_gadget_death_mark"] = [[Чёрная Метка]]
LANGUAGE["Gadget_Desc_gadget_death_mark"] = [[
Ставит метку на выбранном враге.
Отмеченный враг получает на 15% больше урона.
Отмеченный враг взрывается при смерти, нанося урон, основанный на его здоровье.
Метка длится 10 секунд.
Вы можете отметить только 1 врага одновременно.
]]

LANGUAGE["Gadget_gadget_assassin_optics"] = [[Оптика убийцы]]
LANGUAGE["Gadget_Desc_gadget_assassin_optics"] = [[
Увеличивает ваш следующий баллистический урон на 25%.
Эффект заканчивается после нанесения урона врагу.
]]
-- Demolition Gadgets
LANGUAGE["Gadget_gadget_proximity_defense"] = [[Защита от близости]]
LANGUAGE["Gadget_Desc_gadget_proximity_defense"] = [[
Вызывает взрыв, который оглушает ближайших врагов.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_blast"] = [[Пушка для снарядов  (Взрывная)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_blast"] = [[
Стреляет Взрывным Снарядом.
Снаряд наносит 100 ед. урона от взрыва.
Создаёт 3 дополнительных взрыва после небольшой задержки.
]]

LANGUAGE["Gadget_gadget_nitrous_propellor"] = [[Азотистый Пропеллер]]
LANGUAGE["Gadget_Desc_gadget_nitrous_propellor"] = [[
Подталкивает вас вперед и вверх с помощью химического взрыва.
]]

LANGUAGE["Gadget_gadget_ied"] = [[СВУ]]
LANGUAGE["Gadget_Desc_gadget_ied"] = [[
Бросает на землю Самодельное Взрывное Устройство.
Самодельное взрывное устройство взрывается, когда враг оказывается в пределах досягаемости.
У вас есть 5 зарядов СВУ.
СВУ перезаряжается после детонации.
]]

LANGUAGE["Gadget_gadget_nuke"] = [[Ядерная бомба]]
LANGUAGE["Gadget_Desc_gadget_nuke"] = [[
Сбрасывает ядерную бомбу на местоположение цели после 10 секундной задержки.
Бомбардирует огромную территорию с многочисленными подземными толчками.

Оставляет позади радиоактивные отходы в течение 60 секунд.
]]

-- Engineer Gadgets
LANGUAGE["Gadget_gadget_displacer"] = [[Вытеснитель]]
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

LANGUAGE["Gadget_gadget_voidout"] = [[Пустотный щит]]
LANGUAGE["Gadget_Desc_gadget_voidout"] = [[
Позволяет вам поместить щит на миньона который сводит урон на нет полученный урон.
Щит взрывается при ударе, нанося урон от холода, равный 10% от здоровья миньона.
]]

LANGUAGE["Gadget_gadget_quantum_tunnel"] = [[Квантовый туннель]]
LANGUAGE["Gadget_Desc_gadget_quantum_tunnel"] = [[
Позволяет вам быстро отправиться на местоположение указанного миньона.
]]

-- Berserker Gadgets
LANGUAGE["Gadget_gadget_chakra"] = [[Чакра]]
LANGUAGE["Gadget_Desc_gadget_chakra"] = [[
Снимает все дебаффы и нарастания дебаффов.
Восстанавливает 10 единиц здоровья.
]]

LANGUAGE["Gadget_gadget_berserk_armor"] = [[Броня Берсерка]]
LANGUAGE["Gadget_Desc_gadget_berserk_armor"] = [[
Урон увеличен на 25%.
На 25% увеличена глобальная устойчивость к урону.
На 25% увеличена скорость передвижения.
]]

LANGUAGE["Gadget_gadget_flash"] = [[Флеш]]
LANGUAGE["Gadget_Desc_gadget_flash"] = [[
Бросается вперед, нанося {1} рубящего урона всем врагам на пути.
Обеспечивает короткую рамку неуязвимости.
]]

LANGUAGE["Gadget_gadget_aerial_guard"] = [[Воздушная защита]]
LANGUAGE["Gadget_Desc_gadget_aerial_guard"] = [[
Находясь в воздухе, получаете на 65% меньше физического урона.
]]

LANGUAGE["Gadget_gadget_hemocannon"] = [[Гемоцианин]]
LANGUAGE["Gadget_Desc_gadget_hemocannon"] = [[
Стреляет снарядом ценой 10 единиц здоровья.
Снаряд пролетает небольшое расстояние и взрывается.
Взрыв наносит 100 рубящего урона.
Имеет максимум 5 зарядов.
Перезаряжается через 5 секунд.
]]

-- Warden Gadgets
LANGUAGE["Gadget_gadget_solar_array"] = [[Солнечная батарея]]
LANGUAGE["Gadget_Desc_gadget_solar_array"] = [[
Роняет броневую батарею.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_shock"] = [[Пушка для снарядов (Шоковый)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_shock"] = [[
Стреляет магнитным снарядом, который пронзает врагов.
Создаёт ударную волну каждый раз, когда снаряд попадает во врага.
Ударная волна наносит 125 молния урона.
]]

LANGUAGE["Gadget_gadget_watchtower_pack"] = [[Комплект Сторожевых башен]]
LANGUAGE["Gadget_Desc_gadget_watchtower_pack"] = [[
Развертывает дополнительную сторожевую башню.
]]

LANGUAGE["Gadget_gadget_shock_nova"] = [[Шоковая Нова]]
LANGUAGE["Gadget_Desc_gadget_shock_nova"] = [[
Аура Надзирателя быстро создаёт серию шоковых волн.
Каждая шоковая волна наносит 50 электрического урона.
]]

-- Cremator Gadgets
LANGUAGE["Gadget_gadget_butane_can"] = [[Баллон с Бутаном]]
LANGUAGE["Gadget_Desc_gadget_butane_can"] = [[
Роняет Баллон с Бутаном, который взрывается при физическом воздействии.
Взрыв наносит 375 урона от огня.
За один раз можно кинуть только 1 Баллон.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_fire"] = [[Пушка для снарядов  (Огненный)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_fire"] = [[
Стреляет горящим снарядом.
Воспламеняет всех врагов, попавших в зону взрыва.
Наносит 20 урона Огнём.
]]

LANGUAGE["Gadget_gadget_barbeque"] = [[Барбекю]]
LANGUAGE["Gadget_Desc_gadget_barbeque"] = [[
Воспламененные враги, убитые вами, сбрасывают съедобные конечности.
Каждая конечность восстанавливает 5 единиц здоровья.
]]

LANGUAGE["Gadget_gadget_hydrogen_burner"] = [[Водородная горелка]]
LANGUAGE["Gadget_Desc_gadget_hydrogen_burner"] = [[
Синее пламя.
На 25% увеличен урон от огня.
Ваш урон от огня больше не воспламеняется.
]]