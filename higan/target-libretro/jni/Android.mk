LOCAL_PATH := $(call my-dir)

ROOT_DIR  := $(LOCAL_PATH)/../../..
HIGAN_DIR := $(ROOT_DIR)/higan

corename ?= sfc

INCFLAGS  := -I$(ROOT_DIR) -I$(HIGAN_DIR)
COREFLAGS := -DANDROID -Dlibretro_use_$(corename) $(INCFLAGS)

SOURCES_C   := $(ROOT_DIR)/libco/libco.c
SOURCES_CXX := $(HIGAN_DIR)/target-libretro/libretro.cpp \
               $(HIGAN_DIR)/emulator/emulator.cpp \
               $(HIGAN_DIR)/audio/audio.cpp \
               $(HIGAN_DIR)/video/video.cpp \
               $(HIGAN_DIR)/resource/resource.cpp

SOURCES_CXX += $(HIGAN_DIR)/processor/arm7tdmi/arm7tdmi.cpp \
               $(HIGAN_DIR)/processor/gsu/gsu.cpp \
               $(HIGAN_DIR)/processor/hg51b/hg51b.cpp \
               $(HIGAN_DIR)/processor/huc6280/huc6280.cpp \
               $(HIGAN_DIR)/processor/lr35902/lr35902.cpp \
               $(HIGAN_DIR)/processor/m68k/m68k.cpp \
               $(HIGAN_DIR)/processor/mos6502/mos6502.cpp \
               $(HIGAN_DIR)/processor/spc700/spc700.cpp \
               $(HIGAN_DIR)/processor/upd96050/upd96050.cpp \
               $(HIGAN_DIR)/processor/v30mz/v30mz.cpp \
               $(HIGAN_DIR)/processor/wdc65816/wdc65816.cpp \
               $(HIGAN_DIR)/processor/z80/z80.cpp

ifeq ($(corename),sfc)
COREFLAGS   += -DSFC_SUPERGAMEBOY

SOURCES_CXX += $(HIGAN_DIR)/sfc/interface/interface.cpp \
               $(HIGAN_DIR)/sfc/system/system.cpp \
               $(HIGAN_DIR)/sfc/controller/controller.cpp \
               $(HIGAN_DIR)/sfc/cartridge/cartridge.cpp \
               $(HIGAN_DIR)/sfc/memory/memory.cpp \
               $(HIGAN_DIR)/sfc/cpu/cpu.cpp \
               $(HIGAN_DIR)/sfc/smp/smp.cpp \
               $(HIGAN_DIR)/sfc/dsp/dsp.cpp \
               $(HIGAN_DIR)/sfc/ppu/ppu.cpp \
               $(HIGAN_DIR)/sfc/expansion/expansion.cpp \
               $(HIGAN_DIR)/sfc/expansion/satellaview/satellaview.cpp \
               $(HIGAN_DIR)/sfc/expansion/21fx/21fx.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/icd2/icd2.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/mcc/mcc.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/nss/nss.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/event/event.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/sa1/sa1.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/superfx/superfx.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/armdsp/armdsp.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/hitachidsp/hitachidsp.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/necdsp/necdsp.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/epsonrtc/epsonrtc.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/sharprtc/sharprtc.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/spc7110/spc7110.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/sdd1/sdd1.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/obc1/obc1.cpp \
               $(HIGAN_DIR)/sfc/coprocessor/msu1/msu1.cpp \
               $(HIGAN_DIR)/sfc/slot/bsmemory/bsmemory.cpp \
               $(HIGAN_DIR)/sfc/slot/sufamiturbo/sufamiturbo.cpp
endif

ifneq ($(filter $(corename),sfc gb),)
SOURCES_CXX += $(HIGAN_DIR)/gb/interface/interface.cpp \
               $(HIGAN_DIR)/gb/system/system.cpp \
               $(HIGAN_DIR)/gb/cartridge/cartridge.cpp \
               $(HIGAN_DIR)/gb/memory/memory.cpp \
               $(HIGAN_DIR)/gb/cpu/cpu.cpp \
               $(HIGAN_DIR)/gb/ppu/ppu.cpp \
               $(HIGAN_DIR)/gb/apu/apu.cpp
endif

include $(CLEAR_VARS)
LOCAL_MODULE       := retro
LOCAL_SRC_FILES    := $(SOURCES_CXX) $(SOURCES_C)
LOCAL_CXXFLAGS     := $(COREFLAGS) -std=c++14
LOCAL_CFLAGS       := $(COREFLAGS)
LOCAL_CPP_FEATURES := exceptions rtti
LOCAL_ARM_MODE     := arm
include $(BUILD_SHARED_LIBRARY)
