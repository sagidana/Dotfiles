#!/usr/bin/env python3
import json
import sys

data = json.load(sys.stdin)

ctx = data.get("context_window", {})
ctx_used = ctx.get("used_percentage")

rate_limits = data.get("rate_limits", {}) or {}
five_hour_pct = (rate_limits.get("five_hour") or {}).get("used_percentage")
seven_day_pct = (rate_limits.get("seven_day") or {}).get("used_percentage")

ctx_str = "ctx: {:.0f}%".format(ctx_used) if ctx_used is not None else "ctx: ---"

usg_parts = []
if five_hour_pct is not None:
    usg_parts.append("5h {:.0f}%".format(five_hour_pct))
if seven_day_pct is not None:
    usg_parts.append("7d {:.0f}%".format(seven_day_pct))

parts = [ctx_str]
if usg_parts:
    parts.append("usg: " + " ".join(usg_parts))

print(" | ".join(parts), end="")
