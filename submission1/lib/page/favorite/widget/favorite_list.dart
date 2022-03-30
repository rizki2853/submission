import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/providers/all_restaurant.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<RestauranProvider>(context, listen: false);
    dataProvider.getFavorite();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Consumer<RestauranProvider>(builder: (context, value, child) {
        if (!value.internet) {
          return const Center(
            child: Text("No Internet"),
          );
        } else if (value.getState == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (value.getState == ResultState.nodata) {
          return const Center(child: Text("Empty Favorites List"));
        } else {
          return ListView.builder(
              itemExtent: 100,
              itemCount: value.favorite.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.pushNamed(context, '/detail',
                      arguments: value.favorite[index].id),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Dismissible(
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.delete_rounded,
                          size: 30,
                        ),
                      ),
                      onDismissed: (direction) {
                        dataProvider.deleteRestaurant(value.favorite[index].id);
                      },
                      key: Key(value.favorite[index].id),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Hero(
                              tag: value.favorite[index].pictureId,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                height: 189,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://restaurant-api.dicoding.dev/images/medium/" +
                                              value.favorite[index].pictureId),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.favorite[index].name,
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      value.favorite[index].city,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w100),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(value.favorite[index].rating
                                            .toString()),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          Icons.star,
                                          size: 17,
                                          color: Colors.orange,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
      }),
    );
  }
}
