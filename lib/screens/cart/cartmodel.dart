import '../home/component/product_model.dart';

class CartItem{
    final Product product;
    int quantity;
    CartItem({
        required this.product,
        required this.quantity
    });
}
