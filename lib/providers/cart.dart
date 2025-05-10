import 'package:cantika_flutter/models/cart_item.dart';
import 'package:flutter/widgets.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get jumlah {
    return _items.length;
  }

  double get totalHarga {
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.qty * cartItem.price;
    });
    return total;
  }

  void addCart(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      //Ketika sudah tersedia key product id
      _items.update(
        productId,
        (value) => CartItem(
          id: value.id,
          price: value.price,
          qty: value.qty + 1,
          title: value.title,
        ),
      );
    } else {
      //nambah product id baru
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          qty: 1,
          title: title,
        ),
      );
    }
    notifyListeners();
  }
}
