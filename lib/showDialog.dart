import 'package:flutter/material.dart';


class Dialog extends StatelessWidget {
  const Dialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  showDialog(
        context: context,
        builder: (BuildContext context) {
          AlertDialog(
            title: Text('Error'),
            content: Text('Oops!! try again'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text('Cancel')),


              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('Ok')),
            ],
          );
        }
    );
  }
}





