Imports Capa_Entidades
Imports Capa_Conexion
Imports System.Data.SqlClient
Public Class DA_Articulo

    Public Function VerArtiulo(ByVal hpr_id As Int32) As BE_Articulo
        Dim Objeto As BE_Articulo = Nothing
        Try
            Dim Cadena As String = New CN_Conexion().Connection
            Using cn As New SqlConnection(Cadena)
                cn.Open()
                Using cm As New SqlCommand
                    cm.CommandText = "usp_verArticulo"
                    cm.CommandType = CommandType.StoredProcedure
                    cm.Parameters.Clear()
                    cm.Parameters.AddWithValue("@hpr_id", hpr_id)
                    cm.Connection = cn
                    Using dr = cm.ExecuteReader
                        While dr.Read()
                            Objeto = New BE_Articulo()
                            Objeto.art_nombre = IIf(IsDBNull(dr("art_nombre")), 0, dr("art_nombre"))

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
