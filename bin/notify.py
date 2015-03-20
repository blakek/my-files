#! /usr/bin/env python

import sys, argparse, os

def show_notification(args):
	command = "osascript -e 'display notification \"{0}\"".format(args.text)

	if (args.title):
		command += " with title \"{0}\"".format(args.title)

	if (args.sound):
		command += " sound name \"{0}\"".format(args.sound)

	command += "\'"

	os.system(command)

if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument('text', type=str, help='the body text of the notification')
	parser.add_argument('-s', '--sound', help='system sound to play when notification shows (if not found, a default is used)', type=str, nargs='?', const='asdf')
	parser.add_argument('-t', '--title', help='the title of the notification', type=str)
	args = parser.parse_args()

	show_notification(args)
