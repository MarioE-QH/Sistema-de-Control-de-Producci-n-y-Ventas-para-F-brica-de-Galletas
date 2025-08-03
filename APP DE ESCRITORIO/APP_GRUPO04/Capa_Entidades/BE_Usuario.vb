Public Class BE_Usuario : Inherits BE_Personal
    Private vcUsuUsuario As String
    Private vcUsuClave As String
    Private vnUsuEstado As Int32
    Private vdUsuFecRegistro As DateTime

    Public Property cUsuUsuario() As String
        Get
            Return vcUsuUsuario
        End Get
        Set(ByVal value As String)
            vcUsuUsuario = value
        End Set
    End Property

    Public Property cUsuClave() As String
        Get
            Return vcUsuClave
        End Get
        Set(ByVal value As String)
            vcUsuClave = value
        End Set
    End Property

    Public Property nUsuEstado() As Int32
        Get
            Return vnUsuEstado
        End Get
        Set(ByVal value As Int32)
            vnUsuEstado = value
        End Set
    End Property

    Public Property dUsuFecRegistro() As DateTime
        Get
            Return vdUsuFecRegistro
        End Get
        Set(ByVal value As DateTime)
            vdUsuFecRegistro = value
        End Set
    End Property
End Class
