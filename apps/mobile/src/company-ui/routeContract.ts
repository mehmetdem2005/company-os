import type { CompanyScreenId } from './screenCatalog';

export interface CompanyRouteParams {
  readonly organizationId?: string;
  readonly projectId?: string;
  readonly taskId?: string;
  readonly channelId?: string;
  readonly policyVersionId?: string;
  readonly path?: string;
  readonly runId?: string;
}

export interface CompanyRoute {
  readonly screen: CompanyScreenId;
  readonly params: CompanyRouteParams;
}

export interface CompanyNavigationPort {
  readonly current: CompanyRoute;
  navigate(route: CompanyRoute): void;
  replace(route: CompanyRoute): void;
  goBack(): void;
}
