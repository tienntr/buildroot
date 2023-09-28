################################################################################
#
# sfml
#
################################################################################

SFML_VERSION = 2.6.0
SFML_SITE = $(call github,SFML,SFML,$(SFML_VERSION))
SFML_LICENSE = Zlib
SFML_LICENSE_FILES = license.md
SFML_INSTALL_STAGING = YES

SFML_CONF_OPTS += \
	-DSFML_BUILD_DOC=OFF \
	-DSFML_USE_SYSTEM_DEP=ON \
	-DSFML_INSTALL_PKGCONFIG_FILES=ON

ifeq ($(BR2_PACKAGE_SFML_EXAMPLES),y)
SFML_CONF_OPTS += -DSFML_BUILD_EXAMPLES=ON
endif

ifeq ($(BR2_PACKAGE_SFML_WINDOW),y)
SFML_DEPENDENCIES += \
	$(if $(BR2_PACKAGE_XLIB_LIBXCURSOR), xlib_libXcursor) \
	$(if $(BR2_PACKAGE_XLIB_LIBXRENDER), xlib_libXrender) \
	$(if $(BR2_PACKAGE_XLIB_LIBXRANDR), xlib_libXrandr) \
	libgl udev
SFML_CONF_OPTS += -DSFML_BUILD_WINDOW=ON
else
SFML_CONF_OPTS += -DSFML_BUILD_WINDOW=OFF
endif

ifeq ($(BR2_PACKAGE_SFML_GRAPHICS),y)
SFML_DEPENDENCIES += jpeg freetype
SFML_CONF_OPTS += -DSFML_BUILD_GRAPHICS=ON
else
SFML_CONF_OPTS += -DSFML_BUILD_GRAPHICS=OFF
endif

ifeq ($(BR2_PACKAGE_SFML_AUDIO),y)
SFML_DEPENDENCIES += openal libogg libvorbis flac
SFML_CONF_OPTS += -DSFML_BUILD_AUDIO=ON
else
SFML_CONF_OPTS += -DSFML_BUILD_AUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_SFML_NETWORK),y)
SFML_CONF_OPTS += -DSFML_BUILD_NETWORK=ON
else
SFML_CONF_OPTS += -DSFML_BUILD_NETWORK=OFF
endif

$(eval $(cmake-package))
