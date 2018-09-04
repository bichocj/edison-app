import '../../data/rest_ds.dart';
import 'package:flutterapp/models/quote.dart';

abstract class OverdueFeesContract {
  void onOverdueFeesSuccess(List<Quote> quotes);
  void onOverdueFeesError(String errorTxt);
}

class OverdueFeesScreenPresenter {
  String authToken;
  OverdueFeesContract _view;
  RestDatasource api = new RestDatasource();
  OverdueFeesScreenPresenter(this._view, this.authToken);

  requestOverdueFees() {
    try {
      api
          .getOverdueQuotes(this.authToken)
          .then((List<Quote> quote) {
        print(quote);
        _view.onOverdueFeesSuccess(quote);
      }).catchError(
              (handleError) => _view.onOverdueFeesError(handleError.message));
    } catch (e) {
      print(e.toString());
    }
  }
}
