import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender/apps/message.dart';

/*
final messageSnapshotStreamProvider =
    StreamProvider<QuerySnapshot<Map<String, dynamic>>>((ref) {
  Query<Map<String, dynamic>> query = MessageFirestore.ref;
  final startTime = DateTime.now().subtract(const Duration(minutes: 1));
  query = query.where('id', isGreaterThan: Timestamp.fromDate(startTime));
  return query.snapshots();
});

final _messageProvider = Provider.autoDispose<List<MessageCase>>((ref) {
  final asyncSnapshot = ref.watch(messageSnapshotStreamProvider);
  return asyncSnapshot.when(
      data: (snapshot) {
        final message = snapshot.docs.map((document) {
          //final data = doc.data();
          return MessageCase(
            name: document['name'],
            datetime: document['datetime'],
            message: document['message'],
          );
        });
        adding(message.toList());
        print("++++  変更を取得しました  ++++");
        print(message);
        return message.toList();
      },
      loading: () => [],
      error: (error, stackTrace) => []);
});

final messageProvider = Provider.autoDispose<Iterable<MessageCase>>((ref) {
  final messageDate=ref.watch(_messageProvider);
  //adding(messageDate); //こいつが入ると自動的に空白のリストが入ってしまう
  return messageDate;
}); // これをwatchしてListに入れる！
*/

class MessageFirestore {
  static final ref =
      FirebaseFirestore.instance.collection('SDGs_Calendar/v0/sns');

  static Future<String> addMessageList(MessageCase messageCase) async {
    final today = DateTime.now();
    final docRef = ref.doc();
    await docRef.set({
      'name': messageCase.name,
      'datetime': messageCase.datetime,
      'message': messageCase.message,
    }).then((_) => print('Message Added, ID : $docRef.id'));
    return docRef.id;
  }

  static Future addMessageListToBase(List<MessageCase> messageList)async{
    final today = DateTime.now();
    final docRef = ref.doc();
    await docRef.set({
      'name': messageList[messageList.length-1].name,
      'datetime': messageList[messageList.length-1].datetime,
      'message': messageList[messageList.length-1].message,
    }).then((_) => print('Message Added, ID : $docRef.id'));
  }

//以下がテストコード
  static Future testFirestore() async {
    final today = DateTime.now();
    final docRef = ref.doc();
    await docRef.set({
      'message': today,
    }).then((_) => print('セット完了'));
  }

  static Future addLastList(List<ChatMessageModel> dummyList)async{
    final today = DateTime.now();
    final docRef = ref.doc();
    await docRef.set({
      'name': dummyList[dummyList.length-1].name,
      'datetime': dummyList[dummyList.length-1].datetime,
      'message': dummyList[dummyList.length-1].message,
    }).then((_) => print('Message Added, ID : $docRef.id'));
  }
}

final bikeRepositoryProvider =
ChangeNotifierProvider((ref) => receiveRepository());

class receiveRepository extends ChangeNotifier {
  //List<MessageCase>? messageCase;
  Future<void> sleep()async{
    await  Future.delayed(new Duration(milliseconds: 300));
    notifyListeners();
  }
  void refresh(){
    notifyListeners();
  }
  void fetchPositions() async {
    // final QuerySnapshot snapshot =
    // await FirebaseFirestore.instance.collection('SDGs_Calendar/v0/sns').get();
    // final List messageData =
    // snapshot.docs.map((DocumentSnapshot document) async{
    //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      // if(MessageCase.messageList.length-1>2) {
      //   MessageCase.messageList.removeRange(
      //       2, MessageCase.messageList.length - 1);
      // }//リストを消す！！
      // if(MessageCase.messageList.length-1==2){
      //   MessageCase.messageList.removeLast();
      // }


      //MessageCase.messageList.clear();
      // MessageCase.messageList.add(MessageCase(
      //   name: "公式",
      //   message: "皆さん、SDGsな取り組みを記入してください",
      //   datetime: DateTime.now().month.toString()+"/"+DateTime.now().day.toString()+" / "+DateTime.now().hour.toString()+":"+DateTime.now().minute.toString(),
      // ));
      // MessageCase.messageList.add(MessageCase(
      // name: "kodai",
      // message: "全身古着コーデ",
      // datetime: DateTime.now().month.toString()+"/"+DateTime.now().day.toString()+" / "+DateTime.now().hour.toString()+":"+DateTime.now().minute.toString(),
      // ));

    notifyListeners();
  }
}