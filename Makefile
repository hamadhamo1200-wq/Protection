ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Protection
Protection_FILES = Tweak.xm
Protection_LIBRARIES = substrate
Protection_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries

include $(THEOS)/makefiles/tweak.mk
