#!/usr/bin/env python3

import json
import subprocess

current_window = json.loads(subprocess.check_output(
	['hyprctl', 'activewindow', '-j']))
clients = json.loads(subprocess.check_output(["hyprctl", "clients", "-j"]))

print(current_window)

target = ''
if current_window['floating']:
	def dist_sqr(a, b):
		return (a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2
	tileds = [c for c in clients if (
		not c['floating'] and
		c['workspace']['id'] == current_window['workspace']['id']
	)]

	if len(tileds) <= 0: exit()

	center = (
		current_window['at'][0] + current_window['size'][0] / 2,
		current_window['at'][1] + current_window['size'][1] / 2,
	)

	target = min(
		tileds,
		key=lambda t: dist_sqr(
			(
				t['at'][0] + t['size'][0] / 2,
				t['at'][1] + t['size'][1] / 2,
			),
			center,
		),
	)['address']


else:
	for c in clients:
		if c['floating'] and\
			c['workspace']['id'] == current_window['workspace']['id']:
			target = c['address']
			break


if target:
	subprocess.run([
		"hyprctl",
		"dispatch",
		f"hl.dsp.focus({{window='address:{target}'}})"
	])
