# Audio
LOCAL_PATH := vendor/cherta/audio
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,$(LOCAL_PATH)/*,$(TARGET_COPY_OUT_PRODUCT)/media/audio)
