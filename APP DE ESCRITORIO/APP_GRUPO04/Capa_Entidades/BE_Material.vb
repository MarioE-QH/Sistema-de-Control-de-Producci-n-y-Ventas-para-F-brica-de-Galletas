Public Class BE_Material
    Private m_mat_id As Int32
    Private m_mat_nombre As String
    Private m_medida As BE_UnidadMedida
    Private m_mat_cantidad As Int32
    Private m_mat_precioUnitario As Decimal
    Public Property mat_precioUnitario() As Decimal
        Get
            Return m_mat_precioUnitario
        End Get
        Set(ByVal value As Decimal)
            m_mat_precioUnitario = value
        End Set
    End Property

    Public Property mat_cantidad() As Int32
        Get
            Return m_mat_cantidad
        End Get
        Set(ByVal value As Int32)
            m_mat_cantidad = value
        End Set
    End Property

    Public Property medida() As BE_UnidadMedida
        Get
            Return m_medida
        End Get
        Set(ByVal value As BE_UnidadMedida)
            m_medida = value
        End Set
    End Property

    Public Property mat_nombre() As String
        Get
            Return m_mat_nombre
        End Get
        Set(ByVal value As String)
            m_mat_nombre = value
        End Set
    End Property
    Public Property mat_id() As Int32
        Get
            Return m_mat_id
        End Get
        Set(ByVal value As Int32)
            m_mat_id = value
        End Set
    End Property
End Class
