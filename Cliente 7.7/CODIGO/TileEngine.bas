Attribute VB_Name = "Mod_TileEngine"
'Argentum Online 0.9.0.9
'
'Copyright (C) 2002 M�rquez Pablo Ignacio
'Copyright (C) 2002 Otto Perez
'Copyright (C) 2002 Aaron Perkins
'Copyright (C) 2002 Mat�as Fernando Peque�o
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

'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?
'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?
'    C       O       N       S      T
'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?
'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?
'Map sizes in tiles
Public Const XMaxMapSize = 100
Public Const XMinMapSize = 1
Public Const YMaxMapSize = 100
Public Const YMinMapSize = 1
Public SupBMiniMap As DirectDrawSurface7 'minimap
Public SupMiniMap As DirectDrawSurface7 'minimap
Public Const GrhFogata = 1521

'bltbit constant
Public Const SRCCOPY = &HCC0020 ' (DWORD) dest = source


'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?
'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?
'    T       I      P      O      S
'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?
'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?

'Encabezado bmp
Type BITMAPFILEHEADER
        bfType As Integer
        bfSize As Long
        bfReserved1 As Integer
        bfReserved2 As Integer
        bfOffBits As Long
End Type

'Info del encabezado del bmp
Type BITMAPINFOHEADER
        biSize As Long
        biWidth As Long
        biHeight As Long
        biPlanes As Integer
        biBitCount As Integer
        biCompression As Long
        biSizeImage As Long
        biXPelsPerMeter As Long
        biYPelsPerMeter As Long
        biClrUsed As Long
        biClrImportant As Long
End Type

'Posicion en un mapa
Public Type Position
    X As Integer
    Y As Integer
End Type

'Posicion en el Mundo
Public Type WorldPos
    Map As Integer
    X As Integer
    Y As Integer
End Type

'Contiene info acerca de donde se puede encontrar un grh
'tama�o y animacion
Public Type GrhData
    Sx As Integer
    Sy As Integer
    FileNum As Integer
    pixelWidth As Integer
    pixelHeight As Integer
    TileWidth As Single
    TileHeight As Single
    
    NumFrames As Integer
    Frames(1 To 25) As Integer
    Speed As Integer
End Type

'apunta a una estructura grhdata y mantiene la animacion
Public Type Grh
    GrhIndex As Integer
    FrameCounter As Byte
    SpeedCounter As Byte
    Started As Byte
End Type

'Lista de cuerpos
'Pluto:2.11
Public Type BodyData
    Walk(1 To 8) As Grh
    HeadOffset As Position
End Type
'[GAU]
'Lista de Botas
Public Type BotaData
    Walk(1 To 4) As Grh
    HeadOffset As Position
End Type
'[GAU]
'Lista de cabezas
Public Type HeadData
    Head(1 To 4) As Grh
End Type

'Lista de las animaciones de las armas
Type WeaponAnimData
    WeaponWalk(1 To 4) As Grh
End Type

'Lista de las animaciones de los escudos
Type ShieldAnimData
    ShieldWalk(1 To 4) As Grh
End Type


'pluto:2.11
'Type AtaqueAnimData
    'AtaqueWalk(1 To 4) As Grh
'End Type

'Lista de cuerpos
Public Type FxData
    Fx As Grh
    OffsetX As Long
    OffsetY As Long
End Type

Public ValidacionDeCliente As Boolean

'Apariencia del personaje
Public Type Char
    Active As Byte
    Heading As Byte
    pos As Position
    ArmaAnim As Byte
 '[GAU]
    Botas As BotaData
    '[GAU]
    Body As BodyData
    Head As HeadData
    Casco As HeadData
    Arma As WeaponAnimData
    'pluto:2.11
    'Ataque As AtaqueAnimData
    
    Escudo As ShieldAnimData
    UsandoArma As Boolean
    'pluto:2.10
    FxVida As Integer
    FxVidaCounter As Integer
      'pluto:6.0A
    Raid As Byte
    
    Fx As Integer
    FxLoopTimes As Integer
    Criminal As Byte
    'gm As Boolean
    soyNpc As Boolean
    gm As Integer
    legion As Integer
    Nombre As String
    Clan As String
    NumParty As Byte
    'pluto:6.5
    Credito As Byte
    'pluto:7.0
    EsGoblin As Byte
    
    Moving As Byte
    MoveOffset As Position
    Party As Byte
    
    pie As Boolean
    Muerto As Boolean
    invisible As Boolean
    iHead As Integer
    iBody As Integer
    VidaTotal As Long
    VidaActual As Long
    
    '[Alejo-21-5]
'    notpasos As Boolean
End Type

'Info de un objeto
Public Type Obj
    OBJIndex As Integer
    Amount As Integer
End Type

'Tipo de las celdas del mapa
Public Type MapBlock
    Graphic(1 To 4) As Grh
    CharIndex As Integer
    objgrh As Grh
    
    NPCIndex As Integer
    OBJInfo As Obj
    TileExit As WorldPos
    Blocked As Byte
    
    Trigger As Integer
End Type

'Info de cada mapa
Public Type MapInfo
    Music As String
    name As String
    StartPos As WorldPos
    MapVersion As Integer
    'ME Only
    Changed As Byte
    
End Type

Public Segura(1 To 300) As Byte
Public luzaviso(1 To 300) As Byte
Public Luzaviso2 As Integer
Public IniPath As String
Public MapPath As String


'Bordes del mapa
Public MinXBorder As Byte
Public MaxXBorder As Byte
Public MinYBorder As Byte
Public MaxYBorder As Byte

'Status del user
Public CurMap As Integer 'Mapa actual
Public UserIndex As Integer
Public UserMoving As Byte
Public UserBody As Integer
Public UserHead As Integer
Public UserPos As Position 'Posicion
Public AddtoUserPos As Position 'Si se mueve
Public UserCharIndex As Integer

Public UserMaxAGU As Integer
Public UserMinAGU As Integer
Public UserMaxHAM As Integer
Public UserMinHAM As Integer

Public EngineRun As Boolean
Public FramesPerSec As Integer
Public FramesPerSecCounter As Long

'Tama�o del la vista en Tiles
Public WindowTileWidth As Integer
Public WindowTileHeight As Integer

'Offset del desde 0,0 del main view
Public MainViewTop As Integer
Public MainViewLeft As Integer

'Cuantos tiles el engine mete en el BUFFER cuando
'dibuja el mapa. Ojo un tama�o muy grande puede
'volver el engine muy lento
Public TileBufferSize As Integer

'Handle to where all the drawing is going to take place
Public DisplayFormhWnd As Long

'Tama�o de los tiles en pixels
Public TilePixelHeight As Integer
Public TilePixelWidth As Integer

'?�?�?�?�?�?�?�?�?�?�Totales?�?�?�?�?�?�?�?�?�?�?

Public NumBodies As Integer
Public Numheads As Integer
Public NumFxs As Integer

Public Numonline As Integer
Public NumChars As Integer
Public LastChar As Integer
Public NumWeaponAnims As Integer
Public NumShieldAnims As Integer

'�?�?�?�?�?�?�?�?�?�Graficos�?�?�?�?�?�?�?�?�?�?�?

Public LastTime As Long 'Para controlar la velocidad


'[CODE]:MatuX'
Public MainDestRect   As RECT
'[END]'
Public MainViewRect   As RECT
Public BackBufferRect As RECT

Public MainViewWidth As Integer
Public MainViewHeight As Integer




'�?�?�?�?�?�?�?�?�?�Graficos�?�?�?�?�?�?�?�?�?�?�?
Public GrhData() As GrhData 'Guarda todos los grh
Public BodyData() As BodyData
Public HeadData() As HeadData
Public FxData() As FxData
Public WeaponAnimData() As WeaponAnimData
Public ShieldAnimData() As ShieldAnimData
Public CascoAnimData() As HeadData
'[GAU]
Public BotaData() As BotaData
'[GAU]
Public Grh() As Grh 'Animaciones publicas
'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?

'�?�?�?�?�?�?�?�?�?�Mapa?�?�?�?�?�?�?�?�?�?�?�?
Public MapData() As MapBlock ' Mapa
Public MapInfo As MapInfo ' Info acerca del mapa en uso
'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?

'�?�?�?�?�?�?�?�?�?�Usuarios?�?�?�?�?�?�?�?�?�?�?�?�?
Public CharList(1 To 10000) As Char
'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?

'�?�?�?�?�?�?�?�?�?�?�API?�?�?�?�?�?�?�?�?�?�?�?�?�?
'Blt
Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
'Sonido
Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uRetrunLength As Long, ByVal hwndCallback As Long) As Long
Declare Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long
'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?


'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?
'       [CODE 000]: MatuX
'
Public bRain        As Boolean 'est� raineando?
Public bRainST      As Boolean
Public bTecho       As Boolean 'hay techo?
Public brstTick     As Long

Private RLluvia(7)  As RECT  'RECT de la lluvia
Private iFrameIndex As Byte  'Frame actual de la LL
Private llTick      As Long  'Contador
Private LTLluvia(4) As Integer
            
'estados internos del surface (read only)
Public Enum TextureStatus
    tsOriginal = 0
    tsNight = 1
    tsFog = 2
End Enum

'[CODE 001]:MatuX
    Public Enum PlayLoop
        plNone = 0
        plLluviain = 1
        plLluviaout = 2
        plFogata = 3
    End Enum
'[END]'
'pluto:2.14
Public Gerrehaches As Integer
Public arrayGrh(0 To 32000) As Integer
'
'       [END]
'�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?

Sub CargarCabezas()
On Error Resume Next
Dim n As Integer, i As Integer, Numheads As Integer, Index As Integer

Dim Miscabezas() As tIndiceCabeza

n = FreeFile
Open App.Path & "\init\Cabezas.ind" For Binary Access Read As #n

'cabecera
Get #n, , MiCabecera

'num de cabezas
Get #n, , Numheads

'Resize array
ReDim HeadData(0 To Numheads + 1) As HeadData
ReDim Miscabezas(0 To Numheads + 1) As tIndiceCabeza

For i = 1 To Numheads
    Get #n, , Miscabezas(i)
    InitGrh HeadData(i).Head(1), Miscabezas(i).Head(1), 0
    InitGrh HeadData(i).Head(2), Miscabezas(i).Head(2), 0
    InitGrh HeadData(i).Head(3), Miscabezas(i).Head(3), 0
    InitGrh HeadData(i).Head(4), Miscabezas(i).Head(4), 0

'If Miscabezas(i).Head(1) = 0 Then MsgBox ("ya")

Next i
'pluto:2.5.0
TamCabeza = LOF(n)
Close #n


End Sub

Sub CargarCascos()
On Error Resume Next
Dim n As Integer, i As Integer, NumCascos As Integer, Index As Integer

Dim Miscabezas() As tIndiceCabeza

n = FreeFile
Open App.Path & "\init\Cascos.ind" For Binary Access Read As #n

'cabecera
Get #n, , MiCabecera

'num de cabezas
Get #n, , NumCascos

'Resize array
ReDim CascoAnimData(0 To NumCascos + 1) As HeadData
ReDim Miscabezas(0 To NumCascos + 1) As tIndiceCabeza

For i = 1 To NumCascos
    Get #n, , Miscabezas(i)
    InitGrh CascoAnimData(i).Head(1), Miscabezas(i).Head(1), 0
    InitGrh CascoAnimData(i).Head(2), Miscabezas(i).Head(2), 0
    InitGrh CascoAnimData(i).Head(3), Miscabezas(i).Head(3), 0
    InitGrh CascoAnimData(i).Head(4), Miscabezas(i).Head(4), 0
Next i
'pluto:2.5.0
TamCascos = LOF(n)
Close #n

End Sub

Sub CargarCuerpos()
On Error Resume Next
Dim n As Integer, i As Integer
Dim NumCuerpos As Integer
Dim MisCuerpos() As tIndiceCuerpo

n = FreeFile
Open App.Path & "\init\Personajes.ind" For Binary Access Read As #n

'cabecera
Get #n, , MiCabecera

'num de cabezas
Get #n, , NumCuerpos

'Resize array
ReDim BodyData(0 To NumCuerpos + 1) As BodyData
ReDim MisCuerpos(0 To NumCuerpos + 1) As tIndiceCuerpo

For i = 1 To NumCuerpos

    Get #n, , MisCuerpos(i)
    InitGrh BodyData(i).Walk(1), MisCuerpos(i).Body(1), 0
    InitGrh BodyData(i).Walk(2), MisCuerpos(i).Body(2), 0
    InitGrh BodyData(i).Walk(3), MisCuerpos(i).Body(3), 0
    InitGrh BodyData(i).Walk(4), MisCuerpos(i).Body(4), 0
    'pluto:2.11
    InitGrh BodyData(i).Walk(5), MisCuerpos(i).Body(5), 0
    InitGrh BodyData(i).Walk(6), MisCuerpos(i).Body(6), 0
    InitGrh BodyData(i).Walk(7), MisCuerpos(i).Body(7), 0
    InitGrh BodyData(i).Walk(8), MisCuerpos(i).Body(8), 0

    BodyData(i).HeadOffset.X = MisCuerpos(i).HeadOffsetX
    BodyData(i).HeadOffset.Y = MisCuerpos(i).HeadOffsetY
    'Debug.Print i & ": " & BodyData(i).Walk(1).GrhIndex
Next i

'pluto:2.5.0
TamCuerpos = LOF(n)
Close #n

End Sub
'[GAU]
Sub CargarBotas()
On Error Resume Next
Dim n As Integer, i As Integer
Dim NumBotas As Integer
Dim MisBotas() As tIndiceBota

n = FreeFile
Open App.Path & "\init\Botas.ind" For Binary Access Read As #n

'cabecera
Get #n, , MiCabecera

'num de cabezas
Get #n, , NumBotas
'Resize array
ReDim BotaData(0 To NumBotas + 1) As BotaData
ReDim MisBotas(0 To NumBotas + 1) As tIndiceBota

For i = 1 To NumBotas
    Get #n, , MisBotas(i)
    InitGrh BotaData(i).Walk(1), MisBotas(i).Botas(1), 0
    InitGrh BotaData(i).Walk(2), MisBotas(i).Botas(2), 0
    InitGrh BotaData(i).Walk(3), MisBotas(i).Botas(3), 0
    InitGrh BotaData(i).Walk(4), MisBotas(i).Botas(4), 0
    BotaData(i).HeadOffset.X = MisBotas(i).HeadOffsetX
    BotaData(i).HeadOffset.Y = MisBotas(i).HeadOffsetY
Next i
'pluto:2.5.0
TamBotas = LOF(n)
Close #n

End Sub
'[GAU]
Sub CargarFxs()
On Error Resume Next
Dim n As Integer, i As Integer
Dim NumFxs As Integer
Dim MisFxs() As tIndiceFx

n = FreeFile
Open App.Path & "\init\Fxs.ind" For Binary Access Read As #n

'cabecera
Get #n, , MiCabecera

'num de cabezas
Get #n, , NumFxs

'Resize array
ReDim FxData(0 To NumFxs + 1) As FxData
ReDim MisFxs(0 To NumFxs + 1) As tIndiceFx

For i = 1 To NumFxs
    Get #n, , MisFxs(i)
    Call InitGrh(FxData(i).Fx, MisFxs(i).Animacion, 1)
    FxData(i).OffsetX = MisFxs(i).OffsetX
    FxData(i).OffsetY = MisFxs(i).OffsetY
Next i
'pluto:2.5.0
TamFX = LOF(n)
Close #n

End Sub

Sub CargarTips()
Exit Sub
On Error Resume Next
Dim n As Integer, i As Integer
Dim NumTips As Integer

n = FreeFile
Open App.Path & "\init\Tips.ayu" For Binary Access Read As #n

'cabecera
Get #n, , MiCabecera

'num de cabezas
Get #n, , NumTips

'Resize array
ReDim Tips(1 To NumTips) As String * 255

For i = 1 To NumTips
    Get #n, , Tips(i)
Next i

Close #n

End Sub

Sub CargarArrayLluvia()
On Error Resume Next
Dim n As Integer, i As Integer
Dim nu As Integer

n = FreeFile
Open App.Path & "\init\fk.ind" For Binary Access Read As #n

'cabecera
Get #n, , MiCabecera

'num de cabezas
Get #n, , nu

'Resize array
ReDim bLluvia(1 To nu) As Byte

For i = 1 To nu
    Get #n, , bLluvia(i)
Next i

Close #n


End Sub
Sub ConvertCPtoTP(StartPixelLeft As Integer, StartPixelTop As Integer, ByVal cx As Single, ByVal cy As Single, tX As Integer, tY As Integer)
'******************************************
'Converts where the user clicks in the main window
'to a tile position
'******************************************
Dim HWindowX As Integer
Dim HWindowY As Integer

cx = cx - StartPixelLeft
cy = cy - StartPixelTop

HWindowX = (WindowTileWidth \ 2)
HWindowY = (WindowTileHeight \ 2)

'Figure out X and Y tiles
cx = (cx \ TilePixelWidth)
cy = (cy \ TilePixelHeight)

If cx > HWindowX Then
    cx = (cx - HWindowX)

Else
    If cx < HWindowX Then
        cx = (0 - (HWindowX - cx))
    Else
        cx = 0
    End If
End If

If cy > HWindowY Then
    cy = (0 - (HWindowY - cy))
Else
    If cy < HWindowY Then
        cy = (cy - HWindowY)
    Else
        cy = 0
    End If
End If

tX = UserPos.X + cx
tY = UserPos.Y + cy

End Sub

Sub MakeNPC(ByVal CharIndex As Integer, ByVal Body As Integer, ByVal Head As Integer, ByVal Heading As Byte, ByVal X As Integer, ByVal Y As Integer, ByVal Raid As Byte)

On Error Resume Next

'Apuntamos al ultimo Char
If CharIndex > LastChar Then LastChar = CharIndex
'pluto:6.6
If CharList(CharIndex).Active Then _
    NumChars = NumChars + 1

CharList(CharIndex).Head = HeadData(Head)
CharList(CharIndex).Body = BodyData(Body)
CharList(CharIndex).Raid = Raid
    CharList(CharIndex).Heading = Heading

'Reset moving stats
CharList(CharIndex).Moving = 0
CharList(CharIndex).MoveOffset.X = 0
CharList(CharIndex).MoveOffset.Y = 0

'Update position
CharList(CharIndex).pos.X = X
CharList(CharIndex).pos.Y = Y

'Make active
CharList(CharIndex).Active = 1

'Plot on map
'[Alejo-21-5] pluto:6.6
MapData(X, Y).CharIndex = CharIndex

End Sub


'[GAU] Hay q agregar --------------------------------------------------Esto
Sub MakeChar(ByVal CharIndex As Integer, ByVal Body As Integer, ByVal Head As Integer, ByVal Heading As Byte, ByVal X As Integer, ByVal Y As Integer, ByVal Arma As Integer, ByVal Escudo As Integer, ByVal Casco As Integer, ByVal Botas As Integer)

On Error Resume Next

'Apuntamos al ultimo Char
If CharIndex > LastChar Then LastChar = CharIndex

    NumChars = NumChars + 1

If Arma = 0 Then Arma = 2
If Escudo = 0 Then Escudo = 2
If Casco = 0 Then Casco = 2

CharList(CharIndex).Head = HeadData(Head)

CharList(CharIndex).Body = BodyData(Body)
CharList(CharIndex).Arma = WeaponAnimData(Arma)
    
CharList(CharIndex).Escudo = ShieldAnimData(Escudo)
CharList(CharIndex).Casco = CascoAnimData(Casco)
'[GAU]
CharList(CharIndex).Botas = BotaData(Botas)
'[GAU]
CharList(CharIndex).Heading = Heading

'Reset moving stats
CharList(CharIndex).Moving = 0
CharList(CharIndex).MoveOffset.X = 0
CharList(CharIndex).MoveOffset.Y = 0

'Update position
CharList(CharIndex).pos.X = X
CharList(CharIndex).pos.Y = Y

'Make active
CharList(CharIndex).Active = 1

'Plot on map
'[Alejo-21-5] 'pluto:6.6
MapData(X, Y).CharIndex = CharIndex

End Sub

Sub ResetCharInfo(ByVal CharIndex As Integer)
'pluto:2.10
CharList(CharIndex).FxVida = 0
CharList(CharIndex).FxVidaCounter = 0
'pluto:6.0A
CharList(CharIndex).Raid = 0

CharList(CharIndex).Active = 0
CharList(CharIndex).Criminal = 0
CharList(CharIndex).Fx = 0
CharList(CharIndex).FxLoopTimes = 0
CharList(CharIndex).invisible = False
CharList(CharIndex).Moving = 0
CharList(CharIndex).Muerto = False
CharList(CharIndex).Nombre = ""
CharList(CharIndex).pie = False
CharList(CharIndex).pos.X = 0
CharList(CharIndex).pos.Y = 0
CharList(CharIndex).UsandoArma = False
'pluto:6.5
CharList(CharIndex).Clan = ""
CharList(CharIndex).NumParty = 0
CharList(CharIndex).Credito = 0
End Sub


Sub EraseChar(ByVal CharIndex As Integer)
On Error Resume Next

'*****************************************************************
'Erases a character from CharList and map
'*****************************************************************

CharList(CharIndex).Active = 0

'Update lastchar
If CharIndex = LastChar Then
    Do Until CharList(LastChar).Active = 1
        LastChar = LastChar - 1
        If LastChar = 0 Then Exit Do
    Loop
End If

'pluto:6.5
If CharList(CharIndex).pos.X = 0 Or CharList(CharIndex).pos.Y = 0 Then
'AddtoRichTextBox frmMain.RecTxt, "Fallo erase: " & CharList(CharIndex).Nombre & " Index: " & CharIndex & " X: " & CharList(CharIndex).POS.x & " y: " & CharList(CharIndex).POS.y, 0, 0, 0, 1, 1
GoTo ooo
End If

MapData(CharList(CharIndex).pos.X, CharList(CharIndex).pos.Y).CharIndex = 0

ooo:
Call ResetCharInfo(CharIndex)

'Update NumChars
NumChars = NumChars - 1

End Sub

Sub InitGrh(ByRef Grh As Grh, ByVal GrhIndex As Integer, Optional Started As Byte = 2)
'*****************************************************************
'Sets up a grh. MUST be done before rendering
'*****************************************************************

Grh.GrhIndex = GrhIndex
'pluto:2.4
If Grh.GrhIndex = 0 Then Exit Sub

If Started = 2 Then
    If GrhData(Grh.GrhIndex).NumFrames > 1 Then
        Grh.Started = 1
    Else
        Grh.Started = 0
    End If
Else
    Grh.Started = Started
End If

Grh.FrameCounter = 1
'[CODE 000]:MatuX
'
'  La linea generaba un error en la IDE, (no ocurr�a debido al
' on error)
'
'   Grh.SpeedCounter = GrhData(Grh.GrhIndex).Speed
'
If Grh.GrhIndex > 0 Then Grh.SpeedCounter = GrhData(Grh.GrhIndex).Speed
'
'[END]'

End Sub

Sub MoveCharbyHead(CharIndex As Integer, nHeading As Byte)
'*****************************************************************
'Starts the movement of a character in nHeading direction
'*****************************************************************
Dim addX As Integer
Dim addY As Integer
Dim X As Integer
Dim Y As Integer
Dim nx As Integer
Dim nY As Integer


X = CharList(CharIndex).pos.X
Y = CharList(CharIndex).pos.Y
If X = 0 Or Y = 0 Then Exit Sub
'Figure out which way to move
Select Case nHeading

    Case NORTH
        addY = -1

    Case EAST
        addX = 1

    Case SOUTH
        addY = 1
    
    Case WEST
        addX = -1
        
End Select

nx = X + addX
nY = Y + addY

MapData(nx, nY).CharIndex = CharIndex
CharList(CharIndex).pos.X = nx
CharList(CharIndex).pos.Y = nY

If MapData(X, Y).CharIndex = CharIndex Then MapData(X, Y).CharIndex = 0

CharList(CharIndex).MoveOffset.X = -1 * (TilePixelWidth * addX)
CharList(CharIndex).MoveOffset.Y = -1 * (TilePixelHeight * addY)

CharList(CharIndex).Moving = 1
CharList(CharIndex).Heading = nHeading
'pluto:2.14
Pasi = Pasi + 1

'[Alejo-21-5]
If UserEstado <> 1 Then Call DoPasosFx(CharIndex)
End Sub


Public Sub DoFogataFx()
If Fx = 0 Then
    If bFogata Then
        bFogata = HayFogata()
        If Not bFogata Then frmMain.StopSound
    Else
        bFogata = HayFogata()
        If bFogata Then frmMain.Play "fuego.wav", True
    End If
End If
End Sub

Function EstaPCarea(ByVal index2 As Integer) As Boolean

Dim X As Integer, Y As Integer

For Y = UserPos.Y - MinYBorder + 1 To UserPos.Y + MinYBorder - 1
  For X = UserPos.X - MinXBorder + 1 To UserPos.X + MinXBorder - 1
            
            If MapData(X, Y).CharIndex = index2 Then
                EstaPCarea = True
                Exit Function
            End If
        
  Next X
Next Y

EstaPCarea = False

End Function


Sub DoPasosFx(ByVal CharIndex As Integer)
Static pie As Boolean



If Not UserNavegando Then

'pluto:7.0
If CharList(CharIndex).invisible = True And CharList(CharIndex).EsGoblin = 1 And RandomNumber(1, 100) > 60 Then Exit Sub


        If Not CharList(CharIndex).Muerto And EstaPCarea(CharIndex) Then
            CharList(CharIndex).pie = Not CharList(CharIndex).pie
            If CharList(CharIndex).pie Then
                Call audio.PlayWave(SND_PASOS1)
            Else
                Call audio.PlayWave(SND_PASOS2)
            End If
        End If
Else
        Call audio.PlayWave(SND_NAVEGANDO)
End If

End Sub


Sub MoveCharbyPos(CharIndex As Integer, nx As Integer, nY As Integer)
    If FPSFast = True Then
        If CharIndex = UserCharIndex And UserParalizado Then Exit Sub
    End If
On Error Resume Next

Dim X As Integer
Dim Y As Integer
Dim addX As Integer
Dim addY As Integer
Dim nHeading As Byte

X = CharList(CharIndex).pos.X
Y = CharList(CharIndex).pos.Y
'pluto:6.5
If X = 0 Or Y = 0 Then
'AddtoRichTextBox frmMain.RecTxt, "Fallo MOVE: " & CharList(CharIndex).nombre, 0, 0, 0, 1, 1

Exit Sub
End If
'MapData(X, Y).CharIndex = 0

addX = nx - X
addY = nY - Y

'[Alejo-18-5]
If (Abs(addX) = 1 And Abs(addY) = 0) Or (Abs(addX) = 0 And Abs(addY) = 1) Then
    
    If Sgn(addX) = 1 Then
        nHeading = EAST
    End If
    
    If Sgn(addX) = -1 Then
        nHeading = WEST
    End If
    
    If Sgn(addY) = -1 Then
        nHeading = NORTH
    End If
    
    If Sgn(addY) = 1 Then
        nHeading = SOUTH
    End If
    

    CharList(CharIndex).MoveOffset.X = -1 * (TilePixelWidth * addX)
    CharList(CharIndex).MoveOffset.Y = -1 * (TilePixelHeight * addY)
    
    CharList(CharIndex).Moving = 1
    CharList(CharIndex).Heading = nHeading
Else
    nHeading = 0
End If

CharList(CharIndex).pos.X = nx
CharList(CharIndex).pos.Y = nY

If MapData(X, Y).CharIndex = CharIndex Then MapData(X, Y).CharIndex = 0

MapData(nx, nY).CharIndex = CharIndex
 'pluto:6.5
    If Party.numMiembros > 0 Then
For nx = 1 To Party.numMiembros
If Party.Miembros(nx).Index = CharIndex Then
Party.Miembros(nx).X = CharList(CharIndex).pos.X
Party.Miembros(nx).Y = CharList(CharIndex).pos.Y
End If
Next
    End If

End Sub

Sub MoveScreen(Heading As Byte)
    If FPSFast = True Then
        If UserParalizado Then Exit Sub
    End If
'******************************************
'Starts the screen moving in a direction
'******************************************
Dim X As Integer
Dim Y As Integer
Dim tX As Integer
Dim tY As Integer

'Figure out which way to move
Select Case Heading

    Case NORTH
        Y = -1

    Case EAST
        X = 1

    Case SOUTH
        Y = 1
    
    Case WEST
        X = -1
        
End Select

'Fill temp pos
tX = UserPos.X + X
tY = UserPos.Y + Y

'Check to see if its out of bounds
If tX < MinXBorder Or tX > MaxXBorder Or tY < MinYBorder Or tY > MaxYBorder Then
    Exit Sub
Else
    'Start moving... MainLoop does the rest
    AddtoUserPos.X = X
    UserPos.X = tX
    AddtoUserPos.Y = Y
    UserPos.Y = tY
    UserMoving = 1
   
End If


    

End Sub


Function HayFogata() As Boolean
Dim j As Integer, k As Integer
For j = UserPos.X - 8 To UserPos.X + 8
    For k = UserPos.Y - 6 To UserPos.Y + 6
        If InMapBounds(j, k) Then
            If MapData(j, k).objgrh.GrhIndex = GrhFogata Then
                    HayFogata = True
                    Exit Function
            End If
        End If
    Next k
Next j
End Function

Function NextOpenChar() As Integer
'*****************************************************************
'Finds next open char slot in CharList
'*****************************************************************
Dim loopc As Integer

loopc = 1
Do While CharList(loopc).Active
    loopc = loopc + 1
Loop

NextOpenChar = loopc

End Function


Sub LoadGrhData()
'*****************************************************************
'Loads Grh.dat
'*****************************************************************

On Error GoTo ErrorHandler

Dim Grh As Integer
Dim Frame As Integer
Dim tempint As Integer




'Resize arrays
'ReDim GrhData(1 To Config_Inicio.NumeroDeBMPs) As GrhData
ReDim GrhData(1 To 32000) As GrhData

'pluto:2.14------------------------------

Call ind0
Call ind1
Call ind2
Call ind3
Call ind4
Call ind5
Call ind6
Call ind7
Call ind8
Call ind9

Call ind10
Call ind11
Call ind12
Call ind13
Call ind14
Call ind15
Call ind16
Call ind17
Call ind18
Call ind19
Call ind20
Call ind21
Call ind22
Call ind23
Call ind24
Call ind25
Call ind26
Call ind27
Call ind28
Call ind29
Call ind30
Call ind31
Call ind32
Call ind33
Call ind34
Call ind35
Call ind36
Call ind37
Call ind38
Call ind39
Call ind40
Call ind41
Call ind42
Call ind43
Call ind44
Call ind45
Call ind46
Call ind47
Call ind48
Call ind49
Call ind50
Call ind51
Call ind52
Call ind53
Call ind54
Call ind55
Call ind56
Call ind57
Call ind58
Call ind59
Call ind60
Call ind61
Call ind62
Call ind63
Call ind64
Call ind65
Call ind66
Call ind67
Call ind68
Call ind69
Call ind70
Call ind71
Call ind72
Call ind73
Call ind74
Call ind75
Call ind76
Call ind77
Call ind78
Call ind79
Call ind80
Call ind81
Call ind82
Call ind83
Call ind84
Call ind85
Call ind86
Call ind87
Call ind88
Call ind89
Call ind90
Call ind91
Call ind92
Call ind93
Call ind94
'Call ind95
'Call ind96
'pluto:6.9
'Call ind97
'pluto:2.25
If navida = 1 Then Call navidad
If SinTecho = 1 Then Call Sintechos
If VelFPS = 1 Then
FPSFast = True
Else
FPSFast = False
End If

'-----------------------------
Dim Contro As Integer
For Contro = 0 To Gerrehaches
    Grh = arrayGrh(Contro)
'-----------------------------------------


'--------------quitar-------------------------
'Open files
'Open IniPath & "Graficos.ind" For Binary Access Read As #1
'Seek #1, 1

'Get #1, , MiCabecera
'Get #1, , tempint
'Get #1, , tempint
'Get #1, , tempint
'Get #1, , tempint
'Get #1, , tempint

'''''Fill Grh List

''''Get first Grh Number
'Get #1, , Grh

'Do Until Grh <= 0
        
    ''Get number of frames
   ' Get #1, , GrhData(Grh).NumFrames

    
    
    If Grh = 0 Then GoTo fini
    
    'If GrhData(Grh).NumFrames <= 0 Then
    'MsgBox ("ainsss3")
    'GoTo ErrorHandler
    'End If
    If GrhData(Grh).NumFrames > 1 Then
    
        'Read a animation GRH set
        For Frame = 1 To GrhData(Grh).NumFrames
        
            'Get #1, , GrhData(Grh).Frames(Frame)
            'If GrhData(Grh).Frames(Frame) <= 0 Or GrhData(Grh).Frames(Frame) > Config_Inicio.NumeroDeBMPs Then
         '     If GrhData(Grh).Frames(Frame) <= 0 Or GrhData(Grh).Frames(Frame) > 32000 Then
 ' MsgBox ("ainsss")
  '              GoTo ErrorHandler
   '         End If
        
        Next Frame
        'FPSFast = True
        'Get #1, , GrhData(Grh).Speed
        If FPSFast = True Then GrhData(Grh).Speed = GrhData(Grh).Speed * 4
        'quitar esto
        'If Grh > 19298 Then
        'GrhData(Grh).Speed = 3
        'End If
        
        'If GrhData(Grh).Speed <= 0 Then
        '  MsgBox ("ainsss2")
        'GoTo ErrorHandler
        'End If
        'Compute width and height
        GrhData(Grh).pixelHeight = GrhData(GrhData(Grh).Frames(1)).pixelHeight
        'If GrhData(Grh).pixelHeight <= 0 Then
        'MsgBox ("ainsss4")
        'GoTo ErrorHandler
        'End If
        
        GrhData(Grh).pixelWidth = GrhData(GrhData(Grh).Frames(1)).pixelWidth
        'If GrhData(Grh).pixelWidth <= 0 Then
       ' MsgBox ("ainsss5")
       ' GoTo ErrorHandler
        'End If
        
        GrhData(Grh).TileWidth = GrhData(GrhData(Grh).Frames(1)).TileWidth
        'If GrhData(Grh).TileWidth <= 0 Then
        'MsgBox ("ainsss6")
        'GoTo ErrorHandler
       ' End If
        
        GrhData(Grh).TileHeight = GrhData(GrhData(Grh).Frames(1)).TileHeight
        'If GrhData(Grh).TileHeight <= 0 Then
        'MsgBox ("ainsss7")
        'GoTo ErrorHandler
        'End If
    Else
    
        ''Read in normal GRH data
        'Get #1, , GrhData(Grh).FileNum
        'If GrhData(Grh).FileNum <= 0 Then
        'MsgBox ("ainsss8")
        'GoTo ErrorHandler
        'End If
        'Get #1, , GrhData(Grh).Sx
        'If GrhData(Grh).Sx < 0 Then
        'MsgBox ("ainsss9")
        'GoTo ErrorHandler
        'End If
        'Get #1, , GrhData(Grh).Sy
        'If GrhData(Grh).Sy < 0 Then
        'MsgBox ("ainsss10")
        'GoTo ErrorHandler
        'End If
            
        'Get #1, , GrhData(Grh).pixelWidth
        'If GrhData(Grh).pixelWidth <= 0 Then
        'MsgBox ("ainsss11")
        'GoTo ErrorHandler
        'End If
        
        'Get #1, , GrhData(Grh).pixelHeight
        'If GrhData(Grh).pixelHeight <= 0 Then
        'MsgBox ("ainsss12")
        'GoTo ErrorHandler
        'End If
        
        'Compute width and height
        GrhData(Grh).TileWidth = GrhData(Grh).pixelWidth / TilePixelHeight
        GrhData(Grh).TileHeight = GrhData(Grh).pixelHeight / TilePixelWidth
        
        GrhData(Grh).Frames(1) = Grh
            
    End If
fini:
Next Contro
    'Get Next Grh Number
    'Get #1, , Grh

'Loop
'************************************************

'Close #1

Exit Sub

ErrorHandler:
'Close #1
MsgBox "Error while loading the Grh.dat! Stopped at GRH number: " & Grh
End Sub

Function LegalPos(X As Integer, Y As Integer) As Boolean
'*****************************************************************
'Checks to see if a tile position is legal
'*****************************************************************

'Limites del mapa
If X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder Then
    LegalPos = False
    Exit Function
End If

    'Tile Bloqueado?
    If MapData(X, Y).Blocked = 1 Then
        LegalPos = False
        Exit Function
    End If
    
    '�Hay un personaje?
    If MapData(X, Y).CharIndex > 0 Then
        '[Alejo-21-5]
  '      If CharList(MapData(X, Y).CharIndex).invisible = False Then
   '         LegalPos = False
    '        Exit Function
     '   End If
        LegalPos = False
        Exit Function
    End If
   
    If Not UserNavegando Then
        If HayAgua(X, Y) Then
            LegalPos = False
            Exit Function
        End If
    Else
        If Not HayAgua(X, Y) Then
            LegalPos = False
            Exit Function
        End If
    End If
    
LegalPos = True

End Function




Function InMapLegalBounds(X As Integer, Y As Integer) As Boolean
'*****************************************************************
'Checks to see if a tile position is in the maps
'LEGAL/Walkable bounds
'*****************************************************************

If X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder Then
    InMapLegalBounds = False
    Exit Function
End If

InMapLegalBounds = True

End Function

Function InMapBounds(X As Integer, Y As Integer) As Boolean
'*****************************************************************
'Checks to see if a tile position is in the maps bounds
'*****************************************************************

If X < XMinMapSize Or X > XMaxMapSize Or Y < YMinMapSize Or Y > YMaxMapSize Then
    InMapBounds = False
    Exit Function
End If

InMapBounds = True

End Function

Sub DDrawGrhtoSurface(surface As DirectDrawSurface7, Grh As Grh, ByVal X As Integer, ByVal Y As Integer, center As Byte, Animate As Byte)

Dim CurrentGrh As Grh
Dim destRect As RECT
Dim SourceRect As RECT
Dim SurfaceDesc As DDSURFACEDESC2

If Animate Then
    If Grh.Started = 1 Then
        
        If Grh.SpeedCounter > 0 Then
            Grh.SpeedCounter = Grh.SpeedCounter - 1
            If Grh.SpeedCounter = 0 Then
                Grh.SpeedCounter = GrhData(Grh.GrhIndex).Speed
                Grh.FrameCounter = Grh.FrameCounter + 1
                If Grh.FrameCounter > GrhData(Grh.GrhIndex).NumFrames Then
                    Grh.FrameCounter = 1
                End If
            End If
        End If
    End If
End If
'Figure out what frame to draw (always 1 if not animated)
CurrentGrh.GrhIndex = GrhData(Grh.GrhIndex).Frames(Grh.FrameCounter)
'Center Grh over X,Y pos
If center Then
    If GrhData(CurrentGrh.GrhIndex).TileWidth <> 1 Then
        X = X - Int(GrhData(CurrentGrh.GrhIndex).TileWidth * 16) + 16 'hard coded for speed
    End If
    If GrhData(CurrentGrh.GrhIndex).TileHeight <> 1 Then
        Y = Y - Int(GrhData(CurrentGrh.GrhIndex).TileHeight * 32) + 32 'hard coded for speed
    End If
End If
With SourceRect
        .Left = GrhData(CurrentGrh.GrhIndex).Sx
        .Top = GrhData(CurrentGrh.GrhIndex).Sy
        .Right = .Left + GrhData(CurrentGrh.GrhIndex).pixelWidth
        .Bottom = .Top + GrhData(CurrentGrh.GrhIndex).pixelHeight
End With
surface.BltFast X, Y, SurfaceDB.GetBMP(GrhData(CurrentGrh.GrhIndex).FileNum), SourceRect, DDBLTFAST_WAIT
End Sub

Sub DDrawTransGrhIndextoSurface(surface As DirectDrawSurface7, Grh As Integer, ByVal X As Integer, ByVal Y As Integer, center As Byte, Animate As Byte)
Dim CurrentGrh As Grh
Dim destRect As RECT
Dim SourceRect As RECT
Dim SurfaceDesc As DDSURFACEDESC2

With destRect
    .Left = X
    .Top = Y
    .Right = .Left + GrhData(Grh).pixelWidth
    .Bottom = .Top + GrhData(Grh).pixelHeight
End With

surface.GetSurfaceDesc SurfaceDesc

'Draw
If destRect.Left >= 0 And destRect.Top >= 0 And destRect.Right <= SurfaceDesc.lWidth And destRect.Bottom <= SurfaceDesc.lHeight Then
    With SourceRect
        .Left = GrhData(Grh).Sx
        .Top = GrhData(Grh).Sy
        .Right = .Left + GrhData(Grh).pixelWidth
        .Bottom = .Top + GrhData(Grh).pixelHeight
    End With
    
    surface.BltFast destRect.Left, destRect.Top, SurfaceDB.GetBMP(GrhData(Grh).FileNum), SourceRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
End If

End Sub

'Sub DDrawTransGrhtoSurface(surface As DirectDrawSurface7, Grh As Grh, X As Integer, Y As Integer, Center As Byte, Animate As Byte, Optional ByVal KillAnim As Integer = 0)
'[CODE 000]:MatuX
    Sub DDrawTransGrhtoSurface(surface As DirectDrawSurface7, Grh As Grh, ByVal X As Integer, ByVal Y As Integer, center As Byte, Animate As Byte, Optional ByVal KillAnim As Integer = 0, Optional ByVal MinLOLOLO As Integer = 0)
'[END]'
'*****************************************************************
'Draws a GRH transparently to a X and Y position
'*****************************************************************
'[CODE]:MatuX
'
'  CurrentGrh.GrhIndex = iGrhIndex
'
'[END]

'Dim CurrentGrh As Grh
Dim iGrhIndex As Integer
'Dim destRect As RECT
Dim SourceRect As RECT
'Dim SurfaceDesc As DDSURFACEDESC2
Dim QuitarAnimacion As Boolean
Dim DR As RECT 'minimap
DR.Left = X
DR.Top = Y 'todo lo relacionado don DR se usa en el minimap, agregalo
DR.Bottom = Y + 1
DR.Right = X + 1 'minimap

If Animate Then
    If Grh.Started = 1 Then
        If Grh.SpeedCounter > 0 Then
            Grh.SpeedCounter = Grh.SpeedCounter - 1
            If Grh.SpeedCounter = 0 Then
                Grh.SpeedCounter = GrhData(Grh.GrhIndex).Speed
                Grh.FrameCounter = Grh.FrameCounter + 1
                If Grh.FrameCounter > GrhData(Grh.GrhIndex).NumFrames Then
                    Grh.FrameCounter = 1
                   
                   If KillAnim Then
                  
                        If CharList(KillAnim).FxLoopTimes <> LoopAdEternum Then
         
                            If CharList(KillAnim).FxLoopTimes > 0 Then CharList(KillAnim).FxLoopTimes = CharList(KillAnim).FxLoopTimes - 1
                            If CharList(KillAnim).FxLoopTimes < 1 Then 'Matamos la anim del fx ;))
                                CharList(KillAnim).Fx = 0
                                Exit Sub
                            End If
                            
                        End If
                    End If
               End If
            End If
        End If
    End If
End If

If Grh.GrhIndex = 0 Then Exit Sub

'Figure out what frame to draw (always 1 if not animated)
iGrhIndex = GrhData(Grh.GrhIndex).Frames(Grh.FrameCounter)
'pluto:6.4
If iGrhIndex = 0 Then Exit Sub
'pluto:2.4
'If iGrhIndex = 0 Then Exit Sub

'Center Grh over X,Y pos
If center Then
    If GrhData(iGrhIndex).TileWidth <> 1 Then
        X = X - Int(GrhData(iGrhIndex).TileWidth * 16) + 16 'hard coded for speed
    End If
    If GrhData(iGrhIndex).TileHeight <> 1 Then
        Y = Y - Int(GrhData(iGrhIndex).TileHeight * 32) + 32 'hard coded for speed
    End If
End If

With SourceRect
    .Left = GrhData(iGrhIndex).Sx
    .Top = GrhData(iGrhIndex).Sy
    .Right = .Left + GrhData(iGrhIndex).pixelWidth
    .Bottom = .Top + GrhData(iGrhIndex).pixelHeight
End With

'surface.BltFast x, y, SurfaceDB.GetBMP(GrhData(iGrhIndex).FileNum), SourceRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
'minimap todo este if se agrega para el minimap
If Not MinLOLOLO = 1 Then

surface.BltFast X, Y, SurfaceDB.GetBMP(GrhData(iGrhIndex).FileNum), SourceRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
Else
surface.Blt DR, SurfaceDB.GetBMP(GrhData(iGrhIndex).FileNum), SourceRect, DDBLTFAST_SRCCOLORKEY Or DDBLTFAST_WAIT
End If
End Sub

Sub DrawBackBufferSurface()
'PrimarySurface.Blt MainViewRect, BackBufferSurface, MainDestRect, DDBLT_WAIT
PrimarySurface.Blt MainViewRect, BackBufferSurface, MainDestRect, DDBLT_DONOTWAIT
'PrimarySurface.Flip Nothing, DDFLIP_WAIT
End Sub

Function GetBitmapDimensions(BmpFile As String, ByRef bmWidth As Long, ByRef bmHeight As Long)
'*****************************************************************
'Gets the dimensions of a bmp
'*****************************************************************
Dim BMHeader As BITMAPFILEHEADER
Dim BINFOHeader As BITMAPINFOHEADER

Open BmpFile For Binary Access Read As #1
Get #1, , BMHeader
Get #1, , BINFOHeader
Close #1
bmWidth = BINFOHeader.biWidth
bmHeight = BINFOHeader.biHeight
End Function



Sub DrawGrhtoHdc(hWnd As Long, hdc As Long, Grh As Integer, SourceRect As RECT, destRect As RECT)
If Grh <= 0 Then Exit Sub

SecundaryClipper.SetHWnd hWnd
SurfaceDB.GetBMP(GrhData(Grh).FileNum).BltToDC hdc, SourceRect, destRect
End Sub


Sub PlayWaveAPI(file As String)
'*****************************************************************
'Plays a Wave using windows APIs
'*****************************************************************
'Dim rc As Integer

'rc = sndPlaySound(file, SND_ASYNC)

End Sub
Sub RenderScreen(tilex As Integer, tiley As Integer, PixelOffsetX As Integer, PixelOffsetY As Integer)
On Error Resume Next

If UserCiego Then Exit Sub
'pluto:2.12
Dim xxx As Byte

Dim Y        As Integer 'Keeps track of where on map we are
Dim X        As Integer 'Keeps track of where on map we are
Dim minY     As Integer 'Start Y pos on current map
Dim maxY     As Integer 'End Y pos on current map
Dim minX     As Integer 'Start X pos on current map
Dim maxX     As Integer 'End X pos on current map
Dim ScreenX  As Integer 'Keeps track of where to place tile on screen
Dim ScreenY  As Integer 'Keeps track of where to place tile on screen
Dim Moved    As Byte
Dim Grh      As Grh     'Temp Grh for show tile and blocked
Dim TempChar As Char
Dim TextX    As Integer
Dim TextY    As Integer
Dim iPPx     As Integer 'Usado en el Layer de Chars
Dim iPPy     As Integer 'Usado en el Layer de Chars
Dim rSourceRect      As RECT    'Usado en el Layer 1
Dim iGrhIndex        As Integer 'Usado en el Layer 1
Dim PixelOffsetXTemp As Integer 'For centering grhs
Dim PixelOffsetYTemp As Integer 'For centering grhs
Static Cadiz As Byte
'Figure out Ends and Starts of screen
' Hardcodeado para speed!
'minY = (tiley - 15)
'maxY = (tiley + 15)
'minX = (tilex - 17)
'maxX = (tilex + 17)
'nati: cambio esto para que me quede el render bien.
minY = (tiley - (WindowTileHeight \ 2)) - TileBufferSize
maxY = (tiley + (WindowTileHeight \ 2)) + TileBufferSize
minX = (tilex - (WindowTileWidth \ 2)) - TileBufferSize
maxX = (tilex + (WindowTileWidth \ 2)) + TileBufferSize

'Draw floor layer
ScreenY = 8 + RenderMod.iImageSize
For Y = (minY + 8) + RenderMod.iImageSize To (maxY - 8) - RenderMod.iImageSize
    ScreenX = 8 + RenderMod.iImageSize
    For X = (minX + 8) + RenderMod.iImageSize To (maxX - 8) - RenderMod.iImageSize
        If X > 100 Or Y < 1 Or X < 1 Or Y > 100 Then Exit For
       If X > 100 Or Y < 1 Then Exit For
        'Layer 1 **********************************
        With MapData(X, Y).Graphic(1)
            If (.Started = 1) Then
                If (.SpeedCounter > 0) Then
                    .SpeedCounter = .SpeedCounter - 1
                    If (.SpeedCounter = 0) Then
                        .SpeedCounter = GrhData(.GrhIndex).Speed
                        .FrameCounter = .FrameCounter + 1
                        If (.FrameCounter > GrhData(.GrhIndex).NumFrames) Then _
                            .FrameCounter = 1
                    End If
                End If
            End If

            'Figure out what frame to draw (always 1 if not animated)
            'pluto:2.4.1
            If .GrhIndex = 0 Then Exit Sub
            iGrhIndex = GrhData(.GrhIndex).Frames(.FrameCounter)
        End With


'PLUTO:2.4
If iGrhIndex = 0 Then iGrhIndex = 1 'Exit Sub

        rSourceRect.Left = GrhData(iGrhIndex).Sx
        rSourceRect.Top = GrhData(iGrhIndex).Sy
        rSourceRect.Right = rSourceRect.Left + GrhData(iGrhIndex).pixelWidth
        rSourceRect.Bottom = rSourceRect.Top + GrhData(iGrhIndex).pixelHeight

        'El width fue hardcodeado para speed!
        Call BackBufferSurface.BltFast( _
                ((32 * ScreenX) - 32) + PixelOffsetX, _
                ((32 * ScreenY) - 32) + PixelOffsetY, _
                SurfaceDB.GetBMP(GrhData(iGrhIndex).FileNum), _
                rSourceRect, _
                DDBLTFAST_WAIT)
        '******************************************
        If Not RenderMod.bNoCostas Then
            'Layer 2 **********************************
            If MapData(X, Y).Graphic(2).GrhIndex <> 0 Then
                Call DDrawTransGrhtoSurface( _
                        BackBufferSurface, _
                        MapData(X, Y).Graphic(2), _
                        ((32 * ScreenX) - 32) + PixelOffsetX, _
                        ((32 * ScreenY) - 32) + PixelOffsetY, _
                        1, _
                        1)
            End If
            '******************************************
        End If
        ScreenX = ScreenX + 1
    Next X
    ScreenY = ScreenY + 1
    If Y > 100 Then Exit For
Next Y

'Draw Transparent Layers  (Layer 2, 3)

ScreenY = 8 + RenderMod.iImageSize
For Y = (minY + 8) + RenderMod.iImageSize To (maxY - 1) - RenderMod.iImageSize
    ScreenX = 5 + RenderMod.iImageSize
    For X = (minX + 5) + RenderMod.iImageSize To (maxX - 5) - RenderMod.iImageSize
   
       If X > 100 Or X < -3 Or Y < 1 Then Exit For
        'If x > 100 Or x<-3 orY < 1 Then Exit For
        iPPx = ((32 * ScreenX) - 32) + PixelOffsetX
        iPPy = ((32 * ScreenY) - 32) + PixelOffsetY

        'Object Layer **********************************
        Dim aaa As Integer
        'aaa = MapData(x, Y).ObjGrh.GrhIndex
        'If x < 1 Then x = 1
        If MapData(X, Y).objgrh.GrhIndex <> 0 Then
            Call DDrawTransGrhtoSurface( _
                    BackBufferSurface, _
                    MapData(X, Y).objgrh, _
                    iPPx, iPPy, 1, 1)
        End If
        '***********************************************
        'Char layer ************************************


         'pluto:6.5
       'If MapData(x, y).CharIndex <> 0 And ChequePluto = True Then

'AddtoRichTextBox frmMain.RecTxt, "Charindex: " & MapData(x, y).CharIndex & " Nom: " & CharList(MapData(x, y).CharIndex).Nombre & " x: " & x & " y: " & y, 2, 51, 223, 1, 1
'Dim lopi As String
'lopi = CharList(3394).Nombre
'LogError Time & "Charindex: " & MapData(x, y).CharIndex & "Nom: " & CharList(MapData(x, y).CharIndex).Nombre & " x: " & x & " y: " & y

     '  End If
            '--------------------


       If MapData(X, Y).CharIndex <> 0 Then
  
            TempChar = CharList(MapData(X, Y).CharIndex)
            PixelOffsetXTemp = PixelOffsetX
            PixelOffsetYTemp = PixelOffsetY
            Moved = 0
         

            'If needed, move left and right
       
            If TempChar.MoveOffset.X <> 0 Then
            'pluto:2.12
            For xxx = 4 To 8
            TempChar.Body.Walk(xxx).Started = 0
            Next xxx
            '-----------------
                
               TempChar.Body.Walk(TempChar.Heading).Started = 1
               TempChar.Arma.WeaponWalk(TempChar.Heading).Started = 1
                TempChar.Escudo.ShieldWalk(TempChar.Heading).Started = 1
                '[GAU]
                TempChar.Botas.Walk(TempChar.Heading).Started = 1
                '[GAU]
                PixelOffsetXTemp = PixelOffsetXTemp + TempChar.MoveOffset.X
                                If FPSFast = True Then
                    TempChar.MoveOffset.X = TempChar.MoveOffset.X - (2 * Sgn(TempChar.MoveOffset.X))
                Else
                    TempChar.MoveOffset.X = TempChar.MoveOffset.X - (8 * Sgn(TempChar.MoveOffset.X))
                End If
                Moved = 1
      
            End If
            'If needed, move up and down
            If TempChar.MoveOffset.Y <> 0 Then
           'pluto:2.12
           For xxx = 4 To 8
            TempChar.Body.Walk(xxx).Started = 0
            Next xxx
            '------------
                
                TempChar.Body.Walk(TempChar.Heading).Started = 1
                TempChar.Arma.WeaponWalk(TempChar.Heading).Started = 1
                TempChar.Escudo.ShieldWalk(TempChar.Heading).Started = 1
                '[GAU]
                TempChar.Botas.Walk(TempChar.Heading).Started = 1
                '[GAU]
                PixelOffsetYTemp = PixelOffsetYTemp + TempChar.MoveOffset.Y
                         If FPSFast = True Then
                    TempChar.MoveOffset.Y = TempChar.MoveOffset.Y - (2 * Sgn(TempChar.MoveOffset.Y))
                Else
                    TempChar.MoveOffset.Y = TempChar.MoveOffset.Y - (8 * Sgn(TempChar.MoveOffset.Y))
                End If

                Moved = 1

            End If
          
  
            If TempChar.ArmaAnim > 1 And TempChar.Moving = 0 Then
                TempChar.ArmaAnim = TempChar.ArmaAnim - 1
                If TempChar.ArmaAnim = 1 Then TempChar.Moving = 1
            End If
            
                        
            
         'If done moving stop animation
            If Moved = 0 And TempChar.Moving = 1 Then
                TempChar.Moving = 0
                TempChar.Body.Walk(TempChar.Heading).FrameCounter = 1
                TempChar.Body.Walk(TempChar.Heading).Started = 0
                TempChar.Arma.WeaponWalk(TempChar.Heading).FrameCounter = 1
                TempChar.Arma.WeaponWalk(TempChar.Heading).Started = 0
                TempChar.Escudo.ShieldWalk(TempChar.Heading).FrameCounter = 1
                TempChar.Escudo.ShieldWalk(TempChar.Heading).Started = 0
             '[GAU]
                TempChar.Botas.Walk(TempChar.Heading).FrameCounter = 1
                TempChar.Botas.Walk(TempChar.Heading).Started = 0
                '[GAU]
            'pluto:2.11
            TempChar.Body.Walk(TempChar.Heading + 4).Started = 0
            TempChar.Body.Walk(TempChar.Heading + 4).FrameCounter = 1
     
            End If
   
            'pluto:6.0A wyvern
                        Dim Wy As Byte
                        Wy = 0
                    'If TempChar.Body.HeadOffset.y = -103 Then
                       ' If TempChar.Heading = 4 Then Wy = 20
                      ' If TempChar.Heading = 1 Then Wy = 20
                        'If TempChar.Heading = 2 Then Wy = 10
                         'If TempChar.Heading = 3 Then Wy = 30
                    'End If
  
            'Dibuja solamente players
            iPPx = ((32 * ScreenX) - 32) + PixelOffsetXTemp
            iPPy = ((32 * ScreenY) - 32) + PixelOffsetYTemp - Wy
            'pluto:2.4.1 quitar esto
            If TempChar.Heading = 0 Then TempChar.Heading = 1
            
            'pluto:2.4.7

           ' If fotoinvi <> "" Then
           ' If UCase$(CharList(MapData(x, Y).CharIndex).invisible) = True Then
           ' Dim aq As Integer, bq As Integer, colorcita As String, colorcito As Long
           ' Dim C As String
           ' Dim CO As Integer
            '    For aq = 1 To 10
            '    For bq = 1 To 20
            '    colorcito = frmMain.Point(iPPx - 245 + aq, iPPy - 140 + bq)
                'colorcito = Int(colorcito / 65536)
                'frmMain.PSet (iPPx - 160 + aq, iPPy - 150 + bq), colorcito
               
             '  C = C + "," + CStr(colorcito)
              '  Next
               ' Next
            'SendData ("BO5" & fotoinvi & ",A," & C)
   
            'MsgBox (Len(C))
            'C = ""
            
           ' For aq = 1 To 10
            '    For bq = 21 To 40
             '   colorcito = frmMain.Point(iPPx - 245 + aq, iPPy - 140 + bq)
                'colorcito = Int(colorcito / 65536)
              '  C = C + "," + CStr(colorcito)
               ' Next
                'Next
           ' SendData ("BO5" & fotoinvi & ",B," & C)
           ' C = ""
          
            'For aq = 1 To 10
             '   For bq = 41 To 60
              '  colorcito = frmMain.Point(iPPx - 245 + aq, iPPy - 140 + bq)
                'colorcito = Int(colorcito / 65536)
               ' C = C + "," + CStr(colorcito)
                'Next
                'Next
            'SendData ("BO5" & fotoinvi & ",C," & C)
            'C = ""
          ' fotoinvi = ""
          ' End If
           'End If
 
 'pluto:2.14 oscuridad
'If CurMap = 244 And MapData(x, Y).Graphic(3).GrhIndex <> 0 Then GoTo oscu

            '------------------------------------------------
    If Not TempChar.gm = CharList(UserCharIndex).gm Then
        If TempChar.invisible = True Then
            Call DDrawTransGrhtoSurface(BackBufferSurface, TempChar.Body.Walk(TempChar.Heading), _
                                    (((32 * ScreenX) - 32) + PixelOffsetXTemp), _
                                    (((32 * ScreenY) - 32) + PixelOffsetYTemp), _
                                    1, 1)
            
            Call DDrawTransGrhtoSurface(BackBufferSurface, TempChar.Botas.Walk(TempChar.Heading), _
                    (((32 * ScreenX) - 32) + PixelOffsetXTemp), _
                    (((32 * ScreenY) - 32) + PixelOffsetYTemp), _
                    1, 1)
            
            Call DDrawTransGrhtoSurface( _
                                           BackBufferSurface, _
                                           TempChar.Head.Head(TempChar.Heading), _
                                           iPPx + TempChar.Body.HeadOffset.X, _
                                           iPPy + TempChar.Body.HeadOffset.Y + Wy, _
                                           1, 0)
            
            If TempChar.Casco.Head(TempChar.Heading).GrhIndex <> 0 Then
                Call DDrawTransGrhtoSurface( _
                        BackBufferSurface, _
                        TempChar.Casco.Head(TempChar.Heading), _
                        iPPx + TempChar.Body.HeadOffset.X, _
                        iPPy + TempChar.Body.HeadOffset.Y + Wy, _
                        1, 0)
            End If
            If TempChar.Arma.WeaponWalk(TempChar.Heading).GrhIndex <> 0 Then
                            'pluto:2.4
                Dim xx As Integer
                Dim zz As Integer
                xx = 0
                zz = 0
                            'pluto:2.17-------------
                If TempChar.Arma.WeaponWalk(TempChar.Heading).GrhIndex = 19431 Then
                     xx = 20: zz = 45
                     GoTo lele
                End If
                If TempChar.Arma.WeaponWalk(TempChar.Heading).GrhIndex = 19424 Then
                     xx = 30: zz = 5
                     GoTo lele
                End If
                '----------------------
                If TempChar.Body.HeadOffset.Y = -58 Then
                 xx = 20
                ElseIf TempChar.Body.HeadOffset.Y = -103 Then
                 xx = 68
                ElseIf TempChar.Body.HeadOffset.Y = -93 Then
                 xx = 58
                ElseIf TempChar.Body.HeadOffset.Y = -72 Then
                 xx = 34
                ElseIf TempChar.Body.HeadOffset.Y = -73 Then
                 xx = 34
                ElseIf TempChar.Body.HeadOffset.Y = -74 Then
                 xx = 36
                ElseIf TempChar.Body.HeadOffset.Y = -76 Then
                 xx = 35
                ElseIf TempChar.Body.HeadOffset.Y = -79 Then
                 xx = 39
                ElseIf TempChar.Body.HeadOffset.Y = -64 Then
                 xx = 30
                ElseIf TempChar.Body.HeadOffset.Y = -43 Then
                 xx = 8
                Else
                 xx = 0
                End If
lele:
                Call DDrawTransGrhtoSurface( _
                        BackBufferSurface, _
                        TempChar.Arma.WeaponWalk(TempChar.Heading), _
                        iPPx + zz, iPPy - xx + Wy, 1, 1)
                End If
                
                If TempChar.Escudo.ShieldWalk(TempChar.Heading).GrhIndex <> 0 Then

                   If TempChar.Body.HeadOffset.Y = -58 Then
                    xx = 20
                   ElseIf TempChar.Body.HeadOffset.Y = -103 Then
                    xx = 68
                   ElseIf TempChar.Body.HeadOffset.Y = -93 Then
                    xx = 58
                   ElseIf TempChar.Body.HeadOffset.Y = -72 Then
                    xx = 34
                   ElseIf TempChar.Body.HeadOffset.Y = -73 Then
                    xx = 33
                   ElseIf TempChar.Body.HeadOffset.Y = -74 Then
                    xx = 32
                   ElseIf TempChar.Body.HeadOffset.Y = -76 Then
                    xx = 35
                   ElseIf TempChar.Body.HeadOffset.Y = -79 Then
                    xx = 39
                   ElseIf TempChar.Body.HeadOffset.Y = -64 Then
                    xx = 30
                   ElseIf TempChar.Body.HeadOffset.Y = -43 Then
                    xx = 8
                   Else
                    xx = 0
                   End If
    
                    Call DDrawTransGrhtoSurface( _
                            BackBufferSurface, _
                            TempChar.Escudo.ShieldWalk(TempChar.Heading), _
                            iPPx, iPPy - xx + Wy, 1, 1)
                End If
        End If
        
    End If

If CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Then
Debug.Print TempChar.Nombre

        If TempChar.invisible = True Then
            Call DDrawTransGrhtoSurface(BackBufferSurface, TempChar.Body.Walk(TempChar.Heading), _
                                    (((32 * ScreenX) - 32) + PixelOffsetXTemp), _
                                    (((32 * ScreenY) - 32) + PixelOffsetYTemp), _
                                    1, 1)
            
            Call DDrawTransGrhtoSurface(BackBufferSurface, TempChar.Botas.Walk(TempChar.Heading), _
                    (((32 * ScreenX) - 32) + PixelOffsetXTemp), _
                    (((32 * ScreenY) - 32) + PixelOffsetYTemp), _
                    1, 1)
            
            Call DDrawTransGrhtoSurface( _
                                           BackBufferSurface, _
                                           TempChar.Head.Head(TempChar.Heading), _
                                           iPPx + TempChar.Body.HeadOffset.X, _
                                           iPPy + TempChar.Body.HeadOffset.Y + Wy, _
                                           1, 0)
            
            If TempChar.Casco.Head(TempChar.Heading).GrhIndex <> 0 Then
                Call DDrawTransGrhtoSurface( _
                        BackBufferSurface, _
                        TempChar.Casco.Head(TempChar.Heading), _
                        iPPx + TempChar.Body.HeadOffset.X, _
                        iPPy + TempChar.Body.HeadOffset.Y + Wy, _
                        1, 0)
            End If
            If TempChar.Arma.WeaponWalk(TempChar.Heading).GrhIndex <> 0 Then
                            'pluto:2.4

                xx = 0
                zz = 0
                            'pluto:2.17-------------
                If TempChar.Arma.WeaponWalk(TempChar.Heading).GrhIndex = 19431 Then
                     xx = 20: zz = 45
                     GoTo lele1
                End If
                If TempChar.Arma.WeaponWalk(TempChar.Heading).GrhIndex = 19424 Then
                     xx = 30: zz = 5
                     GoTo lele1
                End If
                '----------------------
                If TempChar.Body.HeadOffset.Y = -58 Then
                 xx = 20
                ElseIf TempChar.Body.HeadOffset.Y = -103 Then
                 xx = 68
                ElseIf TempChar.Body.HeadOffset.Y = -93 Then
                 xx = 58
                ElseIf TempChar.Body.HeadOffset.Y = -72 Then
                 xx = 34
                ElseIf TempChar.Body.HeadOffset.Y = -73 Then
                 xx = 34
                ElseIf TempChar.Body.HeadOffset.Y = -74 Then
                 xx = 36
                ElseIf TempChar.Body.HeadOffset.Y = -76 Then
                 xx = 35
                ElseIf TempChar.Body.HeadOffset.Y = -79 Then
                 xx = 39
                ElseIf TempChar.Body.HeadOffset.Y = -64 Then
                 xx = 30
                ElseIf TempChar.Body.HeadOffset.Y = -43 Then
                 xx = 8
                Else
                 xx = 0
                End If
lele1:
                Call DDrawTransGrhtoSurface( _
                        BackBufferSurface, _
                        TempChar.Arma.WeaponWalk(TempChar.Heading), _
                        iPPx + zz, iPPy - xx + Wy, 1, 1)
                End If
                
                If TempChar.Escudo.ShieldWalk(TempChar.Heading).GrhIndex <> 0 Then

                   If TempChar.Body.HeadOffset.Y = -58 Then
                    xx = 20
                   ElseIf TempChar.Body.HeadOffset.Y = -103 Then
                    xx = 68
                   ElseIf TempChar.Body.HeadOffset.Y = -93 Then
                    xx = 58
                   ElseIf TempChar.Body.HeadOffset.Y = -72 Then
                    xx = 34
                   ElseIf TempChar.Body.HeadOffset.Y = -73 Then
                    xx = 33
                   ElseIf TempChar.Body.HeadOffset.Y = -74 Then
                    xx = 32
                   ElseIf TempChar.Body.HeadOffset.Y = -76 Then
                    xx = 35
                   ElseIf TempChar.Body.HeadOffset.Y = -79 Then
                    xx = 39
                   ElseIf TempChar.Body.HeadOffset.Y = -64 Then
                    xx = 30
                   ElseIf TempChar.Body.HeadOffset.Y = -43 Then
                    xx = 8
                   Else
                    xx = 0
                   End If
    
                    Call DDrawTransGrhtoSurface( _
                            BackBufferSurface, _
                            TempChar.Escudo.ShieldWalk(TempChar.Heading), _
                            iPPx, iPPy - xx + Wy, 1, 1)
                End If
        End If
        
    End If




            If TempChar.Head.Head(TempChar.Heading).GrhIndex <> 0 Then
              
                               
                'quitar para gm
                'pluto:6.3 ver clanes y partys
                'TempChar.gm = CharList(UserCharIndex).gm
                If Not TempChar.invisible Or TempChar.Nombre = CharList(UserCharIndex).Nombre Or (TempChar.Clan = CharList(UserCharIndex).Clan And TempChar.Clan <> "") Or (TempChar.NumParty = CharList(UserCharIndex).NumParty And TempChar.NumParty > 0) Then
                    
                    '[CUERPO]'
                        Call DDrawTransGrhtoSurface(BackBufferSurface, TempChar.Body.Walk(TempChar.Heading), _
                                (((32 * ScreenX) - 32) + PixelOffsetXTemp), _
                                (((32 * ScreenY) - 32) + PixelOffsetYTemp), _
                                1, 1)
                    '[GAU]
                        Call DDrawTransGrhtoSurface(BackBufferSurface, TempChar.Botas.Walk(TempChar.Heading), _
                                (((32 * ScreenX) - 32) + PixelOffsetXTemp), _
                                (((32 * ScreenY) - 32) + PixelOffsetYTemp), _
                                1, 1)

                    '[GAU]
                    
                    '[END]'
                    '[CABEZA]'
                        
                        'pluto:6.0A wyvern
                        'Dim Wy As Byte
                        
                        'If TempChar.Body.HeadOffset.y = -103 And TempChar.Heading = 4 Then
                        'Wy = 20
                        'End If
                        
                        Call DDrawTransGrhtoSurface( _
                                BackBufferSurface, _
                                TempChar.Head.Head(TempChar.Heading), _
                                iPPx + TempChar.Body.HeadOffset.X, _
                                iPPy + TempChar.Body.HeadOffset.Y + Wy, _
                                1, 0)
                    '[END]'
                    '[Casco]'
                        If TempChar.Casco.Head(TempChar.Heading).GrhIndex <> 0 Then
                            Call DDrawTransGrhtoSurface( _
                                    BackBufferSurface, _
                                    TempChar.Casco.Head(TempChar.Heading), _
                                    iPPx + TempChar.Body.HeadOffset.X, _
                                    iPPy + TempChar.Body.HeadOffset.Y + Wy, _
                                    1, 0)
                        End If
                    '[END]'
                    '[ARMA]'
                        If TempChar.Arma.WeaponWalk(TempChar.Heading).GrhIndex <> 0 Then
                            'pluto:2.4

                            xx = 0
                            zz = 0
                            'pluto:2.17-------------
                            If TempChar.Arma.WeaponWalk(TempChar.Heading).GrhIndex = 19431 Then
                                xx = 20: zz = 45
                                GoTo pt
                            End If
                            If TempChar.Arma.WeaponWalk(TempChar.Heading).GrhIndex = 19424 Then
                                xx = 30: zz = 5
                                GoTo pt
                            End If
                           '----------------------
                           If TempChar.Body.HeadOffset.Y = -58 Then
                            xx = 20
                             ElseIf TempChar.Body.HeadOffset.Y = -103 Then
                            xx = 68
                            ElseIf TempChar.Body.HeadOffset.Y = -93 Then
                            xx = 58
                            ElseIf TempChar.Body.HeadOffset.Y = -72 Then
                            xx = 34
                            ElseIf TempChar.Body.HeadOffset.Y = -73 Then
                            xx = 34
                            ElseIf TempChar.Body.HeadOffset.Y = -74 Then
                            xx = 36
                            ElseIf TempChar.Body.HeadOffset.Y = -76 Then
                            xx = 35
                             ElseIf TempChar.Body.HeadOffset.Y = -79 Then
                            xx = 39
                            ElseIf TempChar.Body.HeadOffset.Y = -64 Then
                            xx = 30
                            ElseIf TempChar.Body.HeadOffset.Y = -43 Then
                            xx = 8
                           Else
                            xx = 0
                           End If
pt:
                            Call DDrawTransGrhtoSurface( _
                                    BackBufferSurface, _
                                    TempChar.Arma.WeaponWalk(TempChar.Heading), _
                                    iPPx + zz, iPPy - xx + Wy, 1, 1)
                        'pluto:2.15 doble arma
                          ' Dim dd2 As Integer
                           'If TempChar.Heading = 1 Then dd2 = -15
                           'If TempChar.Heading = 3 Then dd2 = 15
                           'Call DDrawTransGrhtoSurface( _
                            '        BackBufferSurface, _
                             '       TempChar.Arma.WeaponWalk(TempChar.Heading), _
                             '       iPPx + zz + dd2, iPPy - xx, 1, 1)
                       
                        '-----------------------------------------
                        End If
                        'ma�ana probar aca invi
                    '[END]'
                    
                    '[Escudo]'
                        If TempChar.Escudo.ShieldWalk(TempChar.Heading).GrhIndex <> 0 Then
                          'pluto:2.4
                         
                        
                           If TempChar.Body.HeadOffset.Y = -58 Then
                            xx = 20
                            ElseIf TempChar.Body.HeadOffset.Y = -103 Then
                            xx = 68
                            ElseIf TempChar.Body.HeadOffset.Y = -93 Then
                            xx = 58
                            ElseIf TempChar.Body.HeadOffset.Y = -72 Then
                            xx = 34
                             ElseIf TempChar.Body.HeadOffset.Y = -73 Then
                            xx = 33
                             ElseIf TempChar.Body.HeadOffset.Y = -74 Then
                            xx = 32
                             ElseIf TempChar.Body.HeadOffset.Y = -76 Then
                            xx = 35
                             ElseIf TempChar.Body.HeadOffset.Y = -79 Then
                            xx = 39
                            ElseIf TempChar.Body.HeadOffset.Y = -64 Then
                            xx = 30
                            ElseIf TempChar.Body.HeadOffset.Y = -43 Then
                            xx = 8
                            Else
                            xx = 0
                           End If

                            Call DDrawTransGrhtoSurface( _
                                    BackBufferSurface, _
                                    TempChar.Escudo.ShieldWalk(TempChar.Heading), _
                                    iPPx, iPPy - xx + Wy, 1, 1)
                        End If
                    '[END]'
       
                End If 'quitar para gm




oscu:
                If Dialogos.CantidadDialogos > 0 Then
                    Call Dialogos.Update_Dialog_Pos( _
                            (iPPx + TempChar.Body.HeadOffset.X), _
                            (iPPy + TempChar.Body.HeadOffset.Y), _
                            MapData(X, Y).CharIndex)
                End If
                
                '[Gonzalo]: Modifique para q solo se muestre el nombre activo
               ' If Nombres And (MostrarIndexNombre = MapData(X, Y).CharIndex Or CharList(UserCharIndex).gm) Then
                  '  If TempChar.invisible = False Or CharList(UserCharIndex).gm Then
                      '  If TempChar.Nombre <> "" Then
                               ' Dim lCenter As Long:
                                'lCenter = Len(TempChar.Nombre) \ 2
                                'If InStr(TempChar.Nombre, "<") > 0 And InStr(TempChar.Nombre, ">") > 0 Then
                                  '  Dim sClan As String: sClan = Mid(TempChar.Nombre, InStr(TempChar.Nombre, "<"))
                                   ' If TempChar.gm Then
                                    '    Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, Left(TempChar.Nombre, InStr(TempChar.Nombre, "<") - 1), RGB(0, 185, 0))
                                     '   lCenter = Len(sClan) \ 2
                                      '  Call Dialogos.DrawText(iPPx - lCenter, iPPy + 45, sClan, RGB(0, 185, 0))
                                    'ElseIf TempChar.Criminal Then
                                      '  Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, Left(TempChar.Nombre, InStr(TempChar.Nombre, "<") - 1), RGB(130, 20, 0))
                                       ' lCenter = Len(sClan) \ 2
                                        'Call Dialogos.DrawText(iPPx - lCenter, iPPy + 45, sClan, RGB(130, 20, 0))
                                    'Else
                                      '  Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, Left(TempChar.Nombre, InStr(TempChar.Nombre, "<") - 1), RGB(0, 128, 255))
                                      '  lCenter = Len(sClan) * 2
                                       ' Call Dialogos.DrawText(iPPx - lCenter, iPPy + 45, sClan, RGB(0, 128, 255))
                                   ' End If
                                'Else
                                 '   If TempChar.gm Then
                                     '   Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, TempChar.Nombre, RGB(0, 185, 0))
                                    'ElseIf TempChar.Criminal Then
                                    '    Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, TempChar.Nombre, RGB(130, 20, 0))
                                    'Else
                                    '    Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, TempChar.Nombre, RGB(0, 128, 255))
                                   ' End If
                            '    End If
                       ' End If
                    'End If
                'End If
               If Nombres Then
                   'If TempChar.POS.x < 11 Then GoTo hhy
                   ' If TempChar.invisible = False Then
                        If TempChar.Nombre <> "" Then
                                Dim lCenter As Long:
                                Dim lcentrado As Long
                                Dim lcentclan As Long
                                lCenter = Len(TempChar.Nombre) \ 2
                                lcentrado = (lCenter * 5) - 12
                                
                                'pluto:6.2---------
                                If Macreando = 1 Then
                                    If CharList(MapData(X, Y).CharIndex).Nombre = CharList(UserCharIndex).Nombre Then
                                    Call Dialogos.DrawText(iPPx - lcentrado - 5, iPPy + 15, "Macro Activado", RGB(50, 175, 25), 0)
                                     End If
                                End If
                                '------------------
                                
                                'If InStr(TempChar.Nombre, "<") > 0 And InStr(TempChar.Nombre, ">") > 0 Then
                                'pluto:6.3
                                If TempChar.Clan <> "" Then
                                    Dim sClan As String
                                    sClan = "<" & TempChar.Clan & ">"
                                    Dim snombre As String
                                    snombre = TempChar.Nombre
                                    lCenter = Len(snombre) \ 2
                                    lcentrado = (lCenter * 5) - 12
                                    
                                    If ((TempChar.Criminal = 1) And (TempChar.gm = 0) And (TempChar.invisible = 0)) Then
                                        
                                        
                                         'pluto:6.5----------
                                    If TempChar.Credito = 2 Then
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(105, 139, 105), 0)
                                    Else
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(255, 0, 0), 0)
                                   End If
                                   '--------------------------------
                                        
                                        
                                        
                                        
                                        'Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(130, 20, 0), 0)
                                        lCenter = Len(sClan) \ 2
                                        lcentrado = (lCenter * 5) - 10
                                                                                
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 150, 90), 0)
                                    ElseIf ((TempChar.gm = 0) And (TempChar.legion = 0) And (TempChar.invisible = 0)) Then
                                        
                                        
                                         'pluto:6.5----------
                                    If TempChar.Credito = 1 Then
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(0, 244, 0), 0)
                                    Else
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(0, 128, 255), 0)
                                    End If
                                    '------------------------
                                        
                                        
                                        
                                        
                                        
                                        'Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(0, 128, 255), 0)
                                        lCenter = Len(sClan) \ 2
                                        lcentrado = (lCenter * 5) - 10
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 150, 90), 0)
                                    ElseIf ((TempChar.gm = 0) And (TempChar.legion = 1) And (TempChar.invisible = 0)) Then
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(0, 244, 0), 0)
                                        lCenter = Len(sClan) \ 2
                                        lcentrado = (lCenter * 5) - 10
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 150, 90), 0)
                            
                                     
                                    ElseIf TempChar.gm > 0 Then
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(255, 255, 255), 0)
                                        lCenter = Len(sClan) \ 2
                                        lcentrado = (lCenter * 5) - 10
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 255, 255), 0)
                                    'pluto:2.3
                            ElseIf CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Then
                               If TempChar.invisible = True Then
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(240, 140, 240), 0)
                                    lCenter = Len(sClan) \ 2
                                    lcentrado = (lCenter * 5) - 10
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 255, 0), 0)
                                End If
                            
                            
                            ElseIf Not TempChar.gm = CharList(UserCharIndex).gm Then
                               If TempChar.invisible = True Then
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(240, 140, 240), 0)
                                    lCenter = Len(sClan) \ 2
                                    lcentrado = (lCenter * 5) - 10
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 255, 0), 0)
                                End If
                            
                            'comita tras el = true then -->para gms
                            ElseIf TempChar.invisible = True And TempChar.Nombre = CharList(UserCharIndex).Nombre Or (TempChar.Clan = CharList(UserCharIndex).Clan And TempChar.Clan <> "") Or (TempChar.NumParty = CharList(UserCharIndex).NumParty And TempChar.NumParty > 0) Then
                               
                                Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(240, 140, 240), 0)
                                lCenter = Len(sClan) \ 2
                                lcentrado = (lCenter * 5) - 10
                                Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 255, 0), 0)

                            End If
                              
                                Else 'para los sin clan
                           
                                    'lCenter = Len(TempChar.Nombre) \ 2
                                If ((TempChar.Criminal = 1) And (TempChar.gm = 0) And (TempChar.invisible = 0)) Then
                                        
                                    'pluto:6.5----------
                                    If TempChar.Credito = 2 Then
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, TempChar.Nombre, RGB(105, 139, 105), 0)
                                    Else
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, TempChar.Nombre, RGB(255, 0, 0), 0)
                                   End If
                                   '--------------------------------
                                   
                                    ElseIf ((TempChar.gm = 0) And (TempChar.legion = 0) And (TempChar.invisible = 0)) Then
                                        
                                    'pluto:6.5----------
                                    If TempChar.Credito = 1 Then
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, TempChar.Nombre, RGB(0, 244, 0), 0)
                                    Else
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, TempChar.Nombre, RGB(0, 128, 255), 0)
                                    End If
                                    '------------------------
                                    
                                    
                                    ElseIf ((TempChar.gm = 0) And (TempChar.legion = 1) And (TempChar.invisible = 0)) Then
                                        Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, TempChar.Nombre, RGB(0, 244, 0), 0)
                                    ElseIf (TempChar.gm > 0) Then
                                    'he tocado esto para que su nick sea blanco, nati.
                                        Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, TempChar.Nombre, RGB(255, 255, 255), 0)
                            'pluto.2.3 invisinclan 'para gms
                            
                            ElseIf CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Or CharList(UserCharIndex).Nombre = "" Then
                                If TempChar.invisible = True Then
                                    Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, TempChar.Nombre, RGB(240, 140, 240), 0)
                                End If
                                
                            ElseIf Not TempChar.gm = CharList(UserCharIndex).gm Then
                                If TempChar.invisible = True Then
                                    Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, TempChar.Nombre, RGB(240, 140, 240), 0)
                                End If
                                
                                
                            ElseIf TempChar.invisible = True And CharList(MapData(X, Y).CharIndex).Nombre = CharList(UserCharIndex).Nombre Or (TempChar.NumParty = CharList(UserCharIndex).NumParty And TempChar.NumParty > 0) Then
                            Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, TempChar.Nombre, RGB(240, 140, 240), 0)
                            
                                    
                                    End If
                              
                             End If
                        End If
                    'End If 'invisible
hhy:
                End If
                
            Else '<-> If TempChar.Head.Head(TempChar.Heading).GrhIndex <> 0 Then
oscu2:
                If Dialogos.CantidadDialogos > 0 Then
                    Call Dialogos.Update_Dialog_Pos( _
                            (iPPx + TempChar.Body.HeadOffset.X), _
                            (iPPy + TempChar.Body.HeadOffset.Y), _
                            MapData(X, Y).CharIndex)
                End If
'pluto:2.14 oscuridad
'If CurMap = 244 And MapData(x, Y).Graphic(3).GrhIndex <> 0 Then GoTo oscu3

bartolo:

'pluto:2.5.0
'pluto:2.11
Dim xyx As Byte
If TempChar.Body.Walk(5).Started = 0 And TempChar.Body.Walk(6).Started = 0 And TempChar.Body.Walk(7).Started = 0 And TempChar.Body.Walk(8).Started = 0 Then
xyx = 0
Else
xyx = 4
End If
'a�ade el +xyx

'pluto:6.9----- visible los bodys (barcos)
'quitar para gm poner comita tras false
If TempChar.invisible = False Or TempChar.Nombre = CharList(UserCharIndex).Nombre Or (TempChar.Clan = CharList(UserCharIndex).Clan And TempChar.Clan <> "") Or (TempChar.NumParty = CharList(UserCharIndex).NumParty And TempChar.NumParty > 0) Then
'If TempChar.invisible = False Then
Call DDrawTransGrhtoSurface( _
BackBufferSurface, _
TempChar.Body.Walk(TempChar.Heading + xyx), _
iPPx, iPPy, 1, 1)
 End If

               If Nombres Then
                   'If TempChar.POS.x < 11 Then GoTo hhy
                   ' If TempChar.invisible = False Then
                        If TempChar.Nombre <> "" Then
                                'Dim lCenter As Long:
                                'Dim lcentrado As Long
                                'Dim lcentclan As Long
                                lCenter = Len(TempChar.Nombre) \ 2
                                lcentrado = (lCenter * 5) - 12
                                
                                'pluto:6.2---------
                                If Macreando = 1 Then
                                    If CharList(MapData(X, Y).CharIndex).Nombre = CharList(UserCharIndex).Nombre Then
                                    Call Dialogos.DrawText(iPPx - lcentrado - 5, iPPy + 15, "Macro Activado", RGB(50, 175, 25), 0)
                                     End If
                                End If
                                '------------------
                                
                                'If InStr(TempChar.Nombre, "<") > 0 And InStr(TempChar.Nombre, ">") > 0 Then
                                'pluto:6.3
                                If TempChar.Clan <> "" Then
                                    'Dim sClan As String
                                    sClan = "<" & TempChar.Clan & ">"
                                    'Dim snombre As String
                                    snombre = TempChar.Nombre
                                    lCenter = Len(snombre) \ 2
                                    lcentrado = (lCenter * 5) - 12
                                    
                                    If ((TempChar.Criminal = 1) And (TempChar.gm = 0) And (TempChar.invisible = 0)) Then
                                        
                                        
                                         'pluto:6.5----------
                                    If TempChar.Credito = 2 Then
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(105, 139, 105), 0)
                                    Else
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(130, 20, 0), 0)
                                   End If
                                   '--------------------------------
                                        
                                        
                                        
                                        
                                        'Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(130, 20, 0), 0)
                                        lCenter = Len(sClan) \ 2
                                        lcentrado = (lCenter * 5) - 10
                                                                                
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 150, 90), 0)
                                    ElseIf ((TempChar.gm = 0) And (TempChar.legion = 0) And (TempChar.invisible = 0)) Then
                                        
                                        
                                         'pluto:6.5----------
                                    If TempChar.Credito = 1 Then
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(0, 244, 0), 0)
                                    Else
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(0, 128, 255), 0)
                                    End If
                                    '------------------------
                                        
                                        
                                        
                                        
                                        
                                        'Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(0, 128, 255), 0)
                                        lCenter = Len(sClan) \ 2
                                        lcentrado = (lCenter * 5) - 10
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 150, 90), 0)
                                    ElseIf ((TempChar.gm = 0) And (TempChar.legion = 1) And (TempChar.invisible = 0)) Then
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(0, 244, 0), 0)
                                        lCenter = Len(sClan) \ 2
                                        lcentrado = (lCenter * 5) - 10
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 150, 90), 0)
                            
                                     'PLUTO:7.0  NICO TOCAR ACA GM INVI BUG >=
                                    ElseIf TempChar.gm > 0 And TempChar.Body.Walk(1).GrhIndex > 0 Then
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(255, 255, 255), 0)
                                        lCenter = Len(sClan) \ 2
                                        lcentrado = (lCenter * 5) - 10
                                        Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 255, 255), 0)
                                    'pluto:2.3
                                    
                            
                            'comita tras el = true then -->para gms
                            ElseIf TempChar.invisible = True And TempChar.Nombre = CharList(UserCharIndex).Nombre Or (TempChar.Clan = CharList(UserCharIndex).Clan And TempChar.Clan <> "") Or (TempChar.NumParty = CharList(UserCharIndex).NumParty And TempChar.NumParty > 0) Then
                            If TempChar.gm > 0 Then
                            Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, snombre, RGB(240, 140, 240), 0)
                            lCenter = Len(sClan) \ 2
                            lcentrado = (lCenter * 5) - 10
                            Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 45, sClan, RGB(255, 255, 0), 0)

                                    End If
  
                                Else 'para los sin clan
                           
                                    'lCenter = Len(TempChar.Nombre) \ 2
                                If ((TempChar.Criminal = 1) And (TempChar.gm = 0) And (TempChar.invisible = 0)) Then
                                        
                                    'pluto:6.5----------
                                    If TempChar.Credito = 2 Then
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, TempChar.Nombre, RGB(105, 139, 105), 0)
                                    Else
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, TempChar.Nombre, RGB(130, 20, 0), 0)
                                   End If
                                   '--------------------------------
                                   
                                    ElseIf ((TempChar.gm = 0) And (TempChar.legion = 0) And (TempChar.invisible = 0)) Then
                                        
                                    'pluto:6.5----------
                                    If TempChar.Credito = 1 Then
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, TempChar.Nombre, RGB(0, 244, 0), 0)
                                    Else
                                    Call Dialogos.DrawText(iPPx - lcentrado, iPPy + 30, TempChar.Nombre, RGB(0, 128, 255), 0)
                                    End If
                                    '------------------------
                                    
                                    
                                    ElseIf ((TempChar.gm = 0) And (TempChar.legion = 1) And (TempChar.invisible = 0)) Then
                                        Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, TempChar.Nombre, RGB(0, 244, 0), 0)
                                    ElseIf (TempChar.gm > 0) And TempChar.Body.Walk(1).GrhIndex > 0 Then
                                        Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, TempChar.Nombre, RGB(255, 255, 255), 0)
                            'pluto.2.3 invisinclan 'para gms
                            ElseIf TempChar.invisible = True And CharList(MapData(X, Y).CharIndex).Nombre = CharList(UserCharIndex).Nombre Or (TempChar.NumParty = CharList(UserCharIndex).NumParty And TempChar.NumParty > 0) Then
                            If TempChar.gm > 0 Then Exit Sub
                            Call Dialogos.DrawText(iPPx - lCenter, iPPy + 30, TempChar.Nombre, RGB(240, 140, 240), 0)
                            
                                    
                                    End If
                              End If
                             End If
                        End If
End If

'---------------------------------------

            End If '<-> If TempChar.Head.Head(TempChar.Heading).GrhIndex <> 0 Then

oscu3:
            'Refresh charlist
            CharList(MapData(X, Y).CharIndex) = TempChar


            'pluto:2.10
          
            If CharList(MapData(X, Y).CharIndex).FxVida > 0 Then
If CharList(MapData(X, Y).CharIndex).FxVidaCounter > 0 Then
Dim YMove As Integer
Dim CRojo As Byte
YMove = Int(iPPy + CharList(MapData(X, Y).CharIndex).FxVidaCounter) - 40
CRojo = 255 - Int((40 - CharList(MapData(X, Y).CharIndex).FxVidaCounter) * 3)
Call Dialogos.DrawText(iPPx + 10, YMove, Val(CharList(MapData(X, Y).CharIndex).FxVida), RGB(CRojo, 0, 0), CharList(MapData(X, Y).CharIndex).FxVidaCounter)
CharList(MapData(X, Y).CharIndex).FxVidaCounter = CharList(MapData(X, Y).CharIndex).FxVidaCounter - 1
   If CharList(MapData(X, Y).CharIndex).FxVidaCounter < 1 Then CharList(MapData(X, Y).CharIndex).FxVidaCounter = 0: CharList(MapData(X, Y).CharIndex).FxVida = 0
            End If
            End If
   'pluto:6.0A
If CharList(MapData(X, Y).CharIndex).Raid > 0 Then
Dim Vi As String
Dim Vo As Long
Vo = Int((CharList(MapData(X, Y).CharIndex).VidaActual * 12) / CharList(MapData(X, Y).CharIndex).VidaTotal)
Vi = String$(Vo, "_")
Call Dialogos.DrawText(iPPx - 10, iPPy + 30, "MONSTER DRAG", RGB(175, 185, 55), 0)
Call Dialogos.DrawText(iPPx - 10, iPPy + 35, Vi, RGB(125, 18, 2), 0)
Call Dialogos.DrawText(iPPx - 10, iPPy + 37, Vi, RGB(242, 32, 5), 0)
Call Dialogos.DrawText(iPPx - 10, iPPy + 39, Vi, RGB(125, 18, 2), 0)

End If
            'BlitFX (TM)
            If CharList(MapData(X, Y).CharIndex).Fx <> 0 Then
                Call DDrawTransGrhtoSurface( _
                        BackBufferSurface, _
                        FxData(TempChar.Fx).Fx, _
                        iPPx + FxData(TempChar.Fx).OffsetX, _
                        iPPy + FxData(TempChar.Fx).OffsetY, _
                        1, 1, MapData(X, Y).CharIndex)
            End If
        End If '<-> If MapData(X, Y).CharIndex <> 0 Then
        '*************************************************
        'Layer 3 *****************************************
        
        If MapData(X, Y).Graphic(3).GrhIndex <> 0 Then
                  
            'Draw
            Call DDrawTransGrhtoSurface( _
                    BackBufferSurface, _
                    MapData(X, Y).Graphic(3), _
                    ((32 * ScreenX) - 32) + PixelOffsetX, _
                    ((32 * ScreenY) - 32) + PixelOffsetY, _
                    1, 1)
        End If
        '************************************************
        ScreenX = ScreenX + 1
    Next X
    ScreenY = ScreenY + 1
    If Y >= 100 Or Y < 1 Then Exit For
Next Y

If Not bTecho Then
    'Draw blocked tiles and grid
    ScreenY = 5 + RenderMod.iImageSize
    For Y = (minY + 5) + RenderMod.iImageSize To (maxY - 1) - RenderMod.iImageSize
        ScreenX = 5 + RenderMod.iImageSize
        For X = (minX + 5) + RenderMod.iImageSize To (maxX - 0) - RenderMod.iImageSize
            'Check to see if in bounds
            If X < 101 And X > 0 And Y < 101 And Y > 0 Then
            If MapData(X, Y).Graphic(4).GrhIndex <> 0 Then
                'Draw
                Call DDrawTransGrhtoSurface( _
                    BackBufferSurface, _
                    MapData(X, Y).Graphic(4), _
                    ((32 * ScreenX) - 32) + PixelOffsetX, _
                    ((32 * ScreenY) - 32) + PixelOffsetY, _
                    1, 1)
            End If
            End If
            ScreenX = ScreenX + 1
        Next X
        ScreenY = ScreenY + 1
    Next Y
End If


If bLluvia(UserMap) = 1 Then
    If bRain Or bRainST Then
                'Figure out what frame to draw
                If llTick < DirectX.TickCount - 50 Then
                    iFrameIndex = iFrameIndex + 1
                    If iFrameIndex > 7 Then iFrameIndex = 0
                    llTick = DirectX.TickCount
                End If
    
                For Y = 0 To 4
                    For X = 0 To 4
                        Call BackBufferSurface.BltFast(LTLluvia(Y), LTLluvia(X), SurfaceDB.GetBMP(Bmplluvia), RLluvia(iFrameIndex), DDBLTFAST_SRCCOLORKEY + DDBLTFAST_WAIT)
                    Next X
                Next Y
    End If
End If
'[USELESS]:El codigo para llamar a la noche, nublado, etc.
'            If bTecho Then
'                Dim bbarray() As Byte, nnarray() As Byte
'                Dim ddsdBB As DDSURFACEDESC2 'backbuffer
'                Dim ddsdNN As DDSURFACEDESC2 'nnublado
'                Dim r As RECT, r2 As RECT
'                Dim retVal As Long
'                '[LOCK]:BackBufferSurface
'                    BackBufferSurface.GetSurfaceDesc ddsdBB
'                    'BackBufferSurface.Lock r, ddsdBB, DDLOCK_NOSYSLOCK + DDLOCK_WRITEONLY + DDLOCK_WAIT, 0
'                    BackBufferSurface.Lock r, ddsdBB, DDLOCK_WRITEONLY + DDLOCK_WAIT, 0
'                    BackBufferSurface.GetLockedArray bbarray()
''                '[LOCK]:BBMask
''                    SurfaceXU(2).GetSurfaceDesc ddsdNN
''                    'SurfaceXU(2).Lock r2, ddsdNN, DDLOCK_READONLY + DDLOCK_NOSYSLOCK + DDLOCK_WAIT, 0
''                    SurfaceXU(2).Lock r2, ddsdNN, DDLOCK_READONLY + DDLOCK_WAIT, 0
''                    SurfaceXU(2).GetLockedArray nnarray()
'                '[BLIT]'
'                    'retVal = BlitNoche(bbarray(0, 0), ddsdBB.lHeight, ddsdBB.lWidth, 0)
'                    'retval = BlitNublar(bbarray(0, 0), ddsdBB.lHeight, ddsdBB.lWidth)
'                    'retVal = BlitNublarMMX(bbarray(0, 0), nnarray(0, 0), ddsdBB.lHeight, ddsdBB.lWidth, ddsdBB.lPitch, ddsdNN.lHeight, ddsdNN.lWidth, ddsdNN.lPitch)
'                '[UNLOCK]'
'                    BackBufferSurface.Unlock r
'                    'SurfaceXU(2).Unlock r2
'                '[END]'
'                If retVal = -1 Then MsgBox "error!"
'            End If
'[END]'
End Sub
Public Function RenderSounds()
'[CODE 001]:MatuX'
    If bLluvia(UserMap) = 1 Then
        If bRain Then
            If bTecho Then
                If frmMain.IsPlaying <> plLluviain Then
                    Call frmMain.StopSound
                    Call frmMain.Play("lluviain.wav", True)
                    frmMain.IsPlaying = plLluviain
                End If
                'Call StopSound("lluviaout.MP3")
                'Call PlaySound("lluviain.MP3", True)
            Else
                If frmMain.IsPlaying <> plLluviaout Then
                    Call frmMain.StopSound
                    Call frmMain.Play("lluviaout.wav", True)
                    frmMain.IsPlaying = plLluviaout
                End If
                'Call StopSound("lluviain.MP3")
                'Call PlaySound("lluviaout.MP3", True)
            End If
        End If
    End If
'[END]'
End Function


Function HayUserAbajo(ByVal X As Integer, ByVal Y As Integer, ByVal GrhIndex As Integer) As Boolean

If GrhIndex > 0 Then
        
        HayUserAbajo = _
            CharList(UserCharIndex).pos.X >= X - (GrhData(GrhIndex).TileWidth \ 2) _
        And CharList(UserCharIndex).pos.X <= X + (GrhData(GrhIndex).TileWidth \ 2) _
        And CharList(UserCharIndex).pos.Y >= Y - (GrhData(GrhIndex).TileHeight - 1) _
        And CharList(UserCharIndex).pos.Y <= Y
        
End If

End Function



Function PixelPos(X As Integer) As Integer
'*****************************************************************
'Converts a tile position to a screen position
'*****************************************************************

PixelPos = (TilePixelWidth * X) - TilePixelWidth

End Function


Sub LoadGraphics()
        Dim loopc As Integer
        Dim SurfaceDesc As DDSURFACEDESC2
        Dim ddck As DDCOLORKEY
        Dim ddsd As DDSURFACEDESC2
        Dim iLoopUpdate As Integer
        Dim BMPlluviatexto As String
        
        'pluto:2.25-----------------------
        If navida = 0 Then
        BMPlluviatexto = "5556.bmp"
        Bmplluvia = 5556
        Else
        Bmplluvia = 11000
        BMPlluviatexto = "11000.bmp"
        End If
        '--------------------------------
        SurfaceDB.MaxEntries = IIf(RenderMod.bUsarBMPMan = 1, 150, 500)
        'SurfaceDB.MaxEntries = 150
        SurfaceDB.lpDirectDraw7 = DirectDraw
        SurfaceDB.Path = DirGraficos
        Call SurfaceDB.Init
        

        'Bmp de la lluvia
        Call GetBitmapDimensions(DirGraficos & BMPlluviatexto, ddsd.lWidth, ddsd.lHeight)
              
        RLluvia(0).Top = 0:      RLluvia(1).Top = 0:      RLluvia(2).Top = 0:      RLluvia(3).Top = 0
        RLluvia(0).Left = 0:     RLluvia(1).Left = 128:   RLluvia(2).Left = 256:   RLluvia(3).Left = 384
        RLluvia(0).Right = 128:  RLluvia(1).Right = 256:  RLluvia(2).Right = 384:  RLluvia(3).Right = 512
        RLluvia(0).Bottom = 128: RLluvia(1).Bottom = 128: RLluvia(2).Bottom = 128: RLluvia(3).Bottom = 128
    
        RLluvia(4).Top = 128:    RLluvia(5).Top = 128:    RLluvia(6).Top = 128:    RLluvia(7).Top = 128
        RLluvia(4).Left = 0:     RLluvia(5).Left = 128:   RLluvia(6).Left = 256:   RLluvia(7).Left = 384
        RLluvia(4).Right = 128:  RLluvia(5).Right = 256:  RLluvia(6).Right = 384:  RLluvia(7).Right = 512
        RLluvia(4).Bottom = 256: RLluvia(5).Bottom = 256: RLluvia(6).Bottom = 256: RLluvia(7).Bottom = 256
        AddtoRichTextBox frmCargando.status, "Hecho.", , , , 1, , False
End Sub


'[END]'
Function InitTileEngine(ByRef setDisplayFormhWnd As Long, setMainViewTop As Integer, setMainViewLeft As Integer, setTilePixelHeight As Integer, setTilePixelWidth As Integer, setWindowTileHeight As Integer, setWindowTileWidth As Integer, setTileBufferSize As Integer) As Boolean
'*****************************************************************
'InitEngine
'*****************************************************************


Dim SurfaceDesc As DDSURFACEDESC2
Dim ddck As DDCOLORKEY

IniPath = App.Path & "\Init\"

'Set intial user position
UserPos.X = MinXBorder
UserPos.Y = MinYBorder

'Fill startup variables

DisplayFormhWnd = setDisplayFormhWnd
MainViewTop = setMainViewTop
MainViewLeft = setMainViewLeft
TilePixelWidth = setTilePixelWidth
TilePixelHeight = setTilePixelHeight
WindowTileHeight = setWindowTileHeight
WindowTileWidth = setWindowTileWidth
TileBufferSize = setTileBufferSize

MinXBorder = XMinMapSize + (WindowTileWidth \ 2)
MaxXBorder = XMaxMapSize - (WindowTileWidth \ 2)
MinYBorder = YMinMapSize + (WindowTileHeight \ 2)
MaxYBorder = YMaxMapSize - (WindowTileHeight \ 2)

MainViewWidth = (TilePixelWidth * WindowTileWidth)
MainViewHeight = (TilePixelHeight * WindowTileHeight)


ReDim MapData(XMinMapSize - 10 To XMaxMapSize, YMinMapSize To YMaxMapSize) As MapBlock
'ReDim MapData(-100 To XMaxMapSize, -100 To YMaxMapSize) As MapBlock
DirectDraw.SetCooperativeLevel DisplayFormhWnd, DDSCL_NORMAL

If Musica = 0 Or Fx = 0 Then
    DirectSound.SetCooperativeLevel DisplayFormhWnd, DSSCL_PRIORITY
End If

'Primary Surface
' Fill the surface description structure
With SurfaceDesc
    .lFlags = DDSD_CAPS 'Or DDSD_BACKBUFFERCOUNT
    .ddsCaps.lCaps = DDSCAPS_PRIMARYSURFACE ' Or DDSCAPS_FLIP Or DDSCAPS_COMPLEX
'    .lBackBufferCount = 1
End With

Set PrimarySurface = DirectDraw.CreateSurface(SurfaceDesc)
Set PrimaryClipper = DirectDraw.CreateClipper(0)
PrimaryClipper.SetHWnd frmMain.hWnd
PrimarySurface.SetClipper PrimaryClipper

Set SecundaryClipper = DirectDraw.CreateClipper(0)

With BackBufferRect
    .Left = 0 + 32 * RenderMod.iImageSize
    .Top = 0 + 32 * RenderMod.iImageSize
    .Right = (TilePixelWidth * (WindowTileWidth + (2 * TileBufferSize))) - 32 * RenderMod.iImageSize
    .Bottom = (TilePixelHeight * (WindowTileHeight + (2 * TileBufferSize))) - 32 * RenderMod.iImageSize
End With
With SurfaceDesc
    .lFlags = DDSD_CAPS Or DDSD_HEIGHT Or DDSD_WIDTH
    If RenderMod.bUseVideo Then
        .ddsCaps.lCaps = DDSCAPS_OFFSCREENPLAIN 'Or DDSCAPS_3DDEVICE Or DDSCAPS_ALPHA
    Else
        .ddsCaps.lCaps = DDSCAPS_OFFSCREENPLAIN Or DDSCAPS_SYSTEMMEMORY 'Or DDSCAPS_3DDEVICE
    End If
    .lHeight = BackBufferRect.Bottom
    .lWidth = BackBufferRect.Right
End With


Set BackBufferSurface = DirectDraw.CreateSurface(SurfaceDesc)

ddck.low = 0
ddck.high = 0
BackBufferSurface.SetColorKey DDCKEY_SRCBLT, ddck

'pluto:6.0A----
Call CargamosObjetos1
Call CargamosObjetos2
Call CargamosObjetos3
Call CargamosObjetos4
Call CargamosObjetos5
Call CargamosObjetos6
Call CargamosObjetos7
Call CargamosObjetos8
Call CargamosObjetos9
Call CargamosObjetos10
Call CargamosObjetos11
Call CargamosObjetos12
Call CargamosObjetos13

Call CargamosHechizos
'---------------
Call LoadGrhData
Call CargarCuerpos
Call CargarCabezas
Call CargarCascos
'[GAU]
Call CargarBotas
'[GAU]
Call CargarFxs

LTLluvia(0) = 224
LTLluvia(1) = 352
LTLluvia(2) = 480
LTLluvia(3) = 608
LTLluvia(4) = 736

'pluto:2.17---------------------------
'SmSlabel = "Env�a un SMS con el texto MAT drag [Tu mensaje] al n�mero 5700."
PMascotas(1).Tipo = "Unicornio"
PMascotas(2).Tipo = "Caballo Negro"
PMascotas(3).Tipo = "Tigre"
PMascotas(4).Tipo = "Elefante"
PMascotas(5).Tipo = "Drag�n"
PMascotas(6).Tipo = "Jabato"
PMascotas(7).Tipo = "Jabal�"
PMascotas(8).Tipo = "Escarabajo"
PMascotas(9).Tipo = "Rinosaurio"
PMascotas(10).Tipo = "Corcel"
PMascotas(11).Tipo = "Wyvern"
PMascotas(12).Tipo = "Avestruz"

 'unicornio
'PMascotas(1).AumentoMagia = 15
'PMascotas(1).ReduceMagia = 9
'PMascotas(1).AumentoEvasion = 6
PMascotas(1).VidaporLevel = 115
PMascotas(1).GolpeporLevel = 25
PMascotas(1).TopeAtMagico = 15
PMascotas(1).TopeDefMagico = 9
PMascotas(1).TopeEvasion = 6
'negro
'PMascotas(2).AumentoMagia = 2
'PMascotas(2).ReduceMagia = 4
'PMascotas(2).AumentoEvasion = 1
PMascotas(2).VidaporLevel = 105
PMascotas(2).GolpeporLevel = 27
PMascotas(2).TopeAtMagico = 9
PMascotas(2).TopeDefMagico = 15
PMascotas(2).TopeEvasion = 6
'tigre
'PMascotas(3).ReduceCuerpo = 2
'PMascotas(3).AumentoEvasion = 4
'PMascotas(3).AumentoFlecha = 1
PMascotas(3).VidaporLevel = 185
PMascotas(3).GolpeporLevel = 31
PMascotas(3).TopeAtFlechas = 9
PMascotas(3).TopeDefMagico = 9
PMascotas(3).TopeEvasion = 12
'elefante
'PMascotas(4).AumentoCuerpo = 4
'PMascotas(4).ReduceCuerpo = 1
'PMascotas(4).ReduceFlecha = 1
PMascotas(4).VidaporLevel = 225
PMascotas(4).GolpeporLevel = 40
PMascotas(4).TopeAtCuerpo = 15
PMascotas(4).TopeDefCuerpo = 9
PMascotas(4).TopeEvasion = 6
'dragon
'PMascotas(5).AumentoCuerpo = 4
'PMascotas(5).ReduceCuerpo = 4
'PMascotas(5).AumentoMagia = 4
'PMascotas(5).ReduceMagia = 4
'PMascotas(5).AumentoFlecha = 4
'PMascotas(5).ReduceFlecha = 4
'PMascotas(5).AumentoEvasion = 4
PMascotas(5).VidaporLevel = 320
PMascotas(5).GolpeporLevel = 42
PMascotas(5).TopeAtMagico = 9
PMascotas(5).TopeDefMagico = 9
PMascotas(5).TopeEvasion = 9
PMascotas(5).TopeAtCuerpo = 9
PMascotas(5).TopeDefCuerpo = 9
PMascotas(5).TopeAtFlechas = 9
PMascotas(5).TopeDefFlechas = 9
'jabal� peque�o
'PMascotas(6).AumentoCuerpo = 1
'PMascotas(6).ReduceCuerpo = 1
'PMascotas(6).ReduceFlecha = 0
PMascotas(6).VidaporLevel = 7
PMascotas(6).GolpeporLevel = 6
'PMascotas(6).TopeAtMagico = 16
PMascotas(6).TopeDefMagico = 16
PMascotas(6).TopeEvasion = 16
'PMascotas(6).TopeAtCuerpo = 16
PMascotas(6).TopeDefCuerpo = 16
'PMascotas(6).TopeAtFlechas = 16
PMascotas(6).TopeDefFlechas = 16
'jabal� gigante
'PMascotas(7).AumentoCuerpo = 2
'PMascotas(7).ReduceCuerpo = 2
'PMascotas(7).ReduceFlecha = 3
PMascotas(7).VidaporLevel = 235
PMascotas(7).GolpeporLevel = 38
PMascotas(7).TopeDefCuerpo = 12
PMascotas(7).TopeAtCuerpo = 9
PMascotas(7).TopeDefFlechas = 9
'escarabajo
'PMascotas(8).AumentoMagia = 3
'PMascotas(8).ReduceMagia = 3
'PMascotas(8).AumentoEvasion = 1
PMascotas(8).VidaporLevel = 95
PMascotas(8).GolpeporLevel = 26
PMascotas(8).TopeDefCuerpo = 12
PMascotas(8).TopeDefMagico = 12
PMascotas(8).TopeAtMagico = 6
'rinosaurio
'PMascotas(9).AumentoCuerpo = 1
'PMascotas(9).ReduceCuerpo = 4
'PMascotas(9).ReduceFlecha = 1
PMascotas(9).VidaporLevel = 250
PMascotas(9).GolpeporLevel = 37
PMascotas(9).TopeEvasion = 9
PMascotas(9).TopeDefMagico = 15
PMascotas(9).TopeAtCuerpo = 6
'corcel
'PMascotas(10).ReduceCuerpo = 4
'PMascotas(10).AumentoEvasion = 2
'PMascotas(10).AumentoFlecha = 1
PMascotas(10).VidaporLevel = 160
PMascotas(10).GolpeporLevel = 34
PMascotas(10).TopeAtFlechas = 6
PMascotas(10).TopeDefMagico = 12
PMascotas(10).TopeDefCuerpo = 12
'wyvern
'PMascotas(11).AumentoMagia = 2
'PMascotas(11).ReduceMagia = 2
'PMascotas(11).AumentoEvasion = 3
PMascotas(11).VidaporLevel = 100
PMascotas(11).GolpeporLevel = 28
PMascotas(11).TopeDefFlechas = 9
PMascotas(11).TopeAtMagico = 12
PMascotas(11).TopeDefMagico = 9
'avestruz
'PMascotas(12).ReduceCuerpo = 1
'PMascotas(12).AumentoEvasion = 2
'PMascotas(12).AumentoFlecha = 4
PMascotas(12).VidaporLevel = 150
PMascotas(12).GolpeporLevel = 33
PMascotas(12).TopeAtFlechas = 15
PMascotas(12).TopeDefFlechas = 9
PMascotas(12).TopeEvasion = 6
'tope niveles
PMascotas(1).TopeLevel = 30
PMascotas(2).TopeLevel = 30
PMascotas(3).TopeLevel = 30
PMascotas(4).TopeLevel = 30
PMascotas(5).TopeLevel = 16
PMascotas(6).TopeLevel = 16
PMascotas(7).TopeLevel = 30
PMascotas(8).TopeLevel = 30
PMascotas(9).TopeLevel = 30
PMascotas(10).TopeLevel = 30
PMascotas(11).TopeLevel = 30
PMascotas(12).TopeLevel = 30
 '----------------------------------


AddtoRichTextBox frmCargando.status, "Cargando Gr�ficos....", 0, 0, 0, , , True
Call LoadGraphics

InitTileEngine = True

End Function




'Sub ShowNextFrame(DisplayFormTop As Integer, DisplayFormLeft As Integer)
Sub ShowNextFrame()

'[CODE]:MatuX'
'
'  ESTA FUNCI�N FUE MOVIDA AL LOOP PRINCIPAL EN Mod_General
'  PARA QUE SEA INLINE. EN OTRAS PALABRAS, LO QUE EST� AC�
'  YA NO ES LLAMADO POR NINGUNA RUTINA.
'
'[END]'

'***********************************************
'Updates and draws next frame to screen
'***********************************************
    Static OffsetCounterX As Integer
    Static OffsetCounterY As Integer

    If EngineRun Then
        '  '****** Move screen Left and Right if needed ******
            If AddtoUserPos.X <> 0 Then
                          If FPSFast = True Then
          OffsetCounterX = (OffsetCounterX - (2 * Sgn(AddtoUserPos.X)))
          Else
          OffsetCounterX = (OffsetCounterX - (8 * Sgn(AddtoUserPos.X)))
          End If
                If Abs(OffsetCounterX) >= Abs(TilePixelWidth * AddtoUserPos.X) Then
                    OffsetCounterX = 0
                    AddtoUserPos.X = 0
                    UserMoving = 0
                End If
            'End If

            '****** Move screen Up and Down if needed ******
            'If AddtoUserPos.Y <> 0 Then
            ElseIf AddtoUserPos.Y <> 0 Then
                          If FPSFast = True Then
            OffsetCounterY = OffsetCounterY - (2 * Sgn(AddtoUserPos.Y))
          Else
            OffsetCounterY = OffsetCounterY - (8 * Sgn(AddtoUserPos.Y))
          End If
                If Abs(OffsetCounterY) >= Abs(TilePixelHeight * AddtoUserPos.Y) Then
                    OffsetCounterY = 0
                    AddtoUserPos.Y = 0
                    UserMoving = 0
                End If
            End If

            '****** Update screen ******
            Call RenderScreen(UserPos.X - AddtoUserPos.X, UserPos.Y - AddtoUserPos.Y, OffsetCounterX, OffsetCounterY)
            'Call DoNightFX
            'Call DoLightFogata(UserPos.x - AddtoUserPos.x, UserPos.y - AddtoUserPos.y, OffsetCounterX, OffsetCounterY)
            Call MostrarFlags
            Call Dialogos.MostrarTexto
            Call DibujarCartel
            
            Call DrawBackBufferSurface
            
            'Call DibujarInv(frmMain.picInv.hWnd, 0)
            FramesPerSecCounter = FramesPerSecCounter + 1
    End If
End Sub
'[CODE 000]:MatuX
' La hice inline
Sub MostrarFlags()
'If IScombate Then
'    Call Dialogos.DrawText(260, 260, "MODO COMBATE", vbRed)
 '   Call Dialogos.DrawText(300, 260, "FPS: " & FPS, vbWhite)
'End If
'[END]'
End Sub
Sub CrearGrh(GrhIndex As Integer, Index As Integer)
ReDim Preserve Grh(1 To Index) As Grh
Grh(Index).FrameCounter = 1
Grh(Index).GrhIndex = GrhIndex
Grh(Index).SpeedCounter = GrhData(GrhIndex).Speed
Grh(Index).Started = 1
End Sub

Sub CargarAnimsExtra()
Call CrearGrh(6580, 1) 'Anim Invent
Call CrearGrh(534, 2) 'Animacion de teleport
Dim DDm As DDSURFACEDESC2 'minimap
DDm.lHeight = 100 'minimap
DDm.lWidth = 100 'minimap
DDm.ddsCaps.lCaps = DDSCAPS_SYSTEMMEMORY 'minimap
DDm.lFlags = DDSD_CAPS Or DDSD_HEIGHT Or DDSD_WIDTH 'minimap
Set SupMiniMap = DirectDraw.CreateSurface(DDm) 'minimap
Set SupBMiniMap = DirectDraw.CreateSurface(DDm) 'minimap

End Sub

Function ControlVelocidad(ByVal LastTime As Long) As Boolean
ControlVelocidad = (GetTickCount - LastTime > 20)
End Function
Public Sub DibujarMiniMapa(ByRef Pic As PictureBox) 'minimap
Dim DR As RECT
Dim SR As RECT
Dim X As Integer
Dim Y As Integer

DR.Left = 0
DR.Top = 0
DR.Bottom = 100
DR.Right = 100
SR.Left = 0
SR.Top = 0
SR.Bottom = 100
SR.Right = 100

'DibujarMiniMapa frmMain.MiniMap
SupMiniMap.Blt DR, SupBMiniMap, DR, DDBLT_DONOTWAIT
'PrimarySurface.Blt DR, SupBMiniMap, DR, DDBLT_DONOTWAIT
DR.Left = UserPos.X
DR.Top = UserPos.Y
DR.Bottom = UserPos.Y + 2
DR.Right = UserPos.X + 2
SupMiniMap.BltColorFill DR, vbRed
DR.Left = 0
DR.Top = 0
DR.Bottom = 100
DR.Right = 100
SupMiniMap.BltToDC Pic.hdc, DR, DR
'SupMiniMap.DrawBox 20, 20, 100, 100
'SupMiniMap.SetForeColor (555555)
End Sub
Public Sub GenerarMiniMapa() 'minimap
Dim X As Integer
Dim Y As Integer
Dim i As Integer
Dim SR As RECT

SR.Left = 1
SR.Top = 1
SR.Bottom = 100
SR.Right = 100
SupBMiniMap.BltColorFill SR, vbBlack
For X = 1 To 100
For Y = 1 To 100

If MapData(X, Y).Graphic(1).GrhIndex > 0 Then
With MapData(X, Y).Graphic(1)
i = GrhData(.GrhIndex).Frames(1)
End With

            Call DDrawTransGrhtoSurface( _
                    SupBMiniMap, _
                    MapData(X, Y).Graphic(1), _
                    X, _
                    Y, _
                    1, _
                    1, 0, 1)

End If
Next
Next


End Sub


