# 📰 News Portal App

Aplikasi mobile pembaca berita built with Flutter & GetX — modern, minimalis, dan responsif.

## 📱 Demo

![Demo](docs/demo.gif)

## ✨ Fitur Utama

- 🔐 Halaman Login sederhana (Email & Password)
- 🏠 Home dengan TabBar (Berita Utama, Teknologi, Olahraga, Bisnis)
- 📖 Halaman Detail Artikel (Gambar, Judul, Penulis, Tanggal, Isi)
- 🔍 Halaman Search dengan history dan popular searches
- 🔖 Halaman Bookmark untuk artikel yang disimpan

## 🛠️ Teknologi

- Flutter (Dart SDK >= 3.8.1)
- GetX (get: ^4.6.5) untuk routing & dependency injection
- Google Fonts (google_fonts: ^6.1.0)
- Lucide Icons (lucide_icons: ^0.257.0)

## 🚀 Quick Start

Clone repo
```bash
git clone https://github.com/JackBerck/news-app-zaki-flutter
cd news_app_zaki_flutter
```

Install dependencies
```bash
flutter pub get
```

Jalankan aplikasi (Android/iOS)
```bash
flutter run
```

Catatan: pastikan file asset ada di `assets/new_data.json` sesuai pubspec.yaml.

## 📁 Struktur Proyek (ringkasan)

lib/
- main.dart
- app/
  - routes/
  - modules/ (login, home, detail, search, bookmark)
  - data/ (models)
assets/
- new_data.json

## 📝 GetX Implementation (singkat)

Routing:
```dart
Get.toNamed(Routes.HOME);
Get.back();
```

Binding:
```dart
class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
```

Contoh observables:
```dart
final articles = <Article>[].obs;
Obx(() => Text('${articles.length}'));
```

## 👤 Author

**Muhammad Zaki Dzulfikar**  
- GitHub: https://github.com/JackBerck  
- NIM: H1D023065
- Email: muhammad.dzulfikar@mhs.unsoed.ac.id

---

Made with ❤️ using Flutter & GetX