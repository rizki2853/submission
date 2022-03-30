import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/providers/all_restaurant.dart';

class ReviewList extends StatelessWidget {
  final String? id;
  const ReviewList({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<RestauranProvider>(context, listen: false);
    dataProvider.detailRestauran(id!);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.50,
      child: Consumer<RestauranProvider>(
        builder: (context, value, child) => ListView.separated(
          itemBuilder: ((context, index) {
            return Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.review[index]['name'],
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      value.review[index]['date'],
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w100),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(value.review[index]['review']),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            );
          }),
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: value.review.length,
        ),
      ),
    );
  }
}
