VERSION 5.00
Begin VB.Form frmtip 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   4065
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6120
   ControlBox      =   0   'False
   FillColor       =   &H80000004&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4065
   ScaleWidth      =   6120
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton Command1 
      Caption         =   "Aceptar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   1680
      MouseIcon       =   "frmtip.frx":0000
      MousePointer    =   99  'Custom
      Picture         =   "frmtip.frx":0CCA
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   3600
      Width           =   1185
   End
   Begin VB.CheckBox Check1 
      BackColor       =   &H00000000&
      Caption         =   "Mostrar proxima vez"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   270
      Left            =   3600
      MouseIcon       =   "frmtip.frx":15F3
      MousePointer    =   99  'Custom
      TabIndex        =   0
      Top             =   3600
      Value           =   1  'Checked
      Width           =   2340
   End
   Begin VB.Label tip 
      BackStyle       =   0  'Transparent
      Caption         =   "Label2"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   1860
      Left            =   840
      TabIndex        =   1
      Top             =   1200
      Width           =   4305
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "frmtip"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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


Private Sub Command1_Click()
If frmtip.Check1.Value = vbChecked Then
    tipf = "1"
Else
    tipf = "0"
End If

Unload Me
End Sub

Private Sub Form_Deactivate()
Me.SetFocus
End Sub

Private Sub Label2_Click()
If frmtip.Check1.Value = vbChecked Then
    tipf = "1"
Else
    tipf = "0"
End If

Unload Me
End Sub
Private Sub Form_Load()
frmtip.Picture = LoadPicture(DirGraficos & "ventanas.jpg")
End Sub
