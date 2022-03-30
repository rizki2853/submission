import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/model/favorite.dart';
import 'package:submission1/page/Detail/Widgets/add_review.dart';
import 'package:submission1/page/Detail/Widgets/review.dart';
import 'package:submission1/providers/all_restaurant.dart';

import 'Widgets/menu_list.dart';

class DetailPage extends StatefulWidget {
  final String? id;
  const DetailPage({Key? key, this.id}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Icon favoriteIcon = const Icon(Icons.favorite, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<RestauranProvider>(context, listen: false);
    dataProvider.detailRestauran(widget.id!);
    // dataProvider.getFavorite();
    return Consumer<RestauranProvider>(builder: (context, value, child) {
      if (!value.internet) {
        return Scaffold(
            appBar: appbar(context, value),
            body: const Center(child: Text('No internet')));
      } else if (value.getState == ResultState.loading) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        return Scaffold(
          appBar: appbar(context, value),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: value.detailres['pictureId'],
                    child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/medium/" +
                            value.detailres['pictureId']),
                  ),
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        value.detailres['name'],
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 13,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(value.detailres['address'] +
                              ", " +
                              value.detailres['city']),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: MediaQuery.of(context).size.width,
                    height: 22,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).primaryColor),
                          child: Text(
                              value.detailres['categories'][index]['name']),
                        );
                      },
                      itemCount: value.detailres['categories'].length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 10);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      subtitle: Text(value.detailres['description']),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Text("Foods",
                        style: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: value.detailres['menus']['foods'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return MenuList(
                          name: value.detailres['menus']['foods'][index]
                              ['name'],
                          image:
                              "https://images.unsplash.com/photo-1624726175512-19b9baf9fbd1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2940&q=80",
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Text("Drinks",
                        style: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: value.detailres['menus']['drinks'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return MenuList(
                          name: value.detailres['menus']['drinks'][index]
                              ['name'],
                          image:
                              "https://images.unsplash.com/photo-1499638673689-79a0b5115d87?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2864&q=80",
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 15),
                    child: Row(
                      children: [
                        const Text(
                          "Review",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 191, 143, 0)),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          value.detailres['rating'].toString(),
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 191, 143, 0)),
                        ),
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                  AddReview(
                    id: widget.id!,
                  ),
                  ReviewList(
                    id: widget.id,
                  )
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  AppBar appbar(BuildContext context, RestauranProvider value) {
    // if (value.favorite.contains(value.detailres['name'])) {
    //   setState(() {
    //     favoriteIcon = const Icon(Icons.favorite, color: Colors.red);
    //   });
    // }
    for (int i = 0; i < value.favorite.length; i++) {
      if (value.favorite[i].name == value.detailres['name']) {
        favoriteIcon = const Icon(Icons.favorite, color: Colors.red);
      }
    }
    IconButton favoriteButton = IconButton(
      onPressed: () {
        final data = Restaurant(
            id: value.detailres['id'],
            name: value.detailres['name'],
            description: value.detailres['description'],
            pictureId: value.detailres['pictureId'],
            city: value.detailres['city'],
            rating: value.detailres['rating']);
        value.addFavorite(data);
        setState(() {
          favoriteIcon = const Icon(Icons.favorite, color: Colors.red);
        });
      },
      icon: favoriteIcon,
    );
    if (favoriteIcon.color == Colors.red) {
      favoriteButton = IconButton(
        onPressed: () {
          value.deleteRestaurant(value.detailres['id']);
          setState(() {
            favoriteIcon = const Icon(Icons.favorite, color: Colors.white);
          });
        },
        icon: favoriteIcon,
      );
    }
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(value.detailres['name']),
      actions: [favoriteButton],
    );
  }
}
