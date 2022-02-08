import 'package:calender/apps/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

import 'home.dart';

//入力された名前
String newUserEmail = "";
// 入力されたパスワード
String newUserPassword = "";
// 入力されたメールアドレス（ログイン）
String loginUserEmail = "";
// 入力されたパスワード（ログイン）
String loginUserPassword = "";
// 登録・ログインに関する情報を表示
String infoText = "";

class TopPage extends ConsumerWidget {
  const TopPage({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Scaffold(
      body: Center(
        child:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "ユーザー名"),
                onChanged: (String value) {
                  myName = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                  newUserEmail = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
                obscureText: true,
                onChanged: (String value) {
                  newUserPassword = value;
                },
              ),
              ElevatedButton(
                onPressed: () async{
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final UserCredential result =
                  await auth.createUserWithEmailAndPassword(
                    email: newUserEmail,
                    password: newUserPassword,
                  );
                  await auth.currentUser!.updateDisplayName(myName);
                  Navigator.pushNamed(context, HomePage.route);
                },
                child: Text("ユーザー登録"),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value) {
                    loginUserEmail = value;
                },

              ),
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
                obscureText: true,
                onChanged: (String value) {
                    loginUserPassword = value;
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                    await auth.signInWithEmailAndPassword(
                      email: loginUserEmail,
                      password: loginUserPassword,
                    );
                    // ログインに成功した場合

                    final User user = result.user!;
                    print("ログインOK：${user.displayName}");
                      infoText = "ログインOK：${user.email}";
                      myName=user.displayName!;
                    Navigator.pushNamed(context, HomePage.route);
                  } catch (e) {
                    // ログインに失敗した場合
                      infoText = "ログインNG：${e.toString()}";
                  }
                },
                child: Text("ログイン"),
              ),
              const SizedBox(height: 8),
              Text(infoText),
            ],
          ),
        ),
      ),
      ),
    );
  }
}