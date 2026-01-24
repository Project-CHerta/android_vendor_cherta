# Sounds
LOCAL_PATH := vendor/cherta/sounds
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/*,$(TARGET_COPY_OUT_PRODUCT)/media/audio)
