import 'package:flutter/widgets.dart';
import 'package:yellow_carmailla/App/services/authentication_service.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({@required this.auth, @required this.child});

  final AuthBase auth;
  final Widget child;
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
  static AuthBase of(BuildContext context) {
    AuthProvider provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider.auth;
  }
}
