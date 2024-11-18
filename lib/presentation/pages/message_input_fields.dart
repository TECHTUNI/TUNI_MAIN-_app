import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni/core/provider/gp_tuni_provider.dart';


class MessageInputField extends StatefulWidget {
  @override
  _MessageInputFieldState createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onSubmitted: (text) {
                if (text.isNotEmpty) {
                  Provider.of<GPTuniProvider>(context, listen: false)
                      .addAnswer(text);
                  _controller.clear();
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                Provider.of<GPTuniProvider>(context, listen: false)
                    .addAnswer(_controller.text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
