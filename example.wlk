class Universidad {
  var provincia
  var honorariosRecomendados


  method provincia() = provincia
  method honorariosRecomendados() = honorariosRecomendados
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
}

class ProfesionalAsociado {
  var universidad
  const honorarios = 3000

  method universidad() = universidad
  method honorarios() = honorarios
  method provincias() {
    return ["Entre Ríos", "Santa Fe", "Corrientes"]
  }
}

class ProfesionalLibre {
  var universidad
  var honorarios 
  var provincias

  method universidad() = universidad
  method honorarios() = honorarios
  method provincias() = provincias
}

//empresa

class Empresa {
  var profesionales = []
  var honorariosDeReferencia

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
}