Public Class BE_HProduccion
    Private m_hpr_id As Int32
    Private m_hpr_fecha As Date
    Private m_art_id As Int32
    Private m_hpr_cantidad As Int32
    Private m_per_id As Int32
    Private m_hpr_fechaInicio As Date
    Private m_hpr_horaInicio As Date
    Private m_hpr_fechaFin As Int32
    Private m_hpr_horaFin As Date
    Private m_hpr_presupuesto As Decimal
    Private m_pla_id As Int32
    Private m_res_id As Int32
    Public Property res_id() As Int32
        Get
            Return m_res_id
        End Get
        Set(ByVal value As Int32)
            m_res_id = value
        End Set
    End Property
    Public Property pla_id() As Int32
        Get
            Return m_pla_id
        End Get
        Set(ByVal value As Int32)
            m_pla_id = value
        End Set
    End Property

    Public Property hpr_presupuesto() As Decimal
        Get
            Return m_hpr_presupuesto
        End Get
        Set(ByVal value As Decimal)
            m_hpr_presupuesto = value
        End Set
    End Property
    Public Property hpr_horaFin() As Date
        Get
            Return m_hpr_horaFin
        End Get
        Set(ByVal value As Date)
            m_hpr_horaFin = value
        End Set
    End Property
    Public Property hpr_fechaFin() As Int32
        Get
            Return m_hpr_fechaFin
        End Get
        Set(ByVal value As Int32)
            m_hpr_fechaFin = value
        End Set
    End Property
    Public Property hpr_horaInicio() As Date
        Get
            Return m_hpr_horaInicio
        End Get
        Set(ByVal value As Date)
            m_hpr_horaInicio = value
        End Set
    End Property
    Public Property hpr_fechaInicio() As Date
        Get
            Return m_hpr_fechaInicio
        End Get
        Set(ByVal value As Date)
            m_hpr_fechaInicio = value
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
    Public Property hpr_cantidad() As Int32
        Get
            Return m_hpr_cantidad
        End Get
        Set(ByVal value As Int32)
            m_hpr_cantidad = value
        End Set
    End Property

    Public Property NewProperty() As Int32
        Get
            Return m_art_id
        End Get
        Set(ByVal value As Int32)
            m_art_id = value
        End Set
    End Property
    Public Property hpr_fecha() As Date
        Get
            Return m_hpr_fecha
        End Get
        Set(ByVal value As Date)
            m_hpr_fecha = value
        End Set
    End Property

    Public Property hpr_id() As Int32
        Get
            Return m_hpr_id
        End Get
        Set(ByVal value As Int32)
            m_hpr_id = value
        End Set
    End Property
End Class
