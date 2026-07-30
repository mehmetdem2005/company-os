# Mobile build source

The React Native Android source is stored as ordered Base64 chunks because this repository was bootstrapped through the GitHub connector.

```bash
cat source/mobile.zip.b64.part* | base64 --decode > /tmp/company-os-mobile.zip
echo "c72794030cc312fe8d6f8d01e5b021f6427b7200ba41b08ef7511508ddf2a8df  /tmp/company-os-mobile.zip" | sha256sum -c -
unzip /tmp/company-os-mobile.zip
```

The archive contains the `apps/mobile` project. Android lifecycle, React Native host, native module registration and the secured Godot snapshot boundary are implemented in Kotlin. React Native UI screens are TypeScript/TSX by design.
