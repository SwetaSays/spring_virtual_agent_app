
import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../services/local_storage.dart';
import '../services/genai_service.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/agent_creator_dialog.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [];
  final TextEditingController controller = TextEditingController();
  String agentName = 'Agent';
  String persona = 'Friendly AI Assistant';

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  Future<void> loadMessages() async {
    messages = await LocalStorageService.loadMessages();
    setState(() {});
  }

  void sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = Message(
      sender: 'You',
      content: text,
      timestamp: DateTime.now(),
    );
    setState(() => messages.add(userMsg));
    await LocalStorageService.saveMessages(messages);

    final botReply = await GenAIService.getReply(text, persona);
    final agentMsg = Message(
      sender: agentName,
      content: botReply,
      timestamp: DateTime.now(),
    );

    setState(() => messages.add(agentMsg));
    await LocalStorageService.saveMessages(messages);
  }

  void openAgentDialog() async {
    final result = await showDialog(
      context: context,
      builder: (_) => AgentCreatorDialog(),
    );

    if (result != null) {
      setState(() {
        agentName = result['name'];
        persona = result['persona'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Virtual Agent Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (_, i) => ChatBubble(message: messages[i]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: "Type a message..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(controller.text);
                    controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 40.0,
        ), 
        child: FloatingActionButton(
          onPressed: openAgentDialog,
          child: Icon(Icons.person_add),
        ),
      ),
    );
  }
}
