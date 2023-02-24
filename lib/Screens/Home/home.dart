import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_auth/Screens/Login/components/api_provider.dart';
import 'package:flutter_auth/Screens/Login/components/login_form.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final Object obj;
  HomeScreen({Key? key, required this.obj}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController dialogUsername = TextEditingController();
  TextEditingController dialogPassword = TextEditingController();
  TextEditingController dialogFullname = TextEditingController();
  TextEditingController dialogEmail = TextEditingController();

  ApiProvider apiProvider = ApiProvider();

  var datalist = [];

  Future createUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    var username = dialogUsername.text;
    var password = dialogPassword.text;
    var fullname = dialogFullname.text;
    var email = dialogEmail.text;
    var rs = await apiProvider.createUser(
        token: token,
        username: username,
        password: password,
        fullname: fullname,
        email: email);
    // var jsonRes = json.decode(rs.body);
    if (!mounted) return;
    Navigator.pop(context);
    getUsers();
    log(username);
    log(password);
    log(fullname);
    log(email);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  Future getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? "";
    var rs = await apiProvider.getUser(token);
    var jsonRes = json.decode(rs.body);
    var uerList = List.from(jsonRes["rows"] as List);
    setState(() {
      datalist = uerList.reversed.toList();
    });
    log(uerList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "P SHOP",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Color.fromARGB(255, 253, 251, 253),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_add,
              color: Colors.black,
            ),
            tooltip: 'Setting Icon',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                        'เพิ่ม User'), // To display the title it is optional
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: dialogUsername,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: ' username',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: dialogPassword,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'password',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: dialogFullname,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'fullname',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: dialogEmail,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'email',
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        // FlatButton widget is used to make a text to work like a butto
                        onPressed:
                            () {}, // function used to perform after pressing the button
                        child: Text('ยกเลิก'),
                      ),
                      TextButton(
                        onPressed: () => createUser(),
                        child: Text('ตกลง'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('token');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      body: Container(
          child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            height: 230,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Image.asset('assets/images/m8.png'),
                color: Color.fromARGB(255, 236, 210, 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            height: 230,
            child: Card(
              child: Image.asset('assets/images/g6.png'),
              color: Color.fromARGB(255, 72, 225, 177),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            height: 230,
            child: Card(
              child: Image.asset('assets/images/k6.png'),
              color: Color.fromARGB(255, 235, 158, 242),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            height: 230,
            child: Card(
              child: Image.asset('assets/images/g2.png'),
              color: Color.fromARGB(255, 92, 110, 241),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            height: 230,
            child: Card(
              child: Image.asset('assets/images/k2.png'),
              color: Color.fromARGB(255, 241, 71, 148),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            height: 230,
            child: Card(
              child: Image.asset('assets/images/m10.png'),
              color: Color.fromARGB(255, 106, 233, 91),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            height: 230,
            child: Card(
              child: Image.asset('assets/images/g7.png'),
              color: Color.fromARGB(255, 16, 191, 226),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            height: 230,
            child: Card(
              child: Image.asset('assets/images/k1.png'),
              color: Color.fromARGB(255, 254, 216, 26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            height: 230,
            child: Card(
              child: Image.asset('assets/images/k4.png'),
              color: Color.fromARGB(255, 38, 181, 206),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            height: 230,
            child: Card(
              child: Image.asset('assets/images/m6.png'),
              color: Color.fromARGB(255, 240, 111, 189),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 0, top: 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            height: 230,
            child: Card(
              child: Image.asset('assets/images/m1.png'),
              color: Color.fromARGB(255, 241, 163, 28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
