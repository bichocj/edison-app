import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/client_detail.dart';
import 'package:flutterapp/screens/quote_detail/quote_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterapp/screens/quote_list/client_quotes_screen_presenter.dart';
import 'package:flutterapp/models/quote.dart';

class QuotesList extends StatefulWidget {
  static String tag = 'quote';
  final int creditId;
  final ClientDetailModel client;
  QuotesList({Key key, this.creditId, this.client}) : super(key: key);

  @override
  _QuotesListState createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList>
    implements QuotesScreenContract {
  List<Quote> _quotes;
  bool _success;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  QuotesScreenPresenter _presenter;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = _sharedPreferences.getString('auth_token');
    _presenter = new QuotesScreenPresenter(this, authToken);
    _presenter.requestQuotes(widget.creditId);
  }

  @override
  void initState() {
    super.initState();
    _success = false;
    _fetchSessionAndNavigate();
  }

  @override
  void onQuotesSuccess(List<Quote> quote) {
    setState(() {
      _success = true;
      _quotes = quote;
    });
  }

  @override
  void onQuotesError(String errorTxt) {
    print(errorTxt);
  }

  List<QuoteTitle> _buildList(client) {
    return _quotes
        .map((quote) => new QuoteTitle(quote, this._presenter, client))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.canvasColor,
      appBar: new AppBar(
        title: Text('Coutas'),
        centerTitle: true,
      ),
      body: _success
          ? new ListView(children: _buildList(widget.client))
          : new Center(
        child:new CircularProgressIndicator(),
      )
    );
  }
}

class QuoteTitle extends StatelessWidget {
  final Quote _quote;
  final QuotesScreenPresenter _presenter;
  final ClientDetailModel _client;
  const QuoteTitle(this._quote, this._presenter, this._client);
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Color _quoteColor;
    if(this._quote.has_complete) {
      _quoteColor = Colors.grey;
    } else {
      if(this._quote.days_late == 0) {
        _quoteColor = Colors.green;
      } else {
        _quoteColor = Colors.red;
      }
    }
    return new Container(
      margin: new EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 4.0),
          ),
        ],
      ),
      child: new ListTile(
        leading: new CircleAvatar(
          backgroundColor:
              _quoteColor
        ),
        title: new Text(
          this._quote.charge_at,
          style: new TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: new Text("S/. ${this._quote.amount_debt.toStringAsFixed(2)}"),
        trailing: new Icon(Icons.arrow_right),
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new QuoteDetail(
                      quote: this._quote, client: this._client)));
        },
      ),
    );
  }
}