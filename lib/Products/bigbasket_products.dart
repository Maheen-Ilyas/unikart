import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unikart/Products/class.dart';
import 'package:unikart/Products/product_card.dart';
import 'package:unikart/Products/jiomart_products.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class BigbasketProducts extends StatefulWidget {
  final String name;
  final List<Product> products;
  final int index;
  const BigbasketProducts({
    super.key,
    required this.name,
    required this.products,
    required this.index,
  });

  @override
  State<BigbasketProducts> createState() => _ProductsState();
}

class _ProductsState extends State<BigbasketProducts> {
  List<Product> jiomartProducts = [];

  final List<Map<String, String>> jiomartCategory = [
    {
      'Appliances': 'https://www.jiomart.com/c/electronics/home-appliances/724',
    },
    {
      'Beauty': 'https://www.jiomart.com/c/beauty/5',
    },
    {
      'Boy\'s Clothing': 'https://www.jiomart.com/c/fashion/boys/499',
    },
    {
      'Electronics': 'https://www.jiomart.com/c/electronics/4',
    },
    {
      'Furniture': 'https://www.jiomart.com/c/homeandkitchen/home-decor/8722',
    },
    {
      'Girl\'s CLothing': 'https://www.jiomart.com/c/fashion/girls/563',
    },
    {
      'Grocery': 'https://www.jiomart.com/c/groceries/2',
    },
    {
      'Health & Personal Care':
          'https://www.jiomart.com/c/groceries/personal-care/91',
    },
    {
      'Home & Kitchen': 'https://www.jiomart.com/c/homeandkitchen/8582',
    },
    {
      'Men\'s Clothing': 'https://www.jiomart.com/c/fashion/men/496',
    },
    {
      'Pet Supplies': 'https://www.jiomart.com/c/groceries/pets/3346',
    },
    {
      'Sports':
          'https://www.jiomart.com/c/sportstoysluggage/sporting-goods-fitness-equipment/9279',
    },
    {
      'Watches': 'https://www.jiomart.com/search/watches',
    },
    {
      'Women\'s Clothing': 'https://www.jiomart.com/c/fashion/women/493',
    },
  ];

  Future<List<Product>> fetchJiomartData(String url,
      {int maxRetries = 3}) async {
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final http.Response response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          List<Product> extractedProducts = parseJiomartProducts(response.body);
          if (mounted) {
            setState(() {
              jiomartProducts = extractedProducts;
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

  List<Product> parseJiomartProducts(String responseBody) {
    List<Product> productList = [];
    final document = html_parser.parse(responseBody);
    final elements = document.querySelectorAll(
      'div.plp-card-container',
    );
    for (var detail in elements) {
      final brandElement = detail.querySelector('div.plp-card-details-wrapper > div > div.plp-card-details-tag > div');
      final String brand = brandElement?.text ?? '';
      print(brand);
      final String name = detail.querySelector('div.plp-card-details-wrapper > div > div.plp-card-details-name.line-clamp.jm-body-xs.jm-fc-primary-grey-80')?.text ?? '';
      print(name);
      final String price = detail
              .querySelector(
                'div.plp-card-details-wrapper > div > div.plp-card-details-price-wrapper > div.plp-card-details-price > span.jm-heading-xxs.jm-mb-xxs',
              )
              ?.text ??
          '';
      print(price);
      final imageElement = detail.querySelector(
        'div.plp-card-image img',
      );
      final String image = imageElement?.attributes['src'] ?? '';
      print(image);
      Product product = Product(
        brand: brand,
        name: name,
        price: price,
        image: image,
        source: 'Jiomart',
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
                FilledButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BigbasketProducts(
                          name: widget.name,
                          products: widget.products,
                          index: widget.index,
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
                  onPressed: () {
                    fetchJiomartData(jiomartCategory[widget.index].values.first)
                        .then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JiomartProducts(
                            name: widget.name,
                            index: widget.index,
                            products: jiomartProducts,
                          ),
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
