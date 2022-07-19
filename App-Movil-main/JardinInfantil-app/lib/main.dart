import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trabajo/Gestion/Curso/Curso_page.dart';
import 'package:trabajo/Gestion/MenuG.dart';
import 'package:trabajo/Listar/MenuL.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
   }
}


class Jardin extends StatefulWidget {
  const Jardin({Key? key}) : super(key: key);

  @override
  State<Jardin> createState() => _JardinState();
}

class _JardinState extends State<Jardin> {
  int _paginaactual = 0;
  
  List<Widget> _paginas = [
    
    MenuG(),

    MenuL()
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
        title: Text('Jardin "Los cachorros"'),
        backgroundColor: Color.fromARGB(255, 255, 132, 24),
      ),
      body: _paginas[_paginaactual],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 187, 89, 3),
     
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        iconSize: 30,
        selectedFontSize: 20,
        showUnselectedLabels: false,
        onTap: (valor){
          setState(() {
            _paginaactual = valor;
          });
        },
        currentIndex: _paginaactual,  
        items: [
          BottomNavigationBarItem(icon: Icon(MdiIcons.pencilPlus), label: 'Gestion'),
          BottomNavigationBarItem(icon: Icon(MdiIcons.clipboardList) , label: 'Listado')
        ],
      ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //iniciar
  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {






  //login
  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if (e.code == "user-not-found"){
        print('No User found for that email');
      }
    }
    return user;
  }



  @override
  Widget build(BuildContext context) {

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My app', style:TextStyle(color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold)),
          const Text('Login a la app',
           style: TextStyle(
            color: Colors.black,
            fontSize: 44.0,
            fontWeight: FontWeight.bold
           )
          ),
          const SizedBox(
            height: 44.0,
          ),
          TextField(

            //fluttertest@usm.comtest
            //123456

            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email Usuario",
              prefixIcon: Icon(Icons.mail, color: Colors.black)
            ),
          ),
          const SizedBox(
            height: 26.0,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "Contraseña Usuario",
              prefixIcon: Icon(Icons.lock, color: Colors.black)
            )
          ),
          const SizedBox(
            height: 8.0,
          ),
          const Text("¿No recuerda su contraseña?", 
            style: TextStyle(color: Colors.blue),
          ),
          const SizedBox(
            height: 88.0,
          ),

          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: const Color(0xFF0069FE),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              onPressed: () async{
                User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                print(user);
                if (user != null){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Jardin()));
                }
              }, 
              child: const Text("Login", 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0
                ),
              ),
            ),
          ),
        ],
      ),
       
    );
  }
}