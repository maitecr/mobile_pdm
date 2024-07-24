// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    initialRoute: '/',
    routes: {
      '/': (context) => MyHomePage(),
      '/login': (context) => LoginScreen(),
 //     '/data': (context) = DataScreen(email: email, senha: senha),
      '/change': (context) => ChangePasswordScreen()
    }
    );
  }
}

class MyHomePage extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PMD I - 2024/01'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[ 
              DrawerHeader(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/museu.jpg'),
                  ),
                  title: Text('Maitê'),
                  subtitle: Text('email@email.com'),
                ),
              ),

              ListTile(
                title: Text('Login'),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),

              ListTile(
                title: Text('Trocar senha'),
                onTap: () {
                  Navigator.pushNamed(context, '/change');
                },
              )
            ]
          ),

      ),
      body: Center(
        child: Image.asset(
          'assets/jiji.jpg',
          fit: BoxFit.cover,
        ),
      ),
      );
  }
}

class LoginScreen extends StatelessWidget {

//  const LoginScreen({super.key});
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
//  String? email;
//  String? senha;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form (
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: emailController,
//                onChanged: (novoValor) => email = novoValor,
                decoration: InputDecoration(
                  hintText: 'Informe seu e-mail'
                ),
              ),
              TextFormField(
                controller: senhaController,
//                onChanged: (novoValor) => senha = novoValor,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Informe sua senha'
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text('Logar'),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => DataScreen(email: emailController.text, senha: senhaController.text))));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ) ,
    );
  }
}

class DataScreen extends StatelessWidget {
  const DataScreen({required this.email, required this.senha});

  final String email;
  final String senha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-mail e senha'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(email),
            Text(senha)
          ],
        ),
      ),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {

  final novaSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mudar senha'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Form (
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Informe senha atual'
                )
              ),
              TextFormField(
                controller: novaSenhaController,
                decoration: InputDecoration(
                  hintText: 'Informe nova senha'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}