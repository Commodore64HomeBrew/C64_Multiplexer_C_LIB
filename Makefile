# Makefile 
CC65_PATH ?=
SOURCE_PATH ?= ./src
GRAPHICS_PATH ?= ./graphics
SID_PATH ?= ./sid
ASMFILES=$(SOURCE_PATH)/multi_ca65_split.s $(GRAPHICS_PATH)/graphics.s

ASMTEST=$(SOURCE_PATH)/irq_test.s $(GRAPHICS_PATH)/graphics.s

BUILD_PATH ?= ./build


MYCCFLAGS=-t c64 -O -Cl
MYC128CCFLAGS=-t c128 -O -Cl
MYDEBUGCCFLAGS=-t c64
MULTICFG=--asm-define MULTICOLOR=1 -DMULTI_COLOR
EXPANDXCFG=--asm-define EXPANDX=1 -DEXPAND_X
EXPANDYCFG=--asm-define EXPANDY=1 -DEXPAND_Y


MYCFG=--config ./cfg/c64_multiplexer_gfx_at_2000.cfg --asm-define USE_KERNAL=1
MYC128CFG=--config ./cfg/c128_multiplexer_gfx_at_3000.cfg --asm-define USE_KERNAL=1
MYSIDCFG=--config ./cfg/c64_multiplexer_sid_at_1000_gfx_at_2000.cfg --asm-define USE_KERNAL=1
MYSIDC128CFG=--config ./cfg/c128_multiplexer_sid_at_2400_gfx_at_3000.cfg --asm-define USE_KERNAL=1


ifneq ($(COMSPEC),)
DO_WIN:=1
endif
ifneq ($(ComSpec),)
DO_WIN:=1
endif 

ifeq ($(DO_WIN),1)
EXEEXT = .exe
endif

ifeq ($(DO_WIN),1)
COMPILEDEXT = .exe
else
COMPILEDEXT = .out
endif

MYCC65 ?= cc65$(EXEEXT) $(INCLUDE_OPTS) 
MYCL65 ?= cl65$(EXEEXT) $(INCLUDE_OPTS) 


some_sprites: 
	$(CC65_PATH)$(MYCL65) $(MYCCFLAGS) $(MYCFG) \
	--asm-define MAXSPR=26 -D_NUMBER_OF_SPRITES_=26 -D_SPRITE_SEPARATION_=24 \
	--asm-define FAST_MODE=1 \
	$(SOURCE_PATH)/many_sprites.c $(ASMFILES) \
	-o $(BUILD_PATH)/some_sprites.prg
	rm $(SOURCE_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o

many_sprites: 
	$(CC65_PATH)$(MYCL65) $(MYCCFLAGS) $(MYCFG) \
	--asm-define MAXSPR=36 -D_NUMBER_OF_SPRITES_=36 -D_SPRITE_SEPARATION_=25 \
	--asm-define FAST_MODE=1 \
	$(SOURCE_PATH)/many_sprites.c $(ASMFILES) \
	-o $(BUILD_PATH)/many_sprites.prg
	rm $(SOURCE_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o

sin_scroller:
	$(CC65_PATH)$(MYCL65) $(MYCCFLAGS) $(MYCFG) \
	--asm-define FAST_MODE=1 \
	--asm-define MAXSPR=16 \
	$(SOURCE_PATH)/sin_scroller.c $(ASMFILES) -o $(BUILD_PATH)/sin_scroller.prg
	rm $(SOURCE_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o

sin_scroller_multicolor:
	$(CC65_PATH)$(MYCL65) $(MYCCFLAGS) $(MYCFG) $(MULTICFG) \
	--asm-define MAXSPR=16  \
	--asm-define FAST_MODE=1 \
	$(SOURCE_PATH)/sin_scroller.c $(ASMFILES) \
	-o $(BUILD_PATH)/sin_scroller_multicolor.prg
	rm $(SOURCE_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o

    
sin_scroller_expand_x:
	$(CC65_PATH)$(MYCL65) $(MYCCFLAGS) $(MYCFG) $(EXPANDXCFG) \
	--asm-define MAXSPR=16  \
	--asm-define FAST_MODE=1 \
	$(SOURCE_PATH)/sin_scroller.c $(ASMFILES) \
	-o $(BUILD_PATH)/sin_scroller_expand_x.prg
	rm $(SOURCE_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o    

sin_scroller_multicolor_expand_x:
	$(CC65_PATH)$(MYCL65) $(MYCCFLAGS) $(MYCFG) $(EXPANDXCFG) $(MULTICFG) \
	--asm-define MAXSPR=16  \
	--asm-define FAST_MODE=1 \
	$(SOURCE_PATH)/sin_scroller.c $(ASMFILES) \
	-o $(BUILD_PATH)/sin_scroller_multicolor_expand_x.prg
	rm $(SOURCE_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o 
    
sin_scroller_expand_y:
	$(CC65_PATH)$(MYCL65) $(MYCCFLAGS) $(MYCFG) $(EXPANDYCFG) \
	--asm-define MAXSPR=16  \
	--asm-define FAST_MODE=1 \
	$(SOURCE_PATH)/sin_scroller.c $(ASMFILES) \
	-o $(BUILD_PATH)/sin_scroller_expand_y.prg
	rm $(SOURCE_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o   

sin_scroller_music:
	$(CC65_PATH)$(MYCL65) $(MYCCFLAGS) $(MYSIDCFG) \
	--asm-define MAXSPR=16  \
	--asm-define FAST_MODE=1 \
	--asm-define MUSIC_CODE=1 \
	$(SID_PATH)/sid.s \
	$(SOURCE_PATH)/sin_scroller.c $(ASMFILES) \
	-o $(BUILD_PATH)/sin_scroller_music.prg
	rm $(SOURCE_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o
	rm $(SID_PATH)/*.o        
    
sin_scroller_c128:
	$(CC65_PATH)$(MYCL65) $(MYC128CCFLAGS) $(MYC128CFG) \
	--asm-define MAXSPR=16 \
	--asm-define FAST_MODE=1 \
	$(SOURCE_PATH)/multi_ca65_split.s \
	$(SOURCE_PATH)/sin_scroller.c \
	$(GRAPHICS_PATH)/graphics.s \
	-o $(BUILD_PATH)/sin_scroller_c128.prg
	rm $(SOURCE_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o

sin_scroller_music_c128:
	$(CC65_PATH)$(MYCL65) $(MYC128CCFLAGS) $(MYSIDC128CFG) \
	--asm-define MAXSPR=16 \
	--asm-define FAST_MODE=1 \
	--asm-define MUSIC_CODE=1 \
	$(SOURCE_PATH)/sin_scroller.c \
	$(SOURCE_PATH)/multi_ca65_split.s \
	$(SID_PATH)/sid_at_2400.s \
    $(GRAPHICS_PATH)/graphics.s \
	-o $(BUILD_PATH)/sin_scroller_music_c128.prg
	rm $(SOURCE_PATH)/*.o
	rm $(SID_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o   


all: some_sprites many_sprites sin_scroller sin_scroller_multicolor sin_scroller_expand_x sin_scroller_multicolor_expand_x sin_scroller_expand_y sin_scroller_music sin_scroller_c128 sin_scroller_music_c128


clean:
	rm -rf *.prg
	rm -rf $(SOURCE_PATH)/*.o
	rm -rf ./build/*
	rm -rf main.s

    
many_sprites_debug:
	$(CC65_PATH)$(MYCC65) $(MYDEBUGCCFLAGS) -D_NUMBER_OF_SPRITES_=26 -D_SPRITE_SEPARATION_=25 \
	$(SOURCE_PATH)/many_sprites.c -o $(SOURCE_PATH)/many_sprites.s
	$(CC65_PATH)$(MYCL65) $(MYDEBUGCCFLAGS) $(MYCFG) --asm-define DEBUG=1 --asm-define MAXSPR=34 -D_NUMBER_OF_SPRITES_=36  \
	$(SOURCE_PATH)/many_sprites.s $(ASMFILES) \
	-o $(BUILD_PATH)/many_sprites_debug.prg
	rm $(SOURCE_PATH)/many_sprites.s
	rm $(SOURCE_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o
    
 
sid_debug:
	$(CC65_PATH)$(MYCL65) $(MYCCFLAGS) $(MYSIDCFG) \
	--asm-define MAXSPR=16  \
	--asm-define FAST_MODE=1 \
	--asm-define MUSIC_CODE=1 \
	--asm-define DEBUG=1 \
	$(SID_PATH)/sid.s \
	$(SOURCE_PATH)/sin_scroller.c $(ASMFILES) \
	-o $(BUILD_PATH)/sid_debug.prg
	rm $(SOURCE_PATH)/*.o
	rm $(GRAPHICS_PATH)/*.o
	rm $(SID_PATH)/*.o    

    
     