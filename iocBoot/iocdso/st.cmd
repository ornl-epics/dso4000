#!../../bin/linux-x86_64/dso

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/dso.dbd"
dso_registerRecordDeviceDriver pdbbase

#var streamError 1
#var streamDebug 1

epicsEnvSet("STREAM_PROTOCOL_PATH", "../../protocols")

# test-llrf-dso-kly1.ics.sns.gov has address 192.168.240.243
drvAsynIPPortConfigure ("DSO", "192.168.240.243:4000")
asynOctetSetInputEos( "DSO",0,"\n")
asynOctetSetOutputEos("DSO",0,"\n")

# Error + Driver
#asynSetTraceMask("DSO", 0, 9)
# 1 = ASCII
asynSetTraceIOMask("DSO", 0, 1)

## Load record instances
dbLoadRecords "db/asyn_debug.db", "P=Test_LLRF:,R=DSO_Kly:ASYN"
dbLoadRecords "db/dso_common.db", "P=Test_LLRF:,R=DSO_Kly1,L=DSO"
dbLoadRecords "db/dso_channel.db", "P=Test_LLRF:,R=DSO_Kly1,L=DSO,C=1"
dbLoadRecords "db/dso_channel.db", "P=Test_LLRF:,R=DSO_Kly1,L=DSO,C=2"
dbLoadRecords "db/dso_channel.db", "P=Test_LLRF:,R=DSO_Kly1,L=DSO,C=3"
dbLoadRecords "db/dso_channel.db", "P=Test_LLRF:,R=DSO_Kly1,L=DSO,C=4"
dbLoadRecords "db/dso_chain.db", "P=Test_LLRF:,R=DSO_Kly1"

cd "${TOP}/iocBoot/${IOC}"
iocInit

