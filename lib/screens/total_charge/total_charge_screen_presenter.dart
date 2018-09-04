import '../../data/rest_ds.dart';
import 'package:flutterapp/models/fee.dart';

abstract class FeesScreenContract {
  void onFeesSuccess(List<Fee> fee);
  void onFeesError(String errorTxt);
}

class FeesScreenPresenter {
  String authToken;
  FeesScreenContract _view;
  RestDatasource api = new RestDatasource();
  FeesScreenPresenter(this._view, this.authToken);

  requestFees(created_at) {
    try {
      api
          .getFees(this.authToken, created_at)
          .then((List<Fee> fee) {
        print(fee);
        _view.onFeesSuccess(fee);
      }).catchError(
              (handleError) => _view.onFeesError(handleError.message));
    } catch (e) {
      print(e.toString());
    }
  }
}
