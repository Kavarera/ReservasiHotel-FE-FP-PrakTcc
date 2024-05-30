import 'package:fe_sendiri_prak_tcc_fp/controllers/register_controller.dart';
import 'package:fe_sendiri_prak_tcc_fp/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegisterController _registerController = Get.put(RegisterController());

  void _register() {
    print('diklik');
    _registerController.register(
      _fullnameController.text,
      _usernameController.text,
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Tinggal-in',
                    style: GoogleFonts.firaSans(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _fullnameController,
                decoration: InputDecoration(
                  labelText: "Fullname",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed:
                          _register, // Memastikan metode _register dipanggil
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side:
                                      const BorderSide(color: Colors.black)))),
                      child: Obx(() {
                        return _registerController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              );
                      }),
                    )),
              ),
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sudah punya akun? "),
                    InkWell(
                        onTap: () {
                          Get.offNamed(AppRouteRepo.login);
                        },
                        child: const Text(
                          "Masuk",
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
