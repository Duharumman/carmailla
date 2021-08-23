import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yellow_carmailla/App/common_widgets/show_alert_dialog.dart';
import 'package:yellow_carmailla/App/services/auth_provider.dart';
import 'package:yellow_carmailla/App/sign_in/loginButton.dart';

import 'validators.dart';

enum EmailSignInFromType { signIn, register }

class EmailSginINForm extends StatefulWidget with EmailAndPasswordValidator {
  @override
  _EmailSginINFormState createState() => _EmailSginINFormState();
}

class _EmailSginINFormState extends State<EmailSginINForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  EmailSignInFromType _formType = EmailSignInFromType.signIn;

  bool _submitted = false;
  bool _isLoading = false;

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = AuthProvider.of(context);

      if (_formType == EmailSignInFromType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }

      Navigator.of(context).pop();
    } catch (e) {
      showAlertDialog(context,
          title: 'Sign in failed',
          content: e.toString(),
          defaultActionText: 'OK');
    } finally {
      _isLoading = false;
    }
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFromType.signIn
          ? EmailSignInFromType.register
          : EmailSignInFromType.signIn;
    });
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFromType.signIn
        ? 'Sign In'
        : 'Creat an account';
    final secondaryText = _formType == EmailSignInFromType.signIn
        ? 'Need an account? Register'
        : 'Have an account?  Sign in';

    bool submitEnabled = widget.emailValidator.isVaild(_email) &&
        widget.passwordValidator.isVaild(_password) &&
        !_isLoading;
    bool showErrorTextemail =
        _submitted && !widget.emailValidator.isVaild(_email);
    bool showErrorTextPassword =
        _submitted && !widget.passwordValidator.isVaild(_password);

    return [
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test',
          prefixIcon: Icon(Icons.mail),
          errorText: showErrorTextemail ? widget.invalidEmailErrorText : null,
          enabled: _isLoading == false,
        ),
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onChanged: (email) => _updateState(),
      ),
      SizedBox(height: 20),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(Icons.visibility),
          errorText:
              showErrorTextPassword ? widget.invalidPasswordErrorText : null,
          enabled: _isLoading == false,
        ),
        textInputAction: TextInputAction.done,
        obscureText: true,
        onChanged: (password) => _updateState(),
      ),
      SizedBox(height: 20),
      Container(
        width: double.infinity,
        height: 50,
        child: LogInButton(
          text: primaryText,
          textColor: Colors.white,
          color: Colors.amberAccent,
          onPressed: submitEnabled ? _submit : null, //_singInAnonymously,
          icon: Icon(
            Icons.login_rounded,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
      // ignore: deprecated_member_use
      FlatButton(
          onPressed: !_isLoading ? _toggleFormType : null,
          child: Text(secondaryText)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildChildren(),
        ));
  }

  _updateState() {
    setState(() {});
  }
}
