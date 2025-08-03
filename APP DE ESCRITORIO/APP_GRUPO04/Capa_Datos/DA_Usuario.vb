Imports System.Data.SqlClient
Imports Capa_Entidades
Imports Capa_Conexion

Public Class DA_Usuario
    Public Function Login(ByVal cUsuUsuario As String, ByVal cUsuClave As String) As BE_Usuario
        Dim Objeto As BE_Usuario = Nothing
        Try
            Dim Cadena As String = New CN_Conexion().Connection
            Using cn As New SqlConnection(Cadena)
                cn.Open()
                Using cm As New SqlCommand
                    cm.CommandText = "usp_LoginUsuario"
                    cm.CommandType = CommandType.StoredProcedure
                    cm.Parameters.Clear()
                    cm.Parameters.AddWithValue("@cUsuUsuario", cUsuUsuario)
                    cm.Parameters.AddWithValue("@cUsuClave", cUsuClave)
                    cm.Connection = cn
                    Using dr = cm.ExecuteReader
                        While dr.Read()
                            Objeto = New BE_Usuario()
                            Objeto.per_id = IIf(IsDBNull(dr("per_id")), 0, dr("per_id"))
                            Objeto.per_nombre = IIf(IsDBNull(dr("per_nombre")), "", dr("per_nombre"))
                            Objeto.per_sueldoHora = IIf(IsDBNull(dr("per_sueldoHora")), "", dr("per_sueldoHora"))
                            Objeto.cUsuUsuario = IIf(IsDBNull(dr("cUsuUsuario")), "", dr("cUsuUsuario"))
                            Objeto.puesto = New BE_Puesto()
                            Objeto.puesto.pue_nombre = IIf(IsDBNull(dr("pue_nombre")), "", dr("pue_nombre"))
                        End While
                        dr.Close()
                    End Using
                End Using
            End Using
        Catch ex As Exception
        End Try
        Return Objeto
    End Function
End Class
