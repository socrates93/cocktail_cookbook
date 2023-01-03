import 'package:flutter/material.dart';

class SearchInputWidget extends StatefulWidget {
  const SearchInputWidget({super.key});

  @override
  State<SearchInputWidget> createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends State<SearchInputWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(_onChangeListener);
  }

  void _onChangeListener() {
    print(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
