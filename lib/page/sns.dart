import 'package:calender/data/storage.dart';
import 'package:calender/apps/firestore.dart';
import 'package:calender/page/home.dart';
import 'package:calender/page/todo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:calender/apps/message.dart';

ScrollController _scrollController = ScrollController();
BuildContext? context1;

class SnsPage extends ConsumerWidget {
  const SnsPage({Key? key}) : super(key: key);
  static const String route = '/sns';

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent +
          MediaQuery.of(context1!).viewInsets.bottom,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageTextInputCtl = TextEditingController();
    final _formKey = GlobalKey();
    context1 = context;

    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: Colors.brown.shade50,
        navigationBar: new CupertinoNavigationBar(
          backgroundColor: Colors.brown.shade50,
          middle: const Text('SDGs SNS'),
          leading: CupertinoButton(
            padding: EdgeInsets.fromLTRB(0, 6, 10, 5),
            child: Icon(
              CupertinoIcons.back,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, ToDoPage.route);
            },
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Icon(
              CupertinoIcons.forward,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, HomePage.route);
            },
          ),
        ),
        child: Stack(
          children: [
            GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                      top: 10.0, right: 5.0, bottom: 50.0, left: 5.0),
                  children: [
                    for (int index = 0;
                        index < ChatMessageModel.dummyData.length;
                        index++)
                      Card(
                        margin: ChatMessageModel.dummyData[index].isMine
                            ? EdgeInsets.only(
                                top: 5.0, left: 90.0, bottom: 5.0, right: 8.0)
                            : EdgeInsets.only(
                                top: 5.0, left: 8.0, bottom: 5.0, right: 90.0),
                        child: ListTile(
                          title:
                              Text(ChatMessageModel.dummyData[index].message),
                          subtitle: Row(
                              mainAxisAlignment:
                                  ChatMessageModel.dummyData[index].isMine
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(ChatMessageModel
                                      .dummyData[index].avatarUrl),
                                  radius: 10.0,
                                ),
                                Text(ChatMessageModel.dummyData[index].name +
                                    ChatMessageModel.dummyData[index].datetime),
                              ]),
                        ),
                      ),
                  ],
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                new Container(
                    color: Colors.green[100],
                    child: Column(children: [
                      Form(
                          key: _formKey,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                    child: TextFormField(
                                  controller: messageTextInputCtl,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  decoration: const InputDecoration(
                                    hintText: 'メッセージを入力してください',
                                  ),
                                  onTap: () {
                                    // タイマーを入れてキーボード分スクロールする様に
                                    Timer(
                                      Duration(milliseconds: 200),
                                      scrollToBottom,
                                    );
                                  },
                                )),
                                Material(
                                  color: Colors.green[100],
                                  child: Center(
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        color: Colors.green,
                                        shape: CircleBorder(),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.send),
                                        color: Colors.white,
                                        onPressed: () {
                                          addMessage(messageTextInputCtl.text);
                                          FocusScope.of(context).unfocus();
                                          messageTextInputCtl.clear();
                                          Timer(
                                            Duration(milliseconds: 200),
                                            scrollToBottom,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              ])),
                    ])),
              ],
            )
          ],
        ),
      ),
    );
  }
}
