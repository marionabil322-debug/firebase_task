import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase/cubit/cubit/auth_cubit.dart'; // تأكد من المسار عندك

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // 1. الـ Controllers لسحب البيانات من الـ UI
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    // تنظيف الـ Controllers عشان ميعملوش Memory Leak
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2D62ED);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            // التعامل مع حالات الـ Cubit
            if (state is AuthSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Account created successfully!"),
                  backgroundColor: Colors.green,
                ),
              );
              // هنا ممكن تعمل Navigator.push لصفحة الـ Home
            } else if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Registration Failed! Please try again."),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // حقل الاسم
                _buildLabel("Full Name"),
                _buildTextField(
                  controller: _nameController,
                  hint: "Mario",
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 20),

                // حقل الإيميل
                _buildLabel("Email Address"),
                _buildTextField(
                  controller: _emailController,
                  hint: "mario@example.com",
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 20),

                // حقل الباسورد
                _buildLabel("Password"),
                _buildTextField(
                  controller: _passwordController,
                  hint: "••••••••",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  obscureText: !_isPasswordVisible,
                  onToggle: () =>
                      setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),

                const SizedBox(height: 15),

                // خانة الموافقة (الزرار مش هيشتغل غير لما تعلم صح)
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      activeColor: primaryColor,
                      onChanged: (value) =>
                          setState(() => _agreeToTerms = value!),
                    ),
                    const Text(
                      "I agree to the Terms & Conditions",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // زرار الـ Sign Up
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      );
                    }

                    return SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _agreeToTerms
                            ? () {
                                // إرسال الريكويست فعلياً للكوبيت
                                context
                                    .read<AuthCubit>()
                                    .registerWithEmailAndPassword(
                                      emailAddress: _emailController.text
                                          .trim(),
                                      password: _passwordController.text,
                                    );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helpers ---
  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, left: 4),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    ),
  );

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.shade400,
                ),
                onPressed: onToggle,
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade50,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF2D62ED)),
        ),
      ),
    );
  }
}
