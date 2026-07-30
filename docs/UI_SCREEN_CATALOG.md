# Company OS — Mobil Ekran Kataloğu

Bu katalog, React Native mobil istemcinin üretim ekran yüzeyini tanımlar. Ekranlar tekil denemeler değil; ortak tasarım sistemi, route sözleşmesi ve domain sınırları üzerinden geliştirilir.

1. `login` — **Giriş**: Şirket çalışma alanına güvenli erişim
2. `company-dashboard` — **Şirket Panosu**: Şirket kapasitesi ve aktif operasyonlar
3. `project-dashboard` — **Proje Panosu**: Godot mobil oyun üretim merkezi
4. `organization-tree` — **Organizasyon Ağacı**: Dinamik departman ve uzman ağı
5. `people-agents` — **İnsanlar ve Ajanlar**: Kapasite, yetki ve çalışma durumu
6. `task-board` — **Görev Panosu**: Bağımlılık tabanlı eşzamanlı çalışma
7. `task-detail` — **Görev Detayı**: Kabul kriterleri, kanıtlar ve teslim akışı
8. `general-chat` — **Genel Mimari**: Tüm ekip için mimari karar kanalı
9. `department-chat` — **Gameplay Departmanı**: Aynı uzmanlık grubunun çalışma kanalı
10. `task-chat` — **Görev Çalışma Grubu**: Göreve özel canlı iş akışı
11. `policy-center` — **Politika Merkezi**: Sürümlü şirket ve proje politikaları
12. `policy-pdf` — **Politika Belgesi**: Resmî PDF görüntüleme ve kabul
13. `file-explorer` — **Dosya Gezgini**: Proje çalışma alanı ve dosya sahipliği
14. `code-editor` — **Kod Editörü**: Patch tabanlı güvenli kod düzenleme
15. `diff-viewer` — **Değişiklik İncelemesi**: Branch farkı, test ve onay
16. `godot-scene` — **Godot Sahne Ağacı**: Node yapısı ve sahne işlemleri
17. `godot-inspector` — **Godot Inspector**: Seçili node özellikleri
18. `godot-logs` — **Godot Çıktıları**: Çalışma, hata ve performans logları
19. `live-preview` — **Canlı Önizleme**: Gerçek cihazda oyun testi
20. `build-center` — **Build Merkezi**: Android üretim ve dağıtım hattı
21. `agent-runs` — **Ajan Çalışmaları**: Planlama ve araç çağrısı izleme
22. `approvals` — **Onay Merkezi**: İnsan kararı bekleyen kritik işlemler
23. `audit-log` — **Denetim Kaydı**: Değiştirilemez kurumsal olay günlüğü
24. `settings` — **Ayarlar**: Şirket, güvenlik ve entegrasyonlar

## Mimari kural

Ekran kimlikleri UI içinde tekrar tanımlanmaz. Mobil navigasyon, yetkilendirme, deep link ve ekran görüntüsü renderer'ı aynı typed katalogdan beslenir. Feature ekranları doğrudan Supabase veya model sağlayıcısına erişmez; application use-case katmanını çağırır.
