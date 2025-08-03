Imports Capa_Entidades
Imports Capa_Conexion
Imports System.Data.SqlClient

Public Class DA_hproducionMaterial
    'As List(Of BE_hproduccionMaterial)
    Public Function ListarDetalleMaterial(ByVal hpr_id As Int32) As List(Of BE_hproduccionMaterial)
        Dim lista = New List(Of BE_hproduccionMaterial)
        Try
            Dim Cadena As String = New CN_Conexion().Connection
            Using cn As New SqlConnection(Cadena)
                cn.Open()
                Using cm As New SqlCommand
                    cm.CommandText = "usp_VerDetalleMaterial"
                    cm.CommandType = CommandType.StoredProcedure
                    cm.Parameters.Clear()
                    cm.Parameters.AddWithValue("@hpr_id", hpr_id)
                    cm.Connection = cn
                    Using dr = cm.ExecuteReader
                        While dr.Read()
                            Dim Objeto = New BE_hproduccionMaterial()
                            Objeto.material = New BE_Material()
                            Objeto.mat_id = IIf(IsDBNull(dr("mat_id")), 0, dr("mat_id"))
                            Objeto.material.mat_nombre = IIf(IsDBNull(dr("mat_nombre")), "", dr("mat_nombre"))
                            Objeto.hprmat_cantidad = IIf(IsDBNull(dr("hprmat_cantidad")), "", dr("hprmat_cantidad"))
                            Objeto.material.mat_precioUnitario = IIf(IsDBNull(dr("mat_precioUnitario")), "", dr("mat_precioUnitario"))
                            Objeto.hprmat_id = IIf(IsDBNull(dr("hprmat_id")), "", dr("hprmat_id"))
                            Objeto.valor_total_produccion = IIf(IsDBNull(dr("valor_total_produccion")), "", dr("valor_total_produccion"))
                            Lista.Add(Objeto)
                        End While


                        dr.Close()
                    End Using
                End Using
            End Using
        Catch ex As Exception
        End Try
        Return Lista
    End Function


    Public Function ListarDetalleMaterialdt(ByVal hpr_id As Int32) As DataTable
        Dim dt As New DataTable()
        Try
            Dim Cadena As String = New CN_Conexion().Connection
            Using cn As New SqlConnection(Cadena)
                cn.Open()
                Using cm As New SqlCommand
                    cm.CommandText = "usp_VerDetalleMaterial"
                    cm.CommandType = CommandType.StoredProcedure
                    cm.Parameters.Clear()
                    cm.Parameters.AddWithValue("@hpr_id", hpr_id)
                    cm.Connection = cn
                    Using dr = cm.ExecuteReader
                        dt.Load(dr)

                        dr.Close()
                    End Using
                End Using
            End Using
        Catch ex As Exception
        End Try
        Return dt
    End Function


    Public Function ModificarCantidad(ByRef m_hprmat_cantidad As BE_hproduccionMaterial) As Int32
        Try
            Dim Cadena As String = New CN_Conexion().Connection
            Using cn As New SqlConnection(Cadena)
                cn.Open()
                Using cm As New SqlCommand
                    cm.CommandText = "usp_ModificarCantidadDetalle"
                    cm.CommandType = CommandType.StoredProcedure
                    cm.Parameters.Clear()
                    cm.Parameters.AddWithValue("@hprmat_id", m_hprmat_cantidad.hprmat_id)
                    cm.Parameters.AddWithValue("@cantidad", m_hprmat_cantidad.hprmat_cantidad)
                    cm.Connection = cn
                    Return cm.ExecuteNonQuery
                End Using
            End Using
        Catch ex As Exception
            Throw
            Return 0
        End Try
    End Function


    Public Function EliminarDetalle(ByVal m_hprmat_id As Int32) As Int32
        Try
            Dim Cadena As String = New CN_Conexion().Connection
            Using cn As New SqlConnection(Cadena)
                cn.Open()
                Using cm As New SqlCommand
                    cm.CommandText = "sp_EiminarDetalle"
                    cm.CommandType = CommandType.StoredProcedure
                    cm.Parameters.Clear()
                    cm.Parameters.AddWithValue("@hprmat_id", m_hprmat_id)
                    cm.Connection = cn
                    Return cm.ExecuteNonQuery
                End Using
            End Using
        Catch ex As Exception
            Throw
            Return 0
        End Try
    End Function
End Class
