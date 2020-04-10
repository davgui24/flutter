import 'package:shared_preferences/shared_preferences.dart';




class PreferenciasUsuario {

 static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

 factory PreferenciasUsuario(){
   return _instancia;
 }

 PreferenciasUsuario._internal();

 SharedPreferences _prefs;

 initPref() async {
   this._prefs = await SharedPreferences.getInstance();
 }

// Cuando se haga ...  pref = new PreferenciasUsuario(); desde cualquier parte
// va a disparar el factory, 
// que a su vez retorna la una única instancia de _instancia en toda la aplicación


// GET y SET del genero
  get genero{
    // si no existe el generoa tomará el valor de 1
    return _prefs.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _prefs.setInt('genero', value);
  }


  // GET y SET del colorSecunsario
  get colorSecunsario{
    // si no existe el generoa tomará el valor de 1
    return _prefs.getBool('colorSecunsario') ?? false;
  }

  set colorSecunsario(bool value) {
    _prefs.setBool('colorSecunsario', value);
  }

    // GET y SET del nombre
  get nombre{
    // si no existe el generoa tomará el valor de 1
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }



     // GET y SET del ultimaPagina
  get ultimaPagina{
    // si no existe el generoa tomará el valor de 1
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }



}