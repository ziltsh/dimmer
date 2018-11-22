#
# Makefile for dimmer
#

# common install options
INSTALL=/usr/bin/install
IOPT='-p -v'

default:
	make -s usage
.PHONY: default

install: ~/bin/dimmer
.PHONY: install
uninstall:
	-rm -v ~/bin/dimmer
	-mv -v ~/.dimmerrc ~/.dimmerrc.old
.PHONY: uninstall

~/bin/dimmer: ~/bin ~/.dimmerrc
	 ${INSTALL} ${I_OPT} dimmer.bash $@

~/.dimmerrc: dimmerrc
	${INSTALL} ${I_OPT} -m 600 dimmerrc $@

~/bin:
	${INSTALL} ${I_OPT} -d $@

#$@:
#	printf "+ do nothing with %s\n" "$@"
#.PHONY: $@

report:
	ls -l ~/.dimmerrc ~/bin/dimmer
.PHONY: report

usage:
	printf "\n"
	printf "  Usage: make [-s] {install|uninstall}\n"
	printf "                   {report}\n"
	printf "                   {default|usage}\n"
	printf "\n"
.PHONY: usage

#.
