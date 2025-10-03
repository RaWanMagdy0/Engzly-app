
import 'package:flutter/material.dart';

class PackedBoxesCard extends StatefulWidget {
  const PackedBoxesCard({super.key});

  @override
  State<PackedBoxesCard> createState() => _PackedBoxesCardState();
}

class _PackedBoxesCardState extends State<PackedBoxesCard> {
  int count = 0;

  void _increment() => setState(() => count++);
  void _decrement() {
    if (count > 0) setState(() => count--);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.orange.shade50,
            child: const Icon(Icons.inventory, color: Colors.orange),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Packed Boxes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text("Weight below 10 Kg",
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: _decrement,
              ),
              Text(
                "$count",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: _increment,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
