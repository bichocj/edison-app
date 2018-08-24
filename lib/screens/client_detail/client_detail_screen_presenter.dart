import '../../data/rest_ds.dart';
import 'package:flutterapp/models/client_detail.dart';

abstract class ClientDetailScreenContract {
  void onClientDetailSuccess(List<ClientDetail> client_detail); //Si no es List que es?
  void onClientDetailError(String errorTxt);
}

class ClientDetailScreenPresenter {
  String authToken;
  ClientDetailScreenContract _view;
  RestDatasource api = new RestDatasource();
  ClientDetailScreenPresenter(this._view, this.authToken);

  requestClientDetails() {
    try{
      api.getClientDetail(this.authToken).then((List<ClientDetail> client_detail) {
        print(client_detail);
        _view.onClientDetailSuccess(client_detail);
      }).catchError((handleError) =>
          _view.onClientDetailError(handleError)
      );
    }catch(e){
      print(e.toString());
    }
  }

}