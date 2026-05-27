/**
 * cmux Notification Extension
 *
 * Sends a cmux notification tagged to the pi agent's caller surface when pi
 * finishes an agent run and is ready for the next input.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { execFile } from "node:child_process";
import { basename } from "node:path";
import { promisify } from "node:util";

const execFileAsync = promisify(execFile);

interface CmuxIdentifyResult {
  caller?: {
    workspace_ref?: string;
    surface_ref?: string;
  };
}

async function cmuxRpc(
  method: string,
  params: Record<string, unknown>,
): Promise<void> {
  await execFileAsync("cmux", ["rpc", method, JSON.stringify(params)], {
    maxBuffer: 1024 * 1024,
  });
}

async function cmuxIdentify(): Promise<CmuxIdentifyResult> {
  const { stdout } = await execFileAsync("cmux", ["identify"], {
    maxBuffer: 1024 * 1024,
  });
  return JSON.parse(stdout) as CmuxIdentifyResult;
}

async function notifyCallerSurface(title: string, body: string): Promise<void> {
  const identity = await cmuxIdentify();
  const workspaceRef = identity.caller?.workspace_ref;
  const surfaceRef = identity.caller?.surface_ref;

  if (!workspaceRef || !surfaceRef) {
    throw new Error(
      "cmux identify did not return caller workspace_ref and surface_ref",
    );
  }

  await cmuxRpc("notification.create_for_surface", {
    workspace_id: workspaceRef,
    surface_id: surfaceRef,
    title,
    body,
  });
}

export default function cmuxNotificationExtension(pi: ExtensionAPI) {
  pi.on("agent_end", async (_event, ctx) => {
    const project = basename(ctx.cwd) || ctx.cwd;

    try {
      await notifyCallerSurface("pi agent", `finished working in ${project}`);
    } catch {
      // Do not surface notification failures in the agent UI.
    }
  });
}
