import 'package:actividad1c2/feature/publication/presentation/custom_widgets/publication.dart';
import 'package:flutter/material.dart';
import 'custom_widgets/input.dart'; // Make sure the path is correct

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key); // Corrected the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff222222),
        title: PreferredSize(
          preferredSize: Size.fromHeight(60), // Define a height
          child: Center(child: MessageFieldBox()), // Center your input field
        ),
      ),
      body: 
    
      _chatView(),
      // ... rest of your Scaffold
    );
  }
}


class _chatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(  
        color: Color(0xff222222), 
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return publication();  
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

