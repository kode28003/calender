import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calender/page/sns.dart';

class ChatMessageModel {
  final String avatarUrl;
  final String name;
  final String datetime;
  final String message;
  final bool isMine;

  ChatMessageModel(
      {required this.avatarUrl, required this.name, required this.datetime, required this.message, required this.isMine});

  static final List<ChatMessageModel> dummyData = [
    ChatMessageModel(
      avatarUrl: "https://randomuser.me/api/portraits/men/83.jpg",
      name: "モーフィアス",
      datetime: "20:18",
      message: "これが最後のチャンスだ。後戻りはできない",
      isMine: false,
    ),
    ChatMessageModel(
      avatarUrl: "https://randomuser.me/api/portraits/men/49.jpg",
      name: "自分",
      datetime: "20:30",
      message: "どういうことだ？",
      isMine: true,
    ),
    ChatMessageModel(
      avatarUrl: "https://randomuser.me/api/portraits/men/83.jpg",
      name: "モーフィアス",
      datetime: "20:34",
      message: "青い錠剤を飲めば、この話はなかったことになりベッドで目覚め元の日常に戻る。赤い錠剤を飲めば、この不思議な世界の真実へ連れて行こう",
      isMine: false,
    ),
    ChatMessageModel(
      avatarUrl: "https://randomuser.me/api/portraits/men/49.jpg",
      name: "自分",
      datetime: "20:45",
      message: "赤を飲むか。。。。",
      isMine: true,
    ),
    ChatMessageModel(
      avatarUrl: "https://randomuser.me/api/portraits/men/83.jpg",
      name: "モーフィアス",
      datetime: "20:46",
      message: "忘れるな・・・。私が見せるのは真実だ。純粋な真実だ",
      isMine: false,
    ),
  ];
}

void addMessage(String message) {
  ChatMessageModel.dummyData.add(
      ChatMessageModel(
        avatarUrl: "https://randomuser.me/api/portraits/men/49.jpg",
        name: "自分",
        datetime: "20:34",
        message: message,
        isMine: true,
      )
  );
}