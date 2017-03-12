#! /bin/sh
. ${0%/*}/common.sh

for mod in ${modules}
do
	(cd "${MERABASE}/em${mod}" && git clean -dxf)
done
rm -rf "${DISTDIR}"
rm -rf "${BUILDDIR}"
