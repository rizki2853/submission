import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/page/favorite/widget/favorite_list.dart';
import 'package:submission1/providers/all_restaurant.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final TextEditingController search = TextEditingController();
  String query = '';
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<RestauranProvider>(context, listen: false);
    if (!dataProvider.internet) {
      return Scaffold(
          appBar: appBar(dataProvider),
          body: const Center(child: Text('No internet')));
    } else if (dataProvider.state == ResultState.loading) {
      return Scaffold(
          appBar: appBar(dataProvider),
          body: const Center(child: CircularProgressIndicator()));
    } else if (dataProvider.state == ResultState.nodata) {
      return Scaffold(
          appBar: appBar(dataProvider),
          body: const Center(child: Text('Empty Favorites List')));
    } else {
      return Scaffold(
        appBar: appBar(dataProvider),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: ListTile(
                      title: Text(
                        "Favorite",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      subtitle: Text("find your favorite restaurants here!"),
                    )),
                FavoriteList(),
              ],
            ),
          ),
        ),
      );
    }
  }

  AppBar appBar(RestauranProvider dataProvider) {
    return AppBar(
      title: TextField(
        controller: search,
        decoration: const InputDecoration(
            hintText: "Search here..", border: InputBorder.none),
        onChanged: (String value) {
          setState(() {
            query = value;
          });
          dataProvider.searchFavorite(query);
        },
      ),
    );
  }
}
