export type Brand = 'match' | 'meetic' | 'okc' | 'pof';

export interface BrandConfig {
  id: Brand;
  name: string;
  primaryColor: string;
  secondaryColor: string;
  backgroundColor: string;
  surfaceColor: string;
  features: string[];
  apiEndpoints: {
    base: string;
    auth: string;
    profiles: string;
  };
}

export interface BrandTheme {
  id: Brand;
  name: string;
  colors: {
    primary: string;
    secondary: string;
    background: string;
    surface: string;
  };
}

export interface BrandFeature {
  id: Brand;
  name: string;
  feature: string;
  enabled: boolean;
}

