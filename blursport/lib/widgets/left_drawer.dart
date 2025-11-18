import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:blursport/screens/login.dart';
import 'package:blursport/screens/product_entry_list.dart';
import 'package:blursport/screens/myproduct_page.dart';
import 'package:blursport/screens/product_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'BlurSport',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // All Products
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text("All Products"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProductEntryListPage()),
              );
            },
          ),

          // My Products
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text("My Products"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyProductsPage()),
              );
            },
          ),

          // Create Product
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Create Product"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProductFormPage()),
              );
            },
          ),

          const Divider(),

          // LOGOUT
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              "Logout",
            ),
            onTap: () async {
              final response = await request.logout(
                "http://localhost:8000/auth/logout/",
              );

              String message = response["message"];

              if (context.mounted) {
                if (response['status']) {
                  // logout sukses
                  String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$message See you again, $uname.")),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                } else {
                  // gagal logout
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
