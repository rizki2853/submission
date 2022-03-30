import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/page/Home/Widgets/restauran_list_item.dart';
import 'package:submission1/providers/all_restaurant.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  String? query;
  SearchPage({Key? key, this.query}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<RestauranProvider>(context, listen: false);
    dataProvider.searchRestauran(widget.query!);
    return Consumer<RestauranProvider>(builder: (context, value, child) {
      if (!value.internet) {
        return Scaffold(
            appBar: appbar(context, dataProvider),
            body: const Center(child: Text('No internet')));
      } else if (value.getState == ResultState.loading) {
        return Scaffold(
          appBar: appbar(context, dataProvider),
          body: const Center(child: CircularProgressIndicator()),
        );
      } else if (value.getState == ResultState.nodata) {
        return Scaffold(
          appBar: appbar(context, dataProvider),
          body: const Center(
            child: Text("No Data"),
          ),
        );
      } else {
        return Scaffold(
          appBar: appbar(context, dataProvider),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: const [
                ListTile(
                  title: Text("Restauran"),
                  subtitle: Text("Recomendation restauran for you!"),
                ),
                RestauranList(),
              ],
            ),
          )),
        );
      }
    });
  }

  AppBar appbar(BuildContext context, RestauranProvider dataProvider) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: TextField(
        controller: search,
        decoration: const InputDecoration(
          hintText: 'Search Here..',
          border: InputBorder.none,
        ),
        onChanged: (String value) {
          setState(() {
            widget.query = value;
          });
          dataProvider.searchRestauran(value);
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                search.text = '';
              });
              dataProvider.searchRestauran("a");
            },
          ),
        ),
      ],
    );
  }
}
