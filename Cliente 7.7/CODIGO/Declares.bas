Attribute VB_Name = "Mod_Declaraciones"
'Argentum Online 0.9.0.9
'
'Copyright (C) 2002 M�rquez Pablo Ignacio
'Copyright (C) 2002 Otto Perez
'Copyright (C) 2002 Aaron Perkins
'
'This program is free software; you can redistribute it and/or modify
'it under the terms of the GNU General Public License as published by
'the Free Software Foundation; either version 2 of the License, or
'any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'GNU General Public License for more details.
'
'You should have received a copy of the GNU General Public License
'along with this program; if not, write to the Free Software
'Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
'
'Argentum Online is based on Baronsoft's VB6 Online RPG
'You can contact the original creator of ORE at aaron@baronsoft.com
'for more information about ORE please visit http://www.baronsoft.com/
'
'
'You can contact me at:
'morgolock@speedy.com.ar
'www.geocities.com/gmorgolock
'Calle 3 n�mero 983 piso 7 dto A
'La Plata - Pcia, Buenos Aires - Republica Argentina
'C�digo Postal 1900
'Pablo Ignacio M�rquez


Option Explicit

'nati:7.0
Public PuedoUsarMagia As Integer
Public FPSFast As Boolean
Public Chats As Integer
Public VelFPS As Integer
Public DBe As Integer
'pluto:7.0
Public Foeste As Byte
Public Feste As Byte
Public Fsur As Byte
Public Fnorte As Byte
Public Ffortaleza As Byte
Public DopeEstimulo As Byte
Public PingTime As Long
Public PingReal As Boolean
'Delzak)
Public CustomKeys As New clsCustomKeys
'pluto:7.0-----------------------------------
Public MemoAgi As Integer
Public MemoFue As Integer
Public Quest As Mision
Type Mision
Time As Integer
Titulo As String
tX As String
Nivelminimo As Byte
Nivelmaximo As Byte
NEnemigos As Byte
Enemigo() As String
NEnemigosConseguidos() As Byte
NObjetos As Byte
Objeto() As String
Level As Integer
Entrega As Integer
exp As Long
Oro As Long
NObjetosR As Byte
ObjetoR() As String
'-------------------------
Estado As Integer
numero As Integer
'Enemigo As Integer
'Objeto As Integer
cantidad As Integer
'Entrega As Integer
'Level As Integer
Clase As String
End Type

Type Viaje
    ciudad As String
    valor As Integer
End Type
'-----------------------------------------

'pluto:6.9
Public vWin As String
Public TodoListado As String
 Type OSVERSIONINFOEX
    dwOSVersionInfoSize As Long
    dwMajorVersion As Long
    dwMinorVersion As Long
    dwBuildNumber As Long
    dwPlatformId As Long
    szCSDVersion As String * 128
    wServicePackMajor As Integer
    wServicePackMinor As Integer
    wSuiteMask As Integer
    wProductType As Byte
    wReserved As Byte
End Type

Public Declare Function GetVersionEx2 Lib "kernel32" Alias "GetVersionExA" _
    (lpVersionInformation As OSVERSIONINFOEX) As Long





Public MacPluto As String
Public MacClave As Integer
Public HayMiniMap As Boolean 'minimap
Public Declare Function CreateRoundRectRgn Lib "gdi32" ( _
    ByVal X1 As Long, _
    ByVal Y1 As Long, _
    ByVal X2 As Long, _
    ByVal Y2 As Long, _
    ByVal X3 As Long, _
    ByVal Y3 As Long) As Long 'minimap
Public Declare Function SetWindowRgn Lib "user32" ( _
    ByVal hWnd As Long, _
    ByVal hRgn As Long, _
    ByVal bRedraw As Boolean) As Long 'minimap
Public Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" _
(ByVal hWnd As Long, _
ByVal nIndex As Long) As Long 'minimap

Public Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" _
(ByVal hWnd As Long, _
ByVal nIndex As Long, _
ByVal dwNewLong As Long) As Long 'minimap
Public Declare Function SetLayeredWindowAttributes Lib "user32" _
(ByVal hWnd As Long, _
ByVal crKey As Long, _
ByVal bAlpha As Byte, _
ByVal dwFlags As Long) As Long 'minimap
Public Declare Sub ReleaseCapture Lib "user32" () 'minimap
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Integer, ByVal lParam As Long) As Long 'minimap

'nati: Abrir Explorador Predeterminado!
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Public Const conSwNormal = 1


'pluto:6.7---------------
'Public UserEnvia As Byte
'Public UserRecibe As Byte
'Public Lusercuenta As Integer
'--------------------------
Public TipoLetra As Byte
'pluto:6.6
'Public ChequePluto As Boolean

Public IChe As Boolean
'Delzak)
Public Wpe As Boolean
Public Bengi As Boolean
Public WpeLen As Long
'Texto
'Public Const FONTTYPE_TALK = "~255~255~255~0~0"
'Public Const FONTTYPE_FIGHT = "~255~0~0~1~0"
'Public Const FONTTYPE_WARNING = "~32~51~223~1~1"
'Public Const FONTTYPE_INFO = "~65~190~156~0~0"
'Public Const FONTTYPE_VENENO = "~0~255~0~0~0"
'Public Const FONTTYPE_GUILD = "~255~255~255~1~0"
'Public Const FONTTYPE_PLUTO = "~255~150~0~1~0"
'pluto:2.8.0
'Public Const FONTTYPE_COMERCIO = "~221~216~9~1~0"
Public TopVentana As Boolean
'pluto:6.4
Public EstadoF As String
Public HaciendoFoto As Boolean
'pluto:6.8
Public LoGTeclas As Boolean
Public LoGTeclas2 As String
Public TIPOCHEAT As Byte
Public Rama(15) As String

Public Noengi As Boolean
Public TrozoFichi(1 To 19) As String
Public Trozo As Byte
Public IndiceLabel As Integer
'hechizos nuevos cantidad
Public Hechizos(73) As Hechizos
 Public Type Hechizos
    Nombre As String
    Desc As String
    PalabrasMagicas As String
    
    HechizeroMsg As String
    TargetMsg As String
    PropioMsg As String
    
    Resis As Byte
    
    Tipo As Byte
    WAV As Integer
    FXgrh As Integer
    Loops As Byte
    
    SubeHP As Byte
    MinHP As Integer
    MaxHP As Integer
    
    SubeMana As Byte
    MiMana As Integer
    MaMana As Integer
    
    SubeSta As Byte
    MinSta As Integer
    MaxSta As Integer
    
    SubeHam As Byte
    MinHam As Integer
    MaxHam As Integer
    
    SubeSed As Byte
    MinSed As Integer
    MaxSed As Integer
    
    SubeAgilidad As Byte
    MinAgilidad As Integer
    MaxAgilidad As Integer
    
    SubeFuerza As Byte
    MinFuerza As Integer
    MaxFuerza As Integer
    
    SubeCarisma As Byte
    MinCarisma As Integer
    MaxCarisma As Integer
    
    Invisibilidad As Byte
    Paraliza As Byte
    Paralizaarea As Byte
    RemoverParalisis As Byte
    CuraVeneno As Byte
    Envenena As Byte
    'pluto:2.15
    Protec As Byte
    Maldicion As Byte
    RemoverMaldicion As Byte
    Bendicion As Byte
    Estupidez As Byte
    Ceguera As Byte
    Revivir As Byte
    Morph As Byte
    
    invoca As Byte
    NumNpc As Integer
    Cant As Integer
    
    Noesquivar As Byte
    itemIndex As Byte
    
    MinSkill As Integer
    MinNivel As Byte
    ManaRequerido As Integer

    Target As Byte
End Type


'Tipos de objetos
Public ObjData() As ObjData
Public Type ObjData
    'pluto:6.0A
    ArmaNpc As Integer
    name As String 'Nombre del obj
    'pluto:2.8.0
    Vendible As Integer
    
    OBJType As Integer 'Tipo enum que determina cuales son las caract del obj
    SubTipo As Integer 'Tipo enum que determina cuales son las caract del obj
    
    GrhIndex As Integer ' Indice del grafico que representa el obj
    GrhSecundario As Integer
    'pluto:2.3
    peso As Double
    
    Respawn As Byte
    
    'Solo contenedores
    MaxItems As Integer
    
    Apu�ala As Byte
    
    HechizoIndex As Integer
    
    ForoID As String
    
    MinHP As Integer ' Minimo puntos de vida
    MaxHP As Integer ' Maximo puntos de vida
    
    
    MineralIndex As Integer
    'LingoteInex As Integer
    
    
    proyectil As Integer
    Municion As Integer
    
    Crucial As Byte
    Newbie As Integer
    
    'Puntos de Stamina que da
    MinSta As Integer ' Minimo puntos de stamina
    
    'Pociones
    TipoPocion As Byte
    MaxModificador As Integer
    MinModificador As Integer
    DuracionEfecto As Long
    MinSkill As Integer
    LingoteIndex As Integer
    
    'nati: nuevas habilidades
    defmagica As Integer
    defcuerpo As Integer
    MinHIT As Integer 'Minimo golpe
    MaxHIT As Integer 'Maximo golpe
    
    MinHam As Integer
    MinSed As Integer
    
    Def As Integer
    MinDef As Integer ' Armaduras
    MaxDef As Integer ' Armaduras
    
    Ropaje As Integer 'Indice del grafico del ropaje
    
    WeaponAnim As Integer ' Apunta a una anim de armas
    ShieldAnim As Integer ' Apunta a una anim de escudo
    CascoAnim As Integer
     '[GAU]
    Botas As Integer
    '[GAU]
    valor As Long     ' Precio
    objetoespecial As Integer
    Cerrada As Integer
    Llave As Byte
    Clave As Long 'si clave=llave la puerta se abre o cierra
    
    IndexAbierta As Integer
    IndexCerrada As Integer
    IndexCerradaLlave As Integer
    
    RazaCiclope As Byte
    RazaEnana As Byte
    Mujer As Byte
    Hombre As Byte
    Envenena As Byte
    Magia As Byte
    Resistencia As Long
    Agarrable As Byte
    
    
    LingH As Integer
    LingO As Integer
    LingP As Integer
    Madera As Integer
    '[MerLiNz:6]
    Gemas As Integer
    Diamantes As Integer
    'pluto:2.10
    ObjetoClan As String
    '[\END]
    
    SkHerreria As Byte
    SkCarpinteria As Byte
    
    texto As String
    
    'Clases que no tienen permitido usar este obj
    ClaseProhibida(1 To 21) As String
    
    Snd1 As Integer
    Snd2 As Integer
    Snd3 As Integer
    MinInt As Integer
    
    Real As Byte
    Caos As Byte
    nocaer As Byte
    razaelfa As Byte
    razavampiro As Byte
    razahumana As Byte
    razaorca As Byte
    SkArco As Byte
    SkArma As Byte
    Cregalos As Integer
    Pregalo As Byte
    Drop As Byte
    End Type

Public Const SND_CLICK = "click.Wav"

Public Const SND_PASOS1 = "23.Wav"
Public Const SND_PASOS2 = "24.Wav"
Public Const SND_NAVEGANDO = "50.wav"
Public Const SND_OVER = "click2.Wav"
Public Const SND_DICE = "cupdice.Wav"

Public Const MIdi_Inicio = 6

Public CurMidi As String
Public LoopMidi As Byte '1 para repetir
'Public IsPlayingCheck As Boolean
'Public GetStartTime As Long
'Public Offset As Long
'Public mtTime As Long
'Public mtLength As Double
'Public dTempo As Double
 'Dim timesig As DMUS_TIMESIGNATURE
'Dim portcaps As DMUS_PORTCAPS
'Dim msg As String
'Dim time As Double
'Dim Offset2 As Long
'Dim ElapsedTime2 As Double
'Dim fIsPaused As Boolean

'pluto:6.0A
Public SeguroCrimi As Boolean

'---------------------------
'pluto:2.17
'Public SmSlabel As String
Public PMascotas(1 To 12) As PMascotas
Type PMascotas
Tipo As String
AumentoCuerpo As Byte
AumentoMagia As Byte
ReduceCuerpo As Byte
ReduceMagia As Byte
AumentoFlecha As Byte
ReduceFlecha As Byte
AumentoEvasion As Byte
TopeLevel As Byte
VidaporLevel As Integer
GolpeporLevel As Integer
exp(1 To 12) As Long
TopeAtMagico As Byte
TopeDefMagico As Byte
TopeAtFlechas As Byte
TopeDefFlechas As Byte
TopeAtCuerpo As Byte
TopeDefCuerpo As Byte
TopeEvasion As Byte
End Type
Public audio As New ClsAudio
'pluto 2.25
Public ConFlash As Byte
Public navida As Byte
Public Resolu As Byte
Public Son As Byte
Public Musi As Byte

Public Bmplluvia As Integer
Public SinTecho As Byte
Public LogInicial As String

Public Generagenero As Byte
Public SELECI As Byte
Public NameCorrecto As Boolean

Public hechi As Byte
Public RawServersList As String
'pluto:2.14
Public totalda As Integer
Public Busca8 As Integer
Public Dir7 As String
Public Mapa8 As String
Public TimeDado As Boolean

Public Type tServerInfo
    Ip As String
    Puerto As Integer
    Desc As String
    PassRecPort As Integer
End Type
'pluto:2.4.7
'Public Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)
Public fotoinvi As String
'pluto:2.11
Public intentos As Byte
'pluto:2.14
Public BotonPulsado As Byte
'pluto:2.14
Public Pasi As Integer
'pluto:2.25---------
Public Segu As Boolean
Public ChatElegido As Byte
'-------------------
'pluto:2.5.0
Public KeyCodi As String
Public Keycodi2 As String
Public vez As Byte
'pluto:2.4.5
Public ShTime As Integer
Public CurServer As Integer
Public macro As Boolean
'pluto:2.8.0
Public PideCuenta As Boolean
Public PideClave As Boolean
'pluto:2.15
Public web As String
Public Orden As Byte

Public CreandoClan As Boolean
Public ClanName As String
Public Site As String

Public UserCiego As Boolean
Public UserEstupido As Boolean
'pluto:2.12
Public BoteTorneo2 As Long
Public UserTorneo2 As String
Public RecordTorneo2 As Integer
'pluto:2.4.2
Public Const tAt = 2000
Public Const tUs = 400
'pluto:6.0A
Public Const tMg = 376
'Public tMg As Integer

'pluto:2.8.0
Public Const tFle = 1400

'pluto:2.4.5
Public Const tTr = 4000
 
Public Const bCabeza = 1
Public Const bPiernaIzquierda = 2
Public Const bPiernaDerecha = 3
Public Const bBrazoDerecho = 4
Public Const bBrazoIzquierdo = 5
Public Const bTorso = 6

Public Const PrimerBodyBarco = 84
Public Const UltimoBodyBarco = 87


Public Dialogos As New cDialogos
Public NumEscudosAnims As Integer

Public ArmasHerrero(0 To 100) As Integer
Public ArmadurasHerrero(0 To 100) As Integer
Public ObjCarpintero(0 To 100) As Integer
'[MerLiNz:6]
Public ObjErmita�o(0 To 100) As Integer
'[\END]


Public Const MAX_BANCOINVENTORY_SLOTS = 20

Public UserBancoInventory(1 To MAX_BANCOINVENTORY_SLOTS) As Inventory
'pluto:6.0A
Public Const MAX_BOVEDACLAN_SLOTS = 40
Public UserClanInventory(1 To MAX_BOVEDACLAN_SLOTS) As Inventory



Public Tips() As String * 255
Public Const LoopAdEternum = 999

Public Const NUMCIUDADES = 3

'Direcciones
Public Const NORTH = 1
Public Const EAST = 2
Public Const SOUTH = 3
Public Const WEST = 4

'Objetos
Public Const MAX_INVENTORY_OBJS = 10000
Public Const MAX_INVENTORY_SLOTS = 25
Public Const MAX_NPC_INVENTORY_SLOTS = 50
Public Const MAXHECHI = 50

Public Const NUMSKILLS = 31
Public Const NUMATRIBUTOS = 5
Public Const NUMCLASES = 19
Public Const NUMRAZAS = 7

Public Const MAXSKILLPOINTS = 200

Public Const FLAGORO = 777

Public Const FOgata = 1521

Public Const f1 = 70
Public Const f2 = 20
Public Const f3 = 20
Public ServActual As Byte
Public Pvez As Byte
'[Tite]Party
Public Const MAXMIEMBROS = 10

'[\Party]
'%%%%%%%%%% CONSTANTES DE INDICES %%%%%%%%%%%%%%%
Public Const Suerte = 1
Public Const Magia = 2
Public Const Robar = 3
Public Const Tacticas = 4
Public Const Armas = 5
Public Const Meditar = 6
Public Const Apu�alar = 7
Public Const Ocultarse = 8
Public Const Supervivencia = 9
Public Const Talar = 10
Public Const Comerciar = 11
Public Const Defensa = 12 'escudos
Public Const Pesca = 13
Public Const Mineria = 14
Public Const Carpinteria = 15
Public Const Herreria = 16
Public Const Liderazgo = 17
Public Const Domar = 18
Public Const Proyectiles = 19 'Acertar Proyec.
Public Const Navegacion = 21

'pluto:2.15
Public Const DobleArma = 20 'Posibilidad de golpear con la segunda

Public Const Da�oMagia = 22
Public Const DefMagia = 23
Public Const EvitaMagia = 24
'Requerido es Magia (2)

Public Const Da�oArma = 25   'vale para dos manos tambi�n
Public Const DefArma = 26    'vale para dos manos tambi�n
Public Const RequeArma = 27 ' vale para dos manos.
'acertar es Armas (5)
'evitar es tactica (4)


Public Const Da�oProyec = 28
Public Const DefProyec = 29
Public Const RequeProyec = 30
Public Const EvitarProyec = 31
'acertar es Proyectiles (19)

Public Const FundirMetal = 88
'pluto:2.15
Public Due�oNix As Byte
Public Due�oCaos As Byte
Public Due�oUlla As Byte
Public Due�oBander As Byte
Public Due�oLindos As Byte
Public Due�oQuest As Byte
Public Due�oArghal As Byte
Public Due�oDescanso As Byte
Public Due�oLaurana As Byte
Public Due�oEsperanza As Byte
Public Due�oAtlantis As Byte
Public Due�oDesierto As Byte

'Inventario
Type Inventory
    OBJIndex As Integer
    name As String
    GrhIndex As Integer
    Amount As Long
    Equipped As Byte
    valor As Long
    OBJType As Integer
    DefMax As Integer
    DefMin As Integer
    MaxHIT As Integer
    MinHIT As Integer
'pluto:2.3
    SubTipo As Integer
    peso As Double
End Type

Type NpCinV
    OBJIndex As Integer
    name As String
    GrhIndex As Integer
    Amount As Integer
    valor As Long
    OBJType As Integer
    DefMax As Integer
    DefMin As Integer
    MaxHIT As Integer
    MinHIT As Integer
    c1 As String
    C2 As String
    C3 As String
    C4 As String
    C5 As String
    C6 As String
    C7 As String
End Type

Type tReputacion 'Fama del usuario
    NobleRep As Long
    BurguesRep As Long
    PlebeRep As Long
    LadronesRep As Long
    BandidoRep As Long
    AsesinoRep As Long
    Promedio As Long
   
End Type
'[Tite]Party
Type cMiembros
    Nombre As String
    privi As Byte
    Index As Integer
    X As Byte
    Y As Byte

End Type
Type cparty
    Miembros(1 To MAXMIEMBROS) As cMiembros
    numMiembros As Byte
    Solicitudes(1 To MAXMIEMBROS) As String
    numSolicitudes As Byte
    reparto As Byte
End Type
'[\Tite]

Public ListaRazas() As String
Public ListaClases() As String

Public Nombres As Boolean
Public clas As String
Public MixedKey As Long

'User status vars
Public UserInventory(1 To MAX_INVENTORY_SLOTS) As Inventory
Global OtroInventario(1 To MAX_INVENTORY_SLOTS) As Inventory

Public UserHechizos(1 To MAXHECHI) As Integer
'[Tite]Party
 Public Party As cparty
'[\Tite]

Type Premios 'Delzak sistema premios
    MataNPCs(1 To 34) As Integer
End Type

'Constantes de sistema premios

Enum NPCsPremios
    Animales = 0
    Ara�as
    Goblin
    Orcos
    Largartos
    Genios
    Hobbits
    Ogros
    Hechiceros
    Nomuertos
    Darks
    Trolls
    Beholders
    Golems
    Marinos
    Ents
    Licantropos
    Medusas
    Ciclopes
    Polares
    Devastador
    Gigantes
    Piratas
    Uruks
    Demonios
    Devir
    Gollums
    Dragones
    Ettin
    Puertas
    Reyes
    Defensores
    Raids
    Navidades
End Enum

Public NPCInventory(1 To MAX_NPC_INVENTORY_SLOTS) As NpCinV
Public NPCViajes(1 To MAX_NPC_INVENTORY_SLOTS) As Viaje
Public NPCInvDim As Integer
Public Premios As Premios 'Delzak sistema premios
Public UserMeditar As Boolean
Public UserName As String
Public Usercuenta As String
Public MostrarIndexNombre As String
Public UserPassword As String
Public UserMaxHP As Integer
Public UserMinHP As Integer
Public UserMaxMAN As Integer
Public UserMinMAN As Integer
Public UserMaxSTA As Integer
Public UserMinSTA As Integer
Public UserGLD As Long
Public UserLvl As Integer
Public UserPort As Integer
Public UserServerIP As String
Public UserCanAttack As Integer
Public UserEstado As Byte '0 = Vivo & 1 = Muerto
Public UserPasarNivel As Long
Public UserExp As Long
'pluto:2.3
Public UserPeso As Single
Public UserPesoMax As Integer
'pluto:2.15
Public Ergs As String

Public UserReputacion As tReputacion
Public UserDescansar As Boolean
Public tipf As String
Public PrimeraVez As Boolean
Public FPSFLAG As Boolean
Public PYFLAG As Boolean
Public ECiudad As Boolean
Public EstadoCiudad As String
Public pausa As Boolean
'Public IScombate As Boolean
Public UserParalizado As Boolean
Public UserNavegando As Boolean
Public UserHogar As String

'<-------------------------NUEVO-------------------------->
Public Comerciando As Boolean
'<-------------------------NUEVO-------------------------->
Public Miraza As String
Public Miclase As String

Public UserClase As String
Public UserSexo As String
Public UserRaza As String
Public UserEmail As String

Public UserSkills() As Integer
Public SkillsNames() As String

Public UserAtributos() As Integer
'pluto:7.0
Public UserPorcentajes(1 To 6) As Byte

Public AtributosNames() As String

Public Ciudades() As String
Public CityDesc() As String

Public Musica As Byte
Public Fx As Byte
Public Fasis As Byte
Public LugarServer As Byte

Public SkillPoints As Integer
Public Alocados As Integer
Public Flags() As Integer
Public Oscuridad As Integer
Public logged As Boolean
Public NoPuedeUsar As Boolean
Public NoPuedeMagia As Boolean
'pluto:2.8.0
Public NoPuedeFlechas As Boolean

'pluto:2.4.5
 Public NoPuedeTirar As Boolean
 
Public UsingSkill As Integer
Public Macreando As Byte
'pluto:2.5.0
Public TamCabeza As Integer
Public TamCuerpos As Integer
Public TamFX As Integer
Public TamCascos As Integer
Public TamBotas As Integer

'Server stuff
Public RequestPosTimer As Integer 'Used in main loop
Public stxtbuffer As String 'Holds temp raw data from server
Public SendNewChar As Boolean 'Used during login
Public Connected As Boolean 'True when connected to server
Public DownloadingMap As Boolean 'Currently downloading a map from server
Public UserMap As Integer

'String contants
Public ENDC As String 'Endline character for talking with server
Public ENDL As String 'Holds the Endline character for textboxes

'Control
Public prgRun As Boolean 'When true the program ends
Public finpres As Boolean

Public IPdelServidor As String
'Public PuertoDelServidor As String

'********** FUNCIONES API ***********
Public Declare Function GetTickCount Lib "kernel32" () As Long

'para escribir y leer variables
Public Declare Function writeprivateprofilestring Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpString As String, ByVal lpFileName As String) As Long
Public Declare Function getprivateprofilestring Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpdefault As String, ByVal lpreturnedstring As String, ByVal nsize As Long, ByVal lpFileName As String) As Long

'Teclado
Public Declare Function GetKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer
Public Declare Function GetAsyncKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer

Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
'pluto:2.14
Public Declare Function GetVolumeInformation& Lib "kernel32" Alias "GetVolumeInformationA" (ByVal lpRootPathName As String, ByVal pVolumeNameBuffer As String, ByVal nVolumeNameSize As Long, lpVolumeSerialNumber As Long, lpMaximumComponentLength As Long, lpFileSystemFlags As Long, ByVal lpFileSystemNameBuffer As String, ByVal nFileSystemNameSize As Long)


'Lista de cabezas
Public Type tIndiceCabeza
    Head(1 To 4) As Integer
End Type

Public Type tIndiceCuerpo
    'Pluto:2.11
  Body(1 To 8) As Integer
    HeadOffsetX As Integer
    HeadOffsetY As Integer
End Type
'[GAU]
Public Type tIndiceBota
    Botas(1 To 4) As Integer
    HeadOffsetX As Integer
    HeadOffsetY As Integer
End Type
'[GAU]
Public Type tIndiceFx
    Animacion As Integer
    OffsetX As Integer
    OffsetY As Integer
End Type
'pluto:2-3-04
Public seguroobjetos As Boolean
'pluto:2.9.0
Public Goleslocal As Byte
Public Golesvisitante As Byte
'pluto:2.15
Public CiudaMuertos As Integer
Public CrimiMuertos As Integer
Public NpcMuertos As Integer

'nati:transparencias
Public Const GWL_EXSTYLE = (-20)
Public Const WS_EX_TRANSPARENT = &H20&
'nati:transparencias

'nati: descargar imagen
Private Type TGUID
Data1 As Long
Data2 As Integer
Data3 As Integer
Data4(0 To 7) As Byte
End Type
Private Declare Function OleLoadPicturePath Lib "oleaut32.dll" (ByVal szURLorPath As Long, ByVal punkCaller As Long, ByVal dwReserved As Long, ByVal clrReserved As OLE_COLOR, ByRef riid As TGUID, ByRef ppvRet As IPicture) As Long
Public Function LoadPicture(ByVal strFileName As String) As Picture
Dim IID As TGUID
With IID
.Data1 = &H7BF80980
.Data2 = &HBF32
.Data3 = &H101A
.Data4(0) = &H8B
.Data4(1) = &HBB
.Data4(2) = &H0
.Data4(3) = &HAA
.Data4(4) = &H0
.Data4(5) = &H30
.Data4(6) = &HC
.Data4(7) = &HAB
End With
On Error GoTo ERR_LINE
OleLoadPicturePath StrPtr(strFileName), 0&, 0&, 0&, IID, LoadPicture
Exit Function
ERR_LINE:
Set LoadPicture = VB.LoadPicture(strFileName)
End Function
