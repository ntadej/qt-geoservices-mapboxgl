TARGET = qtgeoservices_mapboxgl

# Configure platform
macx {
    QT_PLATFORM = clang_64
} else:ios {
    QT_PLATFORM = ios
} else:android {
    QT_PLATFORM = android
} else {
    error("Unknown platform!")
}

message("Platform: $$QT_PLATFORM")

QT += \
    quick-private \
    location-private \
    positioning-private \
    network \
    sql

HEADERS += \
    qgeoserviceproviderpluginmapboxgl.h \
    qgeomappingmanagerenginemapboxgl.h \
    qgeomapmapboxgl.h \
    qgeomapmapboxgl_p.h \
    qmapboxglstylechange_p.h \
    qsgmapboxglnode.h

SOURCES += \
    qgeoserviceproviderpluginmapboxgl.cpp \
    qgeomappingmanagerenginemapboxgl.cpp \
    qgeomapmapboxgl.cpp \
    qmapboxglstylechange.cpp \
    qsgmapboxglnode.cpp

# Mapbox GL Native is always a static
# library linked to this plugin
QMAKE_CXXFLAGS += \
    -DQT_MAPBOXGL_STATIC

RESOURCES += mapboxgl.qrc

OTHER_FILES += \
    mapboxgl_plugin.json

INCLUDEPATH += mapbox-gl-native/include

include(zlib_dependency.pri)

load(qt_build_paths)

LIBS_PRIVATE += -L$$top_srcdir/mapbox-gl-native/lib/$$QT_PLATFORM -lqmapboxgl$$qtPlatformTargetSuffix()

qtConfig(icu) {
    QMAKE_USE_PRIVATE += icu
}

PLUGIN_TYPE = geoservices
PLUGIN_CLASS_NAME = QGeoServiceProviderFactoryMapboxGL
load(qt_plugin)
