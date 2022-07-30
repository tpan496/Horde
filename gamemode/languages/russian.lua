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
LANGUAGE["Game_Next_Wave_Starts_In"] = "Следующая волна начнётся через %d"
LANGUAGE["Game_Difficulty_NORMAL"] = "СРЕДНИЙ"
LANGUAGE["Game_Difficulty_HARD"] = "СЛОЖНЫЙ"
LANGUAGE["Game_Difficulty_REALISM"] = "РЕАЛИСТИЧНЫЙ"
LANGUAGE["Game_Difficulty_NIGHTMARE"] = "КОШМАРНЫЙ"
LANGUAGE["Game_Difficulty_APOCALYPSE"] = "АПОКАЛИПСИС"
LANGUAGE["Game_Enemies"] = "Враги"
LANGUAGE["Game_HintBottomReady"] = "F2-Информация, F3-Магазин/Умение, F4-Готовность"
LANGUAGE["Game_HintBottom"] = "F2-Информация, F3-Магазин/Умение, V-Бросить деньги"
LANGUAGE["Game_Result_VICTORY"] = "ПОБЕДА!"
LANGUAGE["Game_Result_DEFEAT"] = "ПОРАЖЕНИЕ..."
LANGUAGE["Game_Result_Change Map"] = "Смена карты"
LANGUAGE["Game_Wave"] = "Волна"
LANGUAGE["Game_Wave_Has_Started"] = "Волна %d началась"
LANGUAGE["Game_Wave_Completed"] = "Волна пройдена"
LANGUAGE["Game_Remaining_Time"] = "Время"
LANGUAGE["Game_Vote_Map"] = "Голосование карты"
LANGUAGE["Game_Game_Summary"] = "Итог игры"
LANGUAGE["Game_Most_Damage_Dealt"] = "Макс. нанес. урон"
LANGUAGE["Game_X_Damage"] = "%s ед. урона нанесено"
LANGUAGE["Game_Most_Damage_Taken"] = "Макс. получ. урон"
LANGUAGE["Game_X_Damage_Taken"] = "%s ед. урона получено"
LANGUAGE["Game_Most_Kills"] = "Макс. убийств"
LANGUAGE["Game_X_Kills"] = "%s убито"
LANGUAGE["Game_Elite_Killer"] = "Убийца элитных"
LANGUAGE["Game_X_Elite_Kills"] = "%s элитных убито"
LANGUAGE["Game_SharpShooter"] = "Снайпер"
LANGUAGE["Game_X_Headshots"] = "%s выстр. в голову"
LANGUAGE["Game_Most_Heal"] = "Командный целитель"
LANGUAGE["Game_X_Healed"] = "%s ед. вылечено"
LANGUAGE["Game_X_Healed_You"] = "%s вылечил вас."


-- Ranks
LANGUAGE["Rank_Novice"] = "Новичок"
LANGUAGE["Rank_Amateur"] = "Любитель"
LANGUAGE["Rank_Skilled"] = "Опытный"
LANGUAGE["Rank_Professional"] = "Профессионал"
LANGUAGE["Rank_Expert"] = "Эксперт"
LANGUAGE["Rank_Champion"] = "Чемпион"
LANGUAGE["Rank_Master"] = "Мастер"
LANGUAGE["Rank_Not_Met"] = "Требование(-я) к рангу не выполнено"


-- Shop
-- Categories
LANGUAGE["Shop_Class"] = "Класс"
LANGUAGE["Shop_Cash"] = "Деньги"
LANGUAGE["Shop_Weight"] = "Вес"
LANGUAGE["Shop_Melee"] = "Ближний бой"
LANGUAGE["Shop_Pistol"] = "Пистолеты"
LANGUAGE["Shop_Shotgun"] = "Дробовики"
LANGUAGE["Shop_SMG"] = "ПП"
LANGUAGE["Shop_Rifle"] = "Винтовки"
LANGUAGE["Shop_MG"] = "Пулемёты"
LANGUAGE["Shop_Explosive"] = "Взрывчатки"
LANGUAGE["Shop_Special"] = "Особое"
LANGUAGE["Shop_Equipment"] = "Снаряжение"
LANGUAGE["Shop_Attachment"] = "Модули"
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
LANGUAGE["Shop_Unlocks_After_Wave"] = "Открывается после %d волны"
LANGUAGE["Shop_Sell_For"] = "Продать за %s$"
LANGUAGE["Shop_Sell_All_For"] = "Продать все за %s$"
LANGUAGE["Shop_Buy_Item"] = "Купить"
LANGUAGE["Shop_OWNED"] = "КУПЛЕНО"
LANGUAGE["Shop_Buy_Secondary_Ammo"] = "Купить доп. боезапас"
LANGUAGE["Shop_Primary_Ammo"] = "Основные боеприпасы"
LANGUAGE["Shop_Secondary_Ammo"] = "Доп. боеприпасы"

LANGUAGE["Chat_Message_Help_Notice"] = "ля помощь подоспела"

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

-- Subclasses
LANGUAGE["Subclass_Title_Survivor"] = LANGUAGE["Class_Survivor"]
LANGUAGE["Subclass_Title_Assault"] = LANGUAGE["Class_Assault"]
LANGUAGE["Subclass_Title_Heavy"] = LANGUAGE["Class_Heavy"]
LANGUAGE["Subclass_Title_Medic"] = LANGUAGE["Class_Medic"]
LANGUAGE["Subclass_Title_Demolition"] = LANGUAGE["Class_Demolition"]
LANGUAGE["Subclass_Title_Ghost"] = LANGUAGE["Class_Ghost"]
LANGUAGE["Subclass_Title_Engineer"] = LANGUAGE["Class_Engineer"]
LANGUAGE["Subclass_Title_Berserker"] = LANGUAGE["Class_Berserker"]
LANGUAGE["Subclass_Title_Warden"] = LANGUAGE["Class_Warden"]
LANGUAGE["Subclass_Title_Cremator"] = LANGUAGE["Class_Cremator"]

-- Gadgets
LANGUAGE["Gadget_Activation"] = "Нажмите T для активации."
LANGUAGE["Gadget_Cooldown"] = "Перезарядка"
LANGUAGE["Gadget_Duration"] = "Длительность"
LANGUAGE["Gadget_Owned_Warning"] = "Только 1 гаджет может быть ПРИОБРЕТЁН!"
LANGUAGE["Gadget_Seconds"] = "сек"

-- Default Class Extra Descriptions
LANGUAGE["Class_Description_Survivor"] = [[
Имеет доступ ко всему вооружению, кроме эксклюзивного и особого оружия.
Ограниченный доступ к модулям.]]

LANGUAGE["Class_Description_Assault"] = [[
Имеет полный доступ к автоматическим винтовкам.]]

LANGUAGE["Class_Description_Heavy"] = [[
Имеет полный доступ к тяжёлому вооружению.]]

LANGUAGE["Class_Description_Medic"] = [[
Имеет доступ к лёгкому вооружению и медицинскими инструментами.]]

LANGUAGE["Class_Description_Demolition"] = [[
Имеет полный доступ к взрывчатке.]]

LANGUAGE["Class_Description_Ghost"] = [[
Имеет доступ к снайперским винтовкам и некоторым лёгким вооружениям.
Имеет доступ к глушителям и снайперским прицелам.]]

LANGUAGE["Class_Description_Engineer"] = [[
Имеет доступ к специальному вооружению и снаряжению.]]

LANGUAGE["Class_Description_Berserker"] = [[
Имеет доступ только к ближнему бою.]]

LANGUAGE["Class_Description_Warden"] = [[
Имеет полный доступ к дробовикам и сторожевым вышкам (horde_watchtower).]]

LANGUAGE["Class_Description_Cremator"] = [[
Имеет полный доступ к поджигающему вооружению.]]


-- Default Base Perks
LANGUAGE["Perk_survivor_base"] = [[
Выживший может быть сыгран с любым классом, чтобы заполнить недостающие роли в команде.
Сложность: ЛЕГКО

Нет преимуществ.]]

LANGUAGE["Perk_assault_base"] = [[
Штурмовик - это универсальный боец с высокой мобильностью и упором на адреналин.
Сложность: ЛЕГКО

{1} увеличенная скорость передвижения. ({2} за уровень, до {3}).

Получает адреналин, когда убивает врага.
Адреналин увеличивает урон и скорость на {4}.]]

LANGUAGE["Perk_heavy_base"] = [[
Солдат - это класс танков, обеспечивающий мощную огневую мощь на подавление.
Сложность: ЛЕГКО

Регенерирует {1} ед. брони в секунду.
Регенерирует до {2} ед. брони. ({3} + {4} за уровень, до {5})]]

LANGUAGE["Perk_medic_base"] = [[
Медик - это класс поддержки, который специализируется на лечении и поддержке команды.
Сложность: СРЕДНЕ

Усиливает эффективность лечения на {1}. ({2} за уровень, до {3}).

Регенерирует {4} ед. здоровья в секунду.]]

LANGUAGE["Perk_demolition_base"] = [[
Подрывник - это класс контроля толпы, который также может наносить высокий урон по одной цели.
Сложность: СРЕДНЕ

{1} увеличенное сопротивление урону от взрыва. ({2} + {3} за уровень, до {4}).

Восстанавливает {5} осколочных гранат каждые {6} секунд, если у вас их нет.]]

LANGUAGE["Perk_ghost_base"] = [[
Призрак сосредоточен на уничтожении врагов-боссов с помощью камуфляжа.
Сложность: ТРУДНО

На {1} больше урона от выстрела в голову. ({2} за уровень, до {3}).

Пригнитесь, чтобы активировать камуфляж, дающий {4} уклонения.
Атака или бег СНИМАЮТ камуфляж.]]

LANGUAGE["Perk_engineer_base"] = [[
Инженер - это класс, ориентированный на использование построек, который наносит урон через различное постройки.
Сложность: СРЕДНЕ

{1} увеличенный урон построек. ({2} за уровень, до {3}).

Турели имеют {4} ед. базового здоровья и наносят {5} ед. базового урона.]]

LANGUAGE["Perk_berserker_base"] = [[
Берсерк - это класс, ориентированный на рукопашный бой, который может играть как в атаке, так и в обороне.
Сложность: ТРУДНО

{1} увеличенный колющий и тупой урон. ({2} за уровень, до {3}).
{4} общее сопротивление урону. ({5} за уровень, до {6}).

Парирование в воздухе: Прыжок уменьшает получаемый физический урон на {7}.]]

LANGUAGE["Perk_warden_base"] = [[
Надзиратель - это класс поддержки, который использует эффекты ауры и строения для усиления команды.
Сложность: СРЕДНЕ

{1} увеличенный радиус ауры надзирателя. ({2} за уровень, до {3}).

На игроков рядом с вами действует аура надзирателя.
Аура надзирателя блокирует {4} ед. урона.]]

LANGUAGE["Perk_cremator_base"] = [[
Крематор строит свою атаку и защиту вокруг урона от огня.
Сложность: ЛЕГКО

{1} увеличенное сопротивления урону от огня. ({2} + {3} за уровень, до {4}).

Атаки имеют {5} шанс поджечь врагов.
Базовая длительность воспламенения составляет {6} и наносит урон с течением времени, основанный на уроне от попадания.
Урон от огня имеет {7} шанс воспламенения врага.]]


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


LANGUAGE["Item_9mm"] = [[9-мм]]
LANGUAGE["Item_Desc_9mm"] = [[
Стандартное вооружение Альянса
]]

LANGUAGE["Item_357"] = [[357]]
LANGUAGE["Item_Desc_357"] = [[
Пистолет-магнум Colt python.
Используется охранниками Чёрной Мезы.
]]

LANGUAGE["Item_Glock"] = [[Glock]]
LANGUAGE["Item_Desc_Glock"] = [[
Glock 18.
Полуавтоматические пистолеты австрийского производства.
]]

LANGUAGE["Item_USP"] = [[USP]]
LANGUAGE["Item_Desc_USP"] = [[
Универсальный самозарядный пистолет.
Полуавтоматический пистолет, разработанный в германии компанией H&K.
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
Револьвер R8.
Выпускает высокоточный и мощный снаряд,
за счёт длительного нажатия на спусковой крючок.
]]

LANGUAGE["Item_Deagle"] = [[Deagle]]
LANGUAGE["Item_Desc_Deagle"] = [[
Desert Eagle 50 калибра.
Легендарный пистолет, который сложно освоить.
]]

LANGUAGE["Item_M1911"] = [[M1911]]
LANGUAGE["Item_Desc_M1911"] = [[
Colt M1911.
Стандартное личное оружие для вооружённых сил США.
]]

LANGUAGE["Item_FiveSeven"] = [[FiveSeven]]
LANGUAGE["Item_Desc_FiveSeven"] = [[
ES Five-seven.
Бельгийский полуавтоматический пистолет производства FN Herstal.
]]

LANGUAGE["Item_CZ75"] = [[CZ75]]
LANGUAGE["Item_Desc_CZ75"] = [[
CZ 75.
Полуавтоматический пистолет, произведённый в Чехии.
]]

LANGUAGE["Item_M9"] = [[M9]]
LANGUAGE["Item_Desc_M9"] = [[
Beretta M9.
Пистолет, используемый вооружёнными силами США.
]]

LANGUAGE["Item_Tec-9"] = [[Tec-9]]
LANGUAGE["Item_Desc_Tec-9"] = [[
Полуавтоматический пистолет шведского производства.
Смертельно опасен в непосредственной близости.
]]

LANGUAGE["Item_TMP"] = [[TMP]]
LANGUAGE["Item_Desc_TMP"] = [[
Steyr TMP.
Отборный огнестрельный пистолет-пулемёт калибра 9×19-мм Parabellum.
]]

LANGUAGE["Item_Flare Gun"] = [[Ракетница]]
LANGUAGE["Item_Desc_Flare Gun"] = [[
Ракетница фирмы Orion Safety.
Поджигает врагов и наносит урон огнём.
]]

LANGUAGE["Item_Anaconda"] = [[Anaconda]]
LANGUAGE["Item_Desc_Anaconda"] = [[
Colt Anaconda.
Под патрон .44 Magnum.
]]


LANGUAGE["Item_SMG1"] = [[SMG1]]
LANGUAGE["Item_Desc_SMG1"] = [[
Компактное, полностью автоматическое огнестрельное оружие.
]]

LANGUAGE["Item_Mac10"] = [[Mac10]]
LANGUAGE["Item_Desc_Mac10"] = [[
Military Armament Corporation модели 10.
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

LANGUAGE["Item_PP Bizon"] = [[ПП-19 «Бизон»]]
LANGUAGE["Item_Desc_PP Bizon"] = [[
ПП-19 «Бизон».
Предлагает магазин большой емкости, который быстро перезаряжается.
]]

LANGUAGE["Item_P90"] = [[P90]]
LANGUAGE["Item_Desc_P90"] = [[
ES C90.
Бельгийский пистолет-пулемёт булл-пап с магазином на 50 патронов.
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

LANGUAGE["Item_Trench Gun"] = [[Траншейное ружьё]]
LANGUAGE["Item_Desc_Trench Gun"] = [[
Винчестер модели 1200.
Стреляет зажигательными пулями.
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
Atchisson Assault Shotgun.
Разрушительная огневая мощь на близком и среднем расстоянии.
]]


LANGUAGE["Item_AR15"] = [[AR15]]
LANGUAGE["Item_Desc_AR15"] = [[
Винтовка AR-15 Style.
Лёгкая полуавтоматическая винтовка на основе конструкции ArmaLite AR-15.
]]

LANGUAGE["Item_FAMAS"] = [[FAMAS]]
LANGUAGE["Item_Desc_FAMAS"] = [[
Автомат FAMAS булл-пап.
Признан за его высокую скорострельность.
]]

LANGUAGE["Item_Galil"] = [[Galil]]
LANGUAGE["Item_Desc_Galil"] = [[
Galil ACE 22.
Разработано и изготовлено компанией IMI.
]]

LANGUAGE["Item_AK47"] = [[AK47]]
LANGUAGE["Item_Desc_AK47"] = [[
Автомат Калашникова.
Газовая штурмовая винтовка 7,62×39-мм, разработанная в Советском Союзе.
]]

LANGUAGE["Item_M4A1"] = [[M4A1]]
LANGUAGE["Item_Desc_M4A1"] = [[
Colt M4.
Газовый карабин НАТО 5.56×45-мм с воздушным охлаждением.
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

LANGUAGE["Item_G3"] = [[G3]]
LANGUAGE["Item_Desc_G3"] = [[
Боевая винтовка G3.
Боевая винтовка НАТО 7,62×51-мм с возможностью выбора огня, разработанная H&K.
]]

LANGUAGE["Item_Barret AMR"] = [[Barret AMR]]
LANGUAGE["Item_Desc_Barret AMR"] = [[
Снайперская винтовка 50 калибра.
Наносит огромный баллистический урон.
]]


LANGUAGE["Item_SSG08 Medic SR"] = [[Мед. винтовка SSG08]]
LANGUAGE["Item_Desc_SSG08 Medic SR"] = [[
Снайперская винтовка медика, стреляющая целебными дротиками.
Наносит урон врагам и лечит игроков.
]]

LANGUAGE["Item_Negev"] = [[Negev]]
LANGUAGE["Item_Desc_Negev"] = [[
IWI Negev.
Ручной пулемёт 5,56×45-мм НАТО, разработанный IWI.
]]

LANGUAGE["Item_M249"] = [[M249]]
LANGUAGE["Item_Desc_M249"] = [[
Ручной пулемёт М249.
Оружие массового поражения с газовым приводом и воздушным охлаждением.
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

LANGUAGE["Item_DamageResistance RPG"] = [[РПУ]]
LANGUAGE["Item_Desc_DamageResistance RPG"] = [[
Ракетная пусковая установка с лазерным наведением.
]]

LANGUAGE["Item_M79 GL"] = [[M79 GL]]
LANGUAGE["Item_Desc_M79 GL"] = [[
Гранатомёт M79.
Стреляет гранатами 40х46-мм, которые взрываются при попадании.
]]

LANGUAGE["Item_M32 GL"] = [[M32 GL]]
LANGUAGE["Item_Desc_M32 GL"] = [[
Многоствольный гранатомёт «Милкор».
Лёгкий 40-мм шестизарядный револьверный гранатомет.
]]

LANGUAGE["Item_RPG-7"] = [[РПГ-7]]
LANGUAGE["Item_Desc_RPG-7"] = [[
Ручной противотанковый гранатомет.
Противотанковая ракетная установка разработки Советского Союза.
]]

LANGUAGE["Item_SLAM"] = [[Портативная мина]]
LANGUAGE["Item_Desc_SLAM"] = [[
Многоцелевая малогабаритная мина.
ПКМ для взрыва. Прикрепите к стене для лазерного режима.
]]

LANGUAGE["Item_Incendiary Grenade"] = [[Зажигательная граната]]
LANGUAGE["Item_Desc_Incendiary Grenade"] = [[
Создаёт лужу огня после некоторой задержки.
Поджигает всё в пределах своего эффекта.
]]

LANGUAGE["Item_Molotov"] = [[Молотов]]
LANGUAGE["Item_Desc_Molotov"] = [[
Создаёт лужу огня после некоторой задержки.
Поджигает всё в пределах своего эффекта.
]]

LANGUAGE["Item_Incendiary Launcher"] = [[Зажигательный гранатомёт]]
LANGUAGE["Item_Desc_Incendiary Launcher"] = [[
Зажигательный гранатомёт.
Стреляет зажигательными гранатами, которые вспыхивают при попадании.
]]


LANGUAGE["Item_Heat Crossbow"] = [[Тепловой арбалет]]
LANGUAGE["Item_Desc_Heat Crossbow"] = [[
Самодельное снайперское оружие.
Стреляет обжигающей арматурой.
]]

LANGUAGE["Item_Turret"] = [[Турель]]
LANGUAGE["Item_Desc_Turret"] = [[
Наблюдающая турель Альянса.
Используется для охраны узких мест и жизненно важных участков.
]]

LANGUAGE["Item_Medic Grenade"] = [[Лечебная граната]]
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
Сторожевая башня, обеспечивающая пополнение боезапаса.
Создаёт 1 боезапас каждые 30 секунд.
(Класс энтити: horde_watchtower)
]]

LANGUAGE["Item_M2 Flamethrower"] = [[Огнемёт M2]]
LANGUAGE["Item_Desc_M2 Flamethrower"] = [[
Огнемёт M2-2.
Американский переносной ранцевый огнемёт.
]]


LANGUAGE["Item_Medkit"] = [[Аптечка]]
LANGUAGE["Item_Desc_Medkit"] = [[
Перезаряжаемая аптечка.
ПКМ - лечить себя, ЛКМ - лечить других.
]]

LANGUAGE["Item_Health Vial"] = [[Малая аптечка]]
LANGUAGE["Item_Desc_Health Vial"] = [[
Капсула наполнена липкой зелёной жидкостью.
Мгновенно лечит при поднятии.
]]

LANGUAGE["Item_Kevlar Armor Battery"] = [[Кевларовая пластина]]
LANGUAGE["Item_Desc_Kevlar Armor Battery"] = [[
Пластина брони.
Каждый дает 15 брони. Только для личного пользования.
]]

LANGUAGE["Item_Full Kevlar Armor"] = [[Полный комплект кевларовой брони]]
LANGUAGE["Item_Desc_Full Kevlar Armor"] = [[
Полный комплект кевларовой брони.
Пополняет 100% вашей брони.
]]

LANGUAGE["Item_Watchtower MKII"] = [[Сторожевая башня - Модель II]]
LANGUAGE["Item_Desc_Watchtower MKII"] = [[
Сторожевая башня обеспечивающая пополнение боеприпасов.
Создаёт 1 малую аптечку каждые 30 секунд.
(Класс энтити: horde_watchtower_mk2)
]]

LANGUAGE["Item_Watchtower MKIII"] = [[Сторожевая башня - Модель III]]
LANGUAGE["Item_Desc_Watchtower MKIII"] = [[
Башня, отпугивающая врагов.
Бьёт током каждого врага вблизи каждую секунду.
80 урона током.
(Класс энтити: horde_watchtower_mk3)
]]

LANGUAGE["Item_Tau Cannon"] = [[Тау-пушка]]
LANGUAGE["Item_Desc_Tau Cannon"] = [[
Устройство использует электромагнетизм для ионизации частиц.
Зажмите ПКМ для заряда и отпустите для мощного выстрела.
Наносит больше урона при заряде.
Устройство взрывается при избытке заряда.
]]

LANGUAGE["Item_MP7A1 Medic PDW"] = [[ПП медика MP7A1]]
LANGUAGE["Item_Desc_MP7A1 Medic PDW"] = [[
Модифицированный для медицинский задач MP7A1.

Зажмите B или ПРИБЛИЗИТЬ для стрельбы лечащими дротиками.
Лечащий дротик восстанавливается каждую секунду.
]]

LANGUAGE["Item_Vector Medic PDW"] = [[ПП медика KRISS Vector]]
LANGUAGE["Item_Desc_Vector Medic PDW"] = [[
KRISS Vector Gen I оснащённый средством запуска лечащих дротиков.
Использует необычную отдачу Vector, обеспечивающую высокую скорость срабатывания.

Зажмите B или ПРИБЛИЗИТЬ для стрельбы лечащими дротиками.
Лечащий дротик восстанавливается каждые 1,5 секунд.
]]

LANGUAGE["Item_Chainsaw"] = [[Бензопила]]
LANGUAGE["Item_Desc_Chainsaw"] = [[
Брррррррррррррррррррр

Зажмите ПКМ, чтобы прорезать путь сквозь врагов.
]]

LANGUAGE["Item_Mjollnir"] = [[Мьёльнир]]
LANGUAGE["Item_Desc_Mjollnir"] = [[
Боевой молот, заряженный электрической энергией.

Зажмите ПКМ для заряда молота.
Заряженный мьёльнир создаёт мощный электрический взрыв при ударе.
]]

LANGUAGE["Item_Double Barrel"] = [[Двустволка]]
LANGUAGE["Item_Desc_Double Barrel"] = [[
Двуствольный дробовик
Огромный урон на низком расстоянии.
]]

LANGUAGE["Item_FN FAL"] = [[FN FAL]]
LANGUAGE["Item_Desc_FN FAL"] = [[
FN FAL.
Автоматическая винтовка, разработанная в Бельгии и произведённая FN Herstal.
]]

LANGUAGE["Item_AUG HBAR"] = [[AUG HBAR]]
LANGUAGE["Item_Desc_AUG HBAR"] = [[
Steyr AUG HBAR.
Вариант лёгкого пулемёта поддержки штурмовой винтовки AUG.
]]

LANGUAGE["Item_Manhack"] = [[Мэнхэк]]
LANGUAGE["Item_Desc_Manhack"] = [[
Мэнхэк восстанавливается у вас в инвентаре после смерти.
Мэнхэк наносит врагам урон своим здоровьем.
Мэнхэк умирает при ударе.
]]

LANGUAGE["Item_Vortigaunt"] = [[Вортигонт]]
LANGUAGE["Item_Desc_Vortigaunt"] = [[
Зеновские вортигонты могут вызвать концентрированные взрывы шоковой энергии.
Энергетические взрывы имеют большую дальность действия и наносят урон по площади.
]]

LANGUAGE["Item_Combat Bot"] = [[Боевой робот]]
LANGUAGE["Item_Desc_Combat Bot"] = [[
Прочный гуманоидный робот, предназначенный для прямого столкновения с врагами.
Использует мощные атаки ближнего боя и дальние атаки валунами.
]]

LANGUAGE["Item_Advanced Kevlar Armor"] = [[Продвинутая кевларовая броня]]
LANGUAGE["Item_Desc_Advanced Kevlar Armor"] = [[
Наилучшая броня выжившего.

Пополняет 100% брони.
Увеличивает на 5% защиту от урона.
]]

LANGUAGE["Item_Assault Vest"] = [[Штурмовой жилет]]
LANGUAGE["Item_Desc_Assault Vest"] = [[
Наилучшая броня штурмовика.

Пополняет 100% брони.
Увеличивает на 8% защиту от пуль.
]]

LANGUAGE["Item_Bulldozer Suit"] = [[Костюм «Бульдозер»]]
LANGUAGE["Item_Desc_Bulldozer Suit"] = [[
Наилучшая тяжёлая броня.

Пополняет 125% брони.
]]

LANGUAGE["Item_Hazmat Suit"] = [[Костюм химзащиты]]
LANGUAGE["Item_Desc_Hazmat Suit"] = [[
Наилучшая броня медика.

Пополняет 100% брони.
Увеличивает на 8% защиту от яда.
]]

LANGUAGE["Item_Bomb Suit"] = [[Костюм подрывника]]
LANGUAGE["Item_Desc_Bomb Suit"] = [[
Наилучшая броня для сноса.

Пополняет 100% брони.
Увеличивает на 8% защиту от взрыва.
]]

LANGUAGE["Item_Assassin's Cloak"] = [[Плащ наёмника]]
LANGUAGE["Item_Desc_Assassin's Cloak"] = [[
Наилучшая броня призрака.

Пополняет 100% брони.
Увеличивает на 5% шанс уклонения.
]]

LANGUAGE["Item_Defense Matrix"] = [[Защитная матрица]]
LANGUAGE["Item_Desc_Defense Matrix"] = [[
Наилучшая броня инженера.

Пополняет 100% брони.
Увеличивает на 5% защиту от урона.
]]

LANGUAGE["Item_Riot Armor"] = [[Броня спецназовца]]
LANGUAGE["Item_Desc_Riot Armor"] = [[
Наилучшая броня надзирателя.

Пополняет 100% брони.
Увеличивает на 8% защиту от электрического и звукового урона.
]]

LANGUAGE["Item_Molten Armor"] = [[Литая броня]]
LANGUAGE["Item_Desc_Molten Armor"] = [[
Наилучшая броня крематора.

Пополняет 100% брони.
Увеличивает на 8% защиту от огня.
]]

LANGUAGE["Item_Battle Vest"] = [[Боевой жилет]]
LANGUAGE["Item_Desc_Battle Vest"] = [[
Наилучшая броня берсерка.

Пополняет 100% брони.
Увеличивает на 8% защиту от урона в ближнем бою.
]]

-- Gadgets
LANGUAGE["Gadget_gadget_blast_plating"] = [[Покрытие от взрывов]]
LANGUAGE["Gadget_Desc_gadget_blast_plating"] = [[
На 20% увеличена защита от взрыва.
]]

LANGUAGE["Gadget_gadget_shock_plating"] = [[Изоляционное покрытие]]
LANGUAGE["Gadget_Desc_gadget_shock_plating"] = [[
На 20% увеличена защита от электрического урона.
]]

LANGUAGE["Gadget_gadget_heat_plating"] = [[Термостойкое покрытие]]
LANGUAGE["Gadget_Desc_gadget_heat_plating"] = [[
На 20% увеличена защита от огня.
]]

LANGUAGE["Gadget_gadget_detoxifier"] = [[Детоксикатор]]
LANGUAGE["Gadget_Desc_gadget_detoxifier"] = [[
На 20% увеличена защита от яда.
]]

LANGUAGE["Gadget_gadget_diamond_plating"] = [[Алмазное покрытие]]
LANGUAGE["Gadget_Desc_gadget_diamond_plating"] = [[
На 15% увеличена защита от физического урона.
]]

LANGUAGE["Gadget_gadget_corporate_mindset"] = [[Корпоративное мышление]]
LANGUAGE["Gadget_Desc_gadget_corporate_mindset"] = [[
«Установить цели. Есть десятилетний план. Вложить. Просыпайся рано.
Мышление генерального директора».

Значительно увеличивает шанс выпадения жетонов черепа.
]]

-- Survivor Gadgets

LANGUAGE["Gadget_gadget_vitality_booster"] = [[Усилитель жизни]]
LANGUAGE["Gadget_Desc_gadget_vitality_booster"] = [[
+25 ед. к максимуму здоровья.
]]

LANGUAGE["Gadget_gadget_damage_booster"] = [[Усилитель урона]]
LANGUAGE["Gadget_Desc_gadget_damage_booster"] = [[
На 25% увеличен урон.
]]

-- Assault Gadgets
LANGUAGE["Gadget_gadget_iv_injection"] = [[Внутривенная инъекция]]
LANGUAGE["Gadget_Desc_iv_injection"] = [[
Восстанавливает 25 ед. здоровья.
]]

LANGUAGE["Gadget_gadget_cortex"] = [[Кора головного мозга]]
LANGUAGE["Gadget_Desc_gadget_cortex"] = [[
За каждого врага рядом с вами получите 1 шприц адреналина.
Элитные враги предоставляют 2 шприца.
]]

LANGUAGE["Gadget_gadget_neuro_amplifier"] = [[Нейроусилитель]]
LANGUAGE["Gadget_Desc_neuro_amplifier"] = [[
Адреналин увеличивает уклонение на 6%.
]]

LANGUAGE["Gadget_ouroboros"] = [[Уроборос]]
LANGUAGE["Gadget_Desc_ouroboros"] = [[
Помощник по нервной системе Уроборос.
Убирает ограничения тела для повышения боевых возможностей.

Когда у вас более 50% здоровья, вы теряете 1 ед. здоровья в секунду.
Когда у вас меньше 50% здоровья, вы получаете 2 ед. здоровья в секунду.
За каждый потерянный 1% здоровья, урон увеличивается на 0.8%.
]]

-- Heavy Gadgets
LANGUAGE["Gadget_gadget_energy_shield"] = [[Энергощит]]
LANGUAGE["Gadget_Desc_energy_shield"] = [[
Временно даёт 25 ед. здоровья.
]]

LANGUAGE["Gadget_gadget_hardening_injection"] = [[Закаливающая инъекция]]
LANGUAGE["Gadget_Desc_hardening_injection"] = [[
Скорость движения уменьшена на 50%.
На 25% увеличена вся сопротивляемость к урону.
На 25% повышена сопротивляемость к физическому урону.
]]

LANGUAGE["Gadget_exoskeleton"] = [[Экзоскелет]]
LANGUAGE["Gadget_Desc_exoskeleton"] = [[
Использование активной способности активирует короткое усиление.

Вы не сможете бегать.
Навсегда увеличивает на 20% сопротивляемость ко всем повреждениям.
]]

LANGUAGE["Gadget_t_virus"] = [[T-вирус]]
LANGUAGE["Gadget_Desc_t_virus"] = [[
Преобразует вашу броню в здоровье.
Нельзя преобразовать больше 250% здоровья.
]]

-- Medic Gadgets
LANGUAGE["Gadget_gadget_life_diffuser"] = [[Распылитель жизни]]
LANGUAGE["Gadget_Desc_gadget_life_diffuser"] = [[
Запускает импульс, который лечит близлежащих игроков.
Лечит 20 ед. здоровья.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_heal"] = [[Снарядная пушка (Лечащая)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_heal"] = [[
Стреляет химическим снарядом.
Снаряд наносит 75 ед. урона ядом.
Снаряд лечит 25 ед. здоровья близлежащих игроков.
]]

LANGUAGE["Gadget_healing_beam"] = [[Лечащий луч]]
LANGUAGE["Gadget_Desc_gadget_healing_beam"] = [[
Соединяет лечащий луч между пользователем и целью.
Если цель - враг, забирают здоровье у цели.
Если целью является союзник, восстанавливает здоровье союзника.
]]

-- Ghost Gadgets
LANGUAGE["Gadget_gadget_optical_camouflage"] = [[Оптический камуфляж]]
LANGUAGE["Gadget_Desc_optical_camouflage"] = [[
Обеспечивает маскировку на 5 секунд.
На 50% увеличено уклонение во время маскировки.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_ballistic"] = [[Снарядная пушка (Баллистическая)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_ballistic"] = [[
Стреляет баллистическим снарядом.
Снаряд наносит 150 ед. баллистического урона.
Оглушает врага при попадании.
]]

LANGUAGE["Gadget_death_mark"] = [[Метка смерти]]
LANGUAGE["Gadget_Desc_gadget_death_mark"] = [[
Накладывает метку на выбранном враге.
Враг с меткой получает на 15% больше урона.
Враг с меткой взрывается при смерти, нанося урон, основанный на его здоровье.
Метка длится 10 секунд.
Вы можете наложить метку только на 1 врага одновременно.
]]

LANGUAGE["Gadget_gunslinger"] = [[Ковбой]]
LANGUAGE["Gadget_Desc_gadget_gunslinger"] = [[
На 25% больше урона от пистолета.
На 25% больше урона от выстрела в голову из пистолета.
]]

-- Demolition Gadgets
LANGUAGE["Gadget_gadget_proximity_defense"] = [[Бесконтактная защита]]
LANGUAGE["Gadget_Desc_proximity_defense"] = [[
Вызывает взрыв, который оглушает ближайших врагов.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_blast"] = [[Снарядная пушка (Взрывная)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_blast"] = [[
Стреляет взрывным снарядом.
Снаряд наносит 100 ед. урона от взрыва.
Создаёт 3 дополнительных взрыва после небольшой задержки.
]]

LANGUAGE["Gadget_nitrous_propellor"] = [[Азотистый пропеллер]]
LANGUAGE["Gadget_Desc_gadget_nitrous_propellor"] = [[
Подталкивает вас вперёд и вверх с помощью химического взрыва.
]]

LANGUAGE["Gadget_ied"] = [[СВУ]]
LANGUAGE["Gadget_Desc_gadget_ied"] = [[
Бросает на землю самодельное взрывное устройство.
СВУ взрывается, когда враг приближается на расстояние выстрела.
У вас есть 5 зарядов СВУ.
СВУ перезаряжается после детонации.
]]

-- Engineer Gadgets
LANGUAGE["Gadget_displacer"] = [[Вытеснитель]]
LANGUAGE["Gadget_Desc_gadget_displacer"] = [[
Мгновенно перемещает выделенную постройку на вашу сторону.
]]

LANGUAGE["Gadget_gadget_turret_pack"] = [[Комплект турелей]]
LANGUAGE["Gadget_Desc_gadget_turret_pack"] = [[
Устанавливает временную турель.
У турели на 50% меньше здоровья.
Турель уничтожается по истечении срока действия.
]]

LANGUAGE["Gadget_gadget_e_parasite"] = [[Паразит-E]]
LANGUAGE["Gadget_Desc_gadget_e_parasite"] = [[
Проецирует капсулу с паразитами-E, которая заражает врагов при контакте.
Паразит-E на вашей стороне.
Паразит-E наносит непрерывный урон врагам.
Вы получаете здоровье от урона, нанесённого паразитом-E.
Враги, убитые будучи заражёнными паразитами-E, взрываются при смерти.
]]

-- Berserker Gadgets
LANGUAGE["Gadget_gadget_berserk_armor"] = [[Броня берсерка]]
LANGUAGE["Gadget_Desc_gadget_berserk_armor"] = [[
Урон увеличен на 25%.
На 25% увеличена общая сопротивляемость к урону.
На 25% увеличена скорость передвижения.
]]

LANGUAGE["Gadget_gadget_flash"] = [[Флэш]]
LANGUAGE["Gadget_Desc_flash"] = [[
Бросается вперёд, нанося 100 ед. рубящего урона всем врагам на пути.
Даёт короткий эффект неуязвимости.
]]

LANGUAGE["Gadget_gadget_aerial_guard"] = [[Воздушная защита]]
LANGUAGE["Gadget_Desc_aerial_guard"] = [[
Находясь в воздухе, получаете на 65% меньше физического урона.
]]

LANGUAGE["Gadget_gadget_hemocannon"] = [[Гемоцианин]]
LANGUAGE["Gadget_Desc_hemocannon"] = [[
Стреляет снарядом ценой 10 ед. здоровья.
Снаряд пролетает небольшое расстояние и взрывается.
Взрыв наносит 100 ед. режущего урона
Перезаряжается через 5 секунд.
]]

-- Warden Gadgets
LANGUAGE["Gadget_gadget_solar_array"] = [[Солнечная батарея]]
LANGUAGE["Gadget_Desc_gadget_solar_array"] = [[
Вырабатывает и сбрасывает аккумуляторы брони.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_shock"] = [[Снарядная пушка (Шоковая)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_shock"] = [[
Стреляет магнитным снарядом, который пронзает врагов.
Создаёт ударную волну каждый раз, когда снаряд попадает во врага.
Ударная волна наносит 125 ед. электрического урона.
]]

LANGUAGE["Gadget_watchtower_pack"] = [[Комплект сторожевых башен]]
LANGUAGE["Gadget_Desc_gadget_watchtower_pack"] = [[
Устанавливает дополнительную сторожевую башню.
]]

LANGUAGE["Gadget_shock_nova"] = [[Шоковая звезда]]
LANGUAGE["Gadget_Desc_gadget_shock_nova"] = [[
Аура надзирателя быстро создаёт серию шоковых волн.
Каждая шоковая волна наносит 50 ед. электрического урона.
]]

-- Cremator Gadgets
LANGUAGE["Gadget_gadget_butane_can"] = [[Баллон с бутаном]]
LANGUAGE["Gadget_Desc_gadget_butane_can"] = [[
Сбрасывает баллон с бутаном, который взрывается при физическом воздействии.
Взрыв наносит 375 ед. урона огнём.
За один раз можно сбросить только 1 баллон.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_fire"] = [[Снарядная пушка (Огненная)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_fire"] = [[
Стреляет горящим снарядом.
Воспламеняет всех врагов, попавших в зону взрыва.
Наносит 20 ед. урона огнём.
]]

LANGUAGE["Gadget_barbeque"] = [[Барбекю]]
LANGUAGE["Gadget_Desc_gadget_barbeque"] = [[
Из воспламенённых врагов, убитых вами, выпадают съедобные конечности.
Каждая конечность восстанавливает 5 ед. здоровья.
]]
