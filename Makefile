GO_EASY_ON_ME = 1
include theos/makefiles/common.mk

TWEAK_NAME = SnapSelect
SnapSelect_FILES = Tweak.xm
SnapSelect_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk


