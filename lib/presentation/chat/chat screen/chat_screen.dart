import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:yoursportz/utils/color.dart';

const String websocketUrl = "https://yoursportzbackend.azurewebsites.net";
String? username = "testUser"; // Default values for testing
String? userDp = "testDp.png";

class ChatScreen extends StatefulWidget {
  final String teamName;
  final String teamLogo;
  final String chatId;
  final String phone;

  const ChatScreen({
    super.key,
    required this.teamName,
    required this.teamLogo,
    required this.chatId,
    required this.phone,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessageModel> _messages = [];
  bool _isLoading = true;
  String? _errorMessage;
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    socket = IO.io(websocketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print("Connected to WebSocket server");
      _fetchChat();
    });

    socket.on('chat', (data) {
      print("Received chat data: $data");
      setState(() {
        if (data != null && data.isNotEmpty) {
          List<ChatMessageModel> newMessages = List<ChatMessageModel>.from(
            data.map((item) => ChatMessageModel.fromJson(item)),
          );
          _messages.addAll(newMessages);
        }
        _isLoading = false;
      });
    });

    socket.on('updatedChat', (data) {
      print("Received updatedChat data: $data");
      setState(() {
        if (data != null && data.isNotEmpty) {
          List<ChatMessageModel> newMessages = List<ChatMessageModel>.from(
            data.map((item) => ChatMessageModel.fromJson(item)),
          );

          // Add new messages if they are not already in the list
          _messages.addAll(newMessages.where((message) => !_messages
              .any((existingMessage) => existingMessage.id == message.id)));
        }
        _isLoading = false;
      });
    });

    socket.onConnectError((data) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Connection Error";
      });
    });

    socket.onDisconnect((_) {
      print("Disconnected from WebSocket server");
    });
  }

  void _fetchChat() {
    print("Fetching chat with chatId: ${widget.chatId}");
    socket.emit('fetchChat', {'chatId': widget.chatId});
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    final message = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: _controller.text,
      isMe: true, // Ensure the message is marked as sent by the user
      time: DateTime.now(),
      phone: widget.phone,
      dp: userDp ?? '', // Include the dp parameter
    );

    print("Sending message: ${message.toJson()}");

    setState(() {
      _messages.add(message);
    });

    socket.emit('message', {
      'chatId': widget.chatId,
      'message': {
        'phone': widget.phone,
        'name': username,
        'dp': userDp ?? '',
        'text': message.message,
        'time': DateTime.now().toIso8601String(),
      }
    });

    _controller.clear();
  }

  @override
  void dispose() {
    socket.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          appBar(context, widget.teamName, widget.teamLogo),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Center(child: Text('Error: $_errorMessage'))
                    : _messages.isEmpty
                        ? const Center(child: Text('No messages found'))
                        : ListView.builder(
                            itemCount: _messages.length,
                            itemBuilder: (context, index) {
                              final message = _messages[index];
                              print("Rendering message: ${message.message}");
                              return ChatMessage(
                                message: message.message,
                                isMe: message.phone == widget.phone,
                                time: message.getFormattedTime(),
                                dp: message.dp, // Pass dp to ChatMessage
                              );
                            },
                          ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;
  final String dp;

  const ChatMessage({
    super.key,
    required this.message,
    required this.isMe,
    required this.time,
    required this.dp,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isMe ? TColor.greyText : TColor.msgbck.withOpacity(0.6);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe)
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: Image.network(
                        dp.isEmpty ? '' : dp,
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/images/app_logo.png',
                            height: 30,
                            width: 30,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bgColor,
                  border:
                      Border.all(color: isMe ? TColor.greyText : TColor.msgbck),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: Radius.circular(isMe ? 20 : 0),
                    bottomRight: Radius.circular(isMe ? 0 : 20),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
          Padding(
            padding: isMe
                ? const EdgeInsets.all(0)
                : const EdgeInsets.only(left: 38),
            child: Text(
              time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessageModel {
  final String id;
  final String message;
  final bool isMe;
  final DateTime time;
  final String phone;
  final String dp; // Add dp field

  ChatMessageModel({
    required this.id,
    required this.message,
    required this.isMe,
    required this.time,
    required this.phone,
    required this.dp,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['_id'] ?? '',
      message: json['text'] ?? 'No message',
      isMe: json['phone'] == username,
      time: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      phone: json['phone'] ?? '',
      dp: json['dp'] ?? '', // Fetch dp from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'text': message,
      'phone': phone,
      'createdAt': time.toIso8601String(),
      'dp': dp, // Include dp in JSON
    };
  }

  String getFormattedTime() {
    return DateFormat('hh:mm a').format(time);
  }
}

class DateWidget extends StatelessWidget {
  final String date;
  const DateWidget({super.key, required this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          date,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}

/// appbar widget
Widget appBar(BuildContext context, String teamName, String teamLogo) {
  return Container(
    padding: const EdgeInsets.only(top: 30),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: TColor.greyText,
                )),
            CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                    child: Image.network(
                  teamLogo,
                  height: 50,
                  width: 50,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/images/app_logo.png',
                      height: 50,
                    );
                  },
                ))),
            const SizedBox(
              width: 10,
            ),
            Text(teamName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: TColor.greyText,
                )),
          ],
        ),
        Divider(
          color: Colors.grey[300],
          thickness: 1.2,
        )
      ],
    ),
  );
}
