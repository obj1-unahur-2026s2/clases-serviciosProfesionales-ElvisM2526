
//etapa 1
class Universidad {
  var provincia
  var honorariosRecomendados
  var montoTotal = 0


  method provincia() = provincia
  method honorariosRecomendados() = honorariosRecomendados
  method montoTotal() = montoTotal

  method recibirDonacion(unMonto) {
    montoTotal += unMonto
  }
}

//tipo de profesionales

class ProfesionalVinculado {
  var universidad
  
  method universidad() =universidad 

  method honorarios() {
    return universidad.honorariosRecomendados()
  }

  method provincias() {
    return [universidad.provincia()]
  }

  //etapa 3
  method cobrar(unImporte) {
    universidad.recibirDonacion(unImporte / 2)
  }
}

class ProfesionalAsociado {
  var universidad
  const honorarios = 3000

  method universidad() = universidad
  method honorarios() = honorarios
  method provincias() {
    return ["Entre Ríos", "Santa Fe", "Corrientes"]
  }

  //etapa 3
  method cobrar(unImporte) {
    asociacionDelLitoral.recibirAporte(unImporte)
  }
}

class ProfesionalLibre {
  var universidad
  var honorarios 
  var provincias
  var dineroTotal = 0 //etapa 3

  method universidad() = universidad
  method honorarios() = honorarios
  method provincias() = provincias
  
  //atapa 3
  method dineroTotal() = dineroTotal

  method cobrar(unImporte) {
    dineroTotal += unImporte
  }

  method pasarDinero(unProfesional, unMonto) {
    dineroTotal -= unMonto
    unProfesional.cobrar(unMonto)
  }
}

//empresa

class Empresa {
  var profesionales = []
  var honorariosDeReferencia
  var clientes = #{} //etapa 4

  method honorariosDeReferencia() = honorariosDeReferencia

  method agregarProfesional(unProfesional) {
    profesionales.add(unProfesional)
  }

  method quitarProfesional(unProfesional) {
    profesionales.remove(unProfesional)
  }

  //1
  method cuantosEstudiaronEn(unaUniversidad) {
    return profesionales.count({unProfesional => unProfesional.universidad() == unaUniversidad})
  }
  
  //2
  method profesionalesCaros() {
    return profesionales.filter({unProfesional => unProfesional.honorarios() > honorariosDeReferencia})
  }

  //3
  method universidadesFormadoras() {
    return profesionales.map({unProfesional => unProfesional.universidad()}).asSet()
  }

  //4
  method elProfesionalMasBarato() {
    return profesionales.min({unProfesional => unProfesional.honorarios()})
  }

  //5
  method sonGenteAcotada() {
    return profesionales.all({unProfesional => unProfesional.provincias().size() <= 3})
  }

  //etapa 2
  method puedeSatisfacer(unSolicitante) {
    return profesionales.any({unProfesional => unSolicitante.puedeSerAtendidoPor(unProfesional)})
  }

  //etapa 4
  method clientes() = clientes

  method cuantosClientesHay() {
    return clientes.size()
  }

  method tieneComoCliente(unSolicitante) = clientes.contains(unSolicitante)


  method darServicio(unSolicitante) {
  if (self.puedeSatisfacer(unSolicitante)) {
    self.hacerCobrarAUnProfesionalPara(unSolicitante)
    clientes.add(unSolicitante)
   }
  }

  //metodos para acortar el darServicio
  method hacerCobrarAUnProfesionalPara(unSolicitante) {
   self.cobrarServicio(profesionales.find({ unProf => unSolicitante.puedeSerAtendidoPor(unProf) }))
  }

  method cobrarServicio(unProfesional) {
   unProfesional.cobrar(unProfesional.honorarios())
  }

  //desafio final

  //Todas las provincias del profesional tienen a alguien mejor o mas barato
  method esPocoAtractivo(unProfesional) {
    return unProfesional.provincias().all({ unaProvincia => self.hayAlguienMasBaratoEn(unaProvincia, unProfesional)})
  }

  //Hay algún colega en esa provincia que cobre menos que él
  method hayAlguienMasBaratoEn(unaProvincia, unProfesional) {
    return profesionales.any({ otro => self.esColegaMasBarato(otro, unProfesional) and otro.puedeTrabajarEn(unaProvincia)})
  }

  //Es otro profesional distinto y cobra menos
  method esColegaMasBarato(otro, unProfesional) {
    return otro != unProfesional and otro.honorarios() < unProfesional.honorarios()
  }  
}


//etapa 2

class Persona {
  var provincia

  method provincia() = provincia

  method puedeSerAtendidoPor(unProfesional) {
    return unProfesional.provincias().contains(provincia)
  }
}

class Institucion {
  var universidades
  
  method universidades() = universidades

  method puedeSerAtendidoPor(unProfesional) {
    return universidades.contains(unProfesional.universidad())
  }
}

class Club {
  var provincias = []

  method provincias() = provincias
  
  method puedeSerAtendidoPor(unProfesional) {
    return provincias.any({unaProvincia => unProfesional.provincias().contains(unaProvincia)})
  }
}

//etapa 3

object asociacionDelLitoral {
  var totalRecaudado = 0

  method totalRecaudado() = totalRecaudado

  method recibirAporte(unMonto) {
    totalRecaudado += unMonto
  }
}