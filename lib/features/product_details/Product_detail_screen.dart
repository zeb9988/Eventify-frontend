import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventify/common/widgets/custombutton.dart';
import 'package:eventify/common/widgets/star.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/features/cart/cartservices.dart';
import 'package:eventify/features/home/services/HomeServices.dart';
import 'package:eventify/features/home/widgets/BestSellerCard.dart';
import 'package:eventify/models/Product.dart';
import 'package:eventify/models/Producted.dart';
import 'package:eventify/prooviders/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../address/screens/adress_screen.dart';
import '../home/services/favoriteServices.dart';

// import 'package:flutter_rating_bar/flutter_rating_bar';
// import 'package:google_fonts/google_fonts';

class ProductDetailsScreen extends StatefulWidget {
  static const String id = '/DetailsScreen';
  final Product product;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<Product> relatedproduct = [];
  HomeServices home = HomeServices();

  void fetchcatagory() async {
    relatedproduct = await home.fetchsearchproduct(
        context: context, catagory: widget.product.category);
    print(relatedproduct.length);
    setState(() {});
  }

  double sum = 1000;
  List<Product> Productlist = [];
  int _selectedImageIndex = 0;
  CartServices cartServices = CartServices();
  double avgRating = 0;
  double myRating = 0;
  bool isFavorite = false;
  FavoriteServices _favoriteServices = FavoriteServices();

  @override
  void initState() {
    super.initState();
    fetchcatagory();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      print(widget.product.rating![i].rating);
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void toggleFavorite() {
    try {
      if (isFavorite) {
        _favoriteServices.removeFav(context: context, product: widget.product);
      } else {
        _favoriteServices.addToFav(context: context, product: widget.product);
      }
      // Update the UI after adding/removing from favorites
      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  void addToCart() {
    cartServices.addToCart(context: context, product: widget.product);
  }

  Future<void> showAddressBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddressScreen(
          totalAmount: sum.toStringAsFixed(0),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    isFavorite = Provider.of<UserProvider>(context, listen: false)
        .isFavorite(widget.product);
    final user = context.watch<UserProvider>().user;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                elevation: 0,
                snap: true,
                floating: true,
                stretch: true,
                backgroundColor: Colors.grey.shade50,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: [StretchMode.zoomBackground],
                  background: ListView(
                    shrinkWrap: true,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 430,
                              enlargeCenterPage: true,
                              autoPlay: false,
                              aspectRatio: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _selectedImageIndex = index;
                                });
                              },
                            ),
                            items: widget.product.images.map((image) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Positioned(
                            bottom: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                widget.product.images.length,
                                (index) {
                                  return Container(
                                    width: 15,
                                    height: 15,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      color: _selectedImageIndex == index
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 158, 158, 158),
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(10),
                  child: Transform.translate(
                    offset: const Offset(0, 1),
                    child: Container(
                      height: 20,
                      decoration: const BoxDecoration(
                        color: COLOR_ACCENT,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 50,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9 + 330,
                    color: COLOR_PRIMARY,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.businessName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Category',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                                child: Text(
                                  widget.product.category,
                                  style: const TextStyle(
                                    color: COLOR_ACCENT,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Rs. ',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: widget.product.price
                                              .toStringAsFixed(0),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Rating ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  avgRating.toStringAsFixed(1),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Star(rating: avgRating)
                                    ],
                                  ),
                                  MaterialButton(
                                    color:
                                        isFavorite ? Colors.red : Colors.black,
                                    minWidth: 40,
                                    height: 40,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    onPressed: () {
                                      toggleFavorite();
                                    },
                                    padding: const EdgeInsets.all(5),
                                    child: Center(
                                      child: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Details',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                widget.product.generalDetail,
                                style: TextStyle(
                                  height: 1.5,
                                  color: Colors.grey.shade800,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Mobile Number',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                widget.product.phonenumber.toStringAsFixed(0),
                                style: TextStyle(
                                  height: 1.5,
                                  color: Colors.grey.shade800,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Rating and Reviews',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                '${avgRating.toStringAsFixed(1)} (${widget.product.rating!.length} Reviews)',
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              widget.product.rating!.isEmpty
                                  ? Center(
                                      child: LoadingAnimationWidget.inkDrop(
                                        // leftDotColor: COLOR_ACCENT,
                                        //  rightDotColor: Colors.black,
                                        color: COLOR_ACCENT,
                                        size: 50,
                                      ),
                                    )
                                  : SizedBox(
                                      height: 180,
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              widget.product.rating!.length,
                                          itemBuilder: (context, index) {
                                            var review =
                                                widget.product.rating![index];
                                            return Container(
                                              height: 140,
                                              margin: const EdgeInsets.all(5.0),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(0, 2),
                                                    blurRadius: 4,
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    review.username,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13),
                                                  ),
                                                  SizedBox(
                                                    height: 13,
                                                    child: Star(
                                                        rating: review.rating),
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          4), // Reduced vertical spacing
                                                  Flexible(
                                                    child: Text(
                                                      review.feedback,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                      maxLines:
                                                          5, // Adjust based on your content
                                                      // overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        height: 330,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Related Project',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "View All",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black45,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: relatedproduct.length,
                                  itemBuilder: (context, index) {
                                    return BestSellerCard(
                                        relatedproduct[index]);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.sizeOf(context).width,
              height: 70,
              child: CustomButton(
                text: 'Add to cart',
                onTap: () {
                  addToCart();
                },
                color: COLOR_ACCENT,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ReviewItem extends StatelessWidget {
//   // final String imagePath;
//   // final String name;
//   final double rating;
//   final String review;

//   ReviewItem({
//     // required this.imagePath,
//     // required this.name,
//     required this.rating,
//     required this.review,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           // leading: CircleAvatar(
//           //   backgroundImage: NetworkImage(imagePath),
//           // ),
//           title: Text(
//             review,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           subtitle:
//         ),
//         const Divider(),
//       ],
//     );
//   }
// }
