import 'package:flutter/material.dart';
import 'package:flutter_arch/common/widget/widget_form_login.dart';
import 'package:provider/provider.dart';

// 0: create model class which extends ChangeNotifier
class UserLogin with ChangeNotifier {
  String _user;
  String _pass;
  bool _result;

  String get user => _user;

  String get pass => _pass;

  bool get result => _result;

  void checkCredentials(String user, String password) {
    _user = user;
    _pass = password;

    if (user != null &&
        user.isNotEmpty &&
        password != null &&
        password.isNotEmpty) {
      _result = true;
      // user/pass check goes here
    } else
      _result = false;

    notifyListeners();
  }
}

class ProviderExamplePage extends StatefulWidget {
  ProviderExamplePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProviderExamplePageState createState() => _ProviderExamplePageState();
}

class _ProviderExamplePageState extends State<ProviderExamplePage> {
  @override
  Widget build(BuildContext context) {
    // 1: provide state
    return MultiProvider(
      providers: [ChangeNotifierProvider(builder: (context) => UserLogin())],
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginFormWidget(),
              ResultWidget(),
              ProgressWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class ResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserLogin>(builder: (context, userLogin, _) {
      final resultWidget = (userLogin.result != null)
          ? Text("Result: " + (userLogin.result ? "OK" : "WRONG"))
          : Text("");
      return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: resultWidget,
      );
    });
  }
}

class ProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userLogin = Provider.of<UserLogin>(context);
    String log = "";
    if (userLogin.result != null && userLogin.result)
      log = "Logging in: ${userLogin.user}";
    return Text(log);
  }
}