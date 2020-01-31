#
# Makefile for dimmer
#

# common install options
INSTALL=/usr/bin/install
# install options
#IOPT   = -p -v
# install options with backup
IOPT   = -p -v -b --suffix=bak`date '+%Y%m%d'`

PKG     = dimmer-script
DESTDIR = debian
HOMEDIR = ${DESTDIR}${HOME}
BIN_DIR = ${DESTDIR}${HOME}/bin

default:
	make -s usage
.PHONY: default

i: install
install: ${BIN_DIR}/dimmer
	make -s report
.PHONY: i install

u: uninstall
uninstall:
	-rm -v ${BIN_DIR}/dimmer
	-mv -v ${HOMEDIR}/.dimmerrc ${HOMEDIR}/.dimmerrc.uninstalled`date '+%Y%m%d'`
.PHONY: u uninstall

d: diff
diff:
	diff -q dimmer.bash ${BIN_DIR}/dimmer
	diff -q dimmerrc ${HOMEDIR}/.dimmerrc
.PHONY: d diff

${BIN_DIR}/dimmer: ${BIN_DIR} ${HOMEDIR}/.dimmerrc
	 ${INSTALL} ${I_OPT} dimmer.bash $@

${HOMEDIR}/.dimmerrc: dimmerrc
	${INSTALL} ${I_OPT} -m 600 dimmerrc $@

${BIN_DIR}:
	${INSTALL} ${I_OPT} -d $@

#$@:
#	printf "+ do nothing with %s\n" "$@"
#.PHONY: $@

report:
	ls -l ${HOMEDIR}/.dimmerrc ${BIN_DIR}/dimmer
.PHONY: report

usage:
	printf "\n"
	printf "  Usage: make [-s] {install|uninstall}\n"
	printf "                   {report}\n"
	printf "                   {default|usage}\n"
	printf "\n"
.PHONY: usage

#.
