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

translate.AddLanguage("es-ES", "Spanish")

-- Game Info
LANGUAGE["Game_Ready"] = "Listo"
LANGUAGE["Game_Not Ready"] = "No Listo"
LANGUAGE["Game_Players_Ready"] = "Jugadores Listo"
LANGUAGE["Game_Next_Wave_Starts_In"] = "La Siguiente Oleada Empieza En %d"
LANGUAGE["Game_Difficulty_NORMAL"] = "NORMAL"
LANGUAGE["Game_Difficulty_HARD"] = "DIFICIL"
LANGUAGE["Game_Difficulty_REALISM"] = "REALISTA"
LANGUAGE["Game_Difficulty_NIGHTMARE"] = "PESADILLA"
LANGUAGE["Game_Enemies"] = "Enemigos"
LANGUAGE["Game_HintBottomReady"] = "F3 - Tienda/Habilidades, F4 - Listo"
LANGUAGE["Game_HintBottom"] = "F3 - Tienda/Habilidades, V - Soltar $"
LANGUAGE["Game_Result_VICTORY"] = "VICTORIA"
LANGUAGE["Game_Result_DEFEAT"] = "DERROTA"
LANGUAGE["Game_Result_Change Map"] = "Cambiar Mapa"
LANGUAGE["Game_Wave"] = "Oleada"
LANGUAGE["Game_Wave_Has_Started"] = "Oleada %d ha empezado"
LANGUAGE["Game_Wave_Completed"] = "Oleada Completada"
LANGUAGE["Game_Remaining_Time"] = "Tiempo Restante"
LANGUAGE["Game_Vote_Map"] = "Votar Mapa"
LANGUAGE["Game_Game_Summary"] = "Resumen de Partida"
LANGUAGE["Game_Most_Damage_Dealt"] = "Mayor Daño Hecho"
LANGUAGE["Game_Damage"] = "Daño"
LANGUAGE["Game_Most_Damage_Taken"] = "Mayor Daño Recibido"
LANGUAGE["Game_Damage_Taken"] = "Daño Recibido"
LANGUAGE["Game_Most_Kills"] = "Mas Asesinatos"
LANGUAGE["Game_Kills"] = "Asesinatos"
LANGUAGE["Game_Elite_Killer"] = "Asesino de Elites"
LANGUAGE["Game_Elite_Kills"] = "Asesinatos de Elite"
LANGUAGE["Game_SharpShooter"] = "Mejor Tirador/Punteria"
LANGUAGE["Game_Headshots"] = "Tiros a la Cabeza"
LANGUAGE["Game_Most_Heal"] = "Mas Ha Curado"
LANGUAGE["Game_Healed"] = "Curado"
LANGUAGE["Game_Healed_You"] = "Mas te has Curado"


-- Ranks
LANGUAGE["Rank_Novice"] = "Novato"
LANGUAGE["Rank_Amateur"] = "Principiante"
LANGUAGE["Rank_Skilled"] = "Habilidoso"
LANGUAGE["Rank_Professional"] = "Profesional"
LANGUAGE["Rank_Expert"] = "Experto"
LANGUAGE["Rank_Champion"] = "Campeon"
LANGUAGE["Rank_Master"] = "Maestro"

-- Shop
-- Categories
LANGUAGE["Shop_Class"] = "Clase"
LANGUAGE["Shop_Cash"] = "Dinero"
LANGUAGE["Shop_Weight"] = "Peso"
LANGUAGE["Shop_Melee"] = "Cuerpo a C."
LANGUAGE["Shop_Pistol"] = "Pistola"
LANGUAGE["Shop_Shotgun"] = "Escopeta"
LANGUAGE["Shop_SMG"] = "Subfusil"
LANGUAGE["Shop_Rifle"] = "Rifle"
LANGUAGE["Shop_MG"] = "Ametralladora"
LANGUAGE["Shop_Explosive"] = "Explosivos"
LANGUAGE["Shop_Special"] = "Especial"
LANGUAGE["Shop_Equipment"] = "Equipamiento"
LANGUAGE["Shop_Attachment"] = "Accesorios"

-- Attachments
LANGUAGE["Shop_Optic"] = "Miras"
LANGUAGE["Shop_Underbarrel"] = "Debajo del Cañon"
LANGUAGE["Shop_Tactical"] = "Tactico"
LANGUAGE["Shop_Barrel"] = "Cañon"
LANGUAGE["Shop_Muzzle"] = "Bocaza"
LANGUAGE["Shop_Magazine"] = "Cargador"
LANGUAGE["Shop_Stock"] = "Culata"
LANGUAGE["Shop_Ammo Type"] = "Tipo de Municion"
LANGUAGE["Shop_Perk"] = "Habilidades"

-- Class Panel
LANGUAGE["Shop_Class/Perks"] = "Clases/Habilidades"
LANGUAGE["Shop_Select_Class"] = "Elegir Clase (Tus Objetos seran Removidos)"
LANGUAGE["Shop_Show_Perks"] = "Mostrar Habilidades de Clase"
LANGUAGE["Shop_Hide_Perks"] = "Esconder Habilidades de Clase"
LANGUAGE["Shop_Unlocks_After_Wave"] = "Se desbloquea despues de la oleada %d"
LANGUAGE["Shop_Buy_Ammo_Clip"] = "Comprar Cargador"
LANGUAGE["Shop_Sell_For"] = "Vender por"
LANGUAGE["Shop_Sell_All_For"] = "Vender todo por"
LANGUAGE["Shop_Buy_Item"] = "Comprar objeto"
LANGUAGE["Shop_OWNED"] = "ADQUIRIDO"
LANGUAGE["Shop_Buy_Secondary_Ammo"] = "Comprar Municion Secundaria"
LANGUAGE["Shop_Primary_Ammo"] = "Municion Primaria"
LANGUAGE["Shop_Secondary_Ammo"] = "Municion Secundaria"


-- Classes
LANGUAGE["Class_Survivor"] = "Superviviente"
LANGUAGE["Class_Assault"] = "Asalto"
LANGUAGE["Class_Heavy"] = "Pesado"
LANGUAGE["Class_Medic"] = "Medico"
LANGUAGE["Class_Demolition"] = "Demolicion"
LANGUAGE["Class_Ghost"] = "Ghost"
LANGUAGE["Class_Engineer"] = "Engineer"
LANGUAGE["Class_Berserker"] = "Berserker"
LANGUAGE["Class_Warden"] = "Warden"

-- Default Class Extra Descriptions
LANGUAGE["Class_Description_Survivor"] = [[
Tiene acceso a todas las armas excepto por armas exclusivas y especiales.
Acceso limitado a los accesorios.]]

LANGUAGE["Class_Description_Assault"] = [[
Tiene entero acceso a Rifles de Asalto.]]

LANGUAGE["Class_Description_Heavy"] = [[
Tiene entero acceso a Metralladoras Pesadas y armas de alto peso.]]

LANGUAGE["Class_Description_Medic"] = [[
Tiene acceso a las armas mas ligeras y herramientas medicas.]]

LANGUAGE["Class_Description_Demolition"] = [[
Tiene entero acceso a armas explosivas.]]

LANGUAGE["Class_Description_Ghost"] = [[
Tiene acceso a rifles de Tirador y la mayoria de armas ligeras.
Tiene acceso a silenciadores y miras telescopicas.]]

LANGUAGE["Class_Description_Engineer"] = [[
Tiene acceso a equipamiento y armas especiales.]]

LANGUAGE["Class_Description_Berserker"] = [[
Solo tiene acceso a armas Cuerpo a Cuerpo.]]


-- Default Base Perks
LANGUAGE.Perk_survivor_base = [[
La clase Superviviente puede ser jugada como cualquier otra clase para rellenar los roles faltantes para el equipo.
Dificultad: FACIL
Sin bonus.]]

LANGUAGE.Perk_assault_base = [[
La clase Asalto es un todo-tipo luchador con alta mobilidad y se concentra en Cargas de Adrenalina.
Dificultad: FACIL
{1} Velocidad de movimiento alta.
Gana una Carga de Adrenalina cuando matas a un enemigo Adrenaline when you kill an enemy.
Las Cargas de Adrenalina incrementan tu daño y velocidad por {2}.]]

LANGUAGE.Perk_heavy_base = [[
La clase Pesado es una clase de resistencia que provee una fuerte potencia de fuego.
Dificultad: FACIL
Añade {1} a la cantidad maxima de Peso.
Regenera {2} de armadura por segundo.
Regenera hasta {3} de armadura.]]

LANGUAGE.Perk_medic_base = [[
La clase Medico es una clase de soporte resistente que se concentra en ayudar y curar compañeros.
Dificultad: MEDIA
Regenera {1} de vida por segundo.]]

LANGUAGE.Perk_demolition_base = [[
La clase Demolicion es un controlador de masas que tambien puede proveer altas cantidades de daño a un solo objetivo.
Dificultad: MEDIA
{1} la resistencia a las explosiones.
Regenera {2} granadas cada {3} segundos, si no tienes una.]]

LANGUAGE.Perk_ghost_base = [[
La Clase Ghost se concentra en matar a jefes enemigos usando Camuflaje.
Dificultad: ALTA
{1} mas daño a la cabeza.
Agachate para activar Camuflaje, dando un {2} de evasion.
Atacar, Correr o Saltar REMUEVE Camuflaje.]]

LANGUAGE.Perk_engineer_base = [[
La Clase Ingeniero es una clase que se concentra en hacer daño con estructuras a su favor.
Dificultad: MEDIA
{1} vida y daño de estructuras.
Las Torretas tienen {2} de vida base y realiza {3} de daño base.]]

LANGUAGE.Perk_berserker_base = [[
La Clase Berserker se concentra en combate Cuerpo a C. que puede ser usado tanto a la ofensiva como a la defensiva.
Dificultad: ALTA
{1} resistencia al daño en General.
{2} resistencia al daño por Veneno.]]


-- Default Perks: Survivor
LANGUAGE["Perk_Title_Survivor_Tier_1"] = [[Supervivencia]]
LANGUAGE["Perk_Title_Survivor_Tier_2"] = [[Improvisar]]
LANGUAGE["Perk_Title_Survivor_Tier_3"] = [[Aprendimiento Inspirado]]

-- Default Perks: Assault
LANGUAGE["Perk_Title_Assault_Tier_1"] = [[Manejamiento]]
LANGUAGE["Perk_Title_assault_ambush"] = [[Emboscada]]
LANGUAGE["Perk_assault_ambush"] = [[
{1} daño a la cabeza.]]

LANGUAGE["Perk_Title_assault_charge"] = [[Carga]]
LANGUAGE["Perk_assault_charge"] = [[
Añade {1} cargas maximas de Adrenalina.
(Cada Carga de Adrenalina aumenta el daño y velocidad por {2}.)]]

LANGUAGE["Perk_Title_Assault_Tier_2"] = [[Adaptamiento]]
LANGUAGE["Perk_Title_assault_drain"] = [[Apuro]]
LANGUAGE["Perk_assault_drain"] = [[
{1} daño a la cabeza cuando se mantiene la vida al maximo.
Recupera {2} de vida por cada enemigo que hayas matado.]]

LANGUAGE["Perk_Title_assault_overclock"] = [[Sobrecarga]]
LANGUAGE["Perk_assault_overclock"] = [[
Duracion de la Adrenalina aumentada por {1}.
Añade {2} cargas maximas de Adrenalina.]]

LANGUAGE["Perk_Title_Assault_Tier_3"] = [[Acondicionante]]
LANGUAGE["Perk_Title_assault_heightened_reflex"] = [[Reflejos de Punta]]
LANGUAGE["Perk_assault_heightened_reflex"] = [[
{1} daño a la cabeza.
{2} resistencia global mientras se conserva la vida maxima.]]

LANGUAGE["Perk_Title_assault_cardiac_overload"] = [[Sobrecarga Cardiaca]]
LANGUAGE["Perk_assault_cardiac_overload"] = [[
{1} chance de añadir 1 Carga de Adrenalina al dar un tiro a la cabeza.
Añade {2} cargas maximas de Adrenalina.]]

-- Default Perks: Heavy
LANGUAGE["Perk_Title_Heavy_Tier_1"] = [[Supresion]]
LANGUAGE["Perk_Title_heavy_sticky_compound"] = [[Material Pegajoso]]
LANGUAGE["Perk_heavy_sticky_compound"] = [[
Los enemigos disparados con daño Balistico son ralentizados.
Enemigos ralentizados tienen {1} de velocidad de accion menos.]]

LANGUAGE["Perk_Title_heavy_crude_casing"] = [[Carcasa Cruda]]
LANGUAGE["Perk_heavy_crude_casing"] = [[
Enemigos que tu dispares con daño Balistico son debilitados.
Enemigos debilitados realizan un {1} de daño reducido.
Enemigos debilitados reciben un {2} de daño aumentado.]]

LANGUAGE["Perk_Title_Heavy_Tier_2"] = [[Armadura Acorazada]]
LANGUAGE["Perk_Title_heavy_liquid_armor"] = [[Armadura Liquida]]
LANGUAGE["Perk_heavy_liquid_armor"] = [[
Mientras tengas al menos {1} de armadura:
  {2} de resistencia al daño Fisico.]]

LANGUAGE["Perk_Title_heavy_reactive_armor"] = [[Armadura Reactiva]]
LANGUAGE["Perk_heavy_reactive_armor"] = [[
Mientras tengas al menos{1} de armadura:\
  Inmune al daño de Veneno,Fuego y Explosion.]]

LANGUAGE["Perk_Title_Heavy_Tier_3"] = [[Tecnologia]]
LANGUAGE["Perk_Title_heavy_nanomachine"] = [[Nanomaquina]]
LANGUAGE["Perk_heavy_nanomachine"] = [[
{1} de velocidad de regeneracion de armadura.
Ahora puedes regenerar hasta {2} armadura.]]

LANGUAGE["Perk_Title_heavy_ballistic_shock"] = [[Choque Balistico]]
LANGUAGE["Perk_heavy_ballistic_shock"] = [[
Debuffs que tu apliques tendran {1} mas de efecto.
Debuffs que tu apliques tendran {2} mas de duracion.]]

-- Default Perks: Medic
LANGUAGE["Perk_Title_Medic_Tier_1"] = [[Medicina]]
LANGUAGE["Perk_Title_medic_antibiotics"] = [[Antibioticos]]
LANGUAGE["Perk_medic_antibiotics"] = [[
Tu efecto de curacion se amplifica por un {1}.]]

LANGUAGE["Perk_Title_medic_painkillers"] = [[Painkillers]]
LANGUAGE["Perk_medic_painkillers"] = [[
Podes sobrecurar la vida de un jugador por un {1}.]]

LANGUAGE["Perk_Title_Medic_Tier_2"] = [[Bio-Ingenieria]]
LANGUAGE["Perk_Title_medic_berserk"] = [[Berserk]]
LANGUAGE["Perk_medic_berserk"] = [[
Jugadores que tu cures tendran Berserk por {1} segundos.
{2} mas de daño y velocidad mientras tengas Berserk.]]

LANGUAGE["Perk_Title_medic_fortify"] = [[Fortificado]]
LANGUAGE["Perk_medic_fortify"] = [[
Jugadores que tu cures tendran Fortificado por {1} segundos.
{2} resistencia de daño mientras tengas Fortificado.]]

LANGUAGE["Perk_Title_Medic_Tier_3"] = [[Seleccion Natural]]
LANGUAGE["Perk_Title_medic_cellular_implosion"] = [[Implosion Celular]]
LANGUAGE["Perk_medic_cellular_implosion"] = [[
Enemigos que tu mates tienen un {1} posibilidad de generar una nube de curacion.]]

LANGUAGE["Perk_Title_medic_xcele"] = [[Factor de Curacion Acelerada]]
LANGUAGE["Perk_medic_xcele"] = [[
{1} mas de regeneracion de vida por segundo.
Buffs que tu apliques seran un {2} mas efectivo.]]

-- Default Perks: Demolition
LANGUAGE["Perk_Title_Demolition_Tier_1"] = [[Granada]]
LANGUAGE["Perk_Title_demolition_frag_impact"] = [[Granada de Impacto]]
LANGUAGE["Perk_demolition_frag_impact"] = [[
Granadas explotan al impacto contra un enemigo.
Daño de la Granada aumentado un {1}.]]

LANGUAGE["Perk_Title_demolition_frag_cluster"] = [[Granada en Racimo]]
LANGUAGE["Perk_demolition_frag_cluster"] = [[
Granadas y SLAMs crean {1} mini-granadas en la detonacion.
Las mini-granadas hacen un {2} menos de daño.]]

LANGUAGE["Perk_Title_Demolition_Tier_2"] = [[Enfoque]]
LANGUAGE["Perk_Title_demolition_fragmentation"] = [[Fragmentacion]]
LANGUAGE["Perk_demolition_fragmentation"] = [[
{1} Mas daño explosivo contra enemigos con la vida completa.]]

LANGUAGE["Perk_Title_demolition_napalm"] = [[Napalm]]
LANGUAGE["Perk_demolition_napalm"] = [[
{1} Aumento de daño por Fuego.
{2} Aumento de resistencia al daño por fuego.
]]

LANGUAGE["Perk_Title_Demolition_Tier_3"] = [[Destruccion]]
LANGUAGE["Perk_Title_demolition_pressurized_warhead"] = [[Ojiva Presurizada]]
LANGUAGE["Perk_demolition_pressurized_warhead"] = [[
{1} Aumento de daño por explosion contra Elites.
Explosiones hacen un {2} de la cantidad de vida de los enemigos como extra daño explosivo.]]

LANGUAGE["Perk_Title_demolition_chain_reaction"] = [[Reaccion en Cadena]]
LANGUAGE["Perk_demolition_chain_reaction"] = [[
Enemigos que mates tendran un {1} de chance de explotar,
realizando un {2} de su vida maxima como daño explosivo.]]

-- Default Perks: Ghost
LANGUAGE["Perk_Title_Ghost_Tier_1"] = [[Tacticas]]
LANGUAGE["Perk_Title_ghost_headhunter"] = [[Cazador de Cabezas]]
LANGUAGE["Perk_ghost_headhunter"] = [[
El Daño por tiro a la cabeza se apila hasta 5 veces.
Cada carga de Cazador de Cabezas aumenta un 8% el daño por tiro a la cabeza.]]

LANGUAGE["Perk_Title_ghost_sniper"] = [[Francotirador]]
LANGUAGE["Perk_ghost_sniper"] = [[
25% aumento de daño Balistico mientras estas agachado.]]

LANGUAGE["Perk_Title_Ghost_Tier_2"] = [[Reposicion]]
LANGUAGE["Perk_Title_ghost_phase_walk"] = [[Caminata de Fase]]
LANGUAGE["Perk_ghost_phase_walk"] = [[
Correr/Saltar ya no cancela el Camuflaje.
25% aumento de velocidad de movimiento mientras tengas Camuflaje.]]

LANGUAGE["Perk_Title_ghost_ghost_veil"] = [[Velo de Fantasma]]
LANGUAGE["Perk_ghost_ghost_veil"] = [[
Atacar no cancela el Camuflaje.
100% Aumento de velocidad de activacion del Camuflaje.]]

LANGUAGE["Perk_Title_Ghost_Tier_3"] = [[Disposal]]
LANGUAGE["Perk_Title_ghost_coup"] = [[Coup De Grace]]
LANGUAGE["Perk_ghost_coup"] = [[
Mata Instantaneamente a enemigos con menos del 20% de su vida.]]

LANGUAGE["Perk_Title_ghost_decapitate"] = [[Decapitate]]
LANGUAGE["Perk_ghost_decapitate"] = [[
Cuando tienes Camuflaje:
  25% Aumento de daño Balistico.
  50% Aumento de daño por tiro a la cabeza contra elites.]]

-- Default Perks: Engineer
LANGUAGE["Perk_Title_Engineer_Tier_1"] = [[Artesania]]
LANGUAGE["Perk_Title_engineer_tinkerer"] = [[Chapucero]]
LANGUAGE["Perk_engineer_tinkerer"] = [[
Construcciones tienen un {1} mas de vida al aparecer.]]

LANGUAGE["Perk_Title_engineer_manhack"] = [[Manhack]]
LANGUAGE["Perk_engineer_manhack"] = [[
Tienes Manhacks en vez de Torretas.
Los Manhack mueren al impacto y reaparecen automaticamente.
Los Manhack hacen daño segun su vida.]]

LANGUAGE["Perk_Title_Engineer_Tier_2"] = [[Arquetipo]]
LANGUAGE["Perk_Title_engineer_golem"] = [[Golem]]
LANGUAGE["Perk_engineer_golem"] = [[
Las Construcciones regeneran {1} de vida por segundo.
Los ataques de las Construcciones tiene retroceso incrementado.]]

LANGUAGE["Perk_Title_engineer_spectre"] = [[Espectro]]
LANGUAGE["Perk_engineer_spectre"] = [[
Las Construcciones roban un {1} de vida del daño hecho.
Las Construcciones hacen un {2} mas de daño.]]

LANGUAGE["Perk_Title_Engineer_Tier_3"] = [[Experimental]]
LANGUAGE["Perk_Title_engineer_symbiosis"] = [[Simbiosis]]
LANGUAGE["Perk_engineer_symbiosis"] = [[
Las Construcciones tienen un {1} mas de vida al aparecer.
{2} Disminucion de daño recibido por cada Construccion viva.]]

LANGUAGE["Perk_Title_engineer_kamikaze"] = [[Kamikaze]]
LANGUAGE["Perk_engineer_kamikaze"] = [[
Las Consturcciones realizan un {1} de su vida maxima como daño explosivo en la muerte.]]

-- Default Perks: Berserker
LANGUAGE["Perk_Title_Berserker_Tier_1"] = [[Fundamentos]]
LANGUAGE["Perk_Title_berserker_breathing_technique"] = [[Tecnica de Respiracion]]
LANGUAGE["Perk_berserker_breathing_technique"] = [[
Regeneras {1} de vida por segundo.
Inmune al daño por Veneno.]]

LANGUAGE["Perk_Title_berserker_bloodlust"] = [[Sed de Sangre]]
LANGUAGE["Perk_berserker_bloodlust"] = [[
Roba un {1} de vida por el daño cuerpo a cuerpo hecho.
Robo de Vida esta limitado hasta un {2} de vida por golpe.]]

LANGUAGE["Perk_Title_Berserker_Tier_2"] = [[Tecnica]]
LANGUAGE["Perk_Title_berserker_bushido"] = [[Bushido]]
LANGUAGE["Perk_berserker_bushido"] = [[
Aumenta un {1} el daño Cortante.
Aumenta un {2} la velocidad de movimiento.]]

LANGUAGE["Perk_Title_berserker_savagery"] = [[Salvajeria]]
LANGUAGE["Perk_berserker_savagery"] = [[
Aumenta un {1} el daño por golpear.
Aumenta un {2} la vida maxima.]]

LANGUAGE["Perk_Title_Berserker_Tier_3"] = [[Artes de Combate]]
LANGUAGE["Perk_Title_berserker_mindeye"] = [[Ojo de la Mente]]
LANGUAGE["Perk_berserker_mindeye"] = [[
Cada golpe cuerpo a cuerpo aumenta una carga de "Ojo de la Mente" hasta {1}.
Cada carga aumenta un {2} la evasion y {3} el daño cuerpo a cuerpo.
Pierdes todas las cargas si eres golpeado o sobrepasas el limite de las cargas maximas.]]

LANGUAGE["Perk_Title_berserker_rip_and_tear"] = [[Rasgar y Desgarrar]]
LANGUAGE["Perk_berserker_rip_and_tear"] = [[
Aumenta un {1} el daño cuerpo a cuerpo.
Tus golpes cuerpo a cuerpo pueden salpicar.
Daño de salpicadura tiene un {2} de tu daño cuerpo a cuerpo normal.]]


-- Default Config Shop Items
-- Optional
LANGUAGE["Item_Stunstick"] = [[Stunstick]]
LANGUAGE["Item_Desc_Stunstick"] = [[
Baston electrico.
]]

LANGUAGE["Item_Crowbar"] = [[Crowbar]]
LANGUAGE["Item_Desc_Crowbar"] = [[
Una crowbar oxidada.
]]

LANGUAGE["Item_Combat Knife"] = [[Cuchillo de Combate]]
LANGUAGE["Item_Desc_Combat Knife"] = [[
Una bayoneta confiable.
RMB para hacer un corte fuerte.
]]

LANGUAGE["Item_Katana"] = [[Katana]]
LANGUAGE["Item_Desc_Katana"] = [[
Espada ninja.
Largo rango de ataque y rapida velocidad de ataque.
]]

LANGUAGE["Item_Bat"] = [[Bate]]
LANGUAGE["Item_Desc_Bat"] = [[
Bate de beisboll robusto.
Golpea como un camion.
]]

LANGUAGE["Item_9mm"] = [[9mm]]
LANGUAGE["Item_Desc_9mm"] = [[
Arma de mano estandar de un Combine.
]]

LANGUAGE["Item_357"] = [[357]]
LANGUAGE["Item_Desc_357"] = [[
Pistola Colt python magnum.
Usado por los guardias de seguridad de Black Mesa.
]]

LANGUAGE["Item_Glock"] = [[Glock]]
LANGUAGE["Item_Desc_Glock"] = [[
Glock 18.
Pistolas semi-automaticas fabricada en Austria.
]]

LANGUAGE["Item_USP"] = [[USP]]
LANGUAGE["Item_Desc_USP"] = [[
Universelle Selbstladepistole.
Una pistola semi-automatica desarrollada en Alemania por H&K.
]]

LANGUAGE["Item_P2000"] = [[P2000]]
LANGUAGE["Item_Desc_P2000"] = [[
Heckler & Koch P2000.
Una pistola de primera ronda uil hecha por H&K.
]]

LANGUAGE["Item_P250"] = [[P250]]
LANGUAGE["Item_Desc_P250"] = [[
SIG Sauer P250.
Un arma de mano de bajo retroceso con una gran cadencia.
]]

LANGUAGE["Item_R8"] = [[R8]]
LANGUAGE["Item_Desc_R8"] = [[
Revolver R8.
Ofrece una gran precision y una poderosa ronda,
a expensas de un largo tiron del gatillo.
]]

LANGUAGE["Item_Deagle"] = [[Deagle]]
LANGUAGE["Item_Desc_Deagle"] = [[
Night Hawk .50C.
Una pistola iconica que es dificil de dominar.
]]

LANGUAGE["Item_M1911"] = [[M1911]]
LANGUAGE["Item_Desc_M1911"] = [[
Colt 1911.
Arma de mano estandar para las fuerzas de Estados Unidos.
]]

LANGUAGE["Item_FiveSeven"] = [[FiveSeven]]
LANGUAGE["Item_Desc_FiveSeven"] = [[
ES Five-seven.
Una pistola semi-automatica belga fabricada por FN Herstal.
]]

LANGUAGE["Item_CZ75"] = [[CZ75]]
LANGUAGE["Item_Desc_CZ75"] = [[
CZ 75.
Una pistola semi-automatica fabricado en Republica Checa.
]]

LANGUAGE["Item_M9"] = [[M9]]
LANGUAGE["Item_Desc_M9"] = [[
Beretta M9.
Arma de mano usada por las fuerzas de Estados Unidos.
]]

LANGUAGE["Item_Tec-9"] = [[Tec-9]]
LANGUAGE["Item_Desc_Tec-9"] = [[
Una pistola semi-automatica sueca.
Letal en espacios reducidos.
]]

LANGUAGE["Item_TMP"] = [[TMP]]
LANGUAGE["Item_Desc_TMP"] = [[
Steyr TMP.
Una ametralladora de calibre Parabellum de 9 × 19 mm de fuego selecto.
]]


LANGUAGE["Item_SMG1"] = [[SMG1]]
LANGUAGE["Item_Desc_SMG1"] = [[
Un arma de fuego compacta y automatica.
Armado con un M203 Launcher.
]]

LANGUAGE["Item_Mac10"] = [[Mac10]]
LANGUAGE["Item_Desc_Mac10"] = [[
Corporacion de Armamento Militar Modelo 10.
Cuenta con una alta cadencia de fuego,
con poca presicion de propagacion y mucho retroceso como compensacion.
]]

LANGUAGE["Item_MP9"] = [[MP9]]
LANGUAGE["Item_Desc_MP9"] = [[
Brügger & Thomet MP9.
Hecho en Suiza,
la MP9 es favorita de las seguridades privadas en todo el mundo.
]]

LANGUAGE["Item_MP5K"] = [[MP5K]]
LANGUAGE["Item_Desc_MP5K"] = [[
Heckler & Koch MP5K.
Una version mas convertida y movil de la MP5.
]]

LANGUAGE["Item_MP5"] = [[MP5]]
LANGUAGE["Item_Desc_MP5"] = [[
Heckler & Koch MP5.
Imitada a menudo pero nunca igualada,
la MP5 capaz es la ametralladora mas versatil del mundo.
]]

LANGUAGE["Item_UMP45"] = [[UMP45]]
LANGUAGE["Item_Desc_UMP45"] = [[
KM UMP45.
Una sucesora mas ligera y barata de la MP5.
]]

LANGUAGE["Item_PP Bizon"] = [[PP Bizon]]
LANGUAGE["Item_Desc_PP Bizon"] = [[
PP-19 Bizon.
Ofrece un gran cargador y recarga rapida.
]]

LANGUAGE["Item_P90"] = [[P90]]
LANGUAGE["Item_Desc_P90"] = [[
ES C90.
Una bullpup belga con un cargador de 50 rondas.
]]

LANGUAGE["Item_Vector"] = [[Vector]]
LANGUAGE["Item_Desc_Vector"] = [[
KRISS Vector Gen I.
Utiliza un sistema inconvencional de retroceso resultando una alta tasa de fuego.
]]

LANGUAGE["Item_Pump-Action"] = [[Accion de bombeo]]
LANGUAGE["Item_Desc_Pump-Action"] = [[
Una escopeta estandar de calibre 12.
RMB para disparar 2 balas a la vez.
]]

LANGUAGE["Item_Nova"] = [[Nova]]
LANGUAGE["Item_Desc_Nova"] = [[
Nova Benelli.
Escopeta italiana de accion de bombeo calibre 12.
]]

LANGUAGE["Item_M870"] = [[M870]]
LANGUAGE["Item_Desc_M870"] = [[
Escopeta Remington 870.
Fabricada en Estados Unidos.
]]

LANGUAGE["Item_MAG7"] = [[MAG7]]
LANGUAGE["Item_Desc_MAG7"] = [[
Techno Arms MAG-7.
Dispara un cartucho especializado de calibre 12 de 60mm.
]]

LANGUAGE["Item_XM1014"] = [[XM1014]]
LANGUAGE["Item_Desc_XM1014"] = [[
Benelli M4 Super 90.
Escopeta completamente automatica.
]]

LANGUAGE["Item_AA12"] = [[AA12]]
LANGUAGE["Item_Desc_AA12"] = [[
Atchisson Assault Shotgun.
Una potencia de fuego devastadora a rango medio y corto.
]]


LANGUAGE["Item_AR15"] = [[AR15]]
LANGUAGE["Item_Desc_AR15"] = [[
Rifle estilo AR-15.
Un rifle semi-automatico ligero basado en el diseño Armalite AR-15.
]]

LANGUAGE["Item_FAMAS"] = [[FAMAS]]
LANGUAGE["Item_Desc_FAMAS"] = [[
Fusil de asalto bullpup FAMAS.
Reconocido por su alta cadencia de tiro.
]]

LANGUAGE["Item_Galil"] = [[Galil]]
LANGUAGE["Item_Desc_Galil"] = [[
Galil ACE 22.
Desarrollada y fabricada por IMI.
]]

LANGUAGE["Item_AK47"] = [[AK47]]
LANGUAGE["Item_Desc_AK47"] = [[
Avtomat Kalashnikova..
Un rifle de asalto de 7.62×39mm operado por gas hecho en la Union Sovietica.
]]

LANGUAGE["Item_M4A1"] = [[M4A1]]
LANGUAGE["Item_Desc_M4A1"] = [[
Colt M4.
Una carabina de fuego selecta de 5,56×45mm OTAN, refrigerada por aire, operada por gas.
]]

LANGUAGE["Item_SG556"] = [[SG556]]
LANGUAGE["Item_Desc_SG556"] = [[
SIG SG 550.
Un rifle de asalto fabricado por by Swiss Arms AG.
]]

LANGUAGE["Item_AUG"] = [[AUG]]
LANGUAGE["Item_Desc_AUG"] = [[
Steyr AUG.
Un rifle de asalto bullpup austriaco.
]]

LANGUAGE["Item_F2000"] = [[F2000]]
LANGUAGE["Item_Desc_F2000"] = [[
FN F2000.
Un rifle bullpup ambidiestro fabricado por FN.
]]

LANGUAGE["Item_Tavor"] = [[Tavor]]
LANGUAGE["Item_Desc_Tavor"] = [[
IWI Tavor-21.
Diseñado para maximizar la confiabilidad, durabilidad y simplicidad.
]]

LANGUAGE["Item_ACR"] = [[ACR]]
LANGUAGE["Item_Desc_ACR"] = [[
Rifle de combate adaptativo Remington.
Un rifle semi-automatico modular.
]]

LANGUAGE["Item_AWP"] = [[AWP]]
LANGUAGE["Item_Desc_AWP"] = [[
Rifle Magnum Ghost.
Una serie de francotirador fabricado por Reino Unido.
]]

LANGUAGE["Item_SCAR"] = [[SCAR]]
LANGUAGE["Item_Desc_SCAR"] = [[
FN SCAR.
Un rifle de asalto desarrollado por el belga FN Herstal.
]]

LANGUAGE["Item_G3"] = [[G3]]
LANGUAGE["Item_Desc_G3"] = [[
Rifle de combate G3.
Un rifle de batalla de fuego selecto 7.62×51mm OTAN, fabricado por H&K.
]]

LANGUAGE["Item_Barret AMR"] = [[Barret AMR]]
LANGUAGE["Item_Desc_Barret AMR"] = [[
Francotirador .50 Cal Anti-Material.
Hace grandes cantidades de daño balistico.
]]

LANGUAGE["Item_SSG08 Medic SR"] = [[SSG08 Medic SR]]
LANGUAGE["Item_Desc_SSG08 Medic SR"] = [[
Un francotirador de medico que dispara dardos.
Daña enemigos y cura jugadores.
]]

LANGUAGE["Item_Negev"] = [[Negev]]
LANGUAGE["Item_Desc_Negev"] = [[
IWI Negev.
Una ametralladora ligera 5.56×45mm OTAN, fabricada por la IWI.
]]

LANGUAGE["Item_M249"] = [[M249]]
LANGUAGE["Item_Desc_M249"] = [[
Ametralladora ligera M249.
Un arma de destruccion operada por gas y enfriada por aire.
]]

LANGUAGE["Item_MG4"] = [[MG4]]
LANGUAGE["Item_Desc_MG4"] = [[
Heckler & Koch MG4.
Una ametralladora ligera 5.56mm alimentada por correa que reemplazo la MG3.
]]

LANGUAGE["Item_Frag Grenade"] = [[Granada de Fragemntacion]]
LANGUAGE["Item_Desc_Frag Grenade"] = [[
Una granada de fragmentacion estandar.
Buena para control de multitudes.
]]

LANGUAGE["Item_Resistance RPG"] = [[Resistance RPG]]
LANGUAGE["Item_Desc_Resistance RPG"] = [[
Dispositivo de propulsion cohetes guiado por laser.
]]

LANGUAGE["Item_RPG-7"] = [[RPG-7]]
LANGUAGE["Item_Desc_RPG-7"] = [[
Ruchnoy Protivotankoviy Granatomyot.
Lanzacohetes anti-tanques diseñado por la Union Sovietica.
]]

LANGUAGE["Item_SLAM"] = [[SLAM]]
LANGUAGE["Item_Desc_SLAM"] = [[
Selectable Lightweight Attack Munition.
RMB para detonar. Pegala a una pared para activar el modo laser.
]]

LANGUAGE["Item_Incendiary Grenade"] = [[Granada incendiaria]]
LANGUAGE["Item_Desc_Incendiary Grenade"] = [[
Genera un charco de fuego despues de un tiempo.
Prende fuego todo lo que este dentro.
]]


LANGUAGE["Item_Heat Crossbow"] = [[Ballesta de calor]]
LANGUAGE["Item_Desc_Heat Crossbow"] = [[
Arma de francotirador improvisada.
Dispara barras abrasadoras.
]]

LANGUAGE["Item_Turret"] = [[Torreta]]
LANGUAGE["Item_Desc_Turret"] = [[
Torreta Guardian de Combine.
Utilizado para proteger puntos y areas vitales.
]]

LANGUAGE["Item_Medic Grenade"] = [[Granada Medica]]
LANGUAGE["Item_Desc_Medic Grenade"] = [[
Una granada que libera rafagas de nubes desintoxicantes.
Cura jugadores y daña enemigos.
]]

LANGUAGE["Item_Throwing Knives"] = [[Cuchillos Lanzantes]]
LANGUAGE["Item_Desc_Throwing Knives"] = [[
Cuchillos arrojadizos a distancias.
Los cuchillos lanzados son recuperables.
]]


LANGUAGE["Item_Medkit"] = [[Medkit]]
LANGUAGE["Item_Desc_Medkit"] = [[
Medkit recargable.
RMB para curarte, LMB para curar a otros.
]]

LANGUAGE["Item_Health Vial"] = [[Vial de VidaX]]
LANGUAGE["Item_Desc_Health Vial"] = [[
Una capsula de vida llenas de liquido pegajoso verde.
Cura instantaneamente cuando se agarra.
]]

LANGUAGE["Item_Kevlar Armor Battery"] = [[Bateria de Armadura Kevlar]]
LANGUAGE["Item_Desc_Kevlar Armor Battery"] = [[
Bateria de Armadura.
Cada una proporciona 15 de armadura. Solo uso personal.
]]

LANGUAGE["Item_Full Kevlar Armor"] = [[Armadura completa de Kevlar]]
LANGUAGE["Item_Desc_Full Kevlar Armor"] = [[
Set completo de armadura Kevlar.
Llena 100% de tu barra de armadura.
]]