Imports Capa_Negocios
Imports Capa_Entidades
Public Class frmLogin
    Private Sub btnSalir_Click(sender As Object, e As EventArgs) Handles btnSalir.Click
        Me.Close()
    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles btnIngresar.Click
        Dim cUsuUsuario As String = txtLogin.Text
        Dim cUsuClave As String = txtClave.Text
        If cUsuUsuario.Trim = "" Or cUsuClave.Trim = "" Then
            lblMsg.Text = "Ingrese su usuario y clave"
            Return
        End If
        Dim Obj As BE_Usuario = New BL_Usuario().Login(cUsuUsuario, cUsuClave)
        If Obj Is Nothing Then
            lblMsg.Text = "Usuario o clave incorrecto"
        Else
            frmPanel.lblcNombre.Text = Obj.per_nombre
            frmPanel.lblcUsuario.Text = Obj.cUsuUsuario
            frmPanel.lblnUsuCodigo.Text = Obj.per_id
            frmPanel.lblcPuesto.Text = Obj.puesto.pue_nombre
            frmPanel.lblcSueldo.Text = Obj.per_sueldoHora
            frmPanel.Show()
            Me.Hide()
        End If
    End Sub

    Private Sub frmLogin_Load(sender As Object, e As EventArgs) Handles MyBase.Load

    End Sub

    Private Sub txtLogin_keyPress(sender As System.Object, e As System.Windows.Forms.KeyPressEventArgs) Handles txtLogin.KeyPress
        If Char.IsLetter(e.KeyChar) Then
            e.Handled = False ' si se aprecionado una tecla y es una letra que permita escribirla
        ElseIf Char.IsControl(e.KeyChar) Then
            e.Handled = False   ' si se aprecionado la tecla de borrado que permita el borrado
        ElseIf Char.IsSeparator(e.KeyChar) Then
            e.Handled = True ' que  no permita el separado
        Else
            e.Handled = True ' no permita usar los otras teclas 
        End If
    End Sub

    Private Sub txtClave_KeyPress(sender As System.Object, e As System.Windows.Forms.KeyPressEventArgs) Handles txtClave.KeyPress
        If Char.IsLetter(e.KeyChar) Then
            e.Handled = False ' si se aprecionado una tecla y es una letra que permita escribirla
        ElseIf Char.IsControl(e.KeyChar) Then
            e.Handled = False   ' si se aprecionado la tecla de borrado que permita el borrado
        ElseIf Char.IsNumber(e.KeyChar) Then
            e.Handled = False 'si se aprecionado una tecla y es un numero que permita escribirla
        ElseIf Char.IsSeparator(e.KeyChar) Then
            e.Handled = True ' que  no permita el separado
        Else
            e.Handled = True ' no permita usar los otras teclas 
        End If
    End Sub
End Class