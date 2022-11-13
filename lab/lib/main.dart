import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class TextFields extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType? type;

  TextFields({required this.controller, required this.name, required this.validator,this.maxLines,this.type});
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(borderRadius: BorderRadius.circular(40.0),borderSide: BorderSide.none);
    return  Padding(
      padding: EdgeInsets.all(20.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: type,
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.grey[300],
          filled: true,
          labelText: name,
          focusedErrorBorder: border,
          focusedBorder: border,
          enabledBorder: border,
          errorBorder: border,
        ),
        // The validator receives the text that the user has entered.
        validator: validator,
      ),
    );
  }
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  int _selectedIndex = 0;
  static TextEditingController emailController = TextEditingController();
  static TextEditingController subjectController = TextEditingController();
  static TextEditingController messageController = TextEditingController();
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(
            'http://qrcoder.ru/code/?https%3A%2F%2Fgithub.com%2FDanielaObushcharova&4&0',
          ),
              const Text("Github link"),
            ],
          ),
    Card (
      margin: EdgeInsets.all(10),
      color: Colors.cyan[100],
      shadowColor: Colors.blueGrey,
      elevation: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.network(
              'https://t4.ftcdn.net/jpg/03/43/44/63/360_F_343446326_SPDMtXeMfocw1bFCtoZEKVGg9bDt9GsS.jpg',
            ),
            title: Column(
              children: const <Widget>[
                Text(
                "89197249211",
                style: TextStyle(fontSize: 20),
              ),
                Text(
                  "daniobu15@gmail.com",
                  style: TextStyle(fontSize: 20),
                ),
              ],
      ),
          ),
        ],
      ),
    ),
    Form(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFields(
                  controller: subjectController,
                  name: "Subject",
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  })),
              TextFields(
                  controller: emailController,
                  name: "Email address",
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  })),
              TextFields(
                  controller: messageController,
                  name: "Message",
                  validator: ((value) {
                    if (value!.isEmpty) {

                      return 'Message is required';
                    }
                    return null;
                  }),
                  maxLines: null,
                  type: TextInputType.multiline),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: (() async {
                      final Email email = Email(
                        body: messageController.text,
                        subject: subjectController.text,
                        recipients: [emailController.text],
                        isHTML: false,
                      );
                      await FlutterEmailSender.send(email);
                    })
                    ,
                    child: Text('Submit'),
                  )),
       ]) ,
      ),
    )];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 2'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Github',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Email',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

