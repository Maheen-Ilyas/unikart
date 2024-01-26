import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unikart/Products/class.dart';
import 'package:unikart/Products/product_card.dart';
import 'package:unikart/Products/bigbasket_products.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class AmazonProducts extends StatefulWidget {
  final String name;
  final int index;
  final List<Product> products;
  const AmazonProducts({
    super.key,
    required this.name,
    required this.products,
    required this.index,
  });

  @override
  State<AmazonProducts> createState() => _ProductsState();
}

class _ProductsState extends State<AmazonProducts> {
  List<Product> bigBasketProducts = [];

  Future<List<Product>> fetchBigbasketData(String url,
      {int maxRetries = 3}) async {
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final http.Response response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          List<Product> extractedProducts =
              parseBigbasketProducts(response.body);
          if (mounted) {
            setState(() {
              bigBasketProducts = extractedProducts;
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

  List<Product> parseBigbasketProducts(String responseBody) {
    List<Product> productList = [];
    final document = html_parser.parse(responseBody);
    final elements = document.querySelectorAll(
      '#siteLayout > div.col-span-12.mt-3.mb-8 > div.grid.grid-flow-col.gap-x-6.relative.mt-5.pb-5.border-t.border-dashed.border-silverSurfer-400 > section > section > ul > li > div > div',
    );

    for (var detail in elements) {
      final brandElement = detail.querySelector('h3 a span');
      final String brand = brandElement?.text ?? '';
      final String name = detail.querySelector('h3 > a > div > h3')?.text ?? '';
      final String price = detail
              .querySelector(
                'div.Pricing___StyledDiv-sc-pldi2d-0 > span.Pricing___StyledLabel-sc-pldi2d-1',
              )
              ?.text ??
          '';
      final imageElement = detail.querySelector(
        'span > img',
      );
      final String image = imageElement?.attributes['src'] ?? '';
      final String href =
          detail.querySelector('h3 > a')?.attributes['href'] ?? '';

      Product product = Product(
        brand: brand,
        name: name,
        price: price,
        image: image,
        source: 'Bigbasket',
        href: href,
      );
      productList.add(product);
    }
    return productList;
  }

  @override
  void initState() {
    super.initState();
    fetchBigbasketData(bigBasketCategory[0].values.first);
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
                        productLink: product.href,
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
                  onPressed: () {
                    fetchBigbasketData(
                      bigBasketCategory[widget.index].values.first,
                    ).then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BigbasketProducts(
                            name: widget.name,
                            index: widget.index,
                            products: bigBasketProducts,
                          ),
                        ),
                      ),
                    );
                  },
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
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
