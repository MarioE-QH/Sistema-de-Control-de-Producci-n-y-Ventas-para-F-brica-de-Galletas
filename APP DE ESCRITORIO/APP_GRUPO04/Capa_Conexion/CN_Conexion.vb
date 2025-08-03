Imports System.Configuration
Public Class CN_Conexion
    Public Function Connection() As String
        Dim strConnection = ""
        Try
            strConnection = ConfigurationManager.ConnectionStrings("APP_QHME").ConnectionString
        Catch ex As Exception
            strConnection = "Data Source=MARIOE;Initial Catalog=GRUPO04;uid=sa;pwd=pro;Integrated Security=false;"
        End Try
        Return strConnection
    End Function
End Class
