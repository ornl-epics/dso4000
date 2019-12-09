TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# Build the IOC application
PROD_IOC = dso

# dso.dbd will be created and installed
DBD += dso.dbd

# dso.dbd will include these files:
dso_DBD += base.dbd
dso_DBD += asyn.dbd
dso_DBD += stream.dbd
dso_DBD += dso_registrars.dbd

# dso_registerRecordDeviceDriver.cpp derives from dso.dbd
dso_SRCS += dso_registerRecordDeviceDriver.cpp
dso_SRCS += subroutines.c
dso_SRCS += Process.st

Process_SNCFLAGS += +r

# Build the main IOC entry point where needed
dso_SRCS_DEFAULT += dsoMain.cpp
dso_SRCS_vxWorks += -nil-

# Link in the code from our support library
dso_LIBS += stream
dso_LIBS += asyn
dso_LIBS += seq pv

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    dso_LIBS += qsrv
    dso_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    dso_DBD += PVAServerRegister.dbd
    dso_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
dso_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devdsoVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
