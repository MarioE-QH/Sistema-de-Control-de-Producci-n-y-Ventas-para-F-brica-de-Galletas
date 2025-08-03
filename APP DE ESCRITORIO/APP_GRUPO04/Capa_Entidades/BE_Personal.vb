Public Class BE_Personal
    Private m_per_id As Int32
    Private m_per_nombre As String
    Private m_per_sueldoHora As Decimal
    Private m_puesto As BE_Puesto


    Public Property puesto() As BE_Puesto
        Get
            Return m_puesto
        End Get
        Set(ByVal value As BE_Puesto)
            m_puesto = value
        End Set
    End Property
    Public Property per_sueldoHora() As Decimal
        Get
            Return m_per_sueldoHora
        End Get
        Set(ByVal value As Decimal)
            m_per_sueldoHora = value
        End Set
    End Property

    Public Property per_nombre() As String
        Get
            Return m_per_nombre
        End Get
        Set(ByVal value As String)
            m_per_nombre = value
        End Set
    End Property

    Public Property per_id() As Int32
        Get
            Return m_per_id
        End Get
        Set(ByVal value As Int32)
            m_per_id = value
        End Set
    End Property
End Class
