import 'package:flutter/material.dart';
import 'package:formvalidation/scr/bloc/provider.dart';
import 'package:formvalidation/scr/providers/usuario_provider.dart';
import 'package:formvalidation/scr/utils/utils.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RegistroPage extends StatelessWidget {
  // const RegistroPage({Key key}) : super(key: key);

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context)
        ],
      )
    );
  }


  Widget _loginForm(BuildContext context){

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;



    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),

          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3
                ),
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Crear cuenta', style:  TextStyle(fontSize: 20.0),),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc),
              ],
            ),
          ),

          FlatButton(
            child: Text('Ya tienes cuenta?'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'), 
          ),
          SizedBox(height: 100.0,)

        ],
      ),
    );
  }



  Widget _crearEmail(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snpshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snpshot.data,
              errorText: snpshot.error
            ),
            onChanged: ( value )=> bloc.chabgeEmail(value),
          ),
        );
      }
    );
  }


   Widget _crearPassword(LoginBloc bloc){
    return StreamBuilder(
       stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snpshot){
        return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, color: Colors.deepPurple,),
                  labelText: 'Contraseña',
                  counterText: snpshot.data,
                  errorText: snpshot.error
                ),
                onChanged: ( value )=> bloc.chabgePassword(value),
              ),
            );
        }
    );
  }


     Widget _crearBoton(LoginBloc bloc){
      //  formValidStream

      return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snpshot){
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Registrar'),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
            elevation: 0.0,
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: snpshot.hasData ? () => _registro(bloc, context) : null
          );
        }
      );
   }

   _registro(LoginBloc bloc, BuildContext context) async {
     ProgressDialog pr;
     pr = new ProgressDialog(context);
     pr = new ProgressDialog(context, type: ProgressDialogType.Download, isDismissible: false, showLogs: false);

     pr.style(
        message: 'Espere un momento',
        borderRadius: 5.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.bounceIn,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
        color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold),
        messageTextStyle: TextStyle(
        color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
     );
     await pr.show();

  //    pr.update(
  //     progress: 10.0,
  //     message: "Please wait...",
  //     progressWidget: Container(
  //     padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
  //     maxProgress: 100.0,
  //     progressTextStyle: TextStyle(
  //     color: Colors.deepPurple, fontSize: 13.0, fontWeight: FontWeight.w400),
  //     messageTextStyle: TextStyle(
  //     color: Colors.deepPurple, fontSize: 19.0, fontWeight: FontWeight.w600),
  // );


     Map info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password);
     if(info['ok']){
        pr.hide().whenComplete(() {
            Navigator.pushReplacementNamed(context, 'home');
        });
     }else{
      //  Mostrar alertas
       pr.hide().whenComplete(() {
          mostrarAlerta(context, 'El email ya existe.');
        });
     }
   }

 Widget _crearFondo(BuildContext context) {
   final size = MediaQuery.of(context).size;
   final fondoMorado = Container(
     height: size.height * 0.4,
     width: double.infinity,
     decoration: BoxDecoration(
       gradient: LinearGradient(
         colors: <Color>[
           Color.fromRGBO(63, 63, 156, 1.0),
           Color.fromRGBO(116, 71, 224, 1.0)
         ]
         )
     ),
   );
    final circulo = Container(
      width: 90.0,
      height: 90.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.2)
      ),
    );


   return Stack(
     children: <Widget>[
       fondoMorado,
       Positioned(top: 90.0, left: 30.0, child: circulo),
       Positioned(top: -40.0, right: -30.0, child: circulo),
       Positioned(bottom: -50.0, right: -10.0, child: circulo),
       Positioned(bottom: 120.0, right: 20.0, child: circulo),
       Positioned(bottom: -50.0, left: -20.0, child: circulo),

      Container(
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          children: <Widget>[
            Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
            SizedBox(height: 10.0, width: double.infinity,),
            Text('David Pereira', style: TextStyle(color: Colors.white, fontSize: 25.0))
          ],
        ),
      )
     ],
   );
 }
}