/**
 * Notify When Done Extension
 *
 * Sends a native/system terminal notification when Pi finishes an agent run
 * and is ready for the next input.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { execFile } from "node:child_process";
import { basename } from "node:path";

function notifyMacOS(title: string, body: string): boolean {
	if (process.platform !== "darwin") return false;

	execFile(
		"osascript",
		[
			"-e",
			`display notification ${JSON.stringify(body)} with title ${JSON.stringify(title)} sound name "Glass"`,
		],
		(error) => {
			if (error) notifyTerminal(title, body);
		},
	);

	return true;
}

function sanitizeOscText(text: string): string {
	// Prevent terminal escape/control-sequence injection in OSC notifications.
	return text.replace(/[\u0000-\u001f\u007f-\u009f;]/g, " ");
}

function notifyTerminal(title: string, body: string): void {
	const safeTitle = sanitizeOscText(title);
	const safeBody = sanitizeOscText(body);

	if (process.env.KITTY_WINDOW_ID) {
		// Kitty OSC 99.
		process.stdout.write(`\x1b]99;i=pi-done:d=0;${safeTitle}\x1b\\`);
		process.stdout.write(`\x1b]99;i=pi-done:p=body;${safeBody}\x1b\\`);
		return;
	}

	// OSC 777: Ghostty, iTerm2, WezTerm, rxvt-unicode.
	process.stdout.write(`\x1b]777;notify;${safeTitle};${safeBody}\x07`);
}

function notify(title: string, body: string): void {
	if (notifyMacOS(title, body)) return;
	notifyTerminal(title, body);
}

export default function notifyWhenDone(pi: ExtensionAPI) {
	pi.on("agent_end", async (_event, ctx) => {
		const project = basename(ctx.cwd) || ctx.cwd;
		notify("Pi done", `Ready for input in ${project}`);
	});
}
