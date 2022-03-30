import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/providers/all_restaurant.dart';

class AddReview extends StatefulWidget {
  final String? id;
  const AddReview({Key? key, this.id}) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  TextEditingController username = TextEditingController();
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map<String, String> data = {};
    final dataProvider = Provider.of<RestauranProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: const BoxDecoration(color: Colors.amber, boxShadow: []),
      child: Column(
        children: [
          Form(
            child: Column(
              children: [
                TextField(
                  controller: username,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                      labelText: 'Name', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  maxLines: 7,
                  cursorColor: Colors.black,
                  controller: comment,
                  decoration: const InputDecoration(
                      labelText: 'Comment', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: (() {
                    data['id'] = widget.id!;
                    data['name'] = username.text.toString();
                    data['review'] = comment.text.toString();
                    dataProvider.addReview(data);
                    username.clear();
                    comment.clear();
                  }),
                  child: const Text("Comment"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
