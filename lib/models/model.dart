import 'dart:convert';

class TodoModel {
    String id;
    String name;
    //int age;
    // String colour;

    TodoModel({
        required this.id,
        required this.name,
       // required this.age,
        // required this.colour,
    });

    factory TodoModel.fromRawJson(String str) => TodoModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["_id"],
        name: json["name"],
        //age: json["age"],
        // colour: json["colour"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        //"age": age,
        // "colour": colour,
    };
}
