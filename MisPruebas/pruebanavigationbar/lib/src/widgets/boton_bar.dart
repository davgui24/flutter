import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

Widget botonBar({ @override String icon, @override double width, @override double height, Function payload }){
  return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 95, 77, 1),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(5, 5))
        ]
      ),
      child: CupertinoButton(
      child: SvgPicture.asset(icon, width: width, height: height,), 
      onPressed: payload
    ),
  );
}



List<Widget> listaBotonesBar(@override String tipo){
  if(tipo == 'moto'){
    return [
      botonBar(icon: 'assets/icons/moto_carrera.svg', width: 50.0, height: 50.0, payload: (){}),
      botonBar(icon: 'assets/icons/moto_mensajeria.svg', width: 50.0, height: 50.0, payload: (){})
    ];
  }else if(tipo == 'carro'){
    return [
      botonBar(icon: 'assets/icons/carro_carrera.svg', width: 50.0, height: 50.0, payload: (){}),
      botonBar(icon: 'assets/icons/taxi.svg', width: 50.0, height: 50.0, payload: (){})
    ];
  }else if(tipo == 'motoYcarro'){
    return [
      botonBar(icon: 'assets/icons/moto_carrera.svg', width: 25.0, height: 25.0, payload: (){}),
      botonBar(icon: 'assets/icons/moto_mensajeria.svg', width: 25.0, height: 25.0, payload: (){}),
      botonBar(icon: 'assets/icons/carro_carrera.svg', width: 25.0, height: 25.0, payload: (){}),
      botonBar(icon: 'assets/icons/taxi.svg', width: 25.0, height: 25.0, payload: (){})
    ];
  }
}
