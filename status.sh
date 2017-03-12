#! /bin/sh
. ${0%/*}/common.sh

for mod in ${modules}
do
	(cd "${MERABASE}/em${mod}" && git status)
done
