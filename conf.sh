#! /usr/bin/env bash

. "${0%/*}/common.sh"

mkdir -p "${DISTDIR}"
for mod in ${modules}
do
	export "em${mod}_DIR"="${MERABASE}/em${mod}"
done
for mod in ${modules}
do
	destdir="${DISTDIR}/out${RANDOM}"	
	mkdir -p "${destdir}" &&
	(cd "${MERABASE}/em${mod}" &&
	cmake -v -DCMAKE_INSTALL_PREFIX="${destdir}" . &&
	env VERBOSE=1 make &&
	env VERBOSE=1 make install) || exit 2
	[ -d "${destdir}/lib" ] && ld_library_path="${ld_library_path}${ld_library_path+:}${destdir}/lib"
done
echo "LD_LIBRARY_PATH=${ld_library_path}"
