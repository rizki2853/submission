// ignore_for_file: file_names, must_be_immutable
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1/page/Home/Widgets/navbar.dart';
import 'package:submission1/page/Home/Widgets/restauran_list_item.dart';
import 'package:submission1/providers/all_restaurant.dart';
import 'package:submission1/utils/notification_helper.dart';

class HomePage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var query;
  HomePage({Key? key, this.query = ""}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var rand = Random();

  @override
  void initState() {
    super.initState();
    NotificationHelper.init(initScheduled: true);
    listenNotification();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<RestauranProvider>(context, listen: false);
    dataProvider.restauranAPI();
    return Consumer<RestauranProvider>(builder: (context, value, child) {
      if (!value.internet) {
        return Scaffold(
            drawer: const Navbar(),
            appBar: appbar(context),
            body: const Center(child: Text('No internet')));
      } else if (value.getState == ResultState.loading) {
        return Scaffold(
            drawer: const Navbar(),
            appBar: appbar(context),
            body: const Center(child: CircularProgressIndicator()));
      } else {
        startNotification(value.restauran);
        return Scaffold(
          drawer: const Navbar(),
          appBar: appbar(context),
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

  AppBar appbar(BuildContext context) {
    return AppBar(
      title: const Text('Restauran'),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search', arguments: 'a');
            },
          ),
        ),
      ],
    );
  }

  void listenNotification() =>
      NotificationHelper.selectNotificationSubject.stream.listen(
        (String? payload) =>
            Navigator.pushNamed(context, '/detail', arguments: payload),
      );

  void startNotification(List<dynamic> restaurant) {
    int random = rand.nextInt(restaurant.length);
    NotificationHelper.showScheduleNotification(
      title: restaurant[random]['name'],
      body: restaurant[random]['city'],
      payload: restaurant[random]['id'],
      scheduledData: DateTime.now(),
    );
  }
}
