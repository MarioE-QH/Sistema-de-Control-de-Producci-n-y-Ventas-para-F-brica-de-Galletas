Imports Capa_Entidades
Imports Capa_Datos
Public Class BL_Articulo
    Public Function VerArticulo(ByVal hpr_id As Int32) As BE_Articulo
        Return New DA_Articulo().VerArtiulo(hpr_id)
    End Function
End Class
