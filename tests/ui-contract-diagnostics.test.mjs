import test from "node:test";
import { readFile, readdir } from "node:fs/promises";
import path from "node:path";

async function walk(directory) {
  const entries = await readdir(directory, { withFileTypes: true });
  const files = [];
  for (const entry of entries) {
    const target = path.join(directory, entry.name);
    if (entry.isDirectory()) files.push(...await walk(target));
    else if (/\.(ts|tsx)$/.test(entry.name)) files.push(target);
  }
  return files;
}

test("print live UI contracts for deterministic repair", async () => {
  const livePath = "apps/mobile/src/features/live/LiveScreens.tsx";
  const live = await readFile(livePath, "utf8");
  const lines = live.split("\n");
  console.log("LIVE_IMPORTS\n" + lines.slice(0, 45).join("\n"));
  console.log("LIVE_ERROR_REGION\n" + lines.slice(270, 320).join("\n"));

  const files = await walk("apps/mobile/src/components");
  for (const file of files) {
    const source = await readFile(file, "utf8");
    if (/function\s+(Avatar|ListItem|SectionHeader)|const\s+(Avatar|ListItem|SectionHeader)/.test(source)) {
      console.log(`COMPONENT_CONTRACT ${file}\n${source}`);
    }
  }
});
