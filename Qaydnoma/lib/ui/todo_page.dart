import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/model/model_todo.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/model_todo.dart';

class TodoPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TodoPage> {
  final TodoBloc todoBloc = TodoBloc();
  TextEditingController _controller = TextEditingController();
  int valueColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Qaydnoma",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'ExtraBold',
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: new Color(0xFFF2C94C),
        toolbarHeight: 60,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<Todo>>(
              stream: todoBloc.todo,
              builder: (context, snapshot) => _todoCard(context, snapshot),
            ),
          ),
          Container(
            height: 60,
            child: Row(
              children: <Widget>[
                _circleWidget(0xFF219653),
                _circleWidget(0xFFEB5757),
                _circleWidget(0xFFF2C94C),
                _circleWidget(0xFF2F80ED),
                _circleWidget(0xFFF2994A),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(fontFamily: 'SemiBold', fontSize: 18),
              cursorColor: Colors.black,
              controller: _controller,
              decoration: InputDecoration(
                suffixIcon: Card(
                  elevation: 0,
                  margin: EdgeInsets.all(0),
                  color: Color(0xff333333),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: IconButton(
                      iconSize: 36,
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        if (valueColor != 0 &&
                            _controller.text.trim().isNotEmpty) {
                          Todo todo = Todo(
                            description: _controller.text.trim(),
                            valueColor: valueColor,
                          );
                          todoBloc.addTodo(todo);
                          _controller.clear();
                          valueColor = 0;
                        } else {
                          Fluttertoast.showToast(
                            msg: "Rangni tanlang!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleWidget(int value) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          valueColor = value;
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(value),
          ),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        ),
      ),
    );
  }

  Widget _todoCard(BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, int index) {
          return listItem(context, snapshot.data![index]);
        },
      );
    } else {
      return SizedBox();
    }
  }

  Widget listItem(BuildContext context, Todo todo) {
    return Card(
      elevation: 0,
      color: Color(0xffEEEEEE),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Center(
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: Color(todo.valueColor!),
                  child: Container(
                    width: 20,
                    height: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  todo.description!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SemiBold',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Card(
                elevation: 0,
                margin: EdgeInsets.all(0),
                color: Color(0xff9E219653),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(0),
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(0),
                  ),
                ),
                child: InkWell(
                  onTap: () => todoBloc.deleteTodoById(todo.id!),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      "assets/images/Vector.svg",
                      height: 20.0,
                    ),
                    margin: EdgeInsets.all(0),
                    height: 60,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    todoBloc.dispose();
    super.dispose();
  }
}
