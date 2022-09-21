import 'package:control_reunion/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  final oscure = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final errors = false.obs;
  @override
  Widget build(BuildContext context) {
    //get size screen
    final sizeHeightContainer = MediaQuery.of(context).size.height * 0.6;
    print(MediaQuery.of(context).size.height);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 243, 243),
        body: Center(
          child: SingleChildScrollView(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              height: WidgetsBinding.instance.window.viewInsets.bottom > 0
                  ? sizeHeightContainer * 0.9
                  : sizeHeightContainer,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  // color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                    )
                  ]),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: WidgetsBinding.instance.window.viewInsets.bottom > 0
                        ? sizeHeightContainer * 0.1
                        : sizeHeightContainer * 0.13,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      // color: Colors.white,
                      color: Get.theme.colorScheme.secondary,
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    height: WidgetsBinding.instance.window.viewInsets.bottom > 0
                        ? sizeHeightContainer * 0.22
                        : sizeHeightContainer * 0.30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        Text(
                          "Control de Reuniones",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Get.theme.colorScheme.secondary,
                          ),
                        ),
                        Text(
                          "Iniciar Sesión",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Get.theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => controller.isLoadin.value
                      ? Center(
                          child: LinearProgressIndicator(),
                        )
                      : Container()),
                  Container(
                    // color: Colors.red.shade100,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    // height: sizeHeightContainer*0.,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // color: Colors.blue.shade100,
                            height: sizeHeightContainer * 0.15,
                            child: TextFormField(
                              // onFieldSubmitted: (value) {
                              //   print(controller.isLoading.value);
                              //   if (!controller.isLoading.value) {
                              //     if (controller.formKey.currentState!.validate()) {
                              //       controller.login();
                              //     }
                              //   }
                              // },
                              //valitator email
                              validator: (value) => value!.length < 4 ||
                                      !value.contains('@') ||
                                      !value.contains('.')
                                  ? 'Ingresa un correo electrónico valido'
                                  : null,
                              // obscureText: true,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: const InputDecoration(
                                isDense: true,
                                labelText: 'Correo',
                                prefixIcon: Icon(
                                  Icons.email,
                                  size: 20,
                                ),
                                //suffixIcon = Icon(Icons.visibility),
                                // suffixIcon: Icon( Icons.visibility),
                                // contentPadding: EdgeInsets.all(18),
                              ),
                            ),
                          ),
                          Obx(
                            () => Container(
                              height: sizeHeightContainer * 0.15,
                              // color: Colors.red.shade100,
                              child: TextFormField(
                                // onFieldSubmitted: (value) {
                                //   print(controller.isLoading.value);
                                //   if (!controller.isLoading.value) {
                                //     if (controller.formKey.currentState!.validate()) {
                                //       controller.login();
                                //     }
                                //   }
                                // },
                                validator: (value) => value!.isEmpty
                                    ? 'Ingresa tu contraseña'
                                    : null,
                                obscureText: oscure.value,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  prefixIcon: Icon(
                                    Icons.lock_sharp,
                                    size: 20,
                                  ),
                                  //suffixIcon = Icon(Icons.visibility),
                                  suffixIcon: IconButton(
                                    onPressed: () =>
                                        oscure.value = !oscure.value,
                                    color: Colors.black45,
                                    iconSize: 21,
                                    icon: Icon(oscure.value
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  // contentPadding: EdgeInsets.all(18),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              // color: Colors.blue ,
                              height: errors.value ||
                                      controller.isLoadin.value ||
                                      WidgetsBinding.instance.window.viewInsets
                                              .bottom >
                                          0
                                  ? sizeHeightContainer * 0.03
                                  : sizeHeightContainer * 0.03,
                            ),
                          ),
                          Container(
                            // color: Colors.red.shade100 ,
                            padding: const EdgeInsets.only(right: 20),
                            height: sizeHeightContainer * 0.07,
                            child: TextButton(
                              child: Text(
                                "¿Olvidó contraseña?",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              onPressed: () {
                                print('Olvidé contraseña');
                              },
                            ),
                          ),
                          Obx(
                            () => AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              // color: Colors.blue ,
                              height: errors.value ||
                                      controller.isLoadin.value ||
                                      WidgetsBinding.instance.window.viewInsets
                                              .bottom >
                                          0
                                  ? sizeHeightContainer * 0.03
                                  : sizeHeightContainer * 0.03,
                            ),
                          ),
                          Container(
                            height: sizeHeightContainer * 0.08,
                            width: double.infinity,
                            child: Obx(
                              () => ElevatedButton(
                                child: Text('Iniciar sesión'.toUpperCase()),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  backgroundColor: controller.isLoadin.value
                                      ? MaterialStateProperty.all(Colors.grey)
                                      : MaterialStateProperty.all(
                                          Get.theme.colorScheme.primary),
                                ),
                                onPressed: () async {
                                  print(controller.isLoadin.value);
                                  if (!controller.isLoadin.value) {
                                    if (formKey.currentState!.validate()) {
                                      //close keyboard
                                      FocusScope.of(context).unfocus();
                                      errors.value = false;
                                      controller.isLoadin.value = true;
                                      await controller.login(
                                          usuario: emailController.text,
                                          clave: passwordController.text);
                                      
                                    } else {
                                      errors.value = true;
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
