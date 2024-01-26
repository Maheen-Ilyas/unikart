import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unikart/Products/class.dart';
import 'package:unikart/Products/myntra_products.dart';
import 'package:unikart/Products/product_card.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class JiomartProducts extends StatefulWidget {
  final String name;
  final int index;
  final List<Product> products;
  const JiomartProducts({
    super.key,
    required this.name,
    required this.index,
    required this.products,
  });

  @override
  State<JiomartProducts> createState() => _JiomartProductsState();
}

class _JiomartProductsState extends State<JiomartProducts> {
  List<Product> myntraProducts = [];

  Future<List<Product>> fetchMyntraData(String url,
      {int maxRetries = 3}) async {
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final http.Response response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          List<Product> extractedProducts = parseMyntraProducts(response.body);
          if (mounted) {
            setState(() {
              myntraProducts = extractedProducts;
            });
          }
          return extractedProducts;
        } else {
          throw Exception(
              'Failed to load data - Status Code: ${response.statusCode}');
        }
      } catch (e) {
        if (retryCount < maxRetries - 1) {
          retryCount++;
        } else {
          rethrow;
        }
      }
    }
    return [];
  }

  List<Product> parseMyntraProducts(String responseBody) {
    List<Product> productList = [];
    final document = html_parser.parse(responseBody);
    final elements = document.querySelectorAll(
      'section ul li a',
    );
    for (var detail in elements) {
      final brandElement = detail.querySelector('');
      final String brand = brandElement?.text ?? '';
      final String name = detail.querySelector('')?.text ?? '';
      final String price = detail
              .querySelector(
                '',
              )
              ?.text ??
          '';
      final imageElement = detail.querySelector(
        '',
      );
      final String image = imageElement?.attributes['src'] ?? '';
      Product product = Product(
        brand: brand,
        name: name,
        price: price,
        image: image,
        source: 'Myntra',
      );
      productList.add(product);
    }
    return productList;
  }

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
                FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JiomartProducts(
                          name: widget.name,
                          products: widget.products,
                          index: widget.index,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    2.toString(),
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    fetchMyntraData(myntraCategory[widget.index].values.first)
                        .then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyntraProducts(
                            name: widget.name,
                            index: widget.index,
                            products: myntraProducts,
                          ),
                        ),
                      ),
                    );
                  },
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
