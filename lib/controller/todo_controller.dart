import "dart:convert";

import "package:get/get.dart";
import 'package:http/http.dart' as http;
import "../models/model.dart";

class TodoController extends GetxController {
  var TodoList = RxList<TodoModel>();

  @override
  // void onInit() {
  //   super.onInit();
  //   getTodos();
  // }
  RxBool isLoading = false.obs;

  Future<RxList<TodoModel>> getTodos() async {
    isLoading.value = true;
    final response = await http.get(Uri.parse(
        "https://crudcrud.com/api/cd2d4ab7286e4921826e18736a0aaf09/unicorns"));

    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        TodoList.add(TodoModel.fromJson(index));
      }
      print(TodoList);
      isLoading.value = false;

      return TodoList;
    } else {
      print("error");

      return TodoList;
    }
  }

  Future<void> postTodos(title) async {
    isLoading.value = true;

    final response = await http.post(
        Uri.parse(
            "https://crudcrud.com/api/cd2d4ab7286e4921826e18736a0aaf09/unicorns"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"name": title}));

    if (response.statusCode == 201) {
      print("done");
      TodoList.clear();
      isLoading.value = false;

      getTodos();
    } else {
      print("failed");
    }
  }

//delete

  Future<void> deleteTodos(id) async {
    isLoading.value = true;

    final response = await http.delete(
      Uri.parse(
          "https://crudcrud.com/api/cd2d4ab7286e4921826e18736a0aaf09/unicorns/$id"),
    );

    if (response.statusCode == 200) {
      print("done");
      TodoList.clear();
      isLoading.value = false;

      getTodos();
    } else {
      print("failed");
    }
  }

  //update
    Future<void> updateTodos(id,value) async {
    isLoading.value = true;

    final response = await http.put(
      Uri.parse(
          "https://crudcrud.com/api/cd2d4ab7286e4921826e18736a0aaf09/unicorns/$id"),
            headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': value, // Update with the data you want to send
      })
    );

    if (response.statusCode == 200) {
      print("done");
      TodoList.clear();
      isLoading.value = false;

      getTodos();
    } else {
      print("failed");
    }
  }
}
