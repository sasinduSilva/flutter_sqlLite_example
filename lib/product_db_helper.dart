import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqllite_example/product.dart';

class ProductDBHelper{

  static final _databaseName = 'mydb.db';
  static final _databaseVersion = 1;
  static final _table_products = 'products';
  static late String path;

  ProductDBHelper._privateConstructor();

  static final ProductDBHelper instance = ProductDBHelper._privateConstructor();

  static late Database _database;

  Future<Database> get database async{

    if(_database != null) return _database;

    _database = await _initDatabase();
    return _database;
}
////////////////////////////// Initialize database with local file path, db name...

   Future<Database> _initDatabase() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    //////// Locstorage path/database.db
    String path = join(await documentDirectory.path, _databaseName);
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate:  _onCreate
    );
  }
//////////////////// On create for creating database
  static Future _onCreate(Database db, int version) async{

    await db.execute('CREATE TABLE $_table_products(id INTEGER PRIMARY KEY autoincrement, name TEXT, price TEXT, quantity INTEGER)');

  }

static Future getFileData() async{
    return getDatabasesPath().then((value) {
      return path = value;
    });
}

Future insertProduct(Product product) async{

    Database db = await instance._initDatabase();
    return await db.insert(_table_products, {'name':product.name, 'price':product.price, 'quantity': product.quantity}, conflictAlgorithm: ConflictAlgorithm.ignore);

}

Future<List<Product>> getProductsList() async{

    Database db = await instance._initDatabase();
    List<Map<String, dynamic>> maps = await db.query(_table_products);
    print(maps);
    return Product.fromList(maps);

}


Future<Product> updateProduct(Product product) async{
    Database db = await _initDatabase();
    
    await db.update(_table_products, Product.toMap(product) , where: 'id = ?', whereArgs: [product.id]);
    return product;
}

  Future deleteProduct(Product product) async{
    Database db = await _initDatabase();

    var deletedProduct =  db.delete(_table_products, where: 'id = ?', whereArgs: [product.id]);
    return deletedProduct;
  }


}
