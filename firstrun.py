#!/usr/bin/python
import sys
from colorama import Fore, Style

sys.path.extend((
	'/usr/share/sabnzbdplus/',
))

from sabnzbd.config import read_config as sab_read_config
from sabnzbd import cfg as sab_config

FS_TITLE = "{fore}{{}}{reset}".format(fore=Fore.YELLOW, reset=Style.RESET_ALL)
FS_DEFAULT = "[{fore}{{}}{reset}]".format(fore=Fore.WHITE + Style.BRIGHT, reset=Style.RESET_ALL)
FS_QUESTION = "{fore}{{}}{reset}{{}}: ".format(fore=Fore.GREEN, reset=Style.RESET_ALL)

def title(text):
	print FS_TITLE.format(text)

def question_display(text, current=None, default=None):
	if current:
		default_text = FS_DEFAULT.format(current)
	elif default:
		default_text = FS_DEFAULT.format(default)
	else:
		default_text = ''

	print FS_QUESTION.format(text, default_text),

def question(text, current=None, default=None):
	question_display(text, current, default)
	val = sys.stdin.readline()

	if not val:
		if current:
			return current
		elif default:
			return default

	return val

# Load config
sab_read_config('/etc/sabnzbd/sabnzbd.ini')

# General configuration
title('General')
username = question('UI Username', sab_config.username.get_string(), 'admin')
password = question('UI Password')
#import ipdb; ipdb.set_trace()
