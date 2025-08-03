Imports Capa_Entidades
Imports Capa_Datos
Public Class BL_hproduccioMaterial
    Public Function ListarDetalleMaterial(ByVal hpr_id As Int32) As List(Of BE_hproduccionMaterial)
        Return New DA_hproducionMaterial().ListarDetalleMaterial(hpr_id)
    End Function

    Public Function ListarDetalleMaterialdt(ByVal hpr_id As Int32) As DataTable
        Return New DA_hproducionMaterial().ListarDetalleMaterialdt(hpr_id)
    End Function

    Public Function ModificarCantidad(ByRef m_hprmat_cantidad As BE_hproduccionMaterial) As Int32
        Try
            Dim rpta = New DA_hproducionMaterial().ModificarCantidad(m_hprmat_cantidad)
            If rpta = 0 Then
                Return 0
            End If
            Return m_hprmat_cantidad.hprmat_cantidad
        Catch ex As Exception
            Return 0
        End Try
    End Function

    Public Function EliminarDetalle(ByVal m_hprmat_id As Int32) As Int32
        Return New DA_hproducionMaterial().EliminarDetalle(m_hprmat_id)
    End Function

End Class
