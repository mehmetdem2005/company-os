export const companyTokens = {
  color: {
    canvas: '#070A0F',
    surface: '#0D1119',
    raised: '#121824',
    border: '#202A3A',
    text: '#F4F7FB',
    textMuted: '#8D99AA',
    cyan: '#64D8FF',
    violet: '#9887FF',
    green: '#55D69E',
    amber: '#FFC66D',
    red: '#FF7185',
    white: '#FFFFFF',
  },
  radius: { sm: 8, md: 14, lg: 20, xl: 28 },
  space: { xs: 4, sm: 8, md: 12, lg: 16, xl: 24, xxl: 32 },
  type: { caption: 11, body: 13, label: 14, title: 22, display: 30 },
} as const;

export type CompanyTokens = typeof companyTokens;
