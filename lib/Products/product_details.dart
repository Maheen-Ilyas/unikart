import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetail extends StatefulWidget {
  final String productBrand;
  final String productName;
  final String productPrice;
  final String productImage;
  final String productSource;
  const ProductDetail({
    super.key,
    required this.productBrand,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productSource,
  });

  @override
  State<ProductDetail> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductDetail> {
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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.network(
                      widget.productImage,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.productBrand,
                    style: GoogleFonts.outfit(
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.productName,
                    style: GoogleFonts.outfit(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Analyze Reviews",
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FluentIcons.flag_24_filled,
                          color: Colors.red,
                        ),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: () {},
                        child: Text(
                          "Buy on ${widget.productSource}",
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
