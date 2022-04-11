//import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const GeoQuest());
}

Color clouds = HexColor("#ecf0f1");
Color was = HexColor("#34495e");

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF" + hex.toUpperCase().replaceAll("#", "");
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);
int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

class Buttons {
  static Widget PrimaryButton(String text, onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: was,
        onPrimary: was,
        minimumSize: const Size(100, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: clouds),
      ),
    );
  }

  static Widget SecondaryButton(String text, onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: clouds,
        onPrimary: clouds,
        side: BorderSide(color: was, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        minimumSize: const Size(100, 50),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: was),
      ),
    );
  }

  static Widget OptionButton(onPressed) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.settings),
      foregroundColor: clouds,
      backgroundColor: was,
    );
  }
}

class Fields {
  static Widget CustomTextFormField(label, hint, icon, error) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          decoration: InputDecoration(
              filled: true,
              fillColor: clouds,
              suffixIcon: Icon(icon),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: was,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: was,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: label,
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelStyle: TextStyle(
                color: was,
                fontStyle: FontStyle.italic,
              ),
              hintText: hint),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return error;
            }
            return null;
          },
        ));
  }
}

class GeoQuest extends StatelessWidget {
  const GeoQuest({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color nephertis = HexColor('#27ae60');
    return MaterialApp(
      title: 'GeoQuest',
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
        primarySwatch: generateMaterialColor(nephertis),
      ),
      home: const SignInPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Color nephertis = HexColor('#27ae60');

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          // Note: Sensitivity is integer used when you don't want to mess up vertical drag
          if (details.delta.dx > 0) {
            Navigator.pop(context, true);
          }
        },
        child: const Home(),
      ),
      backgroundColor: nephertis,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    String value = 1234567.toString();
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'SCORE :' + value,
          style: TextStyle(fontFamily: 'Chalk', fontSize: 15, color: clouds),
        ),
        Image.asset('assets/images/logo_s.png'),
      ]),
      Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/title.png'),
          Text(
            'USERNAME',
            style: TextStyle(
              fontFamily: 'Chalk',
              fontSize: 30,
              color: clouds,
              shadows: <Shadow>[
                Shadow(
                  offset: const Offset(5.0, 5.0),
                  blurRadius: 3.0,
                  color: was,
                ),
              ],
            ),
          ),
          Buttons.PrimaryButton("New Game", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          }),
          Buttons.SecondaryButton("Continue", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          }),
          Buttons.SecondaryButton("Leaderboard", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          })
        ],
      )),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Buttons.OptionButton(() {
              //Navigator.pop(context, true);
            }),
          )
        ],
      )
    ]);
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    Color nephertis = HexColor('#27ae60');
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          // Note: Sensitivity is integer used when you don't want to mess up vertical drag
          if (details.delta.dx > 0) {
            Navigator.pop(context, true);
          }
        },
        child: const SignUp(),
      ),
      backgroundColor: nephertis,
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  SignUpState createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Color clouds = HexColor("#ecf0f1");
    Color was = HexColor("#34495e");

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset('assets/images/logo.png'),
                Fields.CustomTextFormField('Email*', 'Entrez votre Email',
                    Icons.mail, 'Email nécessaire'),
                Fields.CustomTextFormField(
                    'Username*',
                    "Entrez votre nom d'utilisateur",
                    Icons.person,
                    "Nom d'utilisateur nécessaire"),
                Fields.CustomTextFormField(
                    'Password*',
                    'Entrez votre mot de passe',
                    Icons.key,
                    'Mot de passe nécessaire'),
                Fields.CustomTextFormField(
                    'Password*',
                    'Réentrez votre mot de passe',
                    Icons.key,
                    'Mot de passe nécessaire'),
                Buttons.PrimaryButton('Valider', () {
                  if (_formKey.currentState!.validate()) {
                    //save the datas
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('processing datas')),
                    );
                  }
                }),
              ],
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Buttons.OptionButton(() {
                //Navigator.pop(context, true);
              }),
            )
          ],
        )
      ],
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    Color nephertis = HexColor('#27ae60');
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: const SignIn(),
      backgroundColor: nephertis,
    );
  }
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  SignInState createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Color clouds = HexColor("#ecf0f1");
    Color was = HexColor("#34495e");

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset('assets/images/logo.png'),
              Fields.CustomTextFormField(
                  'Username*',
                  "Entrez votre nom d'utilisateur",
                  Icons.person,
                  "Nom d'utilisateur nécessaire"),
              Fields.CustomTextFormField(
                  'Password*',
                  "Entrez votre mot de passe",
                  Icons.key,
                  "Mot de passe nécessaire"),
              Buttons.PrimaryButton('Valider', () {
                if (_formKey.currentState!.validate()) {
                  //save the datas
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
              }),
              Buttons.SecondaryButton('Sign up', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              })
            ],
          ),
        )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Buttons.OptionButton(() {
                //Navigator.pop(context, true);
              }),
            )
          ],
        )
      ],
    );
  }
}
