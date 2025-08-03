Public Class BE_hproduccionMaterial
    Private m_hprmat_id As Int32
    Private m_material As BE_Material
    Private m_mat_id As Int32
    Private m_hprmat_cantidad As Int32
    Private m_valor_total_produccion As Decimal
    Private m_hproduccion As BE_HProduccion
    Public Property hproduccion() As BE_HProduccion
        Get
            Return m_hproduccion
        End Get
        Set(ByVal value As BE_HProduccion)
            m_hproduccion = value
        End Set
    End Property
    Public Property valor_total_produccion() As Decimal
        Get
            Return m_valor_total_produccion
        End Get
        Set(ByVal value As Decimal)
            m_valor_total_produccion = value
        End Set
    End Property
    Public Property hprmat_cantidad() As String
        Get
            Return m_hprmat_cantidad
        End Get
        Set(ByVal value As String)
            m_hprmat_cantidad = value
        End Set
    End Property
    Public Property mat_id() As String
        Get
            Return m_mat_id
        End Get
        Set(ByVal value As String)
            m_mat_id = value
        End Set
    End Property
    Public Property material() As BE_Material
        Get
            Return m_material
        End Get
        Set(ByVal value As BE_Material)
            m_material = value
        End Set
    End Property
    Public Property hprmat_id() As Int32
        Get
            Return m_hprmat_id
        End Get
        Set(ByVal value As Int32)
            m_hprmat_id = value
        End Set
    End Property
End Class
