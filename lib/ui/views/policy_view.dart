import 'package:chequeamefirestore2/ui/shared/app_colors.dart';
import 'package:chequeamefirestore2/ui/shared/ui_helpers.dart';
import 'package:chequeamefirestore2/ui/views/home_view.dart';
import 'package:flutter/material.dart';

class PolicyView extends StatefulWidget {
  @override
  _PolicyView createState() => _PolicyView();
}

class _PolicyView extends State<PolicyView> {
  bool _accept = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Términos y condiciones',
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.kceleste,
            title: Text('Términos y condiciones'),
          ),
          body: new SingleChildScrollView(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                    child: Text('''Términos y Condiciones del Servicio

En  Chequeame ofrecemos al Usuario un Servicio de consultas para que el mismo pueda verificar si los libradores de cheques poseen historial de cheques rechazados y su situación crediticia brindada por fuentes Públicas.
Las consultas del Usuario de Chequeame se realizan de la Base de Datos que brinda la Central de Cheques Rechazados del Banco Central de la República Argentina (BCRA), conformada por datos que el BCRA recibe de los bancos, que se publican sin alteraciones de acuerdo con los plazos dispuestos en el Artículo 26 Inciso 4 de la Ley 25.326 de Protección de los Datos Personales y con el criterio establecido en la Comunicación B 7074 y B 8103 del BCRA. El Servicio que ofrece Chequeame es simplemente facilitar el acceso del Usuario a la Base de Datos que realiza el BCRA.
Los siguientes Términos y Condiciones regirán la relación entre el Usuario interesado en solicitar la contratación del Servicio de Chequeame y Mauricio Durcak, CUIT: 20330953692, con domicilio legal en la calle Allem 128 norte de la Ciudad de San Juan, República Argentina, en su carácter de prestador del servicio bajo la marca Chequeame.

1. Si el Usuario no estuviera de acuerdo con los Términos y condiciones, deberá abstenerse de aceptarlos. Caso contrario, se entiende que acepta plenamente las condiciones establecidas en los Términos y condiciones, y se obliga a cumplirlos, asumiendo todos los derechos y obligaciones.
2. El Usuario debe respetar los Términos y condiciones, siendo el único responsable de su incumplimiento frente a terceros, y dejará en todo caso indemne e indemnizará a Chequeame frente a cualquier reclamo que pudiera originarse, incluyendo los derechos de copyright, marcas, patentes, información, datos personales, confidencialidad y cualquier otro derecho de propiedad intelectual y/o industrial.
3. El Usuario se obliga a usar el Servicio que ofrece Mauricio Durcak con buena fe, de forma diligente, correcta y lícita y, además abstenerse en utilizar el Servicio que ofrece Mauricio Durcak de forma, con fines o efectos contrarios a la ley, a la moral y a las buenas costumbres. Mauricio Durcak se reserva el derecho a rechazar sin previo aviso el acceso al Usuario cuando haga un uso indebido y/o perjudique su normal desarrollo sin que ello genere responsabilidad alguna de Mauricio Durcak ni derecho a reclamo alguno.
4. El Usuario se responsabiliza por el buen uso del servicio, comprometiéndose expresamente a evitar cualquier tipo de acción que pueda dañar a sistemas,  servicios o equipos que sean accesibles directa o indirectamente a través de Internet, incluyendo la congestión intencional de enlaces o sistemas y de acuerdo con las condiciones.
5. Los datos provistos de contacto como correo podrán ser usado por el proveedor para contactarlo con fines comerciales. En el caso de que el usuario solicita no ser contactado se lo dara de baja de nuestra base.
6. Para solicitar la contratación del Servicio el Usuario deberá adquirirlo mediante suscripción en la plataforma de su dispositivo.
7. El Usuario es el único responsable de la veracidad y autenticidad de los datos ingresados por el mismo, no respondiendo Mauricio Durcak por los daños y perjuicios que pudieran ocasionarse al Usuario y/o a terceros como consecuencia de la falsedad o inexactitud de los datos brindados.  Mauricio Durcak podrá rechazar solicitudes en curso y/o suspender temporal o definitivamente al Usuario cuando los datos no hayan podido ser confirmados o verificados. En todos los casos de incumplimiento de los Términos y condiciones, Mauricio Durcak rechazará la solicitud efectuada y/o dará de baja el Servicio contratado por el Usuario, sin que ello genere derecho del Usuario a resarcimiento alguno, teniendo Mauricio Durcak el derecho a reclamar los correspondientes daños y perjuicios.
8. El Usuario se obliga a notificar de manera inmediata por un medio idóneo y fehaciente cualquier rectificación necesaria de los datos personales brindados para la contratación del Servicio, como así también el uso no autorizado de sus datos personales. El Usuario podrá ejercer el derecho de acceso a sus datos personales en los términos establecidos por el Artículo 14 Inciso 3 de la Ley N° 25.326.
9. El Usuario reconoce que la reproducción, la copia, modificación, inclusión, distribución, comercialización, descompilación, desensamblado y/o utilización de técnicas de ingeniería inversa del Servicio ofrecido se encuentra prohibida y constituye una infracción de los derechos de propiedad intelectual, obligándose, en consecuencia, a no realizar ninguna de las acciones mencionadas y a indemnizar a Mauricio Durcak por cualquier incumplimiento o reclamo relacionado con lo aquí dispuesto.
10. La solicitud del Servicio quedará sujeta a la condición de que Mauricio Durcak acepte suministrarlo. En consecuencia, la aceptación de la solicitud del Servicio por parte de Mauricio Durcak será requisito esencial para la formalización del consentimiento.
11. En el momento en que el Usuario acredite la suscripción en la plataforma digital utilizada, se dará por comenzado el vínculo contractual entre Las Partes.
12. El acceso y correcto uso del nombre de usuario y contraseña son responsabilidad exclusiva del mismo Usuario, donde se obliga a notificar a Mauricio Durcak de manera inmediata y por medio idóneo cualquier modificación o uso no autorizado de sus datos.
13. El Servicio es para uso exclusivo del Usuario, en ningún caso podrá revender, ceder ni transferir por cualquier causa o título el Servicio contratado con Mauricio Durcak. En caso de violar esta disposición, Mauricio Durcak podrá dar de baja el Servicio contratado, reservándose el derecho de accionar contra el Usuario por los daños y perjuicios ocasionados a el mismo.
.''', textAlign: TextAlign.justify)),
                UIHelper.verticalSpaceMedium(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        value: _accept,
                        onChanged: (bool value) {
                          setState(() {
                            _accept = value;
                          });
                        },
                      ),
                      new FlatButton(
                        onPressed: () {
                          setState(() {
                            _accept = !_accept;
                          });
                        },
                        child: Text('He leído y acepto los términos'),
                      )
                    ],
                  ),
                ),
                new Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
                    height: 40.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: _accept ? AppColors.kceleste : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: FlatButton(
                      color: _accept ? AppColors.kceleste : Colors.grey,
                      child: Text(
                        'Acepto',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: !_accept
                          ? null
                          : () async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeView()));
                            },
                    )),
                UIHelper.verticalSpaceMedium(),
              ]))),
    );
  }
}
