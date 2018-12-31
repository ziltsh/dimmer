#! /bin/bash
#
# dimmer.sh
#

set -u
THIS="$(basename $0)"

CFG_FILE=~/.dimmerrc
brightness=1.0
gamma=1.0:1.0:1.0


function GetActiveMonitors () {
	xrandr --listactivemonitors \
		| awk '/^ /{print $2}' \
		| tr -d '*+'
	return $?
}

function Log () {
	local msg="$@"
	local tag="$THIS"
	local pri='notice'
	logger -t $tag -p $pri "$msg"
}

# main

# load settings from file
[ -r $CFG_FILE ] && . $CFG_FILE

Log "setting brightness to $brightness and gamma to $gamma"

# loop active monitors
for M in $(GetActiveMonitors); do
	xrandr --output $M --gamma $gamma --brightness $brightness
done

#.

##
# usage: xrandr [options]
#   where options are:
#   --display <display> or -d <display>
#   --help
#   -o <normal,inverted,left,right,0,1,2,3>
#             or --orientation <normal,inverted,left,right,0,1,2,3>
#   -q        or --query
#   -s <size>/<width>x<height> or --size <size>/<width>x<height>
#   -r <rate> or --rate <rate> or --refresh <rate>
#   -v        or --version
#   -x        (reflect in x)
#   -y        (reflect in y)
#   --screen <screen>
#   --verbose
#   --current
#   --dryrun
#   --nograb
#   --prop or --properties
#   --fb <width>x<height>
#   --fbmm <width>x<height>
#   --dpi <dpi>/<output>
#   --output <output>
#       --auto
#       --mode <mode>
#       --preferred
#       --pos <x>x<y>
#       --rate <rate> or --refresh <rate>
#       --reflect normal,x,y,xy
#       --rotate normal,inverted,left,right
#       --left-of <output>
#       --right-of <output>
#       --above <output>
#       --below <output>
#       --same-as <output>
#       --set <property> <value>
#       --scale <x>x<y>
#       --scale-from <w>x<h>
#       --transform <a>,<b>,<c>,<d>,<e>,<f>,<g>,<h>,<i>
#       --off
#       --crtc <crtc>
#       --panning <w>x<h>[+<x>+<y>[/<track:w>x<h>+<x>+<y>[/<border:l>/<t>/<r>/<b>]]]
#       --gamma <r>:<g>:<b>
#       --brightness <value>
#       --primary
#   --noprimary
#   --newmode <name> <clock MHz>
#             <hdisp> <hsync-start> <hsync-end> <htotal>
#             <vdisp> <vsync-start> <vsync-end> <vtotal>
#             [flags...]
#             Valid flags: +HSync -HSync +VSync -VSync
#                          +CSync -CSync CSync Interlace DoubleScan
#   --rmmode <name>
#   --addmode <output> <name>
#   --delmode <output> <name>
#   --listproviders
#   --setprovideroutputsource <prov-xid> <source-xid>
#   --setprovideroffloadsink <prov-xid> <sink-xid>
#   --listmonitors
#   --listactivemonitors
#   --setmonitor <name> {auto|<w>/<mmw>x<h>/<mmh>+<x>+<y>} {none|<output>,<output>,...}
#   --delmonitor <name>
##
