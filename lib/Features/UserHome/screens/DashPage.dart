// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, library_private_types_in_public_api, empty_catches
import 'package:eventify/Features/UserHome/screens/MenuScreen.dart';
import 'package:eventify/Language/language_constants.dart';
import 'package:eventify/common/widgets/Loader.dart';
import 'package:eventify/constant/Theme_constant.dart';
import 'package:eventify/common/widgets/MainSearchBar.dart';
import 'package:eventify/features/search/Search.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../Models/todoList.dart';
import '../../../constant/constant.dart';
import '../../../models/Product.dart';
import '../../../models/WeatherModel.dart';
import '../../../prooviders/provider.dart';
import '../../Weather/Services/weatherServices.dart';
import '../../checklist/checklistServices.dart';
import '../services/HomeServices.dart';
import '../widgets/AppbarClipper.dart';
import '../widgets/BestSellerCard.dart';
import '../widgets/dashcards.dart';
import '../widgets/slider.dart';
import '../widgets/topeventwidget.dart';

class DashPage extends StatefulWidget {
  static const String id = '/DashPage';

  const DashPage({Key? key}) : super(key: key);

  @override
  State<DashPage> createState() => _DashPageState();
}

//weather animation
class _DashPageState extends State<DashPage> {
  //api key
  final _weatherService = WeatherService('3cf84e3b2bee2c16cf92772b2e51d40e');
  Weather? _weather;

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/animation/sunny.json'; //default to sunny
    }
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/animation/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/animation/rain.json';
      case 'thunderstorm':
        return 'assets/animation/thunder.json';
      case 'clear':
        return 'assets/animation/sunny.json';
      default:
        return 'assets/animation/sunny.json';
    }
  }

  _fetchWeather() async {
    //get current city
    String? cityName = await _weatherService.getCurrentCity();
    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName!);
      setState(() {
        _weather = weather;
      });
    }
    //any error
    catch (e) {}
  }

  List<Product> product = [];
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
    fetchTodoList();
    _fetchWeather();
  }

  void fetchDealOfDay() async {
    product = await homeServices.bestSeller(context: context);
    setState(() {});
  }

  void Navigatetosearchscreen(String query) {
    Navigator.pushNamed(
      context,
      Search.id,
      arguments: query,
    );
  }

  TextEditingController searchController = TextEditingController();

  final TodoServices todoservice = TodoServices();
  List<TodoList> items = [];
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void fetchTodoList() async {
    items = await todoservice.fetchTodoList(context);
    setState(() {});
  }

  void deleteTodoList(int index, TodoList todoitem) {
    todoservice.deleteTodoList(
        context: context,
        todoitem: todoitem,
        onsuccess: () {
          items.removeAt(index);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    final usercartLen = context.watch<UserProvider>().user.cart.length;
    final user = Provider.of<UserProvider>(context).user;
    var pakistanTime = DateTime.now()
        .toUtc()
        .add(const Duration(hours: 5)); // Calculate Pakistan time
    var formattedTime = DateFormat.jm().format(pakistanTime);
    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: ClipPath(
          clipper: CustomAppBarClipper(),
          child: AppBar(
            backgroundColor: COLOR_ACCENT,
            elevation: 5,
            leading: InkWell(
              onTap: () {
                Navigator.pushNamed(context, MenuScreen.id);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      backgroundColor: COLOR_ACCENT,
                      child: Text(
                        user.name.isNotEmpty
                            ? user.name[0].toUpperCase()
                            : 'Empty',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // centerTitle: true, // Center the title and widgets
            title: Padding(
              padding: const EdgeInsets.only(top: 25, left: 15),
              child: SearchBarWidget(
                hintText: "|| Search...",
                controller: searchController,
              ),
            ),
            actions: [
              CartButton(context, usercartLen, Colors.black),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Content
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: COLOR_ACCENT,
                              child: Text(
                                user.name.isNotEmpty
                                    ? user.name[0].toUpperCase()
                                    : 'Empty',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText(
                                    user.name,
                                    curve: Curves.bounceInOut,
                                    speed: const Duration(milliseconds: 300),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 25,
                        child: Text(
                          formattedTime,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 50,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: COLOR_ACCENT,
                              size: 18,
                            ),
                            Text(
                              _weather?.cityName ?? "Loading city...",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 70,
                        top: 80,
                        child: Text(
                          DateFormat('EEEE, MMMM d').format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 175,
                        top: 95,
                        child: Lottie.asset(
                          getWeatherAnimation(_weather?.mainCondition),
                          animate: true,
                          repeat: true,
                          reverse: true,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          height: 130,
                          width: 100,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 165,
                        child: Text(
                          _weather?.temperature != null
                              ? '${_weather!.temperature.round()}°C'
                              : 'Loading..',
                          // Replace 'N/A' with the text you want to display when temperature is null
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 190,
                        child: Text(
                          _weather?.mainCondition ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 20),
                height: 220,
                child: Column(
                  children: const [
                    SizedBox(
                      height: 15,
                    ),
                    ProductSlider(),
                  ],
                ),
              ),
              dashcard(),
              topeventcards(),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 280,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          translation(context).bestseller,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    product.isEmpty
                        ? Loader()
                        : Container(
                            width: MediaQuery.of(context)
                                .size
                                .width, // Adjust the width as needed
                            height: 230,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: product.length,
                                itemBuilder: (context, index) {
                                  return BestSellerCard(product[index]);
                                }),
                          ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        translation(context).checklist,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (items.isEmpty)
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Loader(),
                        ),
                      )
                    else
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, int index) {
                            final todo = items[index];
                            return Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                dismissible: DismissiblePane(onDismissed: () {
                                  deleteTodoList(index, todo);
                                }),
                                children: [
                                  SlidableAction(
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                    onPressed: (BuildContext context) {
                                      deleteTodoList(index, todo);
                                    },
                                  ),
                                ],
                              ),
                              child: Card(
                                borderOnForeground: false,
                                child: ListTile(
                                  title: Text(todo.title),
                                  subtitle: Text(todo.desc),
                                  trailing: const Icon(Icons.arrow_back),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
