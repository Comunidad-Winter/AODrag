Attribute VB_Name = "Drag_Castillos"

Option Explicit

Public Const MSG_ATK_CASTILLO_NOCLAN As String = "Para participar en la conquista de castillos necesitas formar parte de un clan"

'26/02/2016 Irongete: Esta funci�n se ejecuta cuando el defensor de la fortaleza es atacado
' @param UserIndex indice de la persona que realiza el ataque
' @param NPCIndex indice del rey que est� siendo atacado
' @param el da�o calculado que se le va a hacer al rey

Public Sub DefensorEsAtacado(ByVal UserIndex As Integer, ByVal NPCIndex As Integer, da�o As Long)
    On Error GoTo Errhandler
    
    Dim i As Integer
    Dim e As Integer
    
    For i = 1 To NUMCASTILLOS
        If UserList(UserIndex).Pos.Map = Castillos(i).Mapa Then
        
            '16/11/2015 Irongete: Mostrar el mensaje global dependiendo de la vida del rey
            Select Case NPCList(NPCIndex).Stats.MinHP
                Case 28000 To 30000
                    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("�El Defensor de la Fortaleza est� siendo atacado!", FontTypeNames.FONTTYPE_GUILD))
                Case 5000 To 6000
                    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("�El Defensor de la Fortaleza est� a punto de morir!", FontTypeNames.FONTTYPE_GUILD))
            End Select
                    
        End If
    Next i
    
        
Errhandler:
    Debug.Print "Error en ReyEsAtacado(): " & Err.Description
    
End Sub

'16/11/2015 Irongete: Esta funci�n se ejecuta cuando el rey de un castillo es atacado
' @param UserIndex indice de la persona que realiza el ataque
' @param NPCIndex indice del rey que est� siendo atacado
' @param el da�o calculado que se le va a hacer al rey

Public Sub ReyEsAtacado(ByVal UserIndex As Integer, ByVal NPCIndex As Integer, da�o As Long)
    On Error GoTo Errhandler
    
    Dim i As Integer
    Dim e As Integer
    
    For i = 1 To NUMCASTILLOS
        If UserList(UserIndex).Pos.Map = Castillos(i).Mapa Then
        
            '16/11/2015 Irongete: Mostrar el mensaje global dependiendo de la vida del rey
            Select Case NPCList(NPCIndex).Stats.MinHP
                Case 10000 To 12000
                    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("�El Rey d" & Castillos(i).Nombre & " est� siendo atacado!", FontTypeNames.FONTTYPE_GUILD))
                Case 5000 To 6000
                    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("�El Rey d" & Castillos(i).Nombre & " est� a punto de morir!", FontTypeNames.FONTTYPE_GUILD))
            End Select
            
            '16/11/2015 Irongete: Si la puerta no ha sido destruida, el rey recibe 80% menos de da�o
            If Castillos(i).PuertaDie = False Then da�o = da�o * 0.2
            
            '26/02/2015 Irongete: Si la Fortaleza pertenece a quien ataca, el rey recibe 50% m�s de da�o
            If Castillos(5).Due�o = UserList(UserIndex).GuildIndex Then da�o = da�o * 1.5
        
            '16/11/2015 Irongete: Envio el paquete CastleAttack a todos los jugadores del servidor para que salga la llama en el minimapa
            Call WriteCastleAttack(SendTarget.ToAll, i)

        End If
    Next i
    
        
Errhandler:
    Debug.Print "Error en ReyEsAtacado(): " & Err.Description
    
End Sub

'16/11/2015 Irongete: Esta funci�n se ejecuta cuando la puerta de un castillo es atacada
' @param UserIndex userindex de la persona que realiza el ataque
Public Sub PuertaEsAtacada(ByVal UserIndex As Integer, ByVal NPCIndex As Integer, da�o As Long)
    On Error GoTo Errhandler
    
        Dim i As Integer
        
        '16/11/2015 Irongete: Cambiar el grafico de la puerta dependiendo de su vida (Lorwik)
        Select Case NPCList(NPCIndex).Stats.MinHP
            Case 10000 To 15000
                NPCList(NPCIndex).Char.body = 401
            
            Case 5000 To 9999
                NPCList(NPCIndex).Char.body = 443
            
            Case 1 To 4999
                NPCList(NPCIndex).Char.body = 444
        End Select
        Call ChangeNPCChar(NPCIndex, NPCList(NPCIndex).Char.body, 0, 1)
        
        '26/02/2015 Irongete: Si la Fortaleza pertenece a quien ataca, el rey recibe 50% m�s de da�o
        If Castillos(5).Due�o = UserList(UserIndex).GuildIndex Then da�o = da�o * 1.5
        
        '16/11/2015 Irongete: Mostrar el mensaje global dependiendo de la vida de la puerta
        For i = 1 To NUMCASTILLOS
            If UserList(UserIndex).Pos.Map = Castillos(i).Mapa Then
                Select Case NPCList(NPCIndex).Stats.MinHP
                    Case 13000 To 15000
                        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("�La puerta d" & Castillos(i).Nombre & " est� siendo atacada!", FontTypeNames.FONTTYPE_GUILD))
                    Case 5000 To 6000
                        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("�La puerta d" & Castillos(i).Nombre & " est� a punto de morir!", FontTypeNames.FONTTYPE_GUILD))
                End Select
            End If
        Next i
        
Errhandler:
    'Debug.Print "Error en PuertaEsAtacada(): " & Err.Description
End Sub

'26/02/2016 Irongete: Esta funci�n se ejecuta cu ando el defensor de una fortaleza muere
' @param UserIndex userindex de la persona que realiza el ataque
' @param Npcindex indice del npc del defensor
Public Sub DefensorMuere(ByVal UserIndex As Integer, ByVal NPCIndex As Integer)

    Dim i As Integer
    Dim nPos As WorldPos
    
    nPos.Map = NPCList(NPCIndex).Pos.Map
    nPos.X = 41
    nPos.Y = 74
    
    For i = 1 To NUMCASTILLOS
        If UserList(UserIndex).Pos.Map = Castillos(i).Mapa Then
        
            '16/11/2015 Irongete: Guardamos el nuevo due�o en la base de datos
            Castillos(i).Due�o = UserList(UserIndex).GuildIndex
            Call SetDue�oCastillo(CInt(i), Castillos(i).Due�o)
            
            '16/11/2015 Irongete: Sonido de conquista
            Call SendData(SendTarget.ToAll, 0, PrepareMessagePlayWave(44, NO_3D_SOUND, NO_3D_SOUND))
            
            '16/11/2015 Irongete: Mensaje de conquista
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(UCase("EL CLAN " & modGuilds.GuildName(UserList(UserIndex).GuildIndex) & " HA CONQUISTADO " & Castillos(i).Nombre), FontTypeNames.FONTTYPE_GUILD))

            '16/11/2015 Irongete: El Defensor realmente no muere, le curamos.
            NPCList(NPCIndex).Stats.MinHP = NPCList(NPCIndex).Stats.MaxHP
                       
            '16/11/2015 Irongete: Quitar la llama del castillo en el minimapa
            Call WriteCastleAttack(SendTarget.ToAll, 0)
        End If
    Next i


End Sub

'16/11/2015 Irongete: Esta funci�n se ejecuta cuando el rey de un castillo muere
' @param UserIndex userindex de la persona que realiza el ataque
' @param Npcindex indice del npc del rey
Public Sub ReyMuere(ByVal UserIndex As Integer, ByVal NPCIndex As Integer)

    Dim i As Integer
    Dim nPos As WorldPos
    
    'Posici�n de la puerta
    nPos.Map = NPCList(NPCIndex).Pos.Map
    nPos.X = 41
    nPos.Y = 74
    
    For i = 1 To NUMCASTILLOS
        If UserList(UserIndex).Pos.Map = Castillos(i).Mapa Then
        
            '16/11/2015 Irongete: Guardamos el nuevo due�o en la base de datos
            Castillos(i).Due�o = UserList(UserIndex).GuildIndex
            Call SetDue�oCastillo(CInt(i), Castillos(i).Due�o)
            
            '16/11/2015 Irongete: Sonido de conquista
            Call SendData(SendTarget.ToAll, 0, PrepareMessagePlayWave(44, NO_3D_SOUND, NO_3D_SOUND))
            
            '16/11/2015 Irongete: Mensaje de conquista
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(UCase("EL CLAN " & modGuilds.GuildName(UserList(UserIndex).GuildIndex) & " HA CONQUISTADO " & Castillos(i).Nombre), FontTypeNames.FONTTYPE_GUILD))

            '16/11/2015 Irongete: El Rey realmente no muere, le curamos.
            NPCList(NPCIndex).Stats.MinHP = NPCList(NPCIndex).Stats.MaxHP
            
            '16/11/2015 Irongete: Si la puerta murio durante el ataque la volvemos a spawnear y bloquear.
            If Castillos(i).PuertaDie = True Then
                Castillos(i).PuertaDie = False
                
                Call SpawnNpc(595, nPos, False, False) 'Volvemos a respawnear la puerta
                MapData(nPos.Map, nPos.X + 1, nPos.Y).Blocked = 1
                MapData(nPos.Map, nPos.X - 1, nPos.Y).Blocked = 1
                            
                '16/11/2015 Irongete: Bloquea todos los mapas
                Call Bloquear(True, nPos.Map, nPos.X + 1, nPos.Y, 1)
                Call Bloquear(True, nPos.Map, nPos.X - 1, nPos.Y, 1)
            End If
            
            '16/11/2015 Irongete: Quitar la llama del castillo en el minimapa
            Call WriteCastleAttack(SendTarget.ToAll, 0)
        End If
    Next i


End Sub

Public Sub PuertaEsDestruida(ByVal UserIndex As Integer, ByVal NPCIndex As Integer)
    On Error GoTo Errhandler
    
    Dim nPos As WorldPos
    Dim i As Integer
    
    'Posici�n de la puerta
    nPos.Map = NPCList(NPCIndex).Pos.Map
    nPos.X = 41
    nPos.Y = 74
    
    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("�La puerta del " & MapInfo(NPCList(NPCIndex).Pos.Map).MapName & " ha caido!", FontTypeNames.FONTTYPE_GUILD))
            
    For i = 1 To NUMCASTILLOS
        If UserList(UserIndex).Pos.Map = Castillos(i).Mapa Then
            Castillos(i).PuertaDie = True
            
            MapData(nPos.Map, nPos.X + 1, nPos.Y).Blocked = 0
            MapData(nPos.Map, nPos.X - 1, nPos.Y).Blocked = 0
                        
            'Bloquea todos los mapas
            Call Bloquear(True, nPos.Map, nPos.X + 1, nPos.Y, 0)
            Call Bloquear(True, nPos.Map, nPos.X - 1, nPos.Y, 0)
            
            Call QuitarNPC(NPCIndex)
        End If
    Next i

Errhandler:
    Debug.Print "Error en PuertaEsDestruida(): " & Err.Description

End Sub

Public Sub Due�osCastillos(ByVal UserIndex As Integer)
    Call WriteConsoleMsg(UserIndex, "El Castillo Norte est� en manos del clan: " & GetNombreDue�oCastillo(Castillos(1).Due�o) & " - " & Castillos(1).FechaHora, FontTypeNames.FONTTYPE_INFO)
    Call WriteConsoleMsg(UserIndex, "El Castillo Este est� en manos del clan: " & GetNombreDue�oCastillo(Castillos(2).Due�o) & " - " & Castillos(2).FechaHora, FontTypeNames.FONTTYPE_INFO)
    Call WriteConsoleMsg(UserIndex, "El Castillo Sur est� en manos del clan: " & GetNombreDue�oCastillo(Castillos(3).Due�o) & " - " & Castillos(3).FechaHora, FontTypeNames.FONTTYPE_INFO)
    Call WriteConsoleMsg(UserIndex, "El Castillo Oeste est� en manos del clan: " & GetNombreDue�oCastillo(Castillos(4).Due�o) & " - " & Castillos(4).FechaHora, FontTypeNames.FONTTYPE_INFO)
    Call WriteConsoleMsg(UserIndex, "La Fortaleza est� en manos del clan: " & GetNombreDue�oCastillo(Castillos(5).Due�o) & " - " & Castillos(5).FechaHora, FontTypeNames.FONTTYPE_INFO)
End Sub

'27/10/2015 Irongete: Cada minuto se reparte 1 punto por mantener el castillo y 4 puntos por mantener la fortaleza, total un maximo de 8 puntos.
Public Sub PuntuarCastillos()
    Dim i As Integer
    Dim Puntos As Integer
    Dim MinutosCastillo As Integer
    Set RS = New ADODB.Recordset
    
    For i = 1 To NUMCASTILLOS
      '03/10/2015 Irongete: Aumento los minutos totales de conquista de este castillo''
      Set RS = SQL.Execute("UPDATE rel_clan_puntos SET minutoscastillo" & i & " = minutoscastillo" & i & " + 1 WHERE id_clan = '" & Castillos(i).Due�o & "'")
      
      If i < 5 Then
        '03/10/2015 Irongete: Aumento los puntos del clan en 1 por tener el castillo conquistado
        Set RS = SQL.Execute("UPDATE rel_clan_puntos SET puntoscastillos = puntoscastillos + 1 WHERE id_clan = '" & Castillos(i).Due�o & "'")
      Else
        '03/10/2015 Irongete: Aumento los puntos del clan en 4 por tener la fortaleza conquistada
        Set RS = SQL.Execute("UPDATE rel_clan_puntos SET puntoscastillos = puntoscastillos + 4 WHERE id_clan = '" & Castillos(i).Due�o & "'")
      End If
    Next i
    RS.Close
End Sub



'01/11/2015 Irongete: Devuelve la Id del clan que coincida con el nombre
Function GetClanIdPorNombre(ByRef Nombre As String)
    Set RS = New ADODB.Recordset
    Set RS = SQL.Execute("SELECT id FROM clan WHERE nombre = '" & Nombre & "'")
    GetClanIdPorNombre = RS!ID
    RS.Close
End Function


'01/11/2015 Irongete: Devuelve el nombre del clan que est� en posesi�n del castillo.
Function GetNombreDue�oCastillo(ByRef Due�oId As Integer)
    Set RS = New ADODB.Recordset
    Set RS = SQL.Execute("SELECT nombre FROM clan WHERE id = '" & Due�oId & "'")
    If RS.EOF = False And RS.BOF = False Then
        GetNombreDue�oCastillo = RS!Nombre
    End If
    RS.Close
End Function

'26/02/2016 Irongete: Devuelve la id del clan que est� en posesi�n del castillo.
Function GetIdDue�oCastillo(ByRef CastilloId As Integer)
    Set RS = New ADODB.Recordset
    Set RS = SQL.Execute("SELECT due�o FROM castillo WHERE id = '" & CastilloId & "'")
    If RS.EOF = False And RS.BOF = False Then
        GetIdDue�oCastillo = RS!Due�o
    End If
    RS.Close
End Function

Function GetFechaHoraCastillo(ByVal CastilloId As String) As String
    Set RS = New ADODB.Recordset
    Set RS = SQL.Execute("SELECT fecha_conquista FROM castillo WHERE id = '" & CastilloId & "'")
    If RS.EOF = False And RS.BOF = False Then
         GetFechaHoraCastillo = RS!fecha_conquista
    End If
    RS.Close
End Function


'01/11/2015 Irongete: Actualiza el due�o del castillo.
' NOTA: Actualmente le paso el nombre del clan (en el futuro hay que pasar la Id) ya que todav�a no est�n los clanes a�adidos al sistema de SQL
Public Sub SetDue�oCastillo(ByRef CastilloId As Integer, ByRef clanid As Integer)
    Dim Ahora As String
    Ahora = Year(Now) & "-" & Month(Now) & "-" & Day(Now) & " " & Hour(Now) & "-" & Minute(Now) & "-" & Second(Now)
    Set RS = New ADODB.Recordset
    Set RS = SQL.Execute("UPDATE castillo SET due�o = '" & clanid & "', fecha_conquista = '" & Ahora & "' WHERE id = '" & CastilloId & "'")
    RS.Close
End Sub
