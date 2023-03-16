class Product{

  late int id;
  late String name;
  late String price;
  late int quantity;

  Product({ required this.id,required this.name, required this.price, required this.quantity});
  // Product({required this.id, required this.name, required this.price, required this.quantity});


  ////////// From map Map => Product object
  static Product fromMap(Map<String , dynamic> query) {
   return  Product(
      id: query['id'],
     name: query['name'],
     price: query['price'],
     quantity: query['quantity']
   );


  }
  //////////////////////////// from product to map
  static Map<String , dynamic> toMap(Product product){
    return <String, dynamic>{
      'id' : product.id,
      'name' : product.name,
      'price' : product.price,
      'quantity' : product.quantity

    };
  }
  static List<Product> fromList(List<Map<String, dynamic>> query){

    List<Product> products = <Product>[];
    for(Map<String, dynamic> mp in query){
      products.add(fromMap(mp));
    }
    return products;

  }

}