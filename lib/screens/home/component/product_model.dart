import '../../../pbsetup/pb.dart';

class Product {
    final String id;
    final String name;
    final String imgurl;
    final String price;
    final String description;

    Product({
        required this.id,
        required this.name,
        required this.imgurl,
        required this.price,
        required this.description,
    });

    factory Product.fromJson(Map<String, dynamic> json) {
        return Product(
            id: json['id'],
            name: json['name'],
            imgurl: json['imgurl'],
            price: json['price'],
            description: json['description']
        );
    }


    String get fullImageUrl {
        if (imgurl.startsWith('http://') || imgurl.startsWith('https://')) {
        return imgurl;
        }
    return '${pb.baseUrl}/api/files/products/$id/$imgurl'.replaceAll("//", "/").replaceFirst("/", "//");
  }
}
