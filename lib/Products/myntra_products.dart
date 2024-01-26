import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unikart/Products/class.dart';
import 'package:unikart/Products/product_card.dart';

class MyntraProducts extends StatefulWidget {
  final String name;
  final int index;
  final List<Product> products;
  const MyntraProducts({
    super.key,
    required this.name,
    required this.index,
    required this.products,
  });

  @override
  State<MyntraProducts> createState() => _MyntraProductsState();
}

class _MyntraProductsState extends State<MyntraProducts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Image.asset(
            'assets/logo.png',
            width: 150,
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                widget.name,
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: widget.products.length,
                  itemBuilder: (context, index) {
                    final product = widget.products[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ProductCard(
                        productBrand: product.brand,
                        productName: product.name,
                        productPrice: product.price,
                        productImage: product.image,
                        productSource: product.source,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    1.toString(),
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    2.toString(),
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: () {},
                  child: Text(
                    3.toString(),
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
