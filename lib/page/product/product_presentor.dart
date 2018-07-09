import 'package:coremvp/dependency_injection.dart';
import 'package:coremvp/modules/product.dart';

abstract class ProductListViewContract {
  void onLoadProductComplete(List<Product> product);
  void onLoadProductError();
}

class ProductListPresentor {
  ProductListViewContract _view;
  ProductRepository _repository;
  ProductListPresentor(this._view) {
    _repository = new Injector().productRepository;
  }

  void loadProduct() {
    _repository
        .fetchProduct()
        .then((c) => _view.onLoadProductComplete(c))
        .catchError((onError) => _view.onLoadProductError());
  }
}
