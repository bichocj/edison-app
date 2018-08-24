import '../../data/rest_ds.dart';
import 'package:flutterapp/models/client_credit.dart';

abstract class ClientCreditsScreenContract {
  void onClientCreditsSuccess(List<ClientCredits> client_credits);
  void onClientCreditsError(String errorTxt);
}

class ClientCreditsScreenPresenter {
  String authToken;
  ClientCreditsScreenContract _view;
  RestDatasource api = new RestDatasource();
  ClientCreditsScreenPresenter(this._view, this.authToken);

  requestClientCredit() {
    try {
      api
          .getClientCredit(this.authToken)
          .then((List<ClientCredits> client_credits) {
        print(client_credits);
        _view.onClientCreditsSuccess(client_credits);
      }).catchError(
              (handleError) => _view.onClientCreditsError(handleError.message));
    } catch (e) {
      print(e.toString());
    }
  }
}
