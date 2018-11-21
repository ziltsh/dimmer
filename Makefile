#
# Makefile for dimmer
#

# common install options
IOPT='-p -v'

~/bin/dimmer: ~/bin ~/.dimmerrc
	 install dimmer.bash $@

~/.dimmerrc: dimmerrc
	install -m 600 dimmerrc $@

~/bin:
	install -d $@

$@:
.PHONY: $@

report:
	ls -l ~/.dimmerrc ~/bin/dimmer
.PHONY: report

#.
