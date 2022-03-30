import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/providers/all_restaurant.dart';

class RestauranList extends StatelessWidget {
  const RestauranList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Consumer<RestauranProvider>(
          builder: (context, value, child) => (value.allrestauran.isEmpty)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemExtent: 100,
                  itemCount: value.allrestauran.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.pushNamed(context, '/detail',
                          arguments: value.allrestauran[index]['id']),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Hero(
                                tag: value.allrestauran[index]['pictureId'],
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  height: 189,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://restaurant-api.dicoding.dev/images/medium/" +
                                                value.allrestauran[index]
                                                    ['pictureId']),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        value.allrestauran[index]['name'],
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        value.allrestauran[index]['city'],
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w100),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(value.allrestauran[index]
                                                  ['rating']
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
                    );
                  })),
    );
  }
}
