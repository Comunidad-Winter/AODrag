VERSION 5.00
Begin VB.Form frmConnect 
   BackColor       =   &H00E0E0E0&
   BorderStyle     =   0  'None
   Caption         =   "Cliente AoDraG"
   ClientHeight    =   9000
   ClientLeft      =   0
   ClientTop       =   -255
   ClientWidth     =   12000
   ClipControls    =   0   'False
   FillColor       =   &H00000040&
   ForeColor       =   &H00000000&
   Icon            =   "frmConnect.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   Picture         =   "frmConnect.frx":000C
   ScaleHeight     =   600
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   800
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.TextBox passwordtxt 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000040&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Comic Sans MS"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   345
      IMEMode         =   3  'DISABLE
      Left            =   4440
      MouseIcon       =   "frmConnect.frx":7F38A
      MousePointer    =   99  'Custom
      PasswordChar    =   "*"
      TabIndex        =   6
      Top             =   5025
      Width           =   3120
   End
   Begin VB.TextBox nametxt 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00000040&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Comic Sans MS"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   4440
      MouseIcon       =   "frmConnect.frx":80054
      MousePointer    =   99  'Custom
      TabIndex        =   5
      Top             =   4200
      Width           =   3135
   End
   Begin VB.Timer Comprueba1 
      Interval        =   1000
      Left            =   1800
      Top             =   1440
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00008080&
      BackStyle       =   0  'Transparent
      Caption         =   "Servidor AoDraG 2020"
      BeginProperty Font 
         Name            =   "Candara Light"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0FFFF&
      Height          =   255
      Left            =   4560
      TabIndex        =   7
      Top             =   8280
      Width           =   2895
   End
   Begin VB.Image salir 
      Height          =   255
      Left            =   4320
      Top             =   6000
      Width           =   1575
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   855
      Left            =   4200
      TabIndex        =   4
      Top             =   2880
      Width           =   3735
   End
   Begin VB.Image Image4 
      Height          =   420
      Left            =   4920
      MouseIcon       =   "frmConnect.frx":80D1E
      MousePointer    =   99  'Custom
      Top             =   6960
      Width           =   330
   End
   Begin VB.Image Image3 
      Height          =   420
      Left            =   6720
      MouseIcon       =   "frmConnect.frx":819E8
      MousePointer    =   99  'Custom
      Top             =   6960
      Width           =   330
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00800000&
      BackStyle       =   0  'Transparent
      Caption         =   "Version 7.7"
      BeginProperty Font 
         Name            =   "Morpheus"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   5040
      MouseIcon       =   "frmConnect.frx":826B2
      MousePointer    =   99  'Custom
      TabIndex        =   3
      Top             =   0
      Width           =   1815
   End
   Begin VB.Label dragcreditos 
      BackStyle       =   0  'Transparent
      Height          =   375
      Left            =   10200
      MouseIcon       =   "frmConnect.frx":8337C
      MousePointer    =   99  'Custom
      TabIndex        =   2
      Top             =   7920
      Width           =   1695
   End
   Begin VB.Label opciones 
      BackStyle       =   0  'Transparent
      Height          =   255
      Left            =   10200
      MouseIcon       =   "frmConnect.frx":84046
      MousePointer    =   99  'Custom
      TabIndex        =   1
      Top             =   7560
      Width           =   1695
   End
   Begin VB.Image Image2 
      Height          =   330
      Left            =   10200
      MouseIcon       =   "frmConnect.frx":84D10
      MousePointer    =   99  'Custom
      Top             =   7200
      Width           =   1785
   End
   Begin VB.Image Image1 
      Height          =   285
      Index           =   0
      Left            =   10200
      MouseIcon       =   "frmConnect.frx":859DA
      MousePointer    =   99  'Custom
      Top             =   6840
      Width           =   1770
   End
   Begin VB.Image Image1 
      Height          =   375
      Index           =   1
      Left            =   6120
      MouseIcon       =   "frmConnect.frx":866A4
      MousePointer    =   99  'Custom
      Top             =   6000
      Width           =   1635
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Selecciona Servidor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00400000&
      Height          =   255
      Left            =   4200
      TabIndex        =   0
      Top             =   6600
      Visible         =   0   'False
      Width           =   3735
   End
   Begin VB.Image Image1 
      Height          =   1320
      Index           =   2
      Left            =   4200
      MouseIcon       =   "frmConnect.frx":8736E
      MousePointer    =   99  'Custom
      Top             =   1320
      Width           =   3720
   End
   Begin VB.Image serverp 
      Height          =   660
      Left            =   5325
      Picture         =   "frmConnect.frx":88038
      Stretch         =   -1  'True
      Top             =   6885
      Visible         =   0   'False
      Width           =   1380
   End
   Begin VB.Image servers 
      Height          =   660
      Left            =   5325
      Picture         =   "frmConnect.frx":8ACAE
      Stretch         =   -1  'True
      Top             =   6885
      Visible         =   0   'False
      Width           =   1380
   End
   Begin VB.Image FONDO 
      Height          =   9345
      Left            =   0
      MouseIcon       =   "frmConnect.frx":8D924
      MousePointer    =   99  'Custom
      Picture         =   "frmConnect.frx":8E5EE
      Stretch         =   -1  'True
      Top             =   -360
      Width           =   12105
   End
End
Attribute VB_Name = "frmConnect"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Check1_Click()

End Sub
Private Sub Comprueba1_Timer()
Call EWindos
End Sub

Private Sub dragcreditos_Click()
'-----------------------
'Dim variable As String
'Dim ie As Object

'variable = "http://aodrag-enconstruccion.com"
'Set ie = CreateObject("InternetExplorer.Application")
'ie.Visible = True
'ie.Navigate variable
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 27 Then
        frmCargando.Show
        frmCargando.Refresh
        AddtoRichTextBox frmCargando.status, "Cerrando AoDraG.", 0, 0, 0, 1, 0, 1
        
        Call SaveGameini
        frmConnect.MousePointer = 1
        frmMain.MousePointer = 1
        prgRun = False
        
        AddtoRichTextBox frmCargando.status, "Liberando recursos..."
        frmCargando.Refresh
        LiberarObjetosDX
        AddtoRichTextBox frmCargando.status, "Hecho", 0, 0, 0, 1, 0, 1
        AddtoRichTextBox frmCargando.status, "��Gracias por jugar AoDraG!!", 0, 0, 0, 1, 0, 1
        frmCargando.Refresh
        Call UnloadAllForms
End If
'pluto:7.0
If KeyCode = 13 Then Image1_Click (1)
End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyI And Shift = vbCtrlMask Then
    KeyCode = 0
    Exit Sub
End If
End Sub

Private Sub Form_Load()
    frmConnect.Label7.Visible = False
    EngineRun = False
 Dim j
 For Each j In Image1()
    j.Tag = "0"
 Next
 FONDO.Picture = LoadPicture(App.Path & "\Graficos\Conectar.jpg")
 
 'pluto:6.3------------------------
 'nati:cambio esto
   If ServActual = 0 Then
If LugarServer = 1 Then
'activo espa�ol
frmConnect.servers.Visible = True
'desactivo argentino
frmConnect.serverp.Visible = False
ServActual = 1
Call audio.PlayWave("espanol.wav")
Else
'activo argentino
frmConnect.serverp.Visible = True
ServActual = 2
'desactivo espa�a
frmConnect.servers.Visible = False

Call audio.PlayWave("argentino.wav")
End If

            ElseIf ServActual = 1 Then 'serveractual>0
            'activo espa�ol
frmConnect.servers.Visible = True
'frmConnect.Image3.Picture = LoadPicture(App.Path & "\Graficos\espa.jpg")

'desactivo argentino
frmConnect.serverp.Visible = False
'frmConnect.Image4.Picture = LoadPicture(App.Path & "\Graficos\arg.jpg")

Call audio.PlayWave("espanol.wav")
            ElseIf ServActual = 2 Then
            'activo argentino
frmConnect.serverp.Visible = True
'frmConnect.Image4.Picture = LoadPicture(App.Path & "\Graficos\arg.jpg")

'desactivo espa�a
frmConnect.servers.Visible = False
'frmConnect.Image3.Picture = LoadPicture(App.Path & "\Graficos\espa.jpg")

Call audio.PlayWave("argentino.wav")
            
            
            End If

If GetSetting("AODRAG", "SERVIDOR", "ANUNCIO", 0) = 0 Then
    MsgBox "����ATENCI�N!!!! Ya est�n disponibles los servidores de Espa�a y Argentina, pueden cambiar a cual conectarse desde el selector de servidores de abajo. Ambos personajes se encuentran en los servidores.", vbExclamation
    SaveSetting "AODRAG", "SERVIDOR", "ANUNCIO", 1
End If
'-------------------------
End Sub



Private Sub Image1_Click(Index As Integer)
    Call audio.PlayWave(SND_CLICK)
    frmConnect.Label7.Visible = False
Select Case Index
    Case 0
        'If Musica = 0 Then
            CurMidi = DirMidi & "7.mid"
            LoopMidi = 1
             Call audio.PlayMIDI(CStr(CurMidi) & ".mid", LoopMidi)
        'End If
 '       frmCrearPersonaje.Show vbModal
       
        frmCrearCuenta.Show vbModal
    Case 1
        frmMain.Socket1.Disconnect

'pluto:2.18------------

Dim aveces As Byte
aveces = Val(Right(Time, 2))
'Nati: Quitamos esto hasta tener una nueva cuenta y tal...
'If aveces = 20 Then
'Call Form3.Cargaweb2("http://www.juegosdrag.es/aodragc.htm")
'End If
'If aveces = 21 Then
'Call Form3.Cargaweb2("http://www.juegosdrag.es/aodragd.htm")
'End If
'If aveces = 22 Then
'Call Form3.Cargaweb2("http://www.juegosdrag.es/aodragb.htm")
'End If
'If aveces = 23 Then
'Call Form3.Cargaweb2("http://www.juegosdrag.es/aodraga.htm")
'End If
'If aveces = 24 Then
'Call Form3.Cargaweb2("http://www.juegosdrag.es/aodrage.htm")
'End If
'---------------
        'frmOldPersonaje.Show vbModal
         Call audio.PlayWave(SND_CLICK)
       'pluto:2.5.0
        If frmMain.Socket1.Connected Then
        Call frmMain.Socket1.Disconnect
        End If
        'quitar esto
       ' If frmConnect.MousePointer = 11 Then
          '  Exit Sub
       ' End If
        
'pluto:2.5.0
KeyCodi = ""
Keycodi2 = ""
        'update user info
        UserName = NameTxt.Text
        'PLUTO:2.11
        frmCuentas.Label1(1).Caption = LCase$(UserName)
        'frmCuentas.Conectar.Caption = "Entrar con: "

        Dim aux As String
        aux = PasswordTxt.Text
        UserPassword = MD5String(aux)
        If CheckUserData(False) = True Then
        
'pluto:6.3----------------------------------------------
'antes de conectarme el winsock debe estar cerrado
'frmMain.ws_cliente.Close
'me conecto a la pc remota utilizando su ip(la que ponemos en el textbox), x el puerto 8888
'If ServActual = 2 Then
'frmMain.ws_cliente.Connect "redpluto.no-ip.org", "7665"
'frmMain.ws_cliente.Connect "200.85.152.50", "10290"
'Else
'frmMain.ws_cliente.Connect "92.43.20.27", "7667"
'End If
'Me.ws_cliente.Connect "redpluto.no-ip.org", "7667"
'Debug.Print frmMain.ws_cliente.State
'---------------------------------------------------------
        
        
        
        
        
'            Load frmMain.Socket1

            frmMain.Socket1.HostName = CurServerIp
            frmMain.Socket1.RemotePort = CurServerPort
            SendNewChar = False
            Me.MousePointer = 11
           ' Debug.Print (CurServerIp)
            'Debug.Print (CurServerPort)
'pluto:6.7
'UserRecibe = 0
'UserEnvia = 1
            frmMain.Socket1.Connect
        End If

Case 2
Dim variable As String
Dim ie As Object

variable = "https://www.facebook.com/groups/2599258103512061/"
Set ie = CreateObject("InternetExplorer.Application")
ie.Visible = True
ie.Navigate variable


End Select
End Sub

Private Sub Image2_Click()
    frmRecuperarCuenta.Show vbModal
End Sub

Private Sub Image3_Click()
Call audio.PlayWave(SND_CLICK)
frmConnect.serverp.Visible = True
frmConnect.servers.Visible = False
Call audio.PlayWave("argentino.wav")
ServActual = 2
Call SaveSetting("AODRAG", "SERVIDOR", "ACTUAL", ServActual)
End Sub

Private Sub Label1_Click()
 
End Sub



Private Sub Image4_Click()
Call audio.PlayWave(SND_CLICK)
frmConnect.servers.Visible = True
frmConnect.serverp.Visible = False
Call audio.PlayWave("espanol.wav")
ServActual = 1
Call SaveSetting("AODRAG", "SERVIDOR", "ACTUAL", ServActual)
End Sub

Private Sub Label2_Click()
 frmCargando.Show
        frmCargando.Refresh
        AddtoRichTextBox frmCargando.status, "Cerrando Argentum Online.", 0, 0, 0, 1, 0, 1
        
        Call SaveGameini
        frmConnect.MousePointer = 1
        frmMain.MousePointer = 1
        prgRun = False
        
        AddtoRichTextBox frmCargando.status, "Liberando recursos..."
        frmCargando.Refresh
        LiberarObjetosDX
        AddtoRichTextBox frmCargando.status, "Hecho", 0, 0, 0, 1, 0, 1
        AddtoRichTextBox frmCargando.status, "��Gracias por jugar Argentum Online!!", 0, 0, 0, 1, 0, 1
        frmCargando.Refresh
        Call UnloadAllForms
End Sub

Private Sub Label3_Click()
End Sub



Private Sub opciones_Click()
frmOpciones.Show
End Sub

Private Sub salir_Click()
 frmCargando.Show
        frmCargando.Refresh
        AddtoRichTextBox frmCargando.status, "Cerrando Argentum Online.", 0, 0, 0, 1, 0, 1
        
        Call SaveGameini
        frmConnect.MousePointer = 1
        frmMain.MousePointer = 1
        prgRun = False
        
        AddtoRichTextBox frmCargando.status, "Liberando recursos..."
        frmCargando.Refresh
        LiberarObjetosDX
        AddtoRichTextBox frmCargando.status, "Hecho", 0, 0, 0, 1, 0, 1
        AddtoRichTextBox frmCargando.status, "��Gracias por jugar Argentum Online!!", 0, 0, 0, 1, 0, 1
        frmCargando.Refresh
        Call UnloadAllForms
End Sub
