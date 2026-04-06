import 'package:firebase/cubit/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _obscureText = true;
  late TabController _tabController;
  final _emilcontroller = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2D62ED); // لون أزرق عصري

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              // Logo placeholder or Icon
              Center(
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    size: 40,
                    color: primaryColor,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Welcome Text
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1D1E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Please sign in to your account",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              ),

              const SizedBox(height: 40),

              // Email Field
              _buildInputLabel("Email Address"),
              TextField(
                controller: _emilcontroller,
                decoration: _buildInputDecoration(
                  hint: "name@example.com",
                  icon: Icons.email_outlined,
                ),
              ),

              const SizedBox(height: 25),

              // Password Field
              _buildInputLabel("Password"),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: _buildInputDecoration(
                  hint: "••••••••",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  onToggleVisibility: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                ),
              ),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Sign In Button
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().loginWithEmailAndPassword(
                        emailAddress: _emilcontroller.text,
                        password: _passwordController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Divider "OR"
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or continue with",
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),

              const SizedBox(height: 30),

              const SizedBox(height: 40),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // مساعد لبناء عناوين الحقول
  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Color(0xFF1A1D1E),
        ),
      ),
    );
  }

  // مساعد لتصميم الحقول (Decoration)
  InputDecoration _buildInputDecoration({
    required String hint,
    required IconData icon,
    bool isPassword = false,
    VoidCallback? onToggleVisibility,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey.shade400,
                size: 20,
              ),
              onPressed: onToggleVisibility,
            )
          : null,
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFF2D62ED), width: 1.5),
      ),
    );
  }

  // مساعد لبناء أزرار التواصل الاجتماعي
  Widget _buildSocialButton(String label, String iconUrl) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(iconUrl, height: 24),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1D1E),
            ),
          ),
        ],
      ),
    );
  }
}
