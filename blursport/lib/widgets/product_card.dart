import 'package:flutter/material.dart';
import 'package:blursport/screens/product_form.dart';
import 'package:blursport/screens/product_entry_list.dart';
import 'package:blursport/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:blursport/screens/myproduct_page.dart';


class ItemCard extends StatelessWidget {
  final ItemHomepage item; 
  const ItemCard(this.item, {super.key}); 

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );

          if (item.name == "Create Product") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductFormPage(),
              ),
            );
          }
          else if (item.name == "All Products") {
            Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ProductEntryListPage()
        ),

    );
    
}
else if (item.name == "My Products") {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MyProductsPage()),
  );
}
else if(item.name == "Logout"){
  final response = await request.logout(
        "http://localhost:8000/auth/logout/");
    String message = response["message"];
    if (context.mounted) {
        if (response['status']) {
            String uname = response["username"];
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("$message See you again, $uname."),
            ));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
            );
        } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(message),
                ),
            );
        }
    }
}
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(item.name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemHomepage {
 final String name;
 final IconData icon;
 ItemHomepage(this.name, this.icon);
}