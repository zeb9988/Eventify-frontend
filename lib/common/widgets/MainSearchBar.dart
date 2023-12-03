// ignore: file_names
import 'package:flutter/material.dart';
import '../../features/search/Search.dart';

class SearchBarWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const SearchBarWidget({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  void Navigatetosearchscreen(String query) {
    Navigator.pushNamed(
      context,
      Search.id,
      arguments: query,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 40,
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        onFieldSubmitted: Navigatetosearchscreen,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.black26,
            fontSize: 20, // Set the desired font size
          ),
          border: InputBorder.none,
          // icon: Image.asset('assets/images/search.png',height: 35,)
        ),
      ),
    );
  }
}
