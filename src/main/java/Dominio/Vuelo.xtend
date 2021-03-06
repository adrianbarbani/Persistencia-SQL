package Dominio

import java.text.SimpleDateFormat
import java.util.Date
import java.util.HashSet
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Entity
@Accessors
@Observable
class Vuelo {
	
	@Id
	@GeneratedValue
	private Long id
	
	@ManyToOne()
	Aeropuerto origen

	@ManyToOne()
	Aeropuerto destino

	@Column(length=150)
	String aerolinea

	//un vuelo puede tener muchos asientos y un asiento puede tener solo un vuelo.
	//cascade para borrar los asientos si se borra el vuelo.
	//cambio de list a set.
	@OneToMany(cascade=CascadeType.ALL)
	Set<Asiento> asientos = new HashSet

	@Column
	Date fechaSalida

	@Column
	Date fechaLlegada

	//un vuelo puede tener muchas escalas y una escala puede tener solo un vuelo.
	//cascade para borrar las escalas si se borra el vuelo. Una Escala por vuelo
	//cambio de list a set.
	@OneToMany(cascade=CascadeType.ALL)
	Set<Escala> escalas = new HashSet
	
	@ManyToOne()
	Reserva miReserva

	//es necesario parsearlo??
	SimpleDateFormat dateToString = new SimpleDateFormat("dd/MM/yyyy - hh:mm 'hs'")

	new() {
	}

	def agregarEscala(Escala escala) {
		escalas.add(escala)
	}

	def getCantidadDeAsientosLibres() {
		asientos.filter[asiento|asiento.duenio == null].toList.size()
	}

	def conDestino(String destinoStr) {
		destino.nombre.equals(destinoStr)
	}

	def conOrigen(String origenStr) {
		origen.nombre.equals(origenStr)
	}

	//	def getCantAsientosMenorA(float valor){
	//		conTar
	//	}
	def contTarifaMenorA(float valor) {
		asientos.exists[conPrecioMaximo(valor)]

	//		!asientosValorMaximo(valor).empty
	}

	def asientosValorMaximo(float valor) {
		asientos.filter[conPrecioMaximo(valor)].toList
	}

	def llegaAntesQue(Date unaFecha) {
		fechaLlegada.before(unaFecha)
	}

	def saleAntesQue(Date unaFecha) {
		fechaSalida.before(unaFecha)
	}

	def getNombreOrigen() { origen.nombre }

	def getNombreDestino() { destino.nombre }

	def getCantidadEscalas() { escalas.size }

	def getFechaSalidaStr() { dateToString.format(fechaSalida) }

	def getFechaLlegadaStr() { dateToString.format(fechaLlegada) }

}
