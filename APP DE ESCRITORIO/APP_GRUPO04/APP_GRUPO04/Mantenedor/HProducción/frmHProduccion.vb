Imports Capa_Negocios
Imports Capa_Entidades
Public Class frmHProduccion
    Dim BL_hproduccioMaterial As New BL_hproduccioMaterial
    Dim ObjCantidad As New BE_hproduccionMaterial

    Private Sub ListaGridDetalleMaterial()
        'dgDM.AutoGenerateColumns = False
        Dim lista1 = BL_hproduccioMaterial.ListarDetalleMaterial(txtNroProduccion.Text)
        dgDM.DataSource = Nothing
        If (dgDM.Rows.Count() > 0) Then

            dgDM.Rows.Clear()
        End If

        For Each item As BE_hproduccionMaterial In lista1
            Dim fila As Int32 = dgDM.Rows.Add()
            dgDM.Rows(fila).Cells("mat_id").Value = item.mat_id
            dgDM.Rows(fila).Cells("mat_nombre").Value = item.material.mat_nombre
            dgDM.Rows(fila).Cells("hprmat_cantidad").Value = item.hprmat_cantidad
            dgDM.Rows(fila).Cells("mat_precioUnitario").Value = item.material.mat_precioUnitario
            dgDM.Rows(fila).Cells("hprmat_id").Value = item.hprmat_id
            dgDM.Rows(fila).Cells("valor_total_produccion").Value = item.valor_total_produccion
        Next

    End Sub
    Private Sub GridDetalleMaterial()
        dgDM.AutoGenerateColumns = False
        dgDM.DataSource = BL_hproduccioMaterial.ListarDetalleMaterialdt(txtNroProduccion.Text)
    End Sub
    Private Sub Button3_Click(sender As Object, e As EventArgs) Handles btnConsultar.Click


        Dim ObjArticulo As BE_Articulo = New BL_Articulo().VerArticulo(txtNroProduccion.Text.Trim)

        If ObjArticulo Is Nothing Then
            MessageBox.Show("NroProduccion NO SE ENCUENTRA REGISTRADO", "ASISTENTE DE BUSQUEDA DE HProduccion", MessageBoxButtons.OK, MessageBoxIcon.Information)
            txtNroProduccion.Text = ""
            txtNroProduccion.Focus()
            txtNombreArticulo.Text = ""
            dgDM.DataSource = New DataTable
        Else

            txtNombreArticulo.Text = ObjArticulo.art_nombre

            ListaGridDetalleMaterial()
            'Dim ObjNroProduccion As BE_hproduccionMaterial = New BL_hproduccioMaterial().ListarDetalleMaterial(txtNroProduccion.Text.Trim)

        End If

    End Sub

    Private Sub dgDM_DoubleClick(sender As System.Object, e As System.EventArgs) Handles dgDM.DoubleClick
        If dgDM.Rows.Count > 0 Then
            Dim dgDMfila As DataGridViewRow = Me.dgDM.CurrentRow()
            txtIdMaterial.Text = dgDMfila.Cells("mat_id").Value
            txtMaterial.Text = dgDMfila.Cells("mat_nombre").Value
            txtDetalle.Text = dgDMfila.Cells("hprmat_id").Value
            txtCantidad.Text = dgDMfila.Cells("hprmat_cantidad").Value
            btnRegistrar.Enabled = False
            btnModificar.Enabled = True
        End If
    End Sub

    Private Sub btnModificar_Click(sender As Object, e As EventArgs) Handles btnModificar.Click
        Dim result As DialogResult = MessageBox.Show("¿Estas seguro que deseas modificar la cantidad", "ASISTENTE REGISTRO DE HPRODUCCION", MessageBoxButtons.YesNo)
        If result = DialogResult.Yes Then
            ObjCantidad.hprmat_id = txtDetalle.Text

            ObjCantidad.hprmat_cantidad = txtCantidad.Text

            Dim rpta = BL_hproduccioMaterial.ModificarCantidad(ObjCantidad)
            If (rpta >= 0) Then
                MessageBox.Show("Expediente modificado con exito", "ASISTENTE REGISTRO DE EXPEDIENTES", MessageBoxButtons.OK, MessageBoxIcon.Information)

                GridDetalleMaterial()
                LimpiarControles()
            End If
        End If
    End Sub

    Private Sub LimpiarControles()
        txtCantidad.Text = ""
        txtDetalle.Text = ""
        txtIdMaterial.Text = ""
        txtMaterial.Text = ""

    End Sub


    Private Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminar.Click
        Dim result As DialogResult = MessageBox.Show("¿Estas seguro que deseas eliminar este registro", "ASISTENTE APROBADORES DE EXPEDIENTES", MessageBoxButtons.YesNo)
        If result = DialogResult.Yes Then
            Dim rpta = BL_hproduccioMaterial.EliminarDetalle(txtDetalle.Text)
            If rpta >= 0 Then
                MessageBox.Show("Registro eliminado con exito", ":v", MessageBoxButtons.OK, MessageBoxIcon.Information)
                GridDetalleMaterial()
                LimpiarControles()


            End If
        End If
    End Sub

    Private Sub dgDM_CellContentClick(sender As Object, e As DataGridViewCellEventArgs) Handles dgDM.CellContentClick

    End Sub

    Private Sub btnRegistrar_Click(sender As Object, e As EventArgs) Handles btnRegistrar.Click

    End Sub

    Private Sub frmHProduccion_Load(sender As Object, e As EventArgs) Handles MyBase.Load

    End Sub
End Class