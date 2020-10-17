import 'package:chequeamefirestore2/models/info.dart';
import 'package:chequeamefirestore2/ui/shared/app_colors.dart';
import 'package:chequeamefirestore2/ui/shared/text_styles.dart';
import 'package:chequeamefirestore2/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:provider_architecutre/core/models/info.dart';
//import 'package:provider_architecutre/ui/shared/app_colors.dart';
//import 'package:provider_architecutre/ui/shared/text_styles.dart';
//import 'package:provider_architecutre/ui/shared/ui_helpers.dart';
//import 'package:provider_architecutre/ui/widgets/circle_progress_bar.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:vector_math/vector_math.dart' as math;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class PostView extends StatefulWidget {
  final Info info;
  PostView({this.info});
  @override
  _ProgressCardState createState() => _ProgressCardState(info: info);
}

var _score;
int getMonto(List<Deuda> deudas, String mes) {
  var sum = 0;

  for (var d in deudas) {
    sum += d.fecha.substring(5, 7) == mes ? d.monto : 0;
  }

  return sum;
}

List<charts.Series<DeudaBarData, String>> _createBarData12(
    List<Deuda24> deudas24) {
  var series = new List<charts.Series<DeudaBarData, String>>();
  var num_months = 12;

  for (var situacion = 1; situacion <= 6; situacion++) {
    var sum = new List<int>(num_months);
    for (var i = 0; i < num_months; i++) sum[i] = 0;

    for (var deuda in deudas24) {
      for (var i = 0; i < num_months; i++) {
        var periodo = deuda.periodos[i];

        if (periodo.situacion == situacion) sum[i] += periodo.monto;
      }
    }

    var data = new List<DeudaBarData>();
    for (var i = num_months - 1; i >= 0; i--) {
      var fecha = (i == 0) ? '' : deudas24[0].periodos[i].fecha;
      data.add(new DeudaBarData('${i + 1}', fecha, sum[i]));
    }

    var color = charts.Color(r: 165, g: 0, b: 0);
    switch (situacion) {
      case 1:
        color = charts.Color(r: 56, g: 170, b: 5);
        break;
      case 2:
        color = charts.Color(r: 255, g: 235, b: 0);
        break;
      case 3:
        color = charts.Color(r: 194, g: 113, b: 1);
        break;
      case 4:
        color = charts.Color(r: 165, g: 0, b: 0);
        break;
    }

    series.add(new charts.Series<DeudaBarData, String>(
      id: '$situacion',
      domainFn: (DeudaBarData sales, _) => sales.fecha,
      measureFn: (DeudaBarData sales, _) => sales.monto,
      data: data,
      colorFn: (_, __) => color,
    ));
  }

  return series;
}

List<charts.Series<DeudaBarData, String>> _createBarData24(
    List<Deuda24> deudas24) {
  var series = new List<charts.Series<DeudaBarData, String>>();
  var numMonths = 24;

  for (var situacion = 1; situacion <= 6; situacion++) {
    var sum = new List<int>(numMonths);
    for (var i = 0; i < numMonths; i++) sum[i] = 0;

    for (var deuda in deudas24) {
      for (var i = 0; i < numMonths; i++) {
        var periodo = deuda.periodos[i];

        if (periodo.situacion == situacion) sum[i] += periodo.monto;
      }
    }

    var data = new List<DeudaBarData>();
    for (var i = numMonths - 1; i >= 0; i--) {
      data.add(
          new DeudaBarData('${i + 1}', deudas24[0].periodos[i].fecha, sum[i]));
    }

    var color = charts.Color(r: 165, g: 0, b: 0);
    switch (situacion) {
      case 1:
        color = charts.Color(r: 56, g: 170, b: 5);
        break;
      case 2:
        color = charts.Color(r: 255, g: 235, b: 0);
        break;
      case 3:
        color = charts.Color(r: 194, g: 113, b: 1);
        break;
      case 4:
        color = charts.Color(r: 165, g: 0, b: 0);
        break;
    }

    series.add(new charts.Series<DeudaBarData, String>(
      id: '$situacion',
      domainFn: (DeudaBarData sales, _) => sales.fecha,
      measureFn: (DeudaBarData sales, _) => sales.monto,
      data: data,
      colorFn: (_, __) => color,
    ));
  }

  return series;
}

List<charts.Series<DeudaChartData, String>> _createChartData(
    List<Deuda> deudas) {
  var data = new List<DeudaChartData>();
  for (var situacion = 1; situacion <= 6; situacion++) {
    var monto = 0;
    for (var d in deudas) {
      if (d.situacion == situacion) monto += d.monto;
    }
    if (monto > 0) {
      var color = charts.Color(r: 1265, g: 0, b: 0);
      switch (situacion) {
        case 1:
          color = charts.Color(r: 56, g: 170, b: 5);
          break;
        case 2:
          color = charts.Color(r: 180, g: 213, b: 0);
          break;
        case 3:
          color = charts.Color(r: 255, g: 235, b: 0);
          break;
        case 4:
          color = charts.Color(r: 230, g: 186, b: 0);
          break;
      }
      data.add(new DeudaChartData(
          'Situación ' + situacion.toString(), monto, color));
    }
  }

  return [
    new charts.Series<DeudaChartData, String>(
      domainFn: (DeudaChartData sales, _) => sales.situacion,
      measureFn: (DeudaChartData sales, _) => sales.monto,
      colorFn: (DeudaChartData sales, _) => sales.color,
      data: data,
      labelAccessorFn: (DeudaChartData row, _) =>
          '${row.situacion}: ${row.monto}',
    )
  ];
}

class GaugeSegment {
  final String segment;
  final int size;
  var color;

  GaugeSegment(this.segment, this.size, this.color);
}

List<charts.Series<GaugeSegment, String>> _createSampleData() {
  final data = [
    new GaugeSegment('MUY BAJO', 580, charts.Color(r: 165, g: 0, b: 0)),
    new GaugeSegment('BAJO', 40, charts.Color(r: 194, g: 113, b: 1)),
    new GaugeSegment('REGULAR', 40, charts.Color(r: 230, g: 186, b: 0)),
    new GaugeSegment('BUENO', 40, charts.Color(r: 255, g: 235, b: 0)),
    new GaugeSegment('MUY BUENO', 60, charts.Color(r: 180, g: 213, b: 0)),
    new GaugeSegment('EXCELENTE', 240, charts.Color(r: 56, g: 170, b: 5)),
  ];

  return [
    new charts.Series<GaugeSegment, String>(
      id: 'Segments',
      domainFn: (GaugeSegment segment, _) => segment.segment,
      measureFn: (GaugeSegment segment, _) => segment.size,
      data: data,
      colorFn: (GaugeSegment segment, _) => segment.color,
    )
  ];
}

class DeudaChartData {
  final String situacion;
  final int monto;
  var color;

  DeudaChartData(this.situacion, this.monto, this.color);
}

class DeudaBarData {
  final String mes;
  final String fecha;
  final int monto;

  DeudaBarData(this.mes, this.fecha, this.monto);
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double val = 825;
    double angle = 180.0 + (_score * 180 / 1000);
    double a = size.width / 2;
    double b = size.height / 2;
    double r = size.height / 2.5;
    double x = a + r * cos(math.radians(angle));
    double y = b + r * sin(math.radians(angle));

    final p1 = Offset(size.width / 2, size.height / 2);
    final p2 = Offset(x, y);

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 7
      ..style = PaintingStyle.fill;
    final paint2 = Paint()
      ..color = Colors.white.withAlpha(150)
      ..strokeWidth = 12
      ..style = PaintingStyle.fill;
    canvas.drawLine(p1, p2, paint2);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _ProgressCardState extends State<PostView> {
  final Info info;
  _ProgressCardState({this.info});
  double progressPercent = 0;

  @override
  void initState() {
    @override
    final updated = ((this.progressPercent + 0.1).clamp(0.0, 1.0) * 100);
    setState(() {
      this.progressPercent = updated.round() / 100;
      print(this.progressPercent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> litems = ["1", "2", "Third", "4"];
    final oCcy = new NumberFormat("#,##0.00", "es_AR");
    var assetsImage = new AssetImage('images/logo_white.png');
    var image = new Image(image: assetsImage);
    Color foreground = info.scoreColor();
    Color background = foreground.withOpacity(0.2);
    Size size = MediaQuery.of(context).size;
    _score = info.score;
    return Stack(children: [
      Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/bg_bottom.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: AppColors.kceleste,
                    expandedHeight: MediaQuery.of(context).size.height * 0.2,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Container(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: size.width,
                              minWidth: 100,
                              maxHeight: 200,
                              minHeight: 0,
                            ),
                            child: AutoSizeText(info.denominacion(),
                                style: TextStyle(fontSize: 20.0),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        background: Image.asset(
                          "assets/images/bg_top2.png",
                          fit: BoxFit.cover,
                        )),
                  ),
                ];
              },
              body: Center(
                  child: new SingleChildScrollView(
                      child: new Form(
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                    new Container(
                        padding: EdgeInsets.only(left: 20, top: 10, bottom: 30),
                        margin: EdgeInsets.only(left: 40.0, right: 40, top: 7),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2.0,
                                color: Colors.black.withOpacity(.2),
                                offset: Offset(0, 0.5),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              UIHelper.verticalSpaceSmall(),
                              Text(info.cuitFormat(),
                                  textAlign: TextAlign.start,
                                  style: data2Style),
                              UIHelper.verticalSpaceSmall(),
                              if (info.actividadStr().length > 0)
                                UIHelper.verticalSpaceSmall(),
                              if (info.actividadStr().length > 0)
                                Text(info.actividadStr(),
                                    textAlign: TextAlign.start,
                                    style: data3Style),
                              if (info.error.length > 0)
                                UIHelper.verticalSpaceSmall(),
                              if (info.error.length > 0)
                                Text(info.error,
                                    textAlign: TextAlign.start,
                                    style: data3_1Style),
                            ])),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        margin: EdgeInsets.only(left: 40, right: 40, top: 0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0)),
                        //height: 100,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Stack(children: [
                                Container(
                                  margin: EdgeInsets.only(top: 40),
                                  child: Text("Score:",
                                      textAlign: TextAlign.start,
                                      style: data4Style),
                                ),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 0.0),
                                    height: size.width - 50,
                                    child: Stack(
                                      children: <Widget>[
                                        charts.PieChart(
                                          _createSampleData(),
                                          animate: false,
                                          defaultRenderer:
                                              new charts.ArcRendererConfig(
                                                  arcWidth: (size.width / 12)
                                                      .round()
                                                      .toInt(),
                                                  startAngle: pi,
                                                  arcLength: pi),
                                        ),
                                        CustomPaint(
                                          painter: ShapesPainter(),
                                          child: Container(
                                            height: size.width,
                                          ),
                                        ),
                                        Container(
                                            height: (size.width) -
                                                (size.width / 1.6),
                                            margin: EdgeInsets.only(
                                                top: (size.width / 1.6) / 2.5),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 2.0,
                                                    color: Colors.black
                                                        .withOpacity(.5),
                                                    offset: Offset(0, 1.0),
                                                  ),
                                                ],
                                                color: Colors.white),
                                            child: Center(
                                              child: Text(
                                                (info.score / 10)
                                                    .toInt()
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 32.0,
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                      ],
                                    )),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: size.width / 1.4),
                                  width: double.infinity,
                                  child: Text(info.scoreText(),
                                      textAlign: TextAlign.center,
                                      style: scoreResultStyle),
                                ),
                                new Container(
                                  margin: EdgeInsets.only(
                                      left: 40,
                                      right: 40,
                                      top: size.width / 1.4 + 30),
                                  height: 2,
                                  color: info.scoreColor(),
                                ),
                                UIHelper.verticalSpaceMedium(),
                              ]),
                              Text("Cheques rechazados:",
                                  textAlign: TextAlign.start,
                                  style: data4Style),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0.0, vertical: 10),
                                height: 60.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 0,
                                        color: Colors.black.withOpacity(.5),
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2, vertical: 2),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: Image.asset(
                                                'assets/images/cheque_1.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, top: 10, bottom: 10),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Sin fondo",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: data5Style),
                                                    Text(
                                                        "\$${oCcy.format(info.chequesMontoSinFondo())}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: data6Style),
                                                  ])),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 10),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                  info
                                                      .chequesSumSinFondo()
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: data6Style)
                                            ]),
                                      )
                                    ]),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0.0, vertical: 10),
                                height: 60.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 0,
                                        color: Colors.black.withOpacity(.5),
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2, vertical: 2),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: Image.asset(
                                                'assets/images/cheque_2.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, top: 10, bottom: 10),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                        "Por defectos formales",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: data5Style),
                                                    Text(
                                                        "\$${oCcy.format(info.chequesMontoViciosFormales())}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: data6Style),
                                                  ])),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 10),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                  info
                                                      .chequesSumViciosFormales()
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  style: data6Style)
                                            ]),
                                      )
                                    ]),
                              ),
                              UIHelper.verticalSpaceMedium(),
                              Text("Central de deudores:",
                                  textAlign: TextAlign.start,
                                  style: data4Style),
                              UIHelper.verticalSpaceMedium(),
                              for (var deuda in info.deudas)
                                Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('${deuda.entidad}'.toUpperCase(),
                                            style: data8Style),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 20),
                                                child: Text(
                                                    '\$${oCcy.format(deuda.monto * 1000)}',
                                                    style: data9Style),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 40),
                                                child: Text(
                                                    'Situación al ${deuda.fecha.toString()}',
                                                    style: data9Style),
                                              ),
                                            ]),
                                        UIHelper.verticalSpaceSmall(),
                                      ]),
                                ),
                              UIHelper.verticalSpaceMedium(),
                              Text("Total:",
                                  textAlign: TextAlign.start,
                                  style: data4Style),
                              Container(
                                  height: size.width - 100,
                                  child: Stack(children: <Widget>[
                                    charts.PieChart(
                                      _createChartData(info.deudas),
                                      animate: true,
                                      defaultRenderer:
                                          new charts.ArcRendererConfig(
                                        arcWidth: 50,
                                      ),
                                      behaviors: [
                                        new charts.DatumLegend(
                                          position:
                                              charts.BehaviorPosition.bottom,
                                          outsideJustification: charts
                                              .OutsideJustification
                                              .startDrawArea,
                                          horizontalFirst: false,
                                          desiredMaxRows: 2,
                                          cellPadding: new EdgeInsets.only(
                                              right: 4.0, bottom: 4.0),
                                          entryTextStyle: charts.TextStyleSpec(
                                              fontFamily: 'Georgia',
                                              fontSize: 11),
                                        )
                                      ],
                                    ),
                                    Center(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                          Text(
                                            "\$${info.montoDeuda()}K",
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          UIHelper.verticalSpaceMedium(),
                                        ])),
                                  ])),
                              UIHelper.verticalSpaceMedium(),
                              Center(
                                  child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            "assets/images/cuadrosituacion.png"))),
                              )),
                              UIHelper.verticalSpaceMedium(),
                              if (info.deudas24.length > 0)
                                Text("Últimos 12 meses:  ",
                                    textAlign: TextAlign.start,
                                    style: data4Style),
                              UIHelper.verticalSpaceMedium(),
                              if (info.deudas24.length > 0)
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 0.0),
                                    height: size.width - 100,
                                    child: new charts.BarChart(
                                      _createBarData12(info.deudas24),
                                      animate: true,
                                      barGroupingType:
                                          charts.BarGroupingType.stacked,
                                      domainAxis: new charts.OrdinalAxisSpec(
                                          // Make sure that we draw the domain axis line.
                                          showAxisLine: true,
                                          // But don't draw anything else.
                                          renderSpec:
                                              new charts.NoneRenderSpec()),
                                      // Make sure that we draw the domain axis line.

                                      // But don't draw anything else.
                                    )),
                              if (info.deudas24.length > 0)
                                UIHelper.verticalSpaceMedium(),
                              if (info.deudas24.length > 0)
                                Text("Últimos 24 meses:",
                                    textAlign: TextAlign.start,
                                    style: data4Style),
                              if (info.deudas24.length > 0)
                                UIHelper.verticalSpaceMedium(),
                              if (info.deudas24.length > 0)
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 0.0),
                                    height: size.width - 100,
                                    child: new charts.BarChart(
                                      _createBarData24(info.deudas24),
                                      animate: true,
                                      barGroupingType:
                                          charts.BarGroupingType.stacked,
                                      domainAxis: new charts.OrdinalAxisSpec(
                                          // Make sure that we draw the domain axis line.
                                          showAxisLine: true,
                                          // But don't draw anything else.
                                          renderSpec:
                                              new charts.NoneRenderSpec()),
                                    ))
                            ])),
                    Text("Fuentes: BCRA y AFIP")
                  ])))))),
    ]);
    /*Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceMedium(),
            new Container(
                margin: EdgeInsets.symmetric(horizontal: 70.0, vertical: 0),
                child: image
            ),
            UIHelper.verticalSpaceMedium(),
            Text(
              'by ${Provider.of<User>(context).name}',
              style: TextStyle(fontSize: 9.0),
            ),
            UIHelper.verticalSpaceMedium(),
            Text(post.body),
            Comments(post.id)
          ],
        ),
      ),
    );*/
  }
}
