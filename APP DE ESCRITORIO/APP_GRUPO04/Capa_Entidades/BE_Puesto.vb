Public Class BE_Puesto
    Private m_pue_id As Int32
    Private m_pue_nombre As String
    Public Property pue_nombre() As String
        Get
            Return m_pue_nombre
        End Get
        Set(ByVal value As String)
            m_pue_nombre = value
        End Set
    End Property
    Public Property pue_id() As Int32
        Get
            Return m_pue_id
        End Get
        Set(ByVal value As Int32)
            m_pue_id = value
        End Set
    End Property
End Class
