import 'package:flutter/material.dart';

class AgentCreatorDialog extends StatefulWidget {
  const AgentCreatorDialog({super.key});

  @override
  _AgentCreatorDialogState createState() => _AgentCreatorDialogState();
}

class _AgentCreatorDialogState extends State<AgentCreatorDialog> {
  final nameController = TextEditingController();
  final personaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Agent'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameController, decoration: InputDecoration(labelText: 'Agent Name')),
          TextField(controller: personaController, decoration: InputDecoration(labelText: 'Agent Persona')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, {
              'name': nameController.text,
              'persona': personaController.text,
            });
          },
          child: Text('Create'),
        )
      ],
    );
  }
}
