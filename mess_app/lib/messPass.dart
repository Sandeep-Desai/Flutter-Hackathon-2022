import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mess_app/utilities/gsheets.dart';
import 'package:mess_app/order/passModel.dart';

class MessPass extends StatefulWidget {
  const MessPass({Key? key}) : super(key: key);

  @override
  _MessPassState createState() => _MessPassState();
}

class _MessPassState extends State<MessPass> {
  bool isLoading = false;
  List<PassModel> pass = [PassModel()];

  @override
  void initState() {
    super.initState();
    Gsheet sheet = Gsheet('1dFR1hus3VY2zryi8b2QD2FmY9dpqQdupwmLChyXRSdk');
    sheet.readData("MessPass").then((value) {
      pass.add(PassModel(
        pass_id: value[1][0],
        qr_code: value[1][1],
      ));

      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Container(
            child: Center(
                child: Text("Please Wait...",
                    style: GoogleFonts.lato(
                        color: Color.fromARGB(255, 148, 147, 147),
                        fontSize: 30,
                        fontWeight: FontWeight.w700))))
        : Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            'Mess QR Code',
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[400]),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image(
                      image: NetworkImage(pass[1].qr_code),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 350,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[600]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Pass_ID: '+ pass[1].pass_id,
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
