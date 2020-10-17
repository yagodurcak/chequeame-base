import 'package:flutter/material.dart';

class Deuda24 {
  String entidad;
  List<Periodo> periodos;

  Deuda24({
    this.entidad,
    this.periodos,
  });

  Deuda24.fromJson(Map<String, dynamic> json) {
    this.entidad = json['entidad'];
    var listPeriodo = json['periodos'] as List;
    this.periodos = listPeriodo.map((i) => Periodo.fromJson(i)).toList();
  }
}

class Periodo {
  int mes;
  String fecha;
  int situacion;
  int monto;

  Periodo({
    this.mes,
    this.fecha,
    this.situacion,
    this.monto,
  });

  Periodo.fromJson(Map<String, dynamic> json) {
    this.mes = json['mes'];
    this.fecha = json['fecha'];
    this.situacion = json['situacion'];
    this.monto = json['monto'];
  }
}

class Deuda {
  String entidad;
  int situacion;
  String fecha;
  int monto;

  Deuda({
    this.entidad,
    this.situacion,
    this.fecha,
    this.monto,
  });

  Deuda.fromJson(Map<String, dynamic> json) {
    this.entidad = json['entidad'];
    this.situacion = json['situacion'];
    this.fecha = json['fecha_info'];
    this.monto = json['monto'];
  }
}

class Cheque {
  int num_cheque;
  String fecha_rechazo;
  int monto;
  int causal;
  bool baja;

  Cheque(
      {this.num_cheque,
      this.fecha_rechazo,
      this.monto,
      this.causal,
      this.baja});

  Cheque.fromJson(Map<String, dynamic> json) {
    this.num_cheque = json['num_cheque'];
    this.fecha_rechazo = json['fecha_rechazo'];
    this.monto = json['monto'];
    this.causal = json['causal'];
    this.baja = json['baja'];
  }
}

class Info {
  String cuit;
  int score;
  String apellido;
  String nombre;
  String razonSocial;
  String tipoPersona;
  String actividad;
  String periodo;
  List<Cheque> cheques;
  List<Deuda> deudas;
  List<Deuda24> deudas24;
  String error;

  Info(
      {this.cuit,
      this.score,
      this.apellido,
      this.nombre,
      this.razonSocial,
      this.tipoPersona,
      this.actividad,
      this.periodo,
      this.deudas,
      this.cheques,
      this.error});

  Info.initial()
      : cuit = '',
        score = 0,
        nombre = '';

  Info.fromJson(Map<String, dynamic> json) {
    cuit = json['cuit'].toString();
    score = json['score'];
    apellido = json['apellido'];
    nombre = json['nombre'];
    razonSocial = json['razonSocial'];
    tipoPersona = json['tipoPersona'];
    actividad = json['actividad'];
    periodo = json['periodo'];

    var listDeudas = json['deudas'] as List;
    deudas = listDeudas.map((i) => Deuda.fromJson(i)).toList();

    var listCheques = json['cheques'] as List;
    cheques = listCheques.map((i) => Cheque.fromJson(i)).toList();

    var listDeudas24 = json['deudas24'] as List;
    deudas24 = listDeudas24.map((i) => Deuda24.fromJson(i)).toList();

    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cuit'] = int.parse(this.cuit);
    data['score'] = this.score;
    data['apellido'] = this.apellido;
    data['nombre'] = this.nombre;
    data['razonSocial'] = this.razonSocial;
    data['tipoPersona'] = this.tipoPersona;
    data['actividad'] = this.actividad;
    data['periodo'] = this.periodo;
    return data;
  }

  String cuitFormat() {
    if (cuit.length == 11) {
      return '${cuit.substring(0, 2)}-${cuit.substring(2, 10)}-${cuit.substring(10)}';
    }

    return cuit;
  }

  String scoreText() {
    if (score < 580) return 'MUY BAJO';

    if (score < 620) return 'BAJO';

    if (score < 660) return 'REGULAR';

    if (score < 700) return 'BUENO';

    if (score < 760) return 'MUY BUENO';

    return 'EXCELENTE';
  }

  Color scoreColor() {
    if (score < 580) return Color.fromRGBO(165, 0, 0, 1);

    if (score < 620) return Color.fromRGBO(194, 113, 1, 1);

    if (score < 660) return Color.fromRGBO(230, 186, 0, 1);

    if (score < 700) return Color.fromRGBO(255, 235, 0, 1);

    if (score < 760) return Color.fromRGBO(180, 213, 0, 1);

    return Color.fromRGBO(56, 170, 5, 1);
  }

  String denominacion() {
    if (tipoPersona == '') {
      if (apellido.length > 0 || nombre.length > 0) return '$apellido $nombre';
      return razonSocial;
    }

    if (tipoPersona == 'FISICA') {
      return '$apellido $nombre';
    }

    return razonSocial;
  }

  String actividadStr() {
    if (actividad.length < 1) {
      if (tipoPersona.length > 0) return 'PERSONA $tipoPersona';
      return '';
    }

    return actividad;
  }

  int montoDeuda() {
    var sum = 0;
    for (var d in deudas) {
      sum += d.monto;
    }

    return sum;
  }

  int chequesSumSinFondo() {
    var sum = 0;
    for (var c in cheques) {
      if (c.causal == 2) sum++;
    }

    return sum;
  }

  int chequesMontoSinFondo() {
    var sum = 0;
    for (var c in cheques) {
      if (c.causal == 2) sum += c.monto;
    }

    return sum;
  }

  int chequesSumViciosFormales() {
    var sum = 0;
    for (var c in cheques) {
      if (c.causal == 1) sum++;
    }

    return sum;
  }

  int chequesMontoViciosFormales() {
    var sum = 0;
    for (var c in cheques) {
      if (c.causal == 1) sum += c.monto;
    }

    return sum;
  }
}
