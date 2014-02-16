#!/usr/bin/python
import locale, string, sys, traceback

from dialog import Dialog

sys.path.extend((
	'/usr/share/sabnzbdplus/',
))

from sabnzbd.config import read_config as sab_read_config
from sabnzbd import cfg as sab_config, config as sab_config_utils

SAB_CONFIG = '/etc/sabnzbd/sabnzbd.ini'
DIALOG_DEFAULTS = {'height': 8, 'width': 80}
BIG_DIALOG_DEFAULTS = dict(DIALOG_DEFAULTS.items() + [('height', 35)])

def init_val(current, default):
	if not current:
		return default


def show_dialog(name, default, input_method, required=True, **kwargs):
	while True:
		cancelled, value = d.inputbox(name, init=default, **kwargs)

		if not value:
			cancelled = True

		if cancelled and required:
			d.msgbox("This field is required", title="Required", **DIALOG_DEFAULTS)
		else:
			return value


def sab_config_question(name, field, default='', required=True, attr=None, **kwargs):
	if isinstance(field, sab_config_utils.OptionPassword):
		input_method = d.passwordbox
		current_value = ''
	else:
		input_method = d.inputbox

		current_value = field.get_string()
		if not current_value:
			current_value = default

	while True:
		value = show_dialog(name, current_value, input_method, required, **kwargs)
		if input_method == d.passwordbox:
			repeat_value = show_dialog("%s (Again)" % name, '', input_method, True, **kwargs)
			if repeat_value != value:
				d.msgbox("Passwords do not match")
			else:
				break
		else:
			break

	# Set the value


def sab_server_menu(servers, action_text):
	server_names = servers.keys()
	server_choices = [(string.uppercase[idx], item) for idx, item in enumerate(server_names)]
	kwargs = dict(BIG_DIALOG_DEFAULTS.items() + [
		('height', min(BIG_DIALOG_DEFAULTS['height'], len(server_names) + 7))
	])
	cancelled, value = d.menu("%s which server?" % action_text, choices=server_choices, **kwargs)
	return cancelled, servers[dict(server_choices)[value]]

locale.setlocale(locale.LC_ALL, '')
d = Dialog(dialog="dialog")
d.setBackgroundTitle("Docker Usenet Pack - First Run")

try:
	# Load config
	sab_read_config(SAB_CONFIG)

	section_defaults = dict(DIALOG_DEFAULTS.items() + [('title', 'General Configuration')])
	sab_config_question("UI Username", sab_config.username, "admin", True, **section_defaults)
	sab_config_question("UI Password", sab_config.password, required=True, **section_defaults)

	usenet_servers = sab_config_utils.get_servers()
	if usenet_servers:
		done = False
		next_val = ("S", "Skip")
		while not done:
			big_section_defaults = dict(section_defaults.items() + [('height', 10)])
			cancelled, value = d.menu("Servers already configured", choices=(("E", "Edit"), ("D", "Delete"), next_val), **big_section_defaults)

			if value == 'E':
				cancelled, server = sab_server_menu(usenet_servers, "Edit")
			elif value == 'D':
				cancelled, server = sab_server_menu(usenet_servers, "Delete")
			next_val = ("O", "Done")
	# set download_dir
	# set complete_dir
	# setup servers
	# setup categories

except Exception:
	e_out = traceback.format_exc()
	kwargs = dict(BIG_DIALOG_DEFAULTS.items() + [
		('height', min(BIG_DIALOG_DEFAULTS['height'], e_out.count("\n") + 4))
	])
	d.scrollbox(e_out, title="Unexpected Error", **kwargs)

