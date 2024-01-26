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
  final List<Map<String, String>> amazonCategory = [
    {
      'Appliances':
          'https://www.amazon.in/s?bbn=5122349031&rh=n%3A5122348031%2Cn%3A4951860031&dc&qid=1706030387&rnid=5122349031&ref=lp_5122349031_nr_n_1'
    },
    {
      'Beauty':
          'https://www.amazon.in/s?k=beauty+and+personal+care&i=beauty&crid=3GV8OUCQ5HDDW&sprefix=%2Cbeauty%2C176&ref=nb_sb_ss_recent_1_0_recent'
    },
    {
      'Boy\'s Clothing':
          'https://www.amazon.in/s?k=boys+clothing&i=apparel&crid=1QXHKQ0HT1X9R&sprefix=boys+cl%2Capparel%2C187&ref=nb_sb_ss_ts-doa-p_1_7'
    },
    {
      'Electronics':
          'https://www.amazon.in/s?k=electronics&i=electronics&crid=3UC8JI1RNI83D&sprefix=electroni%2Celectronics%2C200&ref=nb_sb_noss_2'
    },
    {
      'Furniture':
          'https://www.amazon.in/s?k=furniture&i=furniture&crid=36VRTVECC2VVZ&sprefix=furniture%2Cfurniture%2C189&ref=nb_sb_noss_1'
    },
    {
      'Girl\'s CLothing':
          'https://www.amazon.in/s?k=girls+clothing&i=apparel&crid=2QD3S1HUXBL0A&sprefix=girls%2Capparel%2C182&ref=nb_sb_ss_ts-doa-p_2_5'
    },
    {
      'Grocery':
          'https://www.amazon.in/s?k=grocery&i=grocery&crid=389RFA9AXLH3S&sprefix=grocery%2Cgrocery%2C188&ref=nb_sb_noss_1'
    },
    {
      'Health & Personal Care':
          'https://www.amazon.in/s?k=health+and+personal+care&i=hpc&crid=32SSXWS3FGFSP&sprefix=health+and+%2Chpc%2C189&ref=nb_sb_ss_ts-doa-p_1_11'
    },
    {
      'Home & Kitchen':
          'https://www.amazon.in/s?k=home+and+kitchen&i=kitchen&crid=29W8TBAZJGF4&sprefix=home+and+kitchen%2Ckitchen%2C184&ref=nb_sb_noss_1'
    },
    {
      'Men\'s Clothing':
          'https://www.amazon.in/s?k=mens+clothing&i=apparel&crid=3EKEB9B1OH4HL&sprefix=mens+cl%2Capparel%2C180&ref=nb_sb_ss_ts-doa-p_2_7'
    },
    {
      'Pet Supplies':
          'https://www.amazon.in/s?k=pet+supplies&i=pets&crid=1YLABT1OB5XYQ&sprefix=pet+supplies%2Cpets%2C178&ref=nb_sb_noss_1'
    },
    {
      'Sports':
          'https://www.amazon.in/s?k=sports&i=sporting&crid=1VHOWZES95USX&sprefix=sports%2Csporting%2C180&ref=nb_sb_noss_1'
    },
    {
      'Watches':
          'https://www.amazon.in/s?k=watches&i=watches&crid=3DUM7AQLGLD3Y&sprefix=watches%2Cwatches%2C189&ref=nb_sb_noss_1'
    },
    {
      'Women\'s Clothing':
          'https://www.amazon.in/s?k=women+clothing&i=apparel&crid=NV135L5ZIDGR&sprefix=women+clothing%2Capparel%2C173&ref=nb_sb_noss_1'
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchAmazonData(amazonCategory[0].values.first);
  }

  Future<List<Product>> fetchAmazonData(String url, {int maxRetries = 3}) async {
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

      Product product = Product(
        brand: brand,
        name: name,
        price: price,
        image: image,
        source: 'Amazon',
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
