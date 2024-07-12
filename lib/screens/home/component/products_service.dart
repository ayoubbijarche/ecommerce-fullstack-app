import 'package:ecommerce_sample/screens/home/component/product_model.dart';

import '../../../pbsetup/pb.dart';


Future<List<Product>> fetchProducts() async{
    try{
        final records = await pb.collection("products").getList();
        return records.items.map((records) => Product.fromJson(records.toJson())).toList();

    }catch(e){
        print("error fetching : $e");
        return [];
    }
}
