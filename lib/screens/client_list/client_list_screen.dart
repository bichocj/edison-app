import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'client_detail.dart';
import 'package:flutterapp/screens/client_list/client_list_screen_presenter.dart';
import 'package:flutterapp/models/client.dart';

class SearchList extends StatefulWidget {
  static String tag = 'clients';

  SearchList({ Key key }) : super(key: key);

  @override
  _SearchListState createState() => new _SearchListState();

}

class _SearchListState extends State<SearchList> implements ClientListScreenContract{
  Widget appBarTitle = new Text(
    "Lista de Clientes", style: new TextStyle(color: Colors.white),);
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _isSearching;
  String _searchText = "";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
	SharedPreferences _sharedPreferences;


  ClientListScreenPresenter _presenter;


  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      }else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });

    _fetchSessionAndNavigate();
  }

  _fetchSessionAndNavigate() async {
		_sharedPreferences = await _prefs;
		String authToken = _sharedPreferences.getString('auth_token');
    print(authToken);
    print(authToken);
    _presenter = new ClientListScreenPresenter(this, authToken);
    _presenter.requestClientList();
  }

  @override
  void onClientListSuccess(List<Client> clients){    
    _list.clear();
    for(Client client in clients){
      _list.add('${client.name} ${client.lastname}');
    }
    
  }

  @override
  void onClientListError(String errorTxt){
    int i=0;
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    init();
  }

  void init() {
    _list = List();
    _list.add("Alison Perez");
    _list.add("Alberto Plaza");
    _list.add("Arturo Anibal");
    _list.add("Bruno Armando");
    _list.add("Brizette Jimenez");
    _list.add("Carlos Gutierrez");
    _list.add("Deysi Hinostroza");
    _list.add("Laura Huarcallo");
    _list.add("Walter Hilar");
    _list.add("Jhon Pampa");
    _list.add("Ximena Hoyos");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _isSearching ? _buildSearchList() : _buildList(),
      ),
    );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => new ChildItem(contact, this._presenter)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => new ChildItem(contact, this._presenter))
          .toList();
    }
    else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => new ChildItem(contact, this._presenter))
          .toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                this.appBarTitle = new TextField(
                  controller: _searchQuery,
                  style: new TextStyle(
                    color: Colors.white,

                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
        ]
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text("Lista de Clientes", style: new TextStyle(color: Colors.white),);
      _isSearching = false;
      _searchQuery.clear();
    });
  }
}

class ChildItem extends StatelessWidget {
  final String name;
  final ClientListScreenPresenter _presenter;

  ChildItem(this.name, this._presenter);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
        title: new Text(this.name),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          // Navigator.of(context).pushNamed(ClientDetail.tag);
          this._presenter.requestClientList();
        }
    );
  }

}