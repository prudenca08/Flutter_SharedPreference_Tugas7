import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_dummy.dart';
import 'main.dart';
import 'models/boxes.dart';
import 'models/todo.dart';
import 'shoppingcart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: appList.length,
        itemBuilder: (context,index){
          return _createCard(context,index);
          },
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              tooltip: 'Lihat Keranjang',
              child: Icon( Icons.add_shopping_cart_outlined, ),
              onPressed: ()=>{
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShoppingCart()))
              },
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              tooltip: 'Log Out',
              child: Icon( Icons.logout, ),
              onPressed: ()=>{
                logindata.setBool('login', true),
                Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => MyLoginPage()))
              },
            )
          ]
      )
    );

  }

  Widget _createCard(context, index) {
    final AppStore data= appList[index];
      return Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(7.0),
                            child: Image.network(
                              data.imageLogo,
                              width: 250,
                              height: 250,
                            ),
                          ),
                        ],
                      )
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                data.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                            SizedBox(height: 20),
                            Text(
                                data.jenis,
                                style: TextStyle(
                                  fontSize: 18,
                                )
                            ),
                            SizedBox(height: 20),
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.green,
                              onPressed: () {
                                Box<Todo> todoBox = Hive.box<Todo>(HiveBoxex.todo);
                                todoBox.add(Todo(name: data.name, jenis: data.jenis, imageLogo: data.imageLogo));
                                print(todoBox);
                              },
                              child: Text("Tambah Daftar Keranjang"),
                            ),
                          ],
                        )
                    ),
                  )
                ],
              )
            ],
          )
      );
  }
}
