Public Class BE_Articulo
    Private m_art_id As Int32
    Private m_art_nombre As String
    Private m_art_stock As Int32
    Public Property art_stock() As Int32
        Get
            Return m_art_stock
        End Get
        Set(ByVal value As Int32)
            m_art_stock = value
        End Set
    End Property

    Public Property art_nombre() As String
        Get
            Return m_art_nombre
        End Get
        Set(ByVal value As String)
            m_art_nombre = value
        End Set
    End Property

    Public Property art_id() As Int32
        Get
            Return m_art_id
        End Get
        Set(ByVal value As Int32)
            m_art_id = value
        End Set
    End Property
End Class
