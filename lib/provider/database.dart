import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:memotiapp/provider/appaccess.dart';
class MemotiDbProvider{
  MemotiDbProvider._();
  static final MemotiDbProvider db = MemotiDbProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }


  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "DB13.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Images ("
          "product_category STRING,"
          "product_name STRING,"
          "product_id INTEGER,"
          "dimesion STRING,"
          "product_type STRING,"
          "images STRING,"
          "lasteditdate DateTime"
          ")");
      await db.execute("CREATE TABLE Creations ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "categorytype TEXT,"
          "images TEXT,"
          "base64 TEXT,"
          "productItem TEXT,"
          "max_photo TEXT,"
          "min_photo TEXT,"
          "product_id TEXT,"
          "product_price TEXT,"
          "selectedSize TEXT,"
          "product_name TEXT,"
          "slovaktitle TEXT,"
          "lasteditdate TEXT"
          ")");

      await db.execute("CREATE TABLE cart ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "categorytype TEXT,"
          "images TEXT,"
          "base64 TEXT,"
          "productItem TEXT,"
          "max_photo TEXT,"
          "min_photo TEXT,"
          "product_id TEXT,"
          "product_price TEXT,"
          "selectedSize TEXT,"
          "product_name TEXT,"
          "slovaktitle TEXT,"
          "lasteditdate TEXT,"
          "pdfUrl TEXT,"
          "count TEXT,"
          "order_status TEXT"
          ")");

      await db.execute("CREATE TABLE Picture(id INTEGER PRIMARY KEY AUTOINCREMENT, picture BLOB )");
    });
  }

  Future savePicture(String image) async {
    var db = await database;
    var res =await db!.rawInsert("INSERT Into Picture (picture)"
    " VALUES (?)",[image]);
    print("image insert :- "+res.toString());
    return res;
  }

  Future insertCreation(String categorytype, String image, String items, String max_photo, String min_photo, String product_id, String product_price, String selectedSize, String product_name,String slovaktitle) async {
    String images = image;
    String productItem = items;
    String date = new DateTime.now().toString();
    print(date+images);
    // print(categorytype+min_photo+selectedSize);
    final db = await database;
    var res = await db!.rawInsert(
        "INSERT Into Creations (categorytype, images, productItem, max_photo, min_photo, product_id, product_price, selectedSize, product_name,slovaktitle, lasteditdate)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?)", [categorytype, images, productItem,max_photo,min_photo,product_id,product_price,selectedSize,product_name,slovaktitle, date]);
    print("insert creation "+res.toString());
    return res;
  }

  Future getTableCountForCart() async{
    print("iam");
    final db = await database;
    var x = await db!.rawQuery("SELECT COUNT (*) from cart");
    //var x = await db.query("cart", where: "order_status = ?", whereArgs: ["pending"]);
    int? count  = Sqflite.firstIntValue(x);
    // print("cart_count - "+count.toString());
    return count;
  }
  Future<List> getAllCart() async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query("cart", 
    columns:[
          "id",
          "categorytype",
          "base64",
          "productItem",
          "max_photo",
          "min_photo",
          "product_id",
          "product_price",
          "selectedSize",
          "product_name",
          "slovaktitle",
          "lasteditdate",
          "pdfUrl",
          "count",
          "order_status"
    ],
     where: "order_status = ?", whereArgs: ["pending"]);
    List list = maps.isNotEmpty ? maps.map((c) => c).toList() : [];
    return list;
 }
  Future<List> getsingleCart(id) async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query("cart", 
    columns:[
          "images",
    ],
     where: "id = ?", whereArgs: [id]);
    List list = maps.isNotEmpty ? maps.map((c) => c).toList() : [];
    return list;
 }

  Future<List> getAllCartItemwithId(int id) async{
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query("cart", where: "id = ?", whereArgs: [id]);
    List list = maps.isNotEmpty ? maps.map((c) =>c).toList() : [];
    return list;
  }
  updateCart(cartModel) async {
    print("cartModelid - "+cartModel["id"].toString());
    final db = await database;
    var response = await db!.update("cart", cartModel,
        where: "id = ?", whereArgs: [cartModel["id"]]);
    print("response update - "+response.toString());
    return response;
  }

  Future insertCart(String categorytype, String image, String base64, String items, String max_photo, String min_photo, String product_id, String product_price, String selectedSize, String product_name,String slovaktitle,String pdfUrl, String count,String order_status) async {
    String images = image;
    String productItem = items;
    String date = new DateTime.now().toString();
    // print(date+images);
    print("date+image");
    print(images);
    print(categorytype+min_photo+selectedSize);
    final db = await database;
    var res = await db!.rawInsert(
        "INSERT Into cart (categorytype, images, base64, productItem, max_photo, min_photo, product_id, product_price, selectedSize, product_name, slovaktitle, lasteditdate, pdfUrl, count,order_status)"
            " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [ categorytype, image, base64, productItem, max_photo,min_photo, product_id, product_price, selectedSize, product_name, slovaktitle, date,pdfUrl, count, order_status ]);
    print("insert cart "+res.toString());
    return res;
  }

  Future removecart(int id) async{
    final db = await database;
    var res =  await db!.delete("cart", where: "id = ?", whereArgs: [id]);
    print("remove cart "+res.toString());
    return res;
  }


  Future getpicture(int uintid) async {
    final db = await database;
    var res = await db!.query("Picture", where: "id = ?", whereArgs: [uintid]);
    print("get image "+res.toString());
    if(res.isNotEmpty){
      Map<String, dynamic> json = res.first;
      return json["picture"];
    }
    return null;
  }
  Future removepicture(int id) async{
    final db = await database;
    var res =  await db!.delete("Picture", where: "id = ?", whereArgs: [id]);
    print("remove image "+res.toString());
    return res;
  }
  Future removecreationItem(int id) async{
    final db = await database;
    var res =  await db!.delete("Creations", where: "id = ?", whereArgs: [id]);
    print("remove Creations "+res.toString());
    return res;
  }

  getTableCount() async{
    final db = await database;
    var x = await db!.rawQuery("SELECT COUNT (*) from Images");
    int? count  = Sqflite.firstIntValue(x);
    return count;
  }

  Future getTableCountForcreation() async{
    final db = await database;
    var x = await db!.rawQuery("SELECT COUNT (*) from Creations");
    int? count  = Sqflite.firstIntValue(x);
    print("creation_count - "+count.toString());
    return count;
  }



  getDBImage(int product_id) async {
    final db = await database;
    var res = await db!.query("Images", where: "product_id = ?", whereArgs: [product_id]);
    print("get data "+res.toString());
    return res.isNotEmpty ? ProductImageModel.fromMap(res.first) : null;
  }
  checkImage(int product_id) async{
    final db = await database;
    var res = await db!.query("Images", where: "product_id = ?", whereArgs: [product_id]);
    print("check data "+res.toString());
    return res.isNotEmpty ? true : false;
  }

   getAllImages() async {
    final db = await database;
    var response = await db!.query("Images");
    print("all_image1 - ");
    print("all_image2 - "+response.toString());
    print("all_image3 - ");
    return response.isNotEmpty? response.map((e) => ProductModel.fromMap(e)).toList():[];
    //return response.isNotEmpty? response:[];
  }

  Future<List> getCreationswithid(String id) async{
    final db = await database;
    // var res = await db.query("Creations");
    final List<Map<String, dynamic>> maps = await db!.query("Creations", where: "product_id = ?", whereArgs: [id]);
    List list = maps.isNotEmpty ? maps.map((c) => c).toList() : [];
    //List<ProductModel> list = maps.isNotEmpty ? maps.map((c) => ProductModel.fromMap(c)).toList() : [];
    return list;
    //return response.isNotEmpty? response.map((e) => ProductModel.fromMap(e)).toList():[];
  }

  Future<List> getAllCreations() async{
    final db = await database;
   // var res = await db.query("Creations");
    final List<Map<String, dynamic>> maps = await db!.query("Creations");/*,
      // Use a `where` clause to delete a specific dog.
      where: "categorytype = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: ["photobook"],*/
 /*   return List.generate(maps.length, (i) {
      return ProductModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i/]['age'],
      );
    });*/

    //var response =  await db.rawQuery("SELECT COUNT (*) from Creations");
   // print("creation response - "+res.toString());

    List list = maps.isNotEmpty ? maps.map((c) => c).toList() : [];
    //List<ProductModel> list = maps.isNotEmpty ? maps.map((c) => ProductModel.fromMap(c)).toList() : [];
    return list;
    //return response.isNotEmpty? response.map((e) => ProductModel.fromMap(e)).toList():[];
  }

  // getAllCart() async {
  //   final db = await database;
  //   var response = await db.query("Images", where: "product_type = ?", whereArgs: ["cart"]);
  //   print("all_image1 - ");
  //   print("all_image2 - "+response.toString());
  //   print("all_image3 - ");
  //   return response.isNotEmpty? response.map((e) => ProductModel.fromMap(e)).toList():[];
  // }

  //delete all persons
  deleteAllData() async {
    final db = await database;
    db!.delete("Images");
  }
  deleteAllCreationData()async{
    final db = await database;
    db!.delete("Creations");
  }
  deleteAllcartData()async{
    final db = await database;
    db!.delete("cart");
  }
}
