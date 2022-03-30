import 'package:flutter_test/flutter_test.dart';
import 'package:submission1/model/favorite.dart';
import 'package:submission1/providers/all_restaurant.dart';

void main() {
  test("model parsing data", () {
    var restaurant = Restaurant(
        id: '1',
        name: "test",
        description: 'test model',
        pictureId: '12',
        city: 'test',
        rating: 3.5);

    const jsonData = {
      'id': 's1knt6za9kkfw1e867',
      'name': 'Kafe Kita',
      'description':
          'Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,',
      'pictureId': '25',
      'city': 'Gorontalo',
      'rating': 4
    };
    Restaurant result = Restaurant.fromMap(jsonData);
    expect(restaurant.id, '1');
    expect(restaurant.name, 'test');
    expect(restaurant.description, 'test model');
    expect(restaurant.pictureId, '12');
    expect(restaurant.city, 'test');
    expect(restaurant.rating, 3.5);
  });
}
