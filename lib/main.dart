// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SharedDataContainer(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/login': (context) => LoginScreen(),
          '/change': (context) => ChangePasswordScreen(),
        },
      ),
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
                  subtitle: Text('maiterefosco.gr004@academico.ifsul.edu.br'),
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

class SharedDataContainer extends StatefulWidget {
  final Widget child;

  const SharedDataContainer({Key? key, required this.child}) : super(key: key);

  @override
  _SharedDataContainerState createState() => _SharedDataContainerState();

  static _SharedDataContainerState? of(BuildContext context) {
    return context.findAncestorStateOfType<_SharedDataContainerState>();
  }
}

class _SharedDataContainerState extends State<SharedDataContainer> {
  String? email;
  String? senha;

  void updateData(String newEmail, String newSenha) {
    setState(() {
      email = newEmail;
      senha = newSenha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SharedData(
      email: email,
      senha: senha,
      child: widget.child,
    );
  }
}

class SharedData extends InheritedWidget {
  final String? email;
  final String? senha;

  const SharedData({
    Key? key,
    required Widget child,
    this.email,
    this.senha,
  }) : super(key: key, child: child);

  static SharedData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharedData>();
  }

  @override
  bool updateShouldNotify(covariant SharedData oldWidget) {
    return oldWidget.email != email || oldWidget.senha != senha;
  }
}

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//  const LoginScreen({super.key});
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form (
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person
                  ),
                  hintText: 'Informe seu e-mail'
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser deixado em branco';
                  }
                },
              ),
              TextFormField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.password
                  ),
                  hintText: 'Informe sua senha'
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser deixado em branco';
                  }

                  if (value.length < 6 || value.length > 12) {
                    return 'Senha deve conter entre 6 e 12 caracteres';
                  }

                  if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#$&*])').hasMatch(value)) {
                    return ' Senha deve ter uma letra maiúscula,\numa letra minúscula e um caractere especial';
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text('Logar'),
                    onPressed: () {

                      if (_formKey.currentState!.validate()) {
                        SharedDataContainer.of(context)?.updateData(emailController.text, senhaController.text,);

                        Navigator.push(context, MaterialPageRoute(builder: (context) => DataScreen()));
                      }
                       
                      //builder: ((context) => DataScreen(email: emailController.text, senha: senhaController.text))));
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
  //const DataScreen({required this.email, required this.senha});
  //final String email;
  //final String senha;
  
  @override
  Widget build(BuildContext context) {

    final sharedData = SharedData.of(context);
  //  print('email');
  //  print(sharedData?.email);
  //  print('senha');
  //  print(sharedData?.senha);

    return Scaffold(
      appBar: AppBar(
        title: Text('E-mail e senha'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: Text(sharedData?.email ?? 'E-mail não disponível')
            ),
            ListTile(
              leading: Icon(
                Icons.vpn_key
              ),
              title: Text(sharedData?.senha ?? 'Senha não disponível'))
          ],
        ),
      ),
    );
  }
}

class ChangePasswordScreen extends StatefulWidget {

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final novaSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final sharedData = SharedData.of(context);
    print(sharedData?.senha);

    return Scaffold(
      appBar: AppBar(
        title: Text('Mudar senha'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Form (
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.password
                  ),
                  hintText: 'Informe senha atual'
                ),
                validator: (String? value) {
                  if(value != sharedData?.senha) {
                    print(value);
                    print(sharedData?.senha);
                    return 'Senha incompatível';
                  }
                },
              ),

              TextFormField(
                controller: novaSenhaController,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.vpn_key
                  ),
                  hintText: 'Informe nova senha'
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo não pode ser deixado em branco';
                  }

                  if (value.length < 6 || value.length > 12) {
                    return 'Senha deve conter entre 6 e 12 caracteres';
                  }

                  if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#$&*])').hasMatch(value)) {
                    return ' Senha deve ter uma letra maiúscula,\numa letra minúscula e um caractere especial';
                  }
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.vpn_key
                  ),
                  hintText: 'Confirmar senha'
                ),
                validator: (String? value) {
                  if (value != novaSenhaController.text) {
                    return 'Confirmação de senha incompatível';
                  }
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text('Alterar'),
                    onPressed: () {
                       if (_formKey.currentState!.validate()) {
                          SharedDataContainer.of(context)?.updateData(
                            SharedDataContainer.of(context)?.email ?? '',
                            novaSenhaController.text,
                          );
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DataScreen()));
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}