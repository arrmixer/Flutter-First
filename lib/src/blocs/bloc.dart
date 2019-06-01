import 'dart:async';
import 'package:login_bloc/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  final _emailController = new BehaviorSubject<String>();
  final _passwordController = new BehaviorSubject<String>();

  Function(String) get changeEmail => _emailController.sink.add; //add
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail); //retrieve
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (e, p) => true);

  submit(){
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print("Email is $validEmail");
    print("Password is $validPassword");
  }
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}