import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home_page.dart';
import 'models/boxes.dart';
import 'models/todo.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keranjang Belanja"),
        automaticallyImplyLeading: false,
      ),
      body: ValueListenableBuilder(
          valueListenable:
          Hive.box<Todo>(HiveBoxex.todo).listenable(),
          builder: (context, Box<Todo> box, _) {
            if (box.values.isEmpty) {
              return Center(
                child: Text('Keranjang Belanja Kosong!!'),
              );
            }
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                Todo? res = box.getAt(index);
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                  ),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    res!.delete();
                  },
                  // child: ListTile(
                  //   title: Text(res!.name),
                  //   subtitle: Text(res!.jenis),
                  child: Card(
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
                                          res!.imageLogo,
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
                                            res!.name,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                            res!.jenis,
                                            style: TextStyle(
                                              fontSize: 18,
                                            )
                                        ),
                                      ],
                                    )
                                ),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                );
              },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Home Page',
        child: Icon( Icons.arrow_left, ),
        onPressed: ()=>{
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage()))
        },
      ),
    );
  }
}
