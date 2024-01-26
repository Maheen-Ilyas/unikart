import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:unikart/Products/class.dart';
import 'package:unikart/Products/amazon_products.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  List<Product> amazonProducts = [];

  @override
  void initState() {
    super.initState();
    fetchAmazonData(amazonCategory[0].values.first);
  }

  Future<List<Product>> fetchAmazonData(String url,
      {int maxRetries = 3}) async {
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final http.Response response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          List<Product> extractedProducts = parseAmazonProducts(response.body);
          if (mounted) {
            setState(() {
              amazonProducts = extractedProducts;
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

  List<Product> parseAmazonProducts(String responseBody) {
    List<Product> productList = [];
    final document = html_parser.parse(responseBody);
    final elements = document.querySelectorAll('.a-spacing-base');

    for (var detail in elements) {
      final brandElement = detail.querySelector('div.a-section h2');
      final String brand = brandElement?.text ?? '';
      final String name = detail
              .querySelector(
                  'div.a-section.a-spacing-small.puis-padding-left-small.puis-padding-right-small > div.a-section.a-spacing-none.a-spacing-top-small.s-title-instructions-style > h2 > a > span')
              ?.text ??
          '';
      final String price =
          detail.querySelector('span[class="a-offscreen"]')?.text ?? '';
      final imageElement =
          detail.querySelector('div.s-product-image-container img.s-image');
      final String image = imageElement?.attributes['src'] ?? '';
      final String href = detail
              .querySelector(
                  'div.a-section.a-spacing-small.puis-padding-left-small.puis-padding-right-small > div.a-section.a-spacing-none.a-spacing-top-small.s-title-instructions-style > h2 > a')
              ?.attributes['href'] ??
          '';
      Product product = Product(
        brand: brand,
        name: name,
        price: price,
        image: image,
        source: 'Amazon',
        href: href,
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
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Card(
                child: Center(
                  child: Text(
                    "Unikart Banner",
                    style: GoogleFonts.outfit(
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Categories",
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: amazonCategory.length,
              itemBuilder: (context, index) {
                final categoryName = amazonCategory[index].keys.first;
                final categoryUrl = amazonCategory[index].values.first;
                return GestureDetector(
                  onTap: () {
                    fetchAmazonData(categoryUrl).then(
                      (extractedProducts) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AmazonProducts(
                              name: categoryName,
                              index: index,
                              products: extractedProducts,
                            ),
                          ),
                        );
                      },
                    ).catchError(
                      (error) {
                        throw Exception('Error: $error');
                      },
                    );
                  },
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Center(
                        child: Text(
                          categoryName,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
