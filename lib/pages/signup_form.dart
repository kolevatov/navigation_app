import 'package:flutter/material.dart';

enum ButtonState { init, loading, done }

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _hidePass = true;
  ButtonState state = ButtonState.init;
  bool isAnimating = true;

  // controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  // focus nodes
  final _nameFieldFocus = FocusNode();
  final _phoneFieldFocus = FocusNode();
  final _emailFieldFocus = FocusNode();
  final _passwordFieldFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nameFieldFocus.dispose();
    _phoneFieldFocus.dispose();
    _emailFieldFocus.dispose();
    _passwordFieldFocus.dispose();

    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentField, FocusNode nextField) {
    currentField.unfocus();
    FocusScope.of(context).requestFocus(nextField);
  }

  @override
  Widget build(BuildContext context) {
    double _weight = MediaQuery.of(context).size.width;
    final isStretched = isAnimating || state == ButtonState.init;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Signup form'),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _fullNameInput(),
              const SizedBox(
                height: 16.0,
              ),
              _phoneNumberInput(),
              const SizedBox(height: 16.0),
              _emailInput(),
              const SizedBox(height: 16.0),
              // Password input
              _passwordInput(),
              const SizedBox(height: 8.0),
              // Password confirmation input
              _confirmPasswordInput(),
              const SizedBox(height: 32.0),
              Container(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  width: state == ButtonState.init ? _weight : 56,
                  height: 56,
                  onEnd: () => setState(() => isAnimating = !isAnimating),
                  child: isStretched ? _submitButton() : _progressIndicator(),
                ),
              ),
            ],
          ),
        ));
  }

  TextFormField _fullNameInput() {
    return TextFormField(
      maxLength: 50,
      keyboardType: TextInputType.name,
      controller: _nameController,
      focusNode: _nameFieldFocus,
      autofocus: true,
      onFieldSubmitted: (_) {
        _fieldFocusChange(context, _nameFieldFocus, _phoneFieldFocus);
      },
      validator: _validateName,
      decoration: InputDecoration(
          labelText: 'Full name *',
          hintText: 'Enter your full name',
          prefixIcon: const Icon(
            Icons.person,
            color: Colors.orange,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              _nameController.clear();
            },
            child: const Icon(
              Icons.delete_outline,
            ),
          ),
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder()),
    );
  }

  TextFormField _phoneNumberInput() {
    return TextFormField(
      maxLength: 15,
      controller: _phoneController,
      focusNode: _phoneFieldFocus,
      onFieldSubmitted: (_) {
        _fieldFocusChange(context, _phoneFieldFocus, _emailFieldFocus);
      },
      keyboardType: TextInputType.phone,
      validator: _validatePhone,
      decoration: InputDecoration(
          labelText: 'Phone number *',
          hintText: 'Enter your phone number',
          helperText: 'Use template +7(###)###-####',
          prefixIcon: const Icon(
            Icons.phone,
            color: Colors.orange,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              _phoneController.clear();
            },
            child: const Icon(
              Icons.delete_outline,
            ),
          ),
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder()),
    );
  }

  TextFormField _emailInput() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFieldFocus,
      onFieldSubmitted: (_) {
        _fieldFocusChange(context, _emailFieldFocus, _passwordFieldFocus);
      },
      keyboardType: TextInputType.emailAddress,
      validator: _validateEmail,
      decoration: InputDecoration(
          labelText: 'Email *',
          hintText: 'Enter your email address',
          prefixIcon: const Icon(
            Icons.email,
            color: Colors.orange,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              _emailController.clear();
            },
            child: const Icon(
              Icons.delete_outline,
            ),
          ),
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder()),
    );
  }

  TextFormField _passwordInput() {
    return TextFormField(
      maxLength: 8,
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordController,
      focusNode: _passwordFieldFocus,
      validator: _validatePassword,
      obscureText: _hidePass,
      decoration: InputDecoration(
          labelText: 'Password *',
          hintText: 'Enter the password',
          prefixIcon: const Icon(
            Icons.security,
            color: Colors.orange,
          ),
          suffixIcon: IconButton(
            icon: Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _hidePass = !_hidePass;
              });
            },
          ),
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder()),
    );
  }

  TextFormField _confirmPasswordInput() {
    return TextFormField(
      maxLength: 8,
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordConfirmController,
      obscureText: _hidePass,
      decoration: const InputDecoration(
          labelText: 'Repeat your password *',
          hintText: 'Repeat your password',
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder()),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 18),
          minimumSize: const Size.fromHeight(56),
          shape: const StadiumBorder()),
      onPressed: () async {
        if (_submitForm()) {
          // to show loading indicator
          setState(() => state = ButtonState.loading);
          await Future.delayed(const Duration(seconds: 3));
          // to show completed indicator
          setState(() => state = ButtonState.done);
          await Future.delayed(const Duration(seconds: 3));
          // to return button to initial state
          setState(() => state = ButtonState.init);
        }
      },
      child: const FittedBox(
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _progressIndicator() {
    Color _color = state == ButtonState.loading ? Colors.blue : Colors.green;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: _color),
      child: Center(
        child: state == ButtonState.loading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(
                Icons.done,
                color: Colors.white,
                size: 36,
              ),
      ),
    );
  }

  String? _validateName(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return 'This field is mandatory!';
    }
  }

  String? _validatePhone(String? value) {
    final _phoneExp = RegExp(r'^\+\d\(\d\d\d\)\d\d\d\-\d\d\d\d$');

    if (value!.isEmpty) {
      return 'This field is mandatory!';
    } else if (_phoneExp.hasMatch(value)) {
      return null;
    } else {
      return 'Please use template +7(###)###-####';
    }
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'This field is mandatory!';
    } else if (_emailController.text.contains('@')) {
      return null;
    } else {
      return 'Email address isn\'t valid!';
    }
  }

  String? _validatePassword(String? value) {
    if (_passwordController.text.length < 4) {
      return '4 chars is minimum!';
    } else if (_passwordController.text != _passwordConfirmController.text) {
      return 'Passwords aren\'t equal!';
    } else {
      return null;
    }
  }

  bool _submitForm() {
    return _formKey.currentState!.validate();
  }
}
