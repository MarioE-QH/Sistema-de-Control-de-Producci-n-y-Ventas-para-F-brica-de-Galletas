Public Class BE_UnidadMedida
    Private m_unm_id As Int32
    Private m_unm_nombre As String
    Public Property unm_nombre() As String
        Get
            Return m_unm_nombre
        End Get
        Set(ByVal value As String)
            m_unm_nombre = value
        End Set
    End Property


    Public Property unm_id() As Int32
        Get
            Return m_unm_id
        End Get
        Set(ByVal value As Int32)
            m_unm_id = value
        End Set
    End Property
End Class
