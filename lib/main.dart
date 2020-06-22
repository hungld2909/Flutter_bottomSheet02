import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: new ThemeData(primarySwatch: Colors.orange),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldkey =
      new GlobalKey<ScaffoldState>(); //! khởi tạo key cho scaffold
  VoidCallback
      _showPersBottomSheetCallBack; //! voidcallBack được hiểu như là bắt sự kiện cho onPress

  @override
  void initState() {
    super.initState();
    _showPersBottomSheetCallBack = _showBottomSheet; //! một biến gắn với 1 hàm
  }

  void _showBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack =
          null; //! ban đầu gán biến đó bằng với giá trị null
    });

    _scaffoldkey.currentState
        .showBottomSheet((context) {
          //! sau đó dùng key của Scaffold để bắt sự kiện tạo Container.
          return new Container(
            //! giao diện sẽ được tạo mới với chiều cao là 300 và có màu xanh, nội dung Text sẽ hiện thị " Hi ButtomSheet"
            height: 300.0,
            color: Colors.greenAccent,
            child: Center(
              child: Text("Hi BottomSheet"),
            ),
          );
        })
        .closed
        //! sau khi hoàn thành thì có thể đóng hoặc kéo lên kéo xuống.
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showPersBottomSheetCallBack = _showBottomSheet;
              //! lúc đó trạng thái sẽ được thay đổi và giữ nguyên ở 1 ví trí nào đó người dùng muốn.
            });
          }
        });
  }

  void _showModalSheet() {
    //! đối với _showModalSheet sẽ được hiện thị cố định 
    showModalBottomSheet(
        context: context,
        builder: (build) { //! tạo ra 1 container mới và giao diện sẽ được hiện thị 1 cách cố định
        //! không được mềm dẻo như _showBottomSheet
          return new Container(
            color: Colors.redAccent,
            child: Center(
              child: Text("Hi ModelSheet"),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Flutter BottomSheet"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                onPressed:
                    _showPersBottomSheetCallBack, //! khi click vào sẽ được gọi hàm _showPersBottomSheetCallBack
                child: Text("Persistent"),
              ),
              new Padding(padding: EdgeInsets.only(top: 10)),
              new RaisedButton(
                onPressed:
                    _showModalSheet, //! khi click vào sẽ được gọi hàm _showModalSheet
                child: Text("Model"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
