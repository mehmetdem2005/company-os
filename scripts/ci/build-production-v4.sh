#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"

restore_mobile() {
  cat \
    source/mobile.zip.b64.part00 source/mobile.zip.b64.part01 \
    source/mobile.zip.b64.part02a source/mobile.zip.b64.part02b \
    source/mobile.zip.b64.part03 source/mobile.zip.b64.part04 \
    source/mobile.zip.b64.part05 source/mobile.zip.b64.part06a \
    source/mobile.zip.b64.part06b source/mobile.zip.b64.part07 \
    source/mobile.zip.b64.part08 source/mobile.zip.b64.part09 \
    source/mobile.zip.b64.part10 source/mobile.zip.b64.part11 \
    | base64 --decode > /tmp/company-os-mobile.zip
  echo "c72794030cc312fe8d6f8d01e5b021f6427b7200ba41b08ef7511508ddf2a8df  /tmp/company-os-mobile.zip" | sha256sum -c -
  unzip -t /tmp/company-os-mobile.zip >/dev/null
  unzip -q /tmp/company-os-mobile.zip

  cat source/no-mock-overlay/mobile-overlay.zip.b64.part* | base64 --decode > /tmp/company-os-no-mock.zip
  echo "fc112ad682df00662d0996dbc610cedd36b4394d742e77edff845218547c4ce9  /tmp/company-os-no-mock.zip" | sha256sum -c -
  unzip -t /tmp/company-os-no-mock.zip >/dev/null
  unzip -qo /tmp/company-os-no-mock.zip
  patch -p1 < patches/no-mock/live-screens-filter.patch
  patch -p1 < patches/no-mock/godot-host-package.patch

  cat source/live-runtime-v2/mobile-overlay.zip.b64.part* | base64 --decode > /tmp/company-os-live.zip
  echo "fe254e84d6177bdeb6d2e04dd2b2761c7d72590b45dea38a917e3b5ac6bb7499  /tmp/company-os-live.zip" | sha256sum -c -
  unzip -t /tmp/company-os-live.zip >/dev/null
  unzip -qo /tmp/company-os-live.zip

  cat source/production-ui-primitives-v1/overlay.zip.b64 | base64 --decode > /tmp/company-os-ui.zip
  echo "84d36210059562dd67c9f427084a4fbb0b872bea8ccd61cd3aedb0eebceeceb1  /tmp/company-os-ui.zip" | sha256sum -c -
  unzip -t /tmp/company-os-ui.zip >/dev/null
  unzip -qo /tmp/company-os-ui.zip
  test "$(wc -l < apps/mobile/src/components/primitives.tsx)" -le 360

  rm -f \
    apps/mobile/src/features/dashboard/DashboardScreens.tsx \
    apps/mobile/src/features/organization/OrganizationScreens.tsx \
    apps/mobile/src/features/tasks/TaskScreens.tsx \
    apps/mobile/src/features/chat/ChatScreens.tsx \
    apps/mobile/src/features/policies/PolicyScreens.tsx \
    apps/mobile/src/features/workspace/WorkspaceScreens.tsx \
    apps/mobile/src/features/godot/GodotScreens.tsx \
    apps/mobile/src/features/operations/OperationsScreens.tsx
}

restore_control_plane() {
  cat source/database/company-os-schema.zip.b64.part* | base64 --decode > /tmp/company-os-schema.zip
  echo "62faa0469b86f20f03b49c2235a7c5d07dfb46b88f67a58a57e668dfc6375045  /tmp/company-os-schema.zip" | sha256sum -c -
  unzip -t /tmp/company-os-schema.zip >/dev/null
  unzip -qo /tmp/company-os-schema.zip

  cat \
    source/control-plane-v3/overlay.zip.b64.part00 \
    source/control-plane-v3/overlay.zip.b64.part01a \
    source/control-plane-v3/overlay.zip.b64.part01b \
    source/control-plane-v3/overlay.zip.b64.part01c0 \
    source/control-plane-v3/overlay.zip.b64.part01c1 \
    source/control-plane-v3/overlay.zip.b64.part01c2 \
    source/control-plane-v3/overlay.zip.b64.part02a \
    source/control-plane-v3/overlay.zip.b64.part02b \
    source/control-plane-v3/overlay.zip.b64.part02c \
    source/control-plane-v3/overlay.zip.b64.part030 \
    source/control-plane-v3/overlay.zip.b64.part031 \
    source/control-plane-v3/overlay.zip.b64.part032 \
    | base64 --decode > /tmp/company-os-control.zip
  echo "704ba373f44c1913a76886a6306c2f68871eac6894fd3a925ea1dbcd07364dda  /tmp/company-os-control.zip" | sha256sum -c -
  unzip -t /tmp/company-os-control.zip >/dev/null
  unzip -qo /tmp/company-os-control.zip

  local parts=(source/staged-control-plane-core-v2/archive.tar.xz.b64.part*)
  test "${#parts[@]}" -eq 9
  cat "${parts[@]}" | base64 --decode > /tmp/company-os-core.tar.xz
  echo "dc844d22af5e0a2b0c028c1f49a65688114abaedef0bfdf4ea1b5ef90632d312  /tmp/company-os-core.tar.xz" | sha256sum -c -
  xz --test /tmp/company-os-core.tar.xz
  test "$(tar -tJf /tmp/company-os-core.tar.xz | wc -l)" -eq 47
  tar -xJf /tmp/company-os-core.tar.xz -C .

  test -f tsconfig.base.json
  test -f tsconfig.core.json
  test -f apps/control-plane/src/CompanyRuntime.ts
  test -f packages/contracts/src/index.ts
  test -f packages/persistence/src/index.ts
  test -f scripts/architecture-check.mjs
}

configure_mobile_typescript() {
  cat > apps/mobile/tsconfig.json <<'JSON'
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022"],
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "jsx": "react-jsx",
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": false,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "resolveJsonModule": true,
    "noEmit": true,
    "types": ["react", "react-native"]
  },
  "include": ["src/**/*.ts", "src/**/*.tsx"],
  "exclude": ["node_modules", "android"]
}
JSON
}

enforce_real_data() {
  ! grep -RInE 'Demo çalışma alanını aç|TASK-[0-9]+|Godot Mobile Alpha|BUILD #[0-9]+|POL-[0-9]+' \
    apps/mobile/src apps/control-plane/src packages

  python - <<'PY'
import re
from pathlib import Path
live = Path('apps/mobile/src/features/live/LiveScreens.tsx').read_text()
schema = '\n'.join(p.read_text().lower() for p in sorted(Path('supabase/migrations').glob('*.sql')))
tables = set(re.findall(r"table:\s*'([a-z_]+)'", live))
tables.update(re.findall(r"useLiveRows\('([a-z_]+)'", live))
missing = sorted(t for t in tables if f'create table public.{t}' not in schema and f'create table if not exists public.{t}' not in schema)
if missing:
    raise SystemExit(f'Missing real tables: {missing}')
required = ('bootstrap_workspace','apply_organization_plan','acquire_project_execution_lease','release_project_execution_lease','project_execution_leases','supabase_realtime')
absent = [item for item in required if item not in schema]
if absent:
    raise SystemExit(f'Missing runtime capabilities: {absent}')
print('Real-data contract validated for', len(tables), 'tables')
PY
}

install_and_verify() {
  (
    cd apps/mobile
    npm install --workspaces=false --no-audit --no-fund
    test -d node_modules/@react-native/gradle-plugin
    npm run typecheck
  )

  local tsc_js="$ROOT/apps/mobile/node_modules/typescript/bin/tsc"
  test -f "$tsc_js"
  node "$tsc_js" -p tsconfig.core.json --noEmit
  rm -rf dist
  node "$tsc_js" -p tsconfig.core.json
  node --test tests/*.test.mjs
  node scripts/architecture-check.mjs
}

build_android() {
  yes | sdkmanager --licenses >/dev/null || true
  sdkmanager "platforms;android-36" "build-tools;36.0.0" "ndk;27.1.12297006"

  rm -f apps/mobile/android/app/debug.keystore
  keytool -genkeypair -v -storetype PKCS12 \
    -keystore apps/mobile/android/app/debug.keystore \
    -storepass android -alias androiddebugkey -keypass android \
    -keyalg RSA -keysize 2048 -validity 10000 \
    -dname "CN=Android Debug,O=Company OS,C=TR"

  gradle -p apps/mobile/android :app:assembleRelease --stacktrace --no-daemon

  local apk="apps/mobile/android/app/build/outputs/apk/release/app-release.apk"
  test -s "$apk"
  unzip -t "$apk" >/dev/null
  sha256sum "$apk" | tee "$apk.sha256"

  zip -qr /tmp/company-os-production-v4-source.zip . \
    -x '.git/*' '*/node_modules/*' '*/build/*' 'dist/*'
  unzip -t /tmp/company-os-production-v4-source.zip >/dev/null
  sha256sum /tmp/company-os-production-v4-source.zip > /tmp/company-os-production-v4-source.zip.sha256
}

restore_mobile
restore_control_plane
configure_mobile_typescript
enforce_real_data
install_and_verify
build_android
