package Vista

import AppModel.LoginAppModel
import AppModel.VerReservasAppModel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class Login extends SimpleWindow<LoginAppModel> {

	new(WindowOwner owner, LoginAppModel model) {
		super(owner, model)
		title = "Login"
	}

	override protected addActions(Panel mainPanel) {
		this.botonera(mainPanel)
	}

	override protected createFormPanel(Panel mainPanel) {
		this.labelInputUsrYContrasenia(mainPanel)
	}

	def labelInputUsrYContrasenia(Panel mainPanel) {
		val panelTexto = new Panel(mainPanel)

		new Label(panelTexto).text = "Usuario"
		new TextBox(panelTexto) => [
			bindValueToProperty("nick")
			width = 150
		]

		new Label(panelTexto).text = "Contraseña"
		new PasswordField(panelTexto) => [
			bindValueToProperty("contrasenia")
			width = 150
		]
	}

	def botonera(Panel mainPanel) {
		val panel = new Panel(mainPanel).layout = new HorizontalLayout

		new Button(panel) => [
			caption = "Iniciar Sesíon"
			onClick [|
				modelObject.autorizarLogin
				this.verReservas
				//this.loguear
			]
			setAsDefault
		]
	}

	def loguear() {
		throw new UnsupportedOperationException(
			"Logeado como Usuario: " + modelObject.usuario.nick + " y contraseñia: " + modelObject.usuario.contrasenia)
	}
	
	def verReservas(){
		this.openDialog(new VerReservas(this, new VerReservasAppModel(modelObject.usuario)))
		
	}
	
	def openDialog(Dialog<?> dialog) {

		//dialog.onAccept[|modelObject.]
		dialog.open
		
	}

	
}
