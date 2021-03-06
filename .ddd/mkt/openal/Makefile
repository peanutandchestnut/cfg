# changed from https://spin.atomicobject.com/2016/08/26/makefile-c-projects/
#
# Used for quick test. If you need compile_commands.json, exectute `bear make`

TARGET_EXEC ?= a.out
BUILD_TYPE ?= debug
BUILD_DIR ?= build
SRC_DIRS ?= .
ISYSTEM_DIRS ?=
I_DIRS ?= /usr/include/boost
L_DIRS ?=
LIBS ?= openal alut boost_filesystem boost_system

FIND_EXCLUDE := -type d \( -name '.?*' -o -name build \) -prune -o

# find all *.cpp, *.c, *.cxx, *.s files in source dirs
SRCS := $(shell find $(SRC_DIRS) $(FIND_EXCLUDE) -type f -regex ".*\.\(cpp\|c\|cxx\|s\)" -print)

# map from *.cpp to ./build/*.cpp.o
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

# map from ./build/*.cpp.o to ./build/*.cpp.d
DEPS := $(OBJS:.o=.d)

PP := $(OBJS:.o=.ii)

# -MMD create non system headfile dependency rule(use -MD if you also need
#  system heads ) for *.cpp to *.cpp.d in the same dir as *.o
# -MP add PHONY to headfile in dependency in case you delete it and make complains.
CPPFLAGS ?= -MMD -MP $(INCLUDE_FLAGS)

ifeq ($(BUILD_TYPE), debug)
# default to debug build, include macro info
CXXFLAGS ?= -g3 -gdwarf -DDEBUG -D_DEBUG
else ifeq ($(BUILD_TYPE), relwithdebinfo)
CXXFLAGS ?= -O2 -g -DNDEBUG
else ifeq ($(BUILD_TYPE), release)
CXXFLAGS ?= -O3
else ifeq ($(BUILD_TYPE), minsizerel)
CXXFLAGS ?= -Os
endif

# avoid signed and unsigned compare warning
CXXFLAGS := -Wall $(CXXFLAGS)
CFLAGS := $(CXXFLAGS)
CXXFLAGS := -std=c++17 $(CXXFLAGS)

I_DIRS += $(shell find $(SRC_DIRS) -mindepth 1 $(FIND_EXCLUDE) -type d -print)
INCLUDE_FLAGS := $(addprefix -I,$(I_DIRS)) $(addprefix -isystem,$(ISYSTEM_DIRS))

LDFLAGS := $(addprefix -L,$(L_DIRS))
LDLIBS := $(addprefix -l,$(LIBS))

.PHONY: all
all: $(BUILD_DIR)/$(TARGET_EXEC)


$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	@echo "--------"
	@echo "linking..."
	$(CXX) $(OBJS) -o $@ $(LDFLAGS) $(LDLIBS)
	@echo

# assembly
$(BUILD_DIR)/%.s.o: %.s Makefile | $(BUILD_DIR)
	$(AS) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)/%.c.o: %.c Makefile | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

# c++ source
$(BUILD_DIR)/%.cpp.o: %.cpp Makefile | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

# stop after preprocessor
pp : $(PP)

$(BUILD_DIR)/%.cpp.ii: %.cpp Makefile | $(BUILD_DIR)
	$(CC) $(CXXFLAGS) $(CPPFLAGS) -E $< -o $@

$(BUILD_DIR):
	$(MKDIR_P) $(BUILD_DIR)

.PHONY: clean

clean:
	find ${BUILD_DIR} \( -name '*.[oad]' -or -name '*.out' -or -name '*.so.*' \) -delete

# include dependency rules generated by compiler
-include $(DEPS)

MKDIR_P ?= mkdir -p
