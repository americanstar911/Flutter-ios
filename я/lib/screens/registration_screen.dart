import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  final Future<void> Function(String name, String email, String role)?
  onRegistered;

  const RegistrationScreen({super.key, this.onRegistered});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _confirmKey = GlobalKey<FormFieldState<String>>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String _role = 'Student';
  bool _acceptedTerms = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      errorMaxLines: 3,
      border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
    );
  }

  Future<void> _register() async {
    if (_isSubmitting) return;

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final role = _role;

    setState(() {
      _isSubmitting = true;
    });

    try {
      debugPrint('Full name: $name');
      debugPrint('Email: $email');
      debugPrint('Role: $role');
      debugPrint('Terms accepted: $_acceptedTerms');

      final onRegistered = widget.onRegistered;

      if (onRegistered != null) {
        await onRegistered(name, email, role);
      } else {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
      }
    } catch (error) {
      debugPrint('Registration error: $error');

      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Could not save registration. Please try again.'),
          ),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create your profile',
                      style: TextStyle(
                        fontFamily: 'CormorantGaramond',
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enter your details and choose your role.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Full Name
                    TextFormField(
                      controller: _nameController,
                      enabled: !_isSubmitting,
                      decoration: _decoration('Full Name'),
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter your full name';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      enabled: !_isSubmitting,
                      decoration: _decoration('Email'),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      validator: (value) {
                        final email = value?.trim() ?? '';

                        if (email.isEmpty) {
                          return 'Enter your email';
                        }

                        final pattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                        if (!pattern.hasMatch(email)) {
                          return 'Use an email like name@narxoz.kz';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      enabled: !_isSubmitting,
                      decoration: _decoration('Password'),
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) {
                        if (_confirmController.text.isNotEmpty) {
                          _confirmKey.currentState?.validate();
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        }

                        if (value.length < 6) {
                          return 'Use at least 6 characters';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password
                    TextFormField(
                      key: _confirmKey,
                      controller: _confirmController,
                      enabled: !_isSubmitting,
                      decoration: _decoration('Confirm Password'),
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm your password';
                        }

                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // User Role
                    DropdownButtonFormField<String>(
                      initialValue: _role,
                      isExpanded: true,
                      decoration: _decoration('User Role'),
                      items: const [
                        DropdownMenuItem(
                          value: 'Student',
                          child: Text('Student'),
                        ),
                        DropdownMenuItem(
                          value: 'Teacher',
                          child: Text('Teacher'),
                        ),
                        DropdownMenuItem(
                          value: 'Developer',
                          child: Text('Developer'),
                        ),
                      ],
                      onChanged: _isSubmitting
                          ? null
                          : (value) {
                              setState(() {
                                _role = value ?? 'Student';
                              });
                            },
                    ),
                    const SizedBox(height: 16),

                    // Terms and Conditions
                    FormField<bool>(
                      initialValue: false,
                      validator: (value) {
                        if (value != true) {
                          return 'Accept the terms to continue';
                        }

                        return null;
                      },
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: const Text(
                                'I accept the Terms and Conditions',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: _acceptedTerms,
                              onChanged: _isSubmitting
                                  ? null
                                  : (value) {
                                      final accepted = value ?? false;

                                      setState(() {
                                        _acceptedTerms = accepted;
                                      });

                                      field.didChange(accepted);
                                    },
                            ),
                            if (field.hasError)
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  field.errorText!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Register button
                    FilledButton(
                      onPressed: _isSubmitting ? null : _register,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(_isSubmitting ? 'Saving...' : 'Register'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
