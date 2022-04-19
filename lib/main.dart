import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_shared/home_page.dart';
import 'models/boxes.dart';
import 'models/todo.dart';

void main() async{
  Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>(HiveBoxex.todo);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(),
    );
  }
}
class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}
class _MyLoginPageState extends State<MyLoginPage> {
// Create a text controller and use it to retrieve the current value
// of the TextField.
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
  @override
  void dispose() {
// Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        automaticallyImplyLeading: false,
    ),
    body: Center(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        "Login Form",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextField(
          controller: username_controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'username',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextField(
          obscureText : true,
          controller: password_controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
        ),
      ),
      RaisedButton(
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: () {
          String username = username_controller.text;
          String password = password_controller.text;
          if (username != '' && password != '') {
            print('Successfull');
            logindata.setBool('login', false);
            logindata.setString('username', username);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          }
          },
        child: Text("Log-In"),
      )
    ],
    ),
    ),
    );
  }
}