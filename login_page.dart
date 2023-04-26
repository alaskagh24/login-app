import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/api_service.dart';
import 'package:flutter_application_1/model/login_model.dart';
import 'package:flutter_application_1/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool hidePassword = true;
  LoginRequestModel requestModel = LoginRequestModel("email", "password");
  bool isApiCallProcces = false;
  APIService apiService = APIService();
  @override
  void initState() {
    super.initState();
    requestModel = LoginRequestModel("email", "password");
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcces,
      opacity: 0.3,
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: const Offset(0, 10),
                          blurRadius: 20,
                        )
                      ]),
                  child: Form(
                      key: globalFormKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Login",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => requestModel.email = input!,
                            validator: (input) => !input!.contains("@")
                                ? "Provide a valid Email address"
                                : null,
                            decoration: InputDecoration(
                                hintText: "Email Address",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    )),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).accentColor,
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => requestModel.password = input!,
                            validator: (input) => input!.length < 8
                                ? "Password should not be less than 8 characters]"
                                : null,
                            obscureText: hidePassword,
                            decoration: InputDecoration(
                              hintText: "Password",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  )),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Theme.of(context).accentColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.4),
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 80,
                                  ),
                                ),
                                shape: const MaterialStatePropertyAll(
                                    StadiumBorder()),
                                backgroundColor:
                                    const MaterialStatePropertyAll(Colors.blue),
                              ),
                              onPressed: () {
                                if (validateAndSave()) {
                                  setState(() {
                                    isApiCallProcces = true;
                                  });
                                  apiService.login(requestModel).then((value) {
                                    setState(
                                      () {
                                        isApiCallProcces = false;
                                      },
                                    );
                                    if (value.token.isNotEmpty) {
                                      const snackBar = SnackBar(
                                        content: Text("Login Sucessful"),
                                      );
                                      scaffoldKey.currentState!.showBottomSheet(
                                          (context) => snackBar);
                                    } else {
                                      final snackBar = SnackBar(
                                        content: Text(value.error),
                                      );
                                      scaffoldKey.currentState!.showBottomSheet(
                                          (context) => snackBar);
                                    }
                                  });
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
