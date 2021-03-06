import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/providers/Curso_provider.dart';

class CursoAgregarPage extends StatefulWidget {
  CursoAgregarPage({Key? key}) : super(key: key);

  @override
  State<CursoAgregarPage> createState() => _CursoAgregarPageState();
}

class _CursoAgregarPageState extends State<CursoAgregarPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController cursoCtrl = TextEditingController();
  TextEditingController cantidadCtrl = TextEditingController();
  
  String errCodigo = '';
  String errCurso = '';
  String errCant = '';
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos'),
        backgroundColor: Color.fromARGB(255, 104, 156, 0),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextFormField(
                controller: codigoCtrl,
                decoration: InputDecoration(labelText: 'Codigo',icon: Icon(MdiIcons.codeBraces)),
              ),
              Container(
                width: double.infinity,
                child: Text(errCodigo,style: TextStyle(color: Colors.red),),
              ),
              TextFormField(
                controller: cursoCtrl,
                decoration: InputDecoration(labelText: 'Nombre del Curso', icon: Icon(MdiIcons.codeBraces)),
              ),
              Container(
                width: double.infinity,
                child: Text(errCurso,style: TextStyle(color: Colors.red),),
              ),
              TextFormField(
                controller: cantidadCtrl,
                decoration: InputDecoration(labelText: 'Cantidad de personas maximas por curso', icon: Icon(MdiIcons.numeric0BoxMultiple)),
                keyboardType: TextInputType.number,
              ),
              Container(
                width: double.infinity,
                child: Text(errCant,style: TextStyle(color: Colors.red),),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Agregar Curso'),
                  onPressed: () async{
                    int cantidad = int.tryParse(cantidadCtrl.text) ?? 0;
                    var respuesta = await CursoProvider().cursoAgregar(
                      codigoCtrl.text.trim(),
                      cursoCtrl.text.trim(),
                      cantidad
                    );
                    if (respuesta['message'] != null){
                      if (respuesta['errors']['cod_curso'] != null){
                        errCodigo = respuesta['errors']['cod_curso'][0];
                      }else{
                        errCodigo = '';
                      }
                    }
                    if (respuesta['message'] != null){
                      if (respuesta['errors']['curso'] != null){
                        errCurso = respuesta['errors']['curso'][0];
                      }else{
                        errCurso = '';
                      }
                    }
                    if (respuesta['message'] != null){
                      if (respuesta['errors']['cantidad'] != null){
                        errCant = respuesta['errors']['cantidad'][0];
                      }else{
                        errCant = '';
                      }
                    setState(() {});
                    return;
                    }
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 71, 106, 0),
                  ) ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}