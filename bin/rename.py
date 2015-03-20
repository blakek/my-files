#! /usr/bin/env python

import argparse, os, re

beVerbose = False

def rename_files(replaceStr, withStr, files):
	for file in args.files:
		newName = re.subn(replaceStr, withStr, file)
		if newName[1] != 0:
			if beVerbose: print(file + ' => ' + newName[0])
			os.rename(file, newName[0])

if __name__ == "__main__":
	parser = argparse.ArgumentParser(description='Rename file similar to how `tr` works.')
	
	parser.add_argument('-v', '--verbose', help='print more garbage', action='store_true')
	parser.add_argument('replaceStr', help='string supplied to this option will be replaced by "with"', type=str)
	parser.add_argument('withStr', help='replaces string supplied in "replace"', type=str)
	parser.add_argument('files', help='files to change; can use simple regex to match multiple files', type=str, nargs='+')
	
	args = parser.parse_args()

	if args.verbose: beVerbose = True

	rename_files(args.replaceStr, args.withStr, args.files)
