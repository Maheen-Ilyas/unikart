import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unikart/Products/product_details.dart';

class ProductCard extends StatefulWidget {
  final String productBrand;
  final String productName;
  final String productPrice;
  final String productImage;
  const ProductCard({
    Key? key,
    required this.productBrand,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              productBrand: widget.productBrand,
              productName: widget.productName,
              productPrice: widget.productPrice,
              productImage: widget.productImage,
            ),
          ),
        );
      },
      child: SizedBox(
        height: 150,
        child: Card(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                width: 130,
                child: Image.network(
                  widget.productImage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Container(
                  padding: const EdgeInsets.only(left: 8, top: 10),
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.productBrand,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.productName,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.productPrice,
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
