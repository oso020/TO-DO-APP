import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/Home/register/cubit/register_states.dart';

import '../../../domain/use_cases/use_case_register.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterStates> {
  RegisterUseCase registerUseCase;
  RegisterViewModel({required this.registerUseCase})
      : super(RegisterStateBegin());

  TextEditingController userName = TextEditingController(text: "mohamed");

  TextEditingController email = TextEditingController(text: "osman@gmail.com");

  TextEditingController password = TextEditingController(text: "Mm#123456");

  TextEditingController rPassword = TextEditingController(text: "Mm#123456");
  TextEditingController phone = TextEditingController(text: "0212185163");

  void register() async {
    emit(RegisterStateLoading());
    var either=await registerUseCase.invoke(
        userName.text, email.text, password.text, rPassword.text, phone.text);

    either.fold((l) {
      emit(RegisterStateError(failures: l));
    }, (r) {
      emit(RegisterStateSuccess(registerResponseEntity: r));
    },);


  }
}
