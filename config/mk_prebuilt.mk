# Use all private binaries
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/mk/prebuilt/private/bin/$(MK_CPU_ABI),system/bin)

# Use all private libraries
ifeq ($(MK_CPU_ABI),arm64-v8a)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/mk/prebuilt/private/lib/$(MK_CPU_ABI),system/lib64) \
    $(call find-copy-subdir-files,*.so,vendor/mk/prebuilt/private/lib/armeabi-v7a,system/lib)
else
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/mk/prebuilt/private/lib/$(MK_CPU_ABI),system/lib)
endif

# Offline Phone Location Database
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,mokee-phonelocation.dat,vendor/mk/prebuilt/common/media/location,system/media/location)

# Use all third-party files
ifneq ($(wildcard vendor/mk/prebuilt/third/app),)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.apk,vendor/mk/prebuilt/third/app,system/third-app)
endif

# Use all developers-party files
ifneq ($(DEVELOPER_MAINTAINER),)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.apk,vendor/mk/prebuilt/$(DEVELOPER_MAINTAINER)/app,system/third-app)
endif

# Google apps
ifeq ($(MK_CPU_ABI),arm64-v8a)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/mk/prebuilt/google/app/GooglePinYin/lib/$(MK_CPU_ABI),system/lib64) \
    $(call find-copy-subdir-files,*.so,vendor/mk/prebuilt/google/app/GooglePinYin/lib/armeabi-v7a,system/lib) \
    $(call find-copy-subdir-files,*.so,vendor/mk/prebuilt/google/app/GoogleIntl/lib/$(MK_CPU_ABI),system/lib64) \
    $(call find-copy-subdir-files,*.so,vendor/mk/prebuilt/google/app/GoogleIntl/lib/armeabi-v7a,system/lib)
else
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/mk/prebuilt/google/app/GooglePinYin/lib/$(MK_CPU_ABI),system/lib) \
    $(call find-copy-subdir-files,*.so,vendor/mk/prebuilt/google/app/GoogleIntl/lib/$(MK_CPU_ABI),system/lib)
endif
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.apk,vendor/mk/prebuilt/google/app/GooglePinYin,system/app/GooglePinYin) \
    $(call find-copy-subdir-files,*.apk,vendor/mk/prebuilt/google/app/GoogleIntl,system/app/GoogleIntl)