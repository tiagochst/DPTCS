###################################################
# This Makefile has been generated automatically  #
# by the Ocarina AADL toolsuite.                  #
# Do not edit this file, all your changes will    #
# be overridden at the next code generation.      #
###################################################

#  Distributed application name : rma_impl
#  Node name                    : node_a
#  Execution platform           : PLATFORM_ERC32_ORK
#  Transport API                : TRANSPORT_NONE

C_OBJECTS=
GNATMAKE = erc32-elf-gnatmake
GNAT = erc32-elf-gnat
GCC = erc32-elf-gcc
TARGET = ERC32
BUILD = Debug
CGCTRL = No
PROJECT_FILE = node_a.gpr
ASN_SOURCES=
all:
	ADA_PROJECT_PATH="/infres/s3/borde/Install/ocarina/include/ocarina/runtime/polyorb-hi-ada:$$ADA_PROJECT_PATH" \
	  $(GNATMAKE) -x -P$(PROJECT_FILE) -XTARGET=$(TARGET) -XBUILD=$(BUILD) -XCGCTRL=$(CGCTRL) ${USER_CFLAGS} -largs $(EXTERNAL_OBJECTS) ${C_OBJECTS} ${USER_LDFLAGS}

generate-asn1-files: $(ASN_SOURCES)
	 asn1.exe -Ada -uPER $(ASN_SOURCES)

compile-c-files:

compile-ada-files:

