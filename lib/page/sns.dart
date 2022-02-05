import 'package:calender/data/storage.dart';
import 'package:calender/apps/firestore.dart';
import 'package:calender/page/home.dart';
import 'package:calender/page/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:calender/apps/message.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

ScrollController _scrollController = ScrollController();
final messageTextInputCtl = TextEditingController();
BuildContext? context1;

class SnsPage extends ConsumerWidget {
  const SnsPage({Key? key}) : super(key: key);
  static const String route = '/home/sns';

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent +
          MediaQuery.of(context1!).viewInsets.bottom,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.watch(bikeRepositoryProvider);
    context1 = context;
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: Colors.brown.shade50,
        navigationBar: CupertinoNavigationBar(
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
              Navigator.pushNamed(context, HomePage.route);
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
              Navigator.pushNamed(context, ToDoPage.route);
            },
          ),
        ),
        child: Stack(
          children: [
            _buildMessage(context, ref),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    color: Colors.black54,
                    child: Column(children: [
                      Form(
                          //key: _formKey,
                          key: key,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                    child: TextFormField(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  controller: messageTextInputCtl,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  minLines: 1,
                                  decoration: const InputDecoration(
                                    hintText: 'メッセージを入力してください',
                                    hintStyle: TextStyle(color: Colors.white),
                                  ),
                                  onTap: () {
                                    // タイマーを入れてキーボード分スクロールする様に
                                    Timer(
                                      Duration(milliseconds: 200),
                                      scrollToBottom,
                                    );
                                    context1 = context;
                                  },
                                )),
                                Material(
                                  color: Colors.black12,
                                  child: Center(
                                    child: Ink(
                                      decoration: const ShapeDecoration(
                                        color: Colors.black54,
                                        shape: CircleBorder(),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.send),
                                        color: Colors.white,
                                        onPressed: () {
                                          if (messageTextInputCtl.value
                                                  .isComposingRangeValid ==
                                              true) {
                                            addSetMessage(
                                                messageTextInputCtl.text);
                                          }
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

  Widget _buildMessage(BuildContext context, WidgetRef ref) {
    //ref.watch(bikeRepositoryProvider);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('SDGs_Calendar/v0/sns')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            print("よくわからんです");
            return Container();
          } else {
            print("---- 検知してますよ ----");
            //いいね！！
            return AnimationConfiguration.staggeredList(
              position: 10,
              duration: const Duration(milliseconds: 255),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      return GestureDetector(
                        onLongPress: () async {
                          document['name'] == myName
                              ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: Text("このテキストをどうしますか？"),
                                      children: [
                                        SimpleDialogOption(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection(
                                                    'SDGs_Calendar/v0/sns')
                                                .doc(document.id)
                                                .delete();
                                            Navigator.pop(context);
                                          },
                                          child: Text("削除する"),
                                        ),
                                        SimpleDialogOption(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("戻る"),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : null;
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9)),
                          margin: document['name'] == myName
                              ? EdgeInsets.only(
                                  top: 5.0, left: 90.0, bottom: 5.0, right: 8.0)
                              : EdgeInsets.only(
                                  top: 5.0,
                                  left: 8.0,
                                  bottom: 5.0,
                                  right: 90.0),
                          child: ListTile(
                            title: Text(document['message']),
                            subtitle: Row(
                                mainAxisAlignment: document['name'] == myName
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    // backgroundImage: NetworkImage(ChatMessageModel
                                    //     .dummyData[index].avatarUrl),
                                    radius: 7.0,
                                  ),
                                  Text(" " +
                                      document['name'] +
                                      "  " +
                                      document['datetime']),
                                ]),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          }
        });
  }
}

Future<void> ak(DocumentSnapshot document) async {
  FirebaseFirestore.instance
      .collection('SDGs_Calendar/v0/sns')
      .doc(document.id)
      .delete();
}
