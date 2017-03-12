#! /usr/bin/env bash

. "${0%/*}/common.sh"

mkdir -p "${DISTDIR}"
rm -rf "${BUILDDIR}"
mkdir -p "${BUILDDIR}"

builddir() {
	echo "${BUILDDIR}/${1}"
}
for mod in ${modules}
do
	export "em${mod}_DIR"="$(builddir "${mod}")"
done
for mod in ${modules}
do
	destdir="${DISTDIR}/out${RANDOM}"	
	builddir="$(builddir "${mod}")"
	mkdir -p "${destdir}" &&
	mkdir -p "${builddir}" &&
	(cd "${builddir}" &&
	cmake -v -DCMAKE_INSTALL_PREFIX="${destdir}" "${MERABASE}/em${mod}" &&
	env VERBOSE=1 make &&
	env VERBOSE=1 make install) || exit 2
	[ -d "${destdir}/lib" ] && ld_library_path="${ld_library_path}${ld_library_path+:}${destdir}/lib"
done
echo "LD_LIBRARY_PATH=${ld_library_path}"
