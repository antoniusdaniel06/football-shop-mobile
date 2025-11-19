README TUGAS 9:
1. Kita perlu model dart saat mengambil/mengirim data JSON agar:
- Tipe yang jelasTipe yang jelas
- Null-safety & default
- Parsing terpusat & validasi

    Konsekuensi jika langsung memakai Map<String, dynamic> :
- Tidak ada tipe yang jelas
- Sulit debugging
- Null safety lemah

2. -  http: Paket standar Dart/Flutter untuk melakukan request HTTP (GET, POST, PUT, DELETE). Ringan, return Response (body, statusCode, headers). Tidak otomatis menyimpan atau mengelola cookie atau CSRF. Cocok untuk REST API stateless (token bearer, JSON only).
    - CookieRequest (konsep/kelas wrapper untuk request yang mengelola cookie — bisa implementasi sendiri atau paket yang mirip).

    Perbedaan peran:
    - http = alat raw untuk melakukan HTTP.
    - CookieRequest = http + stateful cookie jar + helpers CSRF + helpers auth.

3. Karena cookie/session adalah state global yang mempengaruhi behavior seluruh app (siapa yang login, header CSRF, otorisasi).

4. Agar Flutter dapat berkomunikasi dengan Django, kita perlu mengizinkan Android emulator mengakses server dengan menambahkan 10.0.2.2 pada ALLOWED_HOSTS, karena emulator menggunakan alamat itu untuk mengakses localhost komputer. Django juga harus mengaktifkan CORS agar permintaan dari domain atau origin berbeda dapat diterima, terutama bila aplikasi berjalan di Flutter web atau memakai cookie. Selain itu, pengaturan cookie seperti SameSite, Secure, dan izin CORS_ALLOW_CREDENTIALS harus benar agar cookie session dan CSRF dapat dikirim dan dibaca oleh Flutter. Untuk Android, aplikasi harus diberi izin INTERNET di AndroidManifest.xml; jika tidak, semua request akan gagal diam-diam. Bila salah satu konfigurasi ini tidak dilakukan dengan benar, Flutter dapat mengalami masalah seperti request ditolak Django (400 Bad Request), error CORS (403), cookie session tidak dikirim sehingga login selalu gagal, atau bahkan aplikasi Android tidak bisa terhubung ke server sama sekali.

5. Mekanisme pengiriman data dari input pengguna di Flutter ke Django dimulai ketika pengguna memasukkan data dan memicu suatu aksi (misalnya, menekan tombol "Kirim"). Flutter, sebagai client, mengemas data tersebut—biasanya dalam format JSON—dan membuat permintaan HTTP (seperti POST atau GET) menggunakan library seperti http atau dio. Permintaan ini kemudian diarahkan ke URL endpoint spesifik yang telah ditentukan di Django. Setelah sampai di server, Django, khususnya melalui Django REST Framework (DRF), menerima dan mendeserialisasi (menguraikan) data JSON menjadi objek Python yang dapat diproses. Data ini kemudian divalidasi dan digunakan untuk menjalankan logika bisnis, seperti menyimpan atau memperbarui database melalui Django Models. Setelah pemrosesan selesai, Django membuat response yang berisi status keberhasilan (misalnya, kode 200 OK) dan data balasan (juga dalam bentuk JSON), lalu mengirimkannya kembali ke Flutter. Flutter kemudian mem-parsing response tersebut, mengekstrak data atau pesan status, dan memperbarui tampilan (UI) menggunakan state management (seperti setState) agar data baru dapat dilihat oleh pengguna.

6. Proses autentikasi, yang mencakup registrasi, login, dan logout, mengandalkan Token-Based Authentication. Saat registrasi, Flutter mengirimkan username dan password ke endpoint registrasi Django. Django membuat user baru, meng-hash password, dan menyimpannya. Untuk login, Flutter mengirimkan kredensial. Django memverifikasi kredensial, dan jika benar, Django membuat dan mengirimkan Token Autentikasi yang unik kembali ke Flutter. Flutter menyimpan Token ini secara aman. Untuk semua permintaan data sensitif selanjutnya, Flutter menyertakan Token ini dalam header permintaan HTTP, membuktikan identitas user tanpa perlu mengirim password berulang kali. Setelah autentikasi berhasil, Flutter menampilkan Menu Utama. Terakhir, untuk logout, Flutter mengirimkan permintaan ke endpoint logout, yang membuat Django membatalkan (meng-invalidate) Token tersebut di server. Flutter juga menghapus Token secara lokal, sehingga user kehilangan akses terautentikasi dan harus kembali ke halaman login.
