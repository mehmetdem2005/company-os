export type CompanyScreenDomain =
  | 'identity'
  | 'company'
  | 'work'
  | 'communication'
  | 'governance'
  | 'development'
  | 'operations';

export type CompanyScreenId =
  | 'login'
  | 'company-dashboard'
  | 'project-dashboard'
  | 'organization-tree'
  | 'people-agents'
  | 'task-board'
  | 'task-detail'
  | 'general-chat'
  | 'department-chat'
  | 'task-chat'
  | 'policy-center'
  | 'policy-pdf'
  | 'file-explorer'
  | 'code-editor'
  | 'diff-viewer'
  | 'godot-scene'
  | 'godot-inspector'
  | 'godot-logs'
  | 'live-preview'
  | 'build-center'
  | 'agent-runs'
  | 'approvals'
  | 'audit-log'
  | 'settings';

export interface CompanyScreenDefinition {
  readonly id: CompanyScreenId;
  readonly title: string;
  readonly subtitle: string;
  readonly domain: CompanyScreenDomain;
  readonly requiresProject: boolean;
}

export const COMPANY_SCREENS: readonly CompanyScreenDefinition[] = [
  { id: 'login', title: 'Giriş', subtitle: 'Şirket çalışma alanına güvenli erişim', domain: 'identity', requiresProject: false },
  { id: 'company-dashboard', title: 'Şirket Panosu', subtitle: 'Şirket kapasitesi ve aktif operasyonlar', domain: 'company', requiresProject: false },
  { id: 'project-dashboard', title: 'Proje Panosu', subtitle: 'Godot mobil oyun üretim merkezi', domain: 'company', requiresProject: true },
  { id: 'organization-tree', title: 'Organizasyon Ağacı', subtitle: 'Dinamik departman ve uzman ağı', domain: 'company', requiresProject: false },
  { id: 'people-agents', title: 'İnsanlar ve Ajanlar', subtitle: 'Kapasite, yetki ve çalışma durumu', domain: 'company', requiresProject: false },
  { id: 'task-board', title: 'Görev Panosu', subtitle: 'Bağımlılık tabanlı eşzamanlı çalışma', domain: 'work', requiresProject: true },
  { id: 'task-detail', title: 'Görev Detayı', subtitle: 'Kabul kriterleri, kanıtlar ve teslim akışı', domain: 'work', requiresProject: true },
  { id: 'general-chat', title: 'Genel Mimari', subtitle: 'Tüm ekip için mimari karar kanalı', domain: 'communication', requiresProject: true },
  { id: 'department-chat', title: 'Gameplay Departmanı', subtitle: 'Aynı uzmanlık grubunun çalışma kanalı', domain: 'communication', requiresProject: true },
  { id: 'task-chat', title: 'Görev Çalışma Grubu', subtitle: 'Göreve özel canlı iş akışı', domain: 'communication', requiresProject: true },
  { id: 'policy-center', title: 'Politika Merkezi', subtitle: 'Sürümlü şirket ve proje politikaları', domain: 'governance', requiresProject: true },
  { id: 'policy-pdf', title: 'Politika Belgesi', subtitle: 'Resmî PDF görüntüleme ve kabul', domain: 'governance', requiresProject: true },
  { id: 'file-explorer', title: 'Dosya Gezgini', subtitle: 'Proje çalışma alanı ve dosya sahipliği', domain: 'development', requiresProject: true },
  { id: 'code-editor', title: 'Kod Editörü', subtitle: 'Patch tabanlı güvenli kod düzenleme', domain: 'development', requiresProject: true },
  { id: 'diff-viewer', title: 'Değişiklik İncelemesi', subtitle: 'Branch farkı, test ve onay', domain: 'development', requiresProject: true },
  { id: 'godot-scene', title: 'Godot Sahne Ağacı', subtitle: 'Node yapısı ve sahne işlemleri', domain: 'development', requiresProject: true },
  { id: 'godot-inspector', title: 'Godot Inspector', subtitle: 'Seçili node özellikleri', domain: 'development', requiresProject: true },
  { id: 'godot-logs', title: 'Godot Çıktıları', subtitle: 'Çalışma, hata ve performans logları', domain: 'development', requiresProject: true },
  { id: 'live-preview', title: 'Canlı Önizleme', subtitle: 'Gerçek cihazda oyun testi', domain: 'development', requiresProject: true },
  { id: 'build-center', title: 'Build Merkezi', subtitle: 'Android üretim ve dağıtım hattı', domain: 'operations', requiresProject: true },
  { id: 'agent-runs', title: 'Ajan Çalışmaları', subtitle: 'Planlama ve araç çağrısı izleme', domain: 'operations', requiresProject: true },
  { id: 'approvals', title: 'Onay Merkezi', subtitle: 'İnsan kararı bekleyen kritik işlemler', domain: 'governance', requiresProject: true },
  { id: 'audit-log', title: 'Denetim Kaydı', subtitle: 'Değiştirilemez kurumsal olay günlüğü', domain: 'governance', requiresProject: true },
  { id: 'settings', title: 'Ayarlar', subtitle: 'Şirket, güvenlik ve entegrasyonlar', domain: 'governance', requiresProject: false },
] as const;

export function getCompanyScreen(id: CompanyScreenId): CompanyScreenDefinition {
  const screen = COMPANY_SCREENS.find(candidate => candidate.id === id);
  if (!screen) {
    throw new Error(`Unknown Company OS screen: ${id}`);
  }
  return screen;
}
