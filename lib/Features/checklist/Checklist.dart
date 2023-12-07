import 'package:eventify/common/widgets/custombutton.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/checklist/checklistServices.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChecklistScreen extends StatefulWidget {
  static const id = "/Checklist";
  @override
  State<ChecklistScreen> createState() => _DashboardState();
}

class _DashboardState extends State<ChecklistScreen> {
  final TextEditingController _todoTitle = TextEditingController();
  final TextEditingController _todoDesc = TextEditingController();
  List items = [];
  final TodoServices todoservice = TodoServices();
  @override
  void initState() {
    super.initState();

    fetchTodoList();
  }

  void fetchTodoList() async {
    try {
      List<Map<String, dynamic>> fetchedItems =
          await TodoServices().fetchTodoList(context);
      setState(() {
        items = fetchedItems;
      });
    } catch (e) {
      print('Error fetching todo list: $e');
    }
  }

  void addTodo() async {
    todoservice.todolist(
        context: context, title: _todoTitle.text, desc: _todoDesc.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: COLOR_PRIMARY,
        centerTitle: true,
        title: Text(
          'My Checklist',
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: COLOR_PRIMARY,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: items.isEmpty
                    ? Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            LoadingAnimationWidget.bouncingBall(
                              color: COLOR_ACCENT,
                              size: 50,
                            ),
                            Icon(
                              Icons.checklist,
                              color: COLOR_ACCENT,
                              size: 50,
                            ),
                            Center(
                              child: Text(
                                "Checklist is empty",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, int index) {
                          return Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(onDismissed: () {}),
                              children: [
                                SlidableAction(
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  onPressed: (BuildContext context) {},
                                ),
                              ],
                            ),
                            child: Card(
                              borderOnForeground: false,
                              child: ListTile(
                                leading: Checkbox(
                                  activeColor: COLOR_ACCENT,
                                  value: items[index]['checked'] ?? false,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      items[index]['checked'] = value;
                                    });
                                  },
                                ),
                                title: Text('${items[index]['title']}'),
                                subtitle: Text('${items[index]['desc']}'),
                                trailing: const Icon(Icons.arrow_back),
                              ),
                            ),
                          );
                        }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: COLOR_ACCENT,
        onPressed: () => _displayTextInputDialog(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: 'Add-ToDo',
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(child: const Text('Add To-Do')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _todoTitle,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ).p4().px8(),
                TextField(
                  controller: _todoDesc,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ).p4().px8(),
                CustomButton(
                  onTap: () {
                    addTodo();
                  },
                  text: 'Add',
                ),
              ],
            ),
          );
        });
  }
}
