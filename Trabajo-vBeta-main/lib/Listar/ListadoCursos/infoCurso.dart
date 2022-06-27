import 'package:flutter/material.dart';
import 'package:trabajo/providers/educadoras_provider.dart';
import 'package:trabajo/providers/Alumnos_provider.dart';

class infcurso extends StatefulWidget {
  String cursoSelected = "";
  infcurso(this.cursoSelected, {Key? key}) : super(key: key);

  @override
  State<infcurso> createState() => _infcursoState();
}

class _infcursoState extends State<infcurso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacion del curso'),
      ),
      body: Padding(
        padding: EdgeInsets.all(2),
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.center,
        //traer los profes y niños del nivel seleccionado, filtrar segun curso
        child: Column(
          children: [
            Container(
                child: Center(
              child: Text('Educadoras del curso: ${widget.cursoSelected}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            )),
            Expanded(
              child: FutureBuilder(
                future: EducadorasProvider().getEducadoras(),
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      var prod = snap.data[index];
                      if (prod['cod_curso'] != widget.cursoSelected) {
                        return SizedBox(width: 0, height: 0);
                      } else {
                        return ListTile(
                          leading: Icon(Icons.person),
                          title: Text(prod['nombre']),
                          //trailing: Text(prod['cod_curso']),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            Divider(color: Colors.black,),
            Container(
              child: Text('Alumnos del curso: ${widget.cursoSelected}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: FutureBuilder(
                future: AlumnosProvider().getAlumnos(),
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      var prod = snap.data[index];
                      if (prod['nom_curso'] != widget.cursoSelected) {
                        //print('se encontraron otros cursos en la lista, removiendo...');
                        return SizedBox(width: 0, height: 0);
                      } else {
                        return ListTile(
                          leading: Icon(Icons.child_care_rounded),
                          title: Text(prod['nom_alumno']),
                          //trailing: Text(prod['cod_curso']),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
