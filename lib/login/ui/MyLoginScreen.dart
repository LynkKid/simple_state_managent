import 'package:flutter/material.dart';
import 'package:my_state_management_app/catalog/ui/MyCatalog.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff235595),
        title: const Text(
          'Welcome',
          style: TextStyle(
              color: Colors.white, fontSize: 46, fontWeight: FontWeight.normal),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'Login',
                style: TextStyle(color: Color(0xff235595), fontSize: 26),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff235595), // Màu border
                  width: 1.0, // Độ dày border
                ),
                borderRadius: BorderRadius.circular(5.0), // Bo tròn góc
              ),
              child: TextFormField(
                controller: loginController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Password',
                style: TextStyle(color: Color(0xff235595), fontSize: 26),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff235595), // Màu border
                  width: 1.0, // Độ dày border
                ),
                borderRadius: BorderRadius.circular(5.0), // Bo tròn góc
              ),
              child: TextFormField(
                controller: passController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10.0),
                ),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            const Spacer(),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyCatalog()),
                  );
                },
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff235595),
                    borderRadius: BorderRadius.circular(5.0), // Bo tròn góc
                  ),
                  child: const Center(
                      child: Text(
                    'Enter',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
            ),
            const SizedBox(height: 150)
          ],
        ),
      ),
    );
  }
}
