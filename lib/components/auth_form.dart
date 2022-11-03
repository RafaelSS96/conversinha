import 'dart:io';

import 'package:flutter/material.dart';
import '../components/user_image_picker.dart';
import '../core/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key, required this.onSubmit}) : super(key: key);

  final void Function(AuthFormData) onSubmit;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _authData = AuthFormData();

  void _handleImagePick(File image) {
    _authData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_authData.image == null && _authData.isSignUp) {
      return _showError("Imagem não selecionada!");
    }

    widget.onSubmit(_authData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_authData.isSignUp)
                UserImagePicker(onImagePick: _handleImagePick),
              if (_authData.isSignUp)
                TextFormField(
                  key: const ValueKey("name"),
                  initialValue: _authData.name,
                  onChanged: (name) => _authData.name = name,
                  decoration: const InputDecoration(labelText: "Nome"),
                  validator: (naame) {
                    final name = naame ?? "";
                    if (name.trim().length < 3) {
                      return "Nome invalido! O nome deve ter no minimo 3 caracteres.";
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey("email"),
                initialValue: _authData.email,
                onChanged: (email) => _authData.email = email,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (emaail) {
                  final email = emaail ?? "";
                  if (!email.contains("@")) {
                    return "E-mail invalido! Informe um e-mail valido.";
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey("password"),
                initialValue: _authData.password,
                onChanged: (password) => _authData.password = password,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Senha"),
                validator: (passsword) {
                  final password = passsword ?? "";
                  if (password.length < 6) {
                    return "Senha invalida! A senha é muito curta.";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_authData.isLogin ? "Entrar" : "Cadastrar"),
              ),
              TextButton(
                child: Text(_authData.isLogin
                    ? "Criar uma nova conta"
                    : "Já possui conta?"),
                onPressed: () {
                  setState(() {
                    _authData.toggleAuthMode();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
