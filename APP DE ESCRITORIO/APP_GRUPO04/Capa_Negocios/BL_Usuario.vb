Imports Capa_Entidades
Imports Capa_Datos
Public Class BL_Usuario
    Public Function Login(ByVal cUsuUsuario As String, ByVal cUsuClave As String) As BE_Usuario
        Return New DA_Usuario().Login(cUsuUsuario, cUsuClave)
    End Function
End Class
