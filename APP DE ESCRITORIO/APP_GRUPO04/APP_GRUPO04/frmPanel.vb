Public Class frmPanel
    Dim FrmProduccion As frmHProduccion
    Dim FrmPermisos As frmPermisos


    Private Sub HProduccionToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles HProduccionToolStripMenuItem.Click
        If Me.Contains(FrmProduccion) Then
            FrmProduccion.Activate()
        End If
        FrmProduccion = New frmHProduccion()
        FrmProduccion.MdiParent = Me
        FrmProduccion.Show()
    End Sub

    Private Sub PermisosToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles PermisosToolStripMenuItem.Click
        If Me.Contains(FrmPermisos) Then
            FrmPermisos.Activate()
        End If
        FrmPermisos = New frmPermisos()
        FrmPermisos.MdiParent = Me
        FrmPermisos.Show()
    End Sub

    Private Sub MantenedoresToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles MantenedoresToolStripMenuItem.Click

    End Sub
End Class
