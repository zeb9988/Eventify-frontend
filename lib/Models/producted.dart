class Producted {
  final int id, price;
  final String title, description, image, rating;

  Producted(
      {required this.id,
      required this.price,
      required this.title,
      required this.description,
      required this.image,
      required this.rating});
}

// list of products
// for our demo
List<Producted> products = [
  Producted(
    id: 1,
    price: 56,
    title: "Product 1",
    image: "assets/images/cat.jpg",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    rating: '3',
  ),
  Producted(
    id: 2,
    price: 68,
    title: "Product 2",
    image: "assets/images/photo.jpg",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
    rating: '3',
  ),
  Producted(
    id: 3,
    price: 39,
    title: "Product 3",
    image: "assets/images/light.jpg",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
    rating: '3',
  ),
  Producted(
    id: 4,
    price: 39,
    title: "Product 3",
    image: "assets/images/light.jpg",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
    rating: '3',
  ),
  Producted(
    id: 5,
    price: 39,
    title: "Product 3",
    image: "assets/images/light.jpg",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim",
    rating: '3',
  ),
];
