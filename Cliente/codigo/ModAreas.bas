Attribute VB_Name = "ModAreas"
Option Explicit

'Lorwik> Este sistema tendria que volar, me da asco.

'LAS GUARDAMOS PARA PROCESAR LOS MPs y sabes si borrar personajes
Public MinLimiteX As Integer
Public MaxLimiteX As Integer
Public MinLimiteY As Integer
Public MaxLimiteY As Integer

Private Const TamaņoAreas As Byte = 11

Public Sub CambioDeArea(ByVal x As Byte, ByVal y As Byte)
    Dim loopX As Long, loopY As Long
    
    MinLimiteX = (x \ TamaņoAreas - 1) * TamaņoAreas
    MaxLimiteX = MinLimiteX + ((TamaņoAreas * 3) - 1)
    
    MinLimiteY = (y \ TamaņoAreas - 1) * TamaņoAreas
    MaxLimiteY = MinLimiteY + ((TamaņoAreas * 3) - 1)
    
    For loopX = 1 To 100
        For loopY = 1 To 100
            
            If (loopY < MinLimiteY) Or (loopY > MaxLimiteY) Or (loopX < MinLimiteX) Or (loopX > MaxLimiteX) Then
                'Erase NPCs
                
                If MapData(loopX, loopY).CharIndex > 0 Then
                    If MapData(loopX, loopY).CharIndex <> UserCharIndex Then
                        Call EraseChar(MapData(loopX, loopY).CharIndex)
                    End If
                End If
                
                'Erase OBJs
                MapData(loopX, loopY).ObjGrh.GrhIndex = 0
            End If
        Next loopY
    Next loopX
    
    Call RefreshAllChars
End Sub

