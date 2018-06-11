import 'package:coremvp/dependency_injection.dart';
import 'package:coremvp/modules/item.dart';

abstract class ItemContract {
  void onLoadItemSuccess(List<Item> item);
  void onLoadError(String error);
}

class ItemPresenter {
  ItemContract _view;
  ItemRepository _repository;

  ItemPresenter(this._view) {
    _repository = new Injector().itemRepository;
  }

  void loadItem() {
    _repository
        .fetchItem()
        .then((d) => _view.onLoadItemSuccess(d))
        .catchError((e) => _view.onLoadError(e));
  }
}
