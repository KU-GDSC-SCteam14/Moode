import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


//final GoogleSignIn googleSignIn= GoogleSignIn();
//Future<void> signInWithGoogle() async {
//  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn(); final GoogleSignInAuthentication googleSignInAuthentication =
//    await googleSignInAccount!.authentication;

//  final OAuthCredential credential = GoogleAuthProvider.credential(
//  );
//  accessToken: googleSignInAuthentication.accessToken;
//  idToken: googleSignInAuthentication.idToken;
//  final UserCredential userCredential =
//    await FirebaseAuth.instance.signInWithCredential(credential);
//  final User user = userCredential.user!;
//}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginGoogle(),
    );
  }
}

class LoginModal extends StatefulWidget{
  @override
  _LoginModalState createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal>{

}

class LoginApple extends StatefulWidget{
  @override
  _LoginAppleState createState() => _LoginAppleState();
}

class _LoginAppleState extends State<LoginApple>{

}

class LoginGoogle extends StatefulWidget {
  @override
  _LoginGoogleState createState() => _LoginGoogleState();
}

class _LoginGoogleState extends State<LoginGoogle> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      // 로그인 성공 시 수행할 작업 추가
      print("로그인 성공");
    } catch (error) {
      print("로그인 실패: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/splash.jpg',
                width: 200,
              ),
              ElevatedButton(
                onPressed: _handleSignIn,
                child: Text('Get Started'),
              ),
              ElevatedButton(
                onPressed: _handleSignIn,
                child: Text('Log in',
                ),
              ),
              ElevatedButton(
                onPressed: _handleSignIn,
                child: Text('Google 로그인'),
              ),
            ],
          )
      ),
    );
  }
}



