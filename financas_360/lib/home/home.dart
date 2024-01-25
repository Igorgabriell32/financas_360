import 'package:financas_360/home/enum/enum_mes.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  Widget meses() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: Mes.values.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color.fromRGBO(26, 19, 107, 0.973),
                        width: 5,
                      ),
                    ),
                  ),
                  width: 100,
                  height: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => {},
                        icon: Icon(
                          Icons.calendar_month_outlined,
                          color: Color.fromRGBO(37, 109, 133, 0.973),
                        ),
                      ),
                      Text(Mes.values[index].toString().split('.').last),
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(26, 19, 107, 0.973),
        title: Row(
          children: [
            Icon(
              Icons.attach_money,
              color: Colors.white,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Finanças',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            meses(),
          ],
        ),
      ),
    );
  }
}
