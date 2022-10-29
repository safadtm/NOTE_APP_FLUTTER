import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class ScreenPhoneAuth extends StatefulWidget {
  const ScreenPhoneAuth({super.key});

  @override
  State<ScreenPhoneAuth> createState() => _ScreenPhoneAuthState();
}

class _ScreenPhoneAuthState extends State<ScreenPhoneAuth> {
  int start = 30;
  bool wait = false;
  String buttonName = 'Send';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'SignUp',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 120),
              textField(),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    const Text(
                      "Enter 6 digit OTP",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              otpField(),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Send OTP again in ",
                      style:
                          TextStyle(fontSize: 16, color: Colors.yellowAccent),
                    ),
                    TextSpan(
                      text: "00:$start",
                      style: const TextStyle(
                          fontSize: 16, color: Colors.pinkAccent),
                    ),
                    const TextSpan(
                      text: " sec ",
                      style:
                          TextStyle(fontSize: 16, color: Colors.yellowAccent),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 150),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  color: const Color(0xffff9601),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    'Lets Go',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xfffbe2ae),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(
      onsec,
      (timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            wait = false;
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 36,
      fieldWidth: 56,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: const Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: const TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print('Completed $pin');
      },
    );
  }

  Widget textField() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: const Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone number",
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 17),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 19),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 19),
            child: Text(
              '(+91)',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () {
                    startTimer();
                    setState(() {
                      start = 30;
                      wait = true;
                      buttonName = 'Resend';
                    });
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                buttonName,
                style: TextStyle(
                  color: wait ? Colors.grey : Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
