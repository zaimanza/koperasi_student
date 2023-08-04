import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_parcel/components/already_have_an_account_acheck.dart';
import 'package:student_parcel/pages/Authentication/context/AuthenticationProvider.dart';
import 'package:student_parcel/pages/Authentication/register/index.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  // onTapParcelIn() => Navigator.push(
  //       context,
  //       PageRouteBuilder(
  //         pageBuilder: (context, animation1, animation2) =>
  //             const ParcelInPage(),
  //         transitionDuration: Duration.zero,
  //         reverseTransitionDuration: Duration.zero,
  //       ),
  //     );

  // onTapParcelOut() => Navigator.push(
  //       context,
  //       PageRouteBuilder(
  //         pageBuilder: (context, animation1, animation2) =>
  //             const ParcelOutPage(),
  //         transitionDuration: Duration.zero,
  //         reverseTransitionDuration: Duration.zero,
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16.0 * 10),
                const Text(
                  "Dash Parcel",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                ),
                const SizedBox(height: 16.0 * 2),
                const Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0 * 5),
                Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 8,
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              // keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              cursorColor: const Color(0xFF6F35A5),
                              onChanged: (data) {
                                ref
                                    .watch(authenticationProvider)
                                    .setStudentId(data);
                              },
                              decoration: const InputDecoration(
                                hintText: "Student ID",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.person),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                onChanged: (data) {
                                  ref
                                      .watch(authenticationProvider)
                                      .setPassword(data);
                                },
                                obscureText: true,
                                cursorColor: const Color(0xFF6F35A5),
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.lock),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Hero(
                              tag: "login_btn",
                              child: ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(authenticationProvider)
                                      .postStudentLogin();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/Home', (route) => false);
                                },
                                child: Text(
                                  "Login".toUpperCase(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            AlreadyHaveAnAccountCheck(
                              press: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            const Register(),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
