import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget{
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  var username = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final fb = FirebaseDatabase.instance;

  bool remember = true;
  Color visible = Color(0xffcdc7be);
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 70),
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 37,
                  color: Color(0xff00466b),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Create Your Account',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: SvgPicture.asset('assets/images/facebook.svg'),
                    iconSize: 40,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: SvgPicture.asset('assets/images/google.svg'),
                    iconSize: 40,
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 15),
              Divider(color: Colors.black, indent: 100, endIndent: 100,),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextFormField(
                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Username",
                        ),
                        controller: _userController,
                        validator: (value) {
                          // if (value.isEmpty || value.contains('@.com') || !value.contains('@')) {
                          if (value.isEmpty) {
                            return ("Pls enter a valid username");
                          }
                          return null;
                        },

                    ),
                    SizedBox(height: 20),
                    TextFormField(
                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                        ),
                        key: ValueKey('email'),
                        controller: _emailController,
                        validator: (value) {
                          // if (value.isEmpty || value.contains('@.com') || !value.contains('@')) {
                          if (value.isEmpty) {
                            return ("Pls enter a valid email");
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Password",
                          suffixIcon: IconButton(
                            color: visible,
                            onPressed: () {
                              _obscureText == true
                                  ? visible = Colors.blue
                                  : visible = Color(0xffcdc7be);
                              _toggle();
                            },
                            icon: Icon(Icons.visibility),)
                      ),
                      controller: _passwordController,
                      key: ValueKey('password'),
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return ("Pls enter a valid password");
                        } else if (value.length < 6) {
                          return ("Password must be atleast 6 character");
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "ConfirmPassword",
                      ),
                      obscureText: _obscureText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return ("Pls enter a valid password");
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: this.remember,
                                checkColor: Colors.white,
                                activeColor: Colors.blue,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.remember = value;
                                  });
                                }
                            ),
                            Text(
                              'Remember me',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            onPressed: () async {
                              var user,Uid;
                              try {
                                user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                )).user;
                                Uid=user.uid.toString();
                                print("UID:"+Uid);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error u not found")));
                                } else if (e.code == 'wrong-password') {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("wrong password")));
                                }
                              }catch(e){
                                print(e);
                              }

                              if(user!=null){
                                final ref = fb.reference();
                                await ref.child("users").child(Uid).set(<String,Object>{
                                  "username": _userController.text,
                                  "UID": Uid,
                                });
                                Navigator.of(context).pushNamed('/homenav');
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0)),
                            color: Color(0xff00466b),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            )
                        )
                    ),
                    SizedBox(height: 30),
                    Divider(color: Colors.black, indent: 70, endIndent: 70),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",),
                        // ignore: deprecated_member_use
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/login');
                            },
                            child: Text(
                              "SignIn",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xff00466b),
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                              ),
                            )
                        )
                      ],
                    ),
                  ],
                ),
              ),


            ],
          ),
        )
    );
  }
}