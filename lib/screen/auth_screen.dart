import 'package:flutter/material.dart';
import '../core/services/auth/auth_service.dart';
import '../core/models/auth_form_data.dart';
import '../components/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);   

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isloading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      if(!mounted ) return ;
      setState(() => _isloading = true);

      if (formData.isLogin) {
        await AuthService().login(formData.email, formData.password);
      } else {
        await AuthService().signup(
            formData.name, formData.email, formData.password, formData.image);
      }
    } catch (error) {
      // AI MEU DEUS, SEXO
    } finally {
      if(!mounted) return;
      setState(() => _isloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (_isloading)
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
