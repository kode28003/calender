import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calender/apps/message.dart';

class MessageFirestore {
  static final ref =
      FirebaseFirestore.instance.collection('SDGs_Calendar/v0/sns');

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
  Future<void> sleep()async{
    await  Future.delayed(new Duration(milliseconds: 300));
    notifyListeners();
  }
  void refresh(){
    notifyListeners();
  }
}