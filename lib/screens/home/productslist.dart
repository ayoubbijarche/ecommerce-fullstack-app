import 'dart:async';
import 'package:flutter/material.dart';
import './product_model.dart';
import 'products_service.dart';

// CartItem model
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class Productlist extends StatefulWidget {
  const Productlist({Key? key}) : super(key: key);

  @override
  State<Productlist> createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {
  List<Product> products = [];
  List<CartItem> cartItems = [];
  Timer? _datafetchTimer;

  @override
  void initState() {
    super.initState();
    _loadproducts();
    _datafetchTimer = Timer.periodic(const Duration(seconds: 30), (timer) => _loadproducts());
  }

  @override
  void dispose() {
    _datafetchTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadproducts() async {
    try {
      final fetchedproducts = await fetchProducts();
      setState(() {
        products = fetchedproducts;
      });
    } catch (e) {
      print('Error loading products: $e');
      // Consider showing an error message to the user
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(0, 1),
            child: squarecontainer(),
          ),
          Align(
            alignment: const Alignment(0, 0.5),
            child: ProductRow(products),
          ),
        ],
      ),
    );
  }
}

Widget squarecontainer() {
  const double rad = 20;
  return Container(
    width: double.infinity,
    height: 230,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(rad), topRight: Radius.circular(rad))
    ),
  );
}

class ProductRow extends StatelessWidget {    
  final List<Product> products;
  final Function(Product) onAddToCart;

  const ProductRow({Key? key, required this.products, required this.onAddToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {    
    if (products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductContainer(product: product, onAddToCart: onAddToCart);
        }
      ),
    );
  }
}

class ProductContainer extends StatelessWidget {
  final Product product;
  final Function(Product) onAddToCart;

  const ProductContainer({Key? key, required this.product, required this.onAddToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 400,
      margin: const EdgeInsets.only(left: 25),
      decoration: const BoxDecoration(
        color: Color(0xfff3f3f3),
        borderRadius: BorderRadius.all(Radius.circular(17)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17.0),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2),
                        BlendMode.darken
                      ),
                      child: Image.network(
                        product.fullImageUrl,
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: const TextStyle(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 4),
                    Text(
                      product.price,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 11.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: const Alignment(0.8, 0.55),
            child: GestureDetector(
              onTap: () {
                onAddToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} added to cart')),
                );
              },
              child: Container(
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: const Center(
                  child: Text(
                    "+",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


