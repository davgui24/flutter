import 'package:flutter/material.dart';
import 'package:formvalidation/scr/bloc/provider.dart';
import 'package:formvalidation/scr/models/producto_model.dart';
import 'package:formvalidation/scr/providers/productos_providers.dart';

class HomePage extends StatelessWidget {
  // const HomePage({Key key}) : super(key: key);

  final productosProviders = new ProductosProviders();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider.of(context);

    return Scaffold(
      appBar:  AppBar(
        title: Text('Home page'),
      ),
      body: _crearListado(context),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'producto'),
    );
  }

  Widget _crearListado(BuildContext context) {
    return FutureBuilder(
      future: productosProviders.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i])
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Widget _crearItem(BuildContext context, ProductoModel producto){
    return Dismissible(
          key: UniqueKey(),
          background: Container(color: Colors.red,),
          onDismissed: (direccion){
            // Borrar producto
            productosProviders.borrarProducto(producto.id);
          },
          child: Card(
            child: Column(
              children: <Widget>[
                (producto.fotoUrl == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'), 
                  image: NetworkImage(producto.fotoUrl),
                  height: 300.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  ),
                  ListTile(
                    title: Text('${producto.titulo}  -  ${producto.valor}'),
                    subtitle: Text(producto.id),
                    onTap: () => Navigator.pushNamed(context, 'producto', arguments: producto),
                  )
              ],
            ),
          ),
    );


  
  }
}