--[[
HORDE Translation Guideline
1. Use English as base.
2. Do NOT translate special characters. e.g. {1}, %d. Keep those directly.
3. Keep translations short and concise.
4. Consistency, especially for perks.
increase vs. more: these two descriptions are DIFFERENT!
resistance vs. less damage taken: same as above.
5. Translate AS IS.

Translator: Archi, Bishy
--]]

translate.AddLanguage("es-ES", "Spanish")

-- Game Info
LANGUAGE["Game_Ready"] = "Listo"
LANGUAGE["Game_Not Ready"] = "No Listo"
LANGUAGE["Game_Players_Ready"] = "Jugadores Listo"
LANGUAGE["Game_Next_Wave_Starts_In"] = "Próxima oleada empieza en %d"
LANGUAGE["Game_Difficulty_NORMAL"] = "NORMAL"
LANGUAGE["Game_Difficulty_HARD"] = "DIFÍCIL"
LANGUAGE["Game_Difficulty_REALISM"] = "REALISTA"
LANGUAGE["Game_Difficulty_NIGHTMARE"] = "PESADILLA"
LANGUAGE["Game_Difficulty_APOCALYPSE"] = "APOCALIPSIS"
LANGUAGE["Game_Enemies"] = "Enemigos"
LANGUAGE["Game_HintBottomReady"] = "F2 - Info/Config, F3 - Tienda/Habilidad, F4 - Listo"
LANGUAGE["Game_HintBottom"] = "F2 - Info/Config, F3 - Tienda/Habilidad, V - Soltar $"
LANGUAGE["Game_Result_VICTORY"] = "VICTORIA"
LANGUAGE["Game_Result_DEFEAT"] = "DERROTA"
LANGUAGE["Game_Result_Change Map"] = "Cambio de Mapa"
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
LANGUAGE["Game_Most_Kills"] = "Mayores Asesinatos"
LANGUAGE["Game_Kills"] = "Asesinatos"
LANGUAGE["Game_Elite_Killer"] = "Asesino de Élites"
LANGUAGE["Game_Elite_Kills"] = "Asesinatos de Élite"
LANGUAGE["Game_SharpShooter"] = "Mejor Tirador"
LANGUAGE["Game_Headshots"] = "Tiros a la Cabeeza"
LANGUAGE["Game_Most_Heal"] = "Mayor Curación"
LANGUAGE["Game_Healed"] = "Curado"
LANGUAGE["Game_Healed_You"] = "te ha curado"


-- Ranks
LANGUAGE["Rank_Novice"] = "Novato"
LANGUAGE["Rank_Amateur"] = "Principiante"
LANGUAGE["Rank_Skilled"] = "Habilidoso"
LANGUAGE["Rank_Professional"] = "Profesional"
LANGUAGE["Rank_Expert"] = "Experto"
LANGUAGE["Rank_Champion"] = "Campeón"
LANGUAGE["Rank_Master"] = "Maestro"
LANGUAGE["Rank_Not_Met"] = "No se Cumplen los Requerimiento(s) de Rango"

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
LANGUAGE["Shop_Explosive"] = "Explosivo"
LANGUAGE["Shop_Special"] = "Especial"
LANGUAGE["Shop_Equipment"] = "Equipamiento"
LANGUAGE["Shop_Attachment"] = "Accesorio"
LANGUAGE["Shop_Gadget"] = "Artilugio"

-- Attachments
LANGUAGE["Shop_Optic"] = "Óptica"
LANGUAGE["Shop_Underbarrel"] = "Debajo del cañón"
LANGUAGE["Shop_Tactical"] = "Táctico"
LANGUAGE["Shop_Barrel"] = "Cañón"
LANGUAGE["Shop_Muzzle"] = "Bozal"
LANGUAGE["Shop_Magazine"] = "Cargador"
LANGUAGE["Shop_Stock"] = "Culata"
LANGUAGE["Shop_Ammo Type"] = "Tipo de Munición"
LANGUAGE["Shop_Perk"] = "Habilidad"

-- Class Panel
LANGUAGE["Shop_Class/Perks"] = "Clases/Habilidades"
LANGUAGE["Shop_Select_Class"] = "Seleccionar Clase (Tus Objetos Serán Removidos)"
LANGUAGE["Shop_Show_Perks"] = "Mostrar Habilidades de Clase"
LANGUAGE["Shop_Hide_Perks"] = "Ocultar Habilidades de Clase"
LANGUAGE["Shop_Unlocks_After_Wave"] = "Desbloqueado Después de la Oleada %d"
LANGUAGE["Shop_Buy_Ammo_Clip"] = "Comprar Munición"
LANGUAGE["Shop_Sell_For"] = "Vender Por"
LANGUAGE["Shop_Sell_All_For"] = "Vender Todo Por"
LANGUAGE["Shop_Buy_Item"] = "Comprar Objeto"
LANGUAGE["Shop_OWNED"] = "ADQUIRIDO"
LANGUAGE["Shop_Buy_Secondary_Ammo"] = "Comprar Munición Secundaria"
LANGUAGE["Shop_Primary_Ammo"] = "Munición Primaria"
LANGUAGE["Shop_Secondary_Ammo"] = "Munición Secundaria"


-- Classes
LANGUAGE["Class_Survivor"] = "Superviviente"
LANGUAGE["Class_Assault"] = "Asalto"
LANGUAGE["Class_Heavy"] = "Pesado"
LANGUAGE["Class_Medic"] = "Médico"
LANGUAGE["Class_Demolition"] = "Demolición"
LANGUAGE["Class_Ghost"] = "Tirador"
LANGUAGE["Class_Engineer"] = "Ingeniero"
LANGUAGE["Class_Berserker"] = "Berserker"
LANGUAGE["Class_Warden"] = "Guardián"
LANGUAGE["Class_Cremator"] = "Quemador"

-- Gadgets
LANGUAGE["Gadget_Activation"] = "Presiona T para activa."
LANGUAGE["Gadget_Cooldown"] = "Enfriamiento"
LANGUAGE["Gadget_Duration"] = "Duración"
LANGUAGE["Gadget_Owned_Warning"] = "Solo 1 Artilugio puede ser ADQUIRIDO!"
LANGUAGE["Gadget_Seconds"] = "segundos"

-- Default Class Extra Descriptions
LANGUAGE["Class_Description_Survivor"] = [[
Tiene acceso a todas las armas excepto las armas exclusivas y especiales.
Acceso limitado a los accesorios.]]

LANGUAGE["Class_Description_Assault"] = [[
Tiene entero acceso a los rifles de asalto.]]

LANGUAGE["Class_Description_Heavy"] = [[
Tiene entero acceso a las ametralladoras y armas pesadas.]]

LANGUAGE["Class_Description_Medic"] = [[
Tiene entero acceso a las armas más ligeras y herramientas médicas.]]

LANGUAGE["Class_Description_Demolition"] = [[
Tiene entero acceso a las armas explosivas.]]

LANGUAGE["Class_Description_Ghost"] = [[
Tiene acceso a francotiradores y armas de fuego selecto.
Tiene acceso a silenciadores y miras telescópicas.]]

LANGUAGE["Class_Description_Engineer"] = [[
Tiene acceso a armas especiales y equipamiento.]]

LANGUAGE["Class_Description_Berserker"] = [[
Solo tiene acceso a armas de cuerpo a cuerpo.]]

LANGUAGE["Class_Description_Warden"] = [[
Tiene entero acceso a las escopetas y watchtowers (horde_watchtower).]]

LANGUAGE["Class_Description_Cremator"] = [[
Tiene acceso a armamento a base de calor.]]


-- Default Base Perks


-- Default Config Shop Items
-- Optional
LANGUAGE["Item_Stunstick"] = [[Stunstick]]
LANGUAGE["Item_Desc_Stunstick"] = [[
Bastón elétrico.
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
Largo rango de ataque y rápida velocidad de ataque.
]]

LANGUAGE["Item_Bat"] = [[Bate]]
LANGUAGE["Item_Desc_Bat"] = [[
Bate de beisboll robusto.
Golpea como un camión.
]]

LANGUAGE["Item_9mm"] = [[9mm]]
LANGUAGE["Item_Desc_9mm"] = [[
Arma de mano estándar de un Combine.
]]

LANGUAGE["Item_357"] = [[357]]
LANGUAGE["Item_Desc_357"] = [[
Pistola Colt python magnum.
Usado por los guardias de seguridad de Black Mesa.
]]

LANGUAGE["Item_Glock"] = [[Glock]]
LANGUAGE["Item_Desc_Glock"] = [[
Glock 18.
Pistolas semi-automáticas fabricada en Austria.
]]

LANGUAGE["Item_USP"] = [[USP]]
LANGUAGE["Item_Desc_USP"] = [[
Universelle Selbstladepistole.
Una pistola semi-automática desarrollada en Alemania por H&K.
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
Ofrece una gran precisión y una poderosa ronda,
a expensas de un largo tirón del gatillo.
]]

LANGUAGE["Item_Deagle"] = [[Deagle]]
LANGUAGE["Item_Desc_Deagle"] = [[
Night Hawk .50C.
Una pistola icónica que es difícil de dominar.
]]

LANGUAGE["Item_M1911"] = [[M1911]]
LANGUAGE["Item_Desc_M1911"] = [[
Colt 1911.
Arma de mano estándar para las fuerzas de los Estados Unidos.
]]

LANGUAGE["Item_FiveSeven"] = [[FiveSeven]]
LANGUAGE["Item_Desc_FiveSeven"] = [[
ES Five-seven.
Una pistola semi-automática belga fabricada por FN Herstal.
]]

LANGUAGE["Item_CZ75"] = [[CZ75]]
LANGUAGE["Item_Desc_CZ75"] = [[
CZ 75.
Una pistola semi-automática fabricado en República Checa.
]]

LANGUAGE["Item_M9"] = [[M9]]
LANGUAGE["Item_Desc_M9"] = [[
Beretta M9.
Arma de mano usada por las fuerzas de los Estados Unidos.
]]

LANGUAGE["Item_Tec-9"] = [[Tec-9]]
LANGUAGE["Item_Desc_Tec-9"] = [[
Una pistola semi-automática sueca.
Letal en espacios reducidos.
]]

LANGUAGE["Item_TMP"] = [[TMP]]
LANGUAGE["Item_Desc_TMP"] = [[
Steyr TMP.
Una ametralladora de calibre Parabellum de 9×19 mm de fuego selecto.
]]

LANGUAGE["Item_Flare Gun"] = [[Pistola de Bengalas]]
LANGUAGE["Item_Desc_Flare Gun"] = [[
Pistola de Bengalas de Orion Safety.
Incendia enemigos y hace daño de Fuego.
]]

LANGUAGE["Item_Anaconda"] = [[Anaconda]]
LANGUAGE["Item_Desc_Anaconda"] = [[
Colt Anaconda.
Cámara para la poderosa .44 Magnum.
]]


LANGUAGE["Item_SMG1"] = [[SMG1]]
LANGUAGE["Item_Desc_SMG1"] = [[
Un arma de fuego compacta y automática.
Armado con un Lanzador M203.
]]

LANGUAGE["Item_Mac10"] = [[Mac10]]
LANGUAGE["Item_Desc_Mac10"] = [[
Military Armament Corporation Modelo 10.
Cuenta con una alta cadencia de fuego,
con poca presición de propagación y mucho retroceso como compensación.
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
Una versión mas convertida y móvil de la MP5.
]]

LANGUAGE["Item_MP5"] = [[MP5]]
LANGUAGE["Item_Desc_MP5"] = [[
Heckler & Koch MP5.
Imitada a menudo pero nunca igualada,
la MP5 capaz es la ametralladora mas versátil del mundo.
]]

LANGUAGE["Item_UMP45"] = [[UMP45]]
LANGUAGE["Item_Desc_UMP45"] = [[
KM UMP45.
Una sucesora mas ligera y barata de la MP5.
]]

LANGUAGE["Item_PP Bizon"] = [[PP Bizon]]
LANGUAGE["Item_Desc_PP Bizon"] = [[
PP-19 Bizon.
Ofrece un gran cargador y recarga rápida.
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
Escopeta italiana de acción de bombeo calibre 12.
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
Escopeta completamente automática.
]]

LANGUAGE["Item_Trench Gun"] = [[Escopeta de Trinchera]]
LANGUAGE["Item_Desc_Trench Gun"] = [[
Winchester Modelo 1200.
Dispara perdigones incendiarios.
]]

LANGUAGE["Item_SPAS-12"] = [[SPAS-12]]
LANGUAGE["Item_Desc_SPAS-12"] = [[
Franchi SPAS-12.
Una escopeta de combate fabricada por las companías de armas italiana Franchi.
]]

LANGUAGE["Item_Striker"] = [[Striker]]
LANGUAGE["Item_Desc_Striker"] = [[
Armsel Striker.
Una escopeta de calibre 12 con cilindro giratorio de Sudáfrica.
]]

LANGUAGE["Item_AA12"] = [[AA12]]
LANGUAGE["Item_Desc_AA12"] = [[
Atchisson Assault Shotgun.
Potencia de fuego devastadora a corta y media distancia.
]]


LANGUAGE["Item_AR15"] = [[AR15]]
LANGUAGE["Item_Desc_AR15"] = [[
Rifle estilo AR-15.
Un rifle semi-automático ligero basado en el diseño Armalite AR-15.
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
Avtomat Kalashnikova.
Un rifle de asalto de 7.62×39mm operado por gas hecho en la Union Soviética.
]]

LANGUAGE["Item_M4A1"] = [[M4A1]]
LANGUAGE["Item_Desc_M4A1"] = [[
Colt M4.
Una carabina de fuego selecta de 5,56×45mm OTAN, refrigerada por aire, operada por gas.
]]

LANGUAGE["Item_SG556"] = [[SG556]]
LANGUAGE["Item_Desc_SG556"] = [[
SIG SG 550.
Un rifle de asalto fabricado por Swiss Arms AG.
]]

LANGUAGE["Item_AUG"] = [[AUG]]
LANGUAGE["Item_Desc_AUG"] = [[
Steyr AUG.
Un rifle de asalto bullpup austríaco.
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
Un rifle semi-automático modular.
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
Hace grandes cantidades de daño balístico.
]]

LANGUAGE["Item_SSG08 Medic SR"] = [[FR Médico SSG08]]
LANGUAGE["Item_Desc_SSG08 Medic SR"] = [[
Un francotirador de médico que dispara dardos.
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
Un arma de destrucción operada por gas y enfriada por aire.
]]

LANGUAGE["Item_MG4"] = [[MG4]]
LANGUAGE["Item_Desc_MG4"] = [[
Heckler & Koch MG4.
Una ametralladora ligera 5.56mm alimentada por correa que reemplazó la MG3.
]]

LANGUAGE["Item_Frag Grenade"] = [[Granada de Fragmentación]]
LANGUAGE["Item_Desc_Frag Grenade"] = [[
Una granada de fragmentación estándar.
Buena para control de multitudes.
]]

LANGUAGE["Item_DamageResistance RPG"] = [[RPG de la Resistencia]]
LANGUAGE["Item_Desc_DamageResistance RPG"] = [[
Dispositivo de propulsión cohetes guiado por láser.
]]


LANGUAGE["Item_M79 GL"] = [[LG M79]]
LANGUAGE["Item_Desc_M79 GL"] = [[
Lanzagranadas M79.
Dispara granadas de 40x46mm que exlpota al impactar.
]]

LANGUAGE["Item_M32 GL"] = [[LG M32]]
LANGUAGE["Item_Desc_M32 GL"] = [[
Lanzagrandas Múltiple Milkor.
Un lanzagranadas ligero revolver de seis tiros de 40mm.
]]

LANGUAGE["Item_RPG-7"] = [[RPG-7]]
LANGUAGE["Item_Desc_RPG-7"] = [[
Ruchnoy Protivotankoviy Granatomyot.
Lanzacohetes anti-tanques diseñado por la Union Soviética.
]]

LANGUAGE["Item_SLAM"] = [[SLAM]]
LANGUAGE["Item_Desc_SLAM"] = [[
Selectable Lightweight Attack Munition.
RMB para detonar. Pégala a una pared para activar el modo láser.
]]

LANGUAGE["Item_Incendiary Grenade"] = [[Granada Incendiaria]]
LANGUAGE["Item_Desc_Incendiary Grenade"] = [[
Genera un charco de fuego después de un tiempo.
Prende fuego todo lo que esté dentro.
]]

LANGUAGE["Item_Molotov"] = [[Molotov]]
LANGUAGE["Item_Desc_Molotov"] = [[
Genera un charco de fuego al impacto.
Pone todo en fuego dentro de su efecto.
]]


LANGUAGE["Item_Incendiary Launcher"] = [[Lanzador Incendiario]]
LANGUAGE["Item_Desc_Incendiary Launcher"] = [[
Lanzagrandas Incendiario.
Dispara granadas incendiarias que estallan en fuego al impactar.
]]


LANGUAGE["Item_Heat Crossbow"] = [[Ballesta de Calor]]
LANGUAGE["Item_Desc_Heat Crossbow"] = [[
Francotirador improvisado.
Dispara barras abrasadoras.
]]

LANGUAGE["Item_Turret"] = [[Torreta]]
LANGUAGE["Item_Desc_Turret"] = [[
Torreta Guardián Combine.
Utilizado para proteger puntos y áreas vitales.
]]

LANGUAGE["Item_Medic Grenade"] = [[Granada Médica]]
LANGUAGE["Item_Desc_Medic Grenade"] = [[
Una granada que libera ráfagas de nubes desintoxicantes.
Cura jugadores y daña enemigos.
]]

LANGUAGE["Item_Throwing Knives"] = [[Cuchillos Lanzantes]]
LANGUAGE["Item_Desc_Throwing Knives"] = [[
Cuchillos arrojadizos a distancias.
Los cuchillos lanzados son recuperables.
]]

LANGUAGE["Item_Watchtower"] = [[Watchtower]]
LANGUAGE["Item_Desc_Watchtower"] = [[
Un watchtower que proporciona reabastecimiento.
Genera 1 caja de munición cada 30 segundos.
(Clase de entidad: horde_watchtower)
]]

LANGUAGE["Item_M2 Flamethrower"] = [[Lanzallamas M2]]
LANGUAGE["Item_Desc_M2 Flamethrower"] = [[
Lanzallamas M2-2.
Un lanzallamas americano portable.
]]


LANGUAGE["Item_Medkit"] = [[Medkit]]
LANGUAGE["Item_Desc_Medkit"] = [[
Medkit recargable.
RMB para curarte, LMB parar curar a otros.
]]

LANGUAGE["Item_Health Vial"] = [[Vial de Vida]]
LANGUAGE["Item_Desc_Health Vial"] = [[
Una cápsula de vida llena de líquido verde pegajoso.
Cura instantáneamente cuando se recoge.
]]

LANGUAGE["Item_Kevlar Armor Battery"] = [[Batería de Armadura Kevlar]]
LANGUAGE["Item_Desc_Kevlar Armor Battery"] = [[
Batería de armadura.
Cada uno proporciona 15 de armadura. Solo uso personal.
]]

LANGUAGE["Item_Full Kevlar Armor"] = [[Armadura Kevlar Completa]]
LANGUAGE["Item_Desc_Full Kevlar Armor"] = [[
Set de armadura completa.
LLena hasta 100% tu barra de armadura
]]

LANGUAGE["Item_Watchtower MKII"] = [[Watchtower MKII]]
LANGUAGE["Item_Desc_Watchtower MKII"] = [[
Un watchtower que proporciona reabastecimiento.
Genera 1 vial de vida cada 30 segundos.
(Clase de Entidad: horde_watchtower_mk2)
]]

LANGUAGE["Item_Watchtower MKIII"] = [[Watchtower MKIII]]
LANGUAGE["Item_Desc_Watchtower MKIII"] = [[
Un watchtower que disuade enemigos.
Electrocuta 1 enemigo cercano cada 1 segundo.
Realiza 100 de daño eléctrico.
(Entity Class: horde_watchtower_mk3)
]]

LANGUAGE["Item_Tau Cannon"] = [[Cañón Tau]]
LANGUAGE["Item_Desc_Tau Cannon"] = [[
Un dispositivo que usa electromagnetismo para ionizar partículas.
Mantén RMB para cargar y realizar un disparo poderoso.
Hace más daño mientras mas cargues.
El dispotisivo explotará si sobrecargas.
]]

LANGUAGE["Item_MP7A1 Medic PDW"] = [[MP7A1 Médica PDW]]
LANGUAGE["Item_Desc_MP7A1 Medic PDW"] = [[
Una versión modificada de la MP7A1 para fines médicos.
Presiona B o ZOOM para disparar dardos curativos.
El dardo curativo se recarga cada 1 segundo.
]]

LANGUAGE["Item_Vector Medic PDW"] = [[Vector Médica PDW]]
LANGUAGE["Item_Desc_Vector Medic PDW"] = [[
KRISS Vector Gen I equipado con un lanzador de dardos médicos.
Usa un sistema de retroceso inconvencional que resulta en una gran cadencia.
Presiona B o ZOOM para disparar dardos curativos.
El dardo curativo se recarga cada 1.5 segundos.
]]

LANGUAGE["Item_Chainsaw"] = [[Motosierra]]
LANGUAGE["Item_Desc_Chainsaw"] = [[
Brrrrrrrrrrrrrrrr.
Mantén RMB para atravesar enemigos.
]]

LANGUAGE["Item_Mjollnir"] = [[Mjolnir]]
LANGUAGE["Item_Desc_Mjollnir"] = [[
Un martillo de guerra impregnado de energía eléctrica.
Presiona RMB para cargar el arma.
El Mjolnir cargado crea una explosión eléctrica al impactar.
]]

LANGUAGE["Item_Double Barrel"] = [[Double Barrel]]
LANGUAGE["Item_Desc_Double Barrel"] = [[
Double Barrel Shotgun.
Devastating power at close range.
]]

LANGUAGE["Item_FN FAL"] = [[FN FAL]]
LANGUAGE["Item_Desc_FN FAL"] = [[
FN FAL.
Un rifle de batalla diseñado y fabricado por el Belga FN Herstal.
]]

LANGUAGE["Item_AUG HBAR"] = [[AUG HBAR]]
LANGUAGE["Item_Desc_AUG HBAR"] = [[
Steyr AUG HBAR.
Una ametralladora de apoyo ligero variante del rifle de asalto AUG.
]]

LANGUAGE["Item_Manhack"] = [[Manhack]]
LANGUAGE["Item_Desc_Manhack"] = [[
Manhack que se regenera al morir.
Manhack hacen su vida como daño a enemigos.
Manhack muere al impacto.
]]

LANGUAGE["Item_Vortigaunt"] = [[Vortigaunt]]
LANGUAGE["Item_Desc_Vortigaunt"] = [[
Vortigaunts Xen que puede conjurar explosiones concentrada de energía.
Las explosiones de energía tienen alto rango y hacen daño por salpicadura.
]]

LANGUAGE["Item_Combat Bot"] = [[Robot de Combate]]
LANGUAGE["Item_Desc_Combat Bot"] = [[
Un robot humanoide resistente diseñado para enfrentar enemigos de frente.
Usa poderosos golpes cuerpo a cuerpo y ataques de rocas a distancia.
]]

LANGUAGE["Item_Advanced Kevlar Armor"] = [[Armadura Kevlar Avanzada]]
LANGUAGE["Item_Desc_Advanced Kevlar Armor"] = [[
Armadura de Superviviente distinguida.
Llena tu barra de armadura hasta 100%.
Proporciona 5% más de resistencia al daño.
]]

LANGUAGE["Item_Assault Vest"] = [[Chaleco de Asalto]]
LANGUAGE["Item_Desc_Assault Vest"] = [[
Armadura de Asalto distinguida.
Llena tu barra de armadura hasta 100%.
Proporciona 8% más de resistencia al daño Balístico.
]]

LANGUAGE["Item_Bulldozer Suit"] = [[Traje de Excavadora]]
LANGUAGE["Item_Desc_Bulldozer Suit"] = [[
Armadura de Pesado distinguida.
Llena tu barra de armadura hasta 125%.
]]

LANGUAGE["Item_Hazmat Suit"] = [[Traje Hazmat]]
LANGUAGE["Item_Desc_Hazmat Suit"] = [[
Armadura de Médico distinguida.
Llena tu barra de armadura hasta 100%.
Proporciona 8% más de resitencia al daño Venenoso.
]]

LANGUAGE["Item_Bomb Suit"] = [[Traje Bomba]]
LANGUAGE["Item_Desc_Bomb Suit"] = [[
Armadura de Demloición distuinguida.
Llena tu barra de armadura hasta 100%.
Proporciona 8% más de resitencia al daño Explosivo.
]]

LANGUAGE["Item_Assassin's Cloak"] = [[Capa de Asesino]]
LANGUAGE["Item_Desc_Assassin's Cloak"] = [[
Armadura de Tirador distinguida.
Llena tu barra de armadura hasta 100%.
Proporciona 5% más de evasión.
]]

LANGUAGE["Item_Defense Matrix"] = [[Matriz defensa]]
LANGUAGE["Item_Desc_Defense Matrix"] = [[
Armadura de Ingeniero distinguida.
Llena tu barra de armadura hasta 100%.
Proporciona 5% más de resistencia al daño.
]]

LANGUAGE["Item_Riot Armor"] = [[Armadura Antidisturbios]]
LANGUAGE["Item_Desc_Riot Armor"] = [[
Distinguished Warden armor.
Llena tu barra de armadura hasta 100%.
Proporciona 8% más de resistencia al daño de Choque y Sónico.
]]

LANGUAGE["Item_Molten Armor"] = [[Armadura Fundida]]
LANGUAGE["Item_Desc_Molten Armor"] = [[
Armadura de Quemador distinguida.
Llena tu barra de armadura hasta 100%.
Proporciona 8% más de resistencia al daño de Fuego.
]]

LANGUAGE["Item_Battle Vest"] = [[Chaleco de Batalla]]
LANGUAGE["Item_Desc_Battle Vest"] = [[
Armadura de Berserker distinguida.
Llena tu barra de armadura hasta 100%.
Proporciona 8% más de resistencia al daño Cortante/Golpeante.
]]

-- Gadgets
LANGUAGE["Gadget_gadget_blast_plating"] = [[Galjanoplastia Explosiva]]
LANGUAGE["Gadget_Desc_gadget_blast_plating"] = [[
20% de resistencia al daño Explosivo aumentado.
]]

LANGUAGE["Gadget_gadget_shock_plating"] = [[Galjanoplastia de Choque]]
LANGUAGE["Gadget_Desc_gadget_shock_plating"] = [[
20% de resistencia al daño Relámpago aumentado.
]]

LANGUAGE["Gadget_gadget_heat_plating"] = [[Galjanoplastia de Calor]]
LANGUAGE["Gadget_Desc_gadget_heat_plating"] = [[
20% de resistencia al daño de Fuego aumentado.
]]

LANGUAGE["Gadget_gadget_detoxifier"] = [[Desintoxicante]]
LANGUAGE["Gadget_Desc_gadget_detoxifier"] = [[
20% de resistencia al daño Venenoso aumentado.
]]

LANGUAGE["Gadget_gadget_diamond_plating"] = [[Galjanoplastia de Diamante]]
LANGUAGE["Gadget_Desc_gadget_diamond_plating"] = [[
15% increased Physical damage resistance.
]]

LANGUAGE["Gadget_gadget_corporate_mindset"] = [[Mentalidad Corporativa]]
LANGUAGE["Gadget_Desc_gadget_corporate_mindset"] = [[
"Ponerte metas. Ten un plan de diez años. Invierte. Levantate temprano. Mentalidad de CEO."
Aumenta enormemente la posibilidad de soltar fichas de calavera.
]]

-- Survivor Gadgets

LANGUAGE["Gadget_gadget_vitality_booster"] = [[Potenciador de Vitalidad]]
LANGUAGE["Gadget_Desc_gadget_vitality_booster"] = [[
+25 de vida máxima.
]]

LANGUAGE["Gadget_gadget_damage_booster"] = [[Potenciador de Daño]]
LANGUAGE["Gadget_Desc_gadget_damage_booster"] = [[
25% de daño Global incrementado.
]]

-- Assault Gadgets
LANGUAGE["Gadget_gadget_iv_injection"] = [[Inyección IV]]
LANGUAGE["Gadget_Desc_iv_injection"] = [[
Recupera 25 de vida.
]]

LANGUAGE["Gadget_gadget_cortex"] = [[Corteza]]
LANGUAGE["Gadget_Desc_gadget_cortex"] = [[
Por cada enemigo cerca tuyo, ganas 1 carga de Adrenalina.
Enemigos élites dan 2 cargas.
]]

LANGUAGE["Gadget_gadget_neuro_amplifier"] = [[Neuro Amplificador]]
LANGUAGE["Gadget_Desc_neuro_amplifier"] = [[
Adrenalina también incrementa 6% de evasión.
]]

LANGUAGE["Gadget_ouroboros"] = [[Ouroboros]]
LANGUAGE["Gadget_Desc_ouroboros"] = [[
Asistente del sistema nervioso de Ouroboros.
Elimina las regulaciones corporales para aumentar las capacidades de combate.
Cuando tienes mas del 50% de vida, pierdes 1 de vida por segundo.
Cuando tienes menos del 50% de vida, ganas 2 de vida por segundo.
Por cada 1% de vida faltante, aumenta tu daño un 0.8%.
]]

-- Heavy Gadgets
LANGUAGE["Gadget_gadget_energy_shield"] = [[Escudos de Energía]]
LANGUAGE["Gadget_Desc_energy_shield"] = [[
Temporalmente ganas 25 de armadura.
]]

LANGUAGE["Gadget_gadget_hardening_injection"] = [[Inyección de Endurecimiento]]
LANGUAGE["Gadget_Desc_hardening_injection"] = [[
Velocidad de movimiento reducido un 50%.
25% de resistencia al daño Global aumentado.
25% de resistencia al daño Físico aumentado.
]]

LANGUAGE["Gadget_exoskeleton"] = [[Exoesqueleto]]
LANGUAGE["Gadget_Desc_exoskeleton"] = [[
Usando esta habilidad activa una breve mejora.
No puedes correr.
Pasivamente proporciona un 20% de resistencia al daño Global.
]]

LANGUAGE["Gadget_t_virus"] = [[Virus]]
LANGUAGE["Gadget_Desc_t_virus"] = [[
Convierte tu armadura a vida.
No puedes pasarte de 250% de vida.
]]

-- Medic Gadgets
LANGUAGE["Gadget_gadget_life_diffuser"] = [[Difusor de Vida]]
LANGUAGE["Gadget_Desc_gadget_life_diffuser"] = [[
Activa un pulso que cura a jugadores cercanos.
Cura 20 de vida.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_heal"] = [[Lanzador de Proyectiles (Curativo)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_heal"] = [[
Dispara un proyectil químico.
El proyectil realiza 75 de daño Venenoso.
El proyectil cura 25 de vida a jugadores cercanos.
]]

LANGUAGE["Gadget_healing_beam"] = [[Rayo Curativo]]
LANGUAGE["Gadget_Desc_gadget_healing_beam"] = [[
Conecta un rayo curativo entre el usuario y el objetivo.
Si el objetivo es un enemigo, roba vida del objetivo.
Si el objetivo es un aliado, restaura vida al aliado.
]]

-- Ghost Gadgets
LANGUAGE["Gadget_gadget_optical_camouflage"] = [[Camuflaje Óptico]]
LANGUAGE["Gadget_Desc_optical_camouflage"] = [[
Otorga Camuflaje por 5 segundos.
50% de evasión aumentada durante Camuflaje.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_ballistic"] = [[Lanzador de Proyectiles (Balístico)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_ballistic"] = [[
Dispara un proyectil balístico.
El proyectil realiza 150 de daño Balístico.
Aturde enemigos al pegarlos.
]]

LANGUAGE["Gadget_death_mark"] = [[Marca de la Muerte]]
LANGUAGE["Gadget_Desc_gadget_death_mark"] = [[
Coloca una marca al enemigo apuntado.
Enemigos apuntados reciben un 15% más de daño.
Enemigos marcados explotan al morir, realizando daño basado en su vida.
La marca dura 10 segundos.
Puedes marcar 1 enemigo a la vez.
]]

LANGUAGE["Gadget_gunslinger"] = [[Pistolero]]
LANGUAGE["Gadget_Desc_gadget_gunslinger"] = [[
25% de daño de Pistola aumentado.
25% de daño por tiro a la cabeza de Pistola aumentado.
]]

-- Demolition Gadgets
LANGUAGE["Gadget_gadget_proximity_defense"] = [[Defensa de Proximidad]]
LANGUAGE["Gadget_Desc_proximity_defense"] = [[
Activa una explosión que Aturde enemigos cercanos.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_blast"] = [[Lanzador de Proyectiles (Explosivo)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_blast"] = [[
Dispara un proyectil explosivo.
El proecytil realiza 100 de daño Explosivo.
Generates 3 extra explosions after a short delay.
]]

LANGUAGE["Gadget_nitrous_propellor"] = [[Propulsor Nitroso]]
LANGUAGE["Gadget_Desc_gadget_nitrous_propellor"] = [[
Te impulsa hacia adelante y arriba con una expolsión química.
]]

LANGUAGE["Gadget_ied"] = [[AEI]]
LANGUAGE["Gadget_Desc_gadget_ied"] = [[
Suelta un Artefaco Explosivo Improvisado al suelo.
AEI explota cuando un enemigo se acerca.
Tienes 5 cargas de AEI.
Los AEI se recargan después de la detonación.
]]

-- Engineer Gadgets
LANGUAGE["Gadget_displacer"] = [[Desplazador]]
LANGUAGE["Gadget_Desc_gadget_displacer"] = [[
Mueve instantáneamente al esbirro apuntado a tu la.
]]

LANGUAGE["Gadget_gadget_turret_pack"] = [[Paquete de Torreta]]
LANGUAGE["Gadget_Desc_gadget_turret_pack"] = [[
Despliega una torreta temporal.
La torreta tiene 50% menos de vida.
La torreta se destruye cuando su duración expira.
]]

LANGUAGE["Gadget_gadget_e_parasite"] = [[Parásito E]]
LANGUAGE["Gadget_Desc_gadget_e_parasite"] = [[
Lanza una cápsula de Parásito E que infecta enemigos al impactar.
Parásito E cuenta como un esbirro.
Parásito E realiza daño continuo a enemigos.
Robas vida del daño hecho por el Parásito E.
Enemigos asesinados mientras están infectados por el Parásito E exlpotan al morir.
]]

-- Berserker Gadgets
LANGUAGE["Gadget_gadget_berserk_armor"] = [[Armadura de Berserker]]
LANGUAGE["Gadget_Desc_gadget_berserk_armor"] = [[
25% de daño incrementado.
25% más resistencia al daño Global.
25% de velocidad de movimiento aumentada.
]]

LANGUAGE["Gadget_gadget_flash"] = [[Destello]]
LANGUAGE["Gadget_Desc_flash"] = [[
Embiste hacia adelante, realizando 100 de daño Cortante a todos los enemigos en su camino.
Proporciona un breve tiempo de invencibilidad.
]]

LANGUAGE["Gadget_gadget_aerial_guard"] = [[Guardia Aéreo]]
LANGUAGE["Gadget_Desc_aerial_guard"] = [[
Mientras estés en el aire, recibes 65% menos de daño Físico.
]]

LANGUAGE["Gadget_gadget_hemocannon"] = [[Hemocañón]]
LANGUAGE["Gadget_Desc_hemocannon"] = [[
Dispara un proyectil al costo de 10 de vida.
El proectil viaja una corta distancia y explota.
La explosión realiza 100 de daño Cortante.
Tiene un máximo de 5 cargas.
Se recarga después de 5 segundos.
]]

-- Warden Gadgets
LANGUAGE["Gadget_gadget_solar_array"] = [[Panel Solar]]
LANGUAGE["Gadget_Desc_gadget_solar_array"] = [[
Suelta una batería de armadura.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_shock"] = [[Lanzador de Proyectiles (Choque)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_shock"] = [[
Dispara un proyectil magnético que atraviesa enemigos.
Genera una onda de choque cada vez que el proyectil atraviesa un enemigo.
La onda de choque realiza 125 de daño de Relámpago.
]]

LANGUAGE["Gadget_watchtower_pack"] = [[Paquete de Watchtower]]
LANGUAGE["Gadget_Desc_gadget_watchtower_pack"] = [[
Despliega un watchtower extra.
]]

LANGUAGE["Gadget_shock_nova"] = [[Choque Nova]]
LANGUAGE["Gadget_Desc_gadget_shock_nova"] = [[
El Aura Guardián rápidamente genera una seria de ondas de choques.
Cada onda de choque realiza 50 de daño de Relámpago.
]]

-- Cremator Gadgets
LANGUAGE["Gadget_gadget_butane_can"] = [[Lata de Butano]]
LANGUAGE["Gadget_Desc_gadget_butane_can"] = [[
Suelta una Lata de Butano que explota al impacto físico.
La explosión realiza 375 de daño de Fuego.
Solo 1 Lata de Butano puede ser generada a la vez.
]]

LANGUAGE["Gadget_gadget_projectile_launcher_fire"] = [[Lanzador de Proyectiles (Incendiario)]]
LANGUAGE["Gadget_Desc_gadget_projectile_launcher_fire"] = [[
Dispara un proyectil incendiario.
Incendia todos los enemigos atrapados en la explosión.
Realiza 20 de daño base de Incendiar.
]]

LANGUAGE["Gadget_barbeque"] = [[Barbacoa]]
LANGUAGE["Gadget_Desc_gadget_barbeque"] = [[
Enemigos incendiadios asesinados por ti suelta entrañas consumibles.
Cada entraña restaura 5 de vida.
]]