import path from "node:path";

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import {
  createBashToolDefinition,
  keyHint,
} from "@earendil-works/pi-coding-agent";
import { Text, truncateToWidth } from "@earendil-works/pi-tui";

const bashToolCache = new Map<
  string,
  ReturnType<typeof createBashToolDefinition>
>();

function getBashTool(cwd: string) {
  let tool = bashToolCache.get(cwd);
  if (!tool) {
    tool = createBashToolDefinition(cwd);
    bashToolCache.set(cwd, tool);
  }
  return tool;
}

function getTextOutput(result: {
  content?: Array<{ type: string; text?: string }>;
}) {
  return (
    result.content
      ?.filter(
        (content): content is { type: "text"; text: string } =>
          content.type === "text" && typeof content.text === "string",
      )
      .map((content) => content.text)
      .join("\n") ?? ""
  );
}

export default function (pi: ExtensionAPI) {
  const baseBashTool = getBashTool(process.cwd());

  pi.registerTool({
    ...baseBashTool,

    async execute(toolCallId, params, signal, onUpdate, ctx) {
      return getBashTool(ctx.cwd).execute(
        toolCallId,
        params,
        signal,
        onUpdate,
        ctx,
      );
    },

    renderResult(result, options, theme, context) {
      if (options.isPartial)
        return new Text(theme.fg("warning", "Running..."), 0, 0);

      const output = getTextOutput(result).trimEnd();

      if (options.expanded) {
        if (!output) return new Text("", 0, 0);
        const expandedOutput = output
          .split("\n")
          .map((line) => theme.fg("toolOutput", line))
          .join("\n");
        return new Text(`\n${expandedOutput}`, 0, 0);
      }

      const lines = output ? output.split("\n") : [];
      const lineCount = lines.length;
      const lineCountText = `${lineCount} ${lineCount === 1 ? "line" : "lines"}`;
      const details = result.details as
        | { truncation?: { truncated?: boolean }; fullOutputPath?: string }
        | undefined;
      const isTruncated =
        Boolean(details?.truncation?.truncated) ||
        Boolean(details?.fullOutputPath);
      const truncationSummary = details?.fullOutputPath
        ? `truncated: ${path.basename(details.fullOutputPath)}`
        : "truncated";
      const expandHint = keyHint("app.tools.expand", "to expand");
      const summary = theme.fg("muted", `${lineCountText}, `) + expandHint;
      const lastNonEmptyLine =
        [...lines].reverse().find((line) => line.trim().length > 0) ?? "";
      return {
        render(width: number) {
          const renderedSummary = truncateToWidth(summary, width, "…");
          const renderedTruncation = truncateToWidth(
            theme.fg("muted", truncationSummary),
            width,
            "…",
          );

          if (context.isError) {
            const renderedLines = [
              truncateToWidth(theme.fg("muted", lastNonEmptyLine), width, "…"),
              renderedSummary,
            ];
            if (isTruncated) renderedLines.push(renderedTruncation);
            return renderedLines;
          }

          const renderedLines = [renderedSummary];
          if (isTruncated) renderedLines.push(renderedTruncation);
          return renderedLines;
        },
        invalidate() {},
      };
    },
  });
}
