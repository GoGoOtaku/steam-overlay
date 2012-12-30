# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

# Please report bugs/suggestions on: https://github.com/anyc/steam-overlay
# or come to #gentoo-gamerlay in freenode IRC

DESCRIPTION="Meta package for Steam games"
HOMEPAGE="https://steampowered.com"
SRC_URI=""
LICENSE="metapackage"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="s3tc testdeps video_cards_intel video_cards_fglrx"

# add USE_EXPAND="${USE_EXPAND} STEAMGAMES" to your make.conf for proper
# display of steamgames use flags
IUSE_STEAMGAMES="unwritten_tales tf2"

for sgame in ${IUSE_STEAMGAMES}; do
	IUSE="${IUSE} steamgames_${sgame}"
done

RDEPEND="
		s3tc? (
			amd64? ( media-libs/libtxc_dxtn[multilib] )
			x86? ( media-libs/libtxc_dxtn )
			)
		testdeps? (
			x86? (
				dev-games/ogre
				dev-lang/mono
				media-libs/freealut
				media-libs/sdl-image
				media-libs/sdl-mixer
				media-libs/sdl-ttf
				media-libs/tiff
				net-dns/libidn
				net-misc/curl
				sys-apps/pciutils
				x11-misc/xclip
				)
			)
		steamgames_unwritten_tales? (
			x86? ( media-libs/jasper )
			)
		steamgames_tf2? (
				video_cards_fglrx? ( >=x11-drivers/ati-drivers-12.8 )
			)
		"
REQUIRED_USE="
		steamgames_tf2? (
				video_cards_intel? ( s3tc )
			)
		"

pkg_postinst() {
	if use x86; then
		elog "If a game does not start, please enable \"testdeps\" use-flag and"
		elog "check if it fixes the issue. Please report, if and which one of the"
		elog "dependencies is required for a game, so we can mark it accordingly."
	fi

	if use amd64; then
		elog "If a game does not start, please take a look at the dependencies"
		elog "for the x86 architecture in this ebuild. It might be required that"
		elog "you build them in a x86 chroot environment or using crossdev (see"
		elog "http://en.gentoo-wiki.com/wiki/Crossdev ). Please report, if and"
		elog "which one of the dependencies is required for a game, so we can"
		elog "request the inclusion in the emul-linux-x86* packages, see:"
		elog "https://bugs.gentoo.org/show_bug.cgi?id=446682"
	fi
	elog "Ebuild development website: https://github.com/anyc/steam-overlay"
}
