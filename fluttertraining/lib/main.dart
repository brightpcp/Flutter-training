import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'UserData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late UserData _dataFromAPI;
  var dataFromTotal;
  @override
  void initState() {
    super.initState();
    getUserData();
    var total = getUserData();
    getUserData().then((value) => dataFromTotal = value.hydraTotalItems);
  }

  Future<UserData> getUserData() async {
    var url = Uri.parse("http://192.168.1.101:8000/api/users");
    var response = await http.get(url);
    _dataFromAPI = userDataFromJson(response.body); //json => dart
    return _dataFromAPI;
  }

  int count = 0;
  int num = 0;

  void next() {
    setState(() {
      if (count < dataFromTotal-1) {
        count++;
      }
    });
    print(count);
  }

  void previous() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("User API"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            future: getUserData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var result = snapshot.data;
                return Text(result.hydraMember[count].username,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ));
              }
              return LinearProgressIndicator();
            },
          ),
          Expanded(child: Container()),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    previous();
                  },
                  child: Icon(Icons.arrow_back),
                ),
                FloatingActionButton(
                    onPressed: () {
                      next();
                    },
                    child: Icon(Icons.arrow_forward))
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
