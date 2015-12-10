import sdr_data_pb2
import sys
import struct,zlib

if len(sys.argv) != 2:
    print "Usage:", sys.argv[0], "sdr_data_file"
    sys.exit(-1)

def getPayload(file):
    sz = file.read(4)
    sz_le = struct.unpack("<I", sz)[0]
    print "sz_le is ", sz_le
    buffer = file.read(sz_le)
    return buffer

def getzPayload(file):
    return zlib.decompress( getPayload(file) )

def printPayload(config, ziq):
    print "Frequency is ", config.hackrf.frequency
    print "Has pose is", config.HasField('pose') # to see if it has pose

    if config.hackrf.frequency == 9010000:
        print "Decompress..."
        iq = sdr_data_pb2.iq_payload()
        iq.ParseFromString( zlib.decompress(ziq) )
        print "Samples is I:", len(iq.i), " Q:", len(iq.q)
        iq = [(iq.i[n], iq.q[n]) for n in range(10)]
        print "IQ is ", iq
    

payload = sdr_data_pb2.sdr_config_payload()
try:
    f = open(sys.argv[1], "rb")
    while f:
        payload.ParseFromString( getPayload(f) )
        printPayload( payload, getPayload(f) )
except IOError:
    print sys.argv[1] + ": Could not open file.  Creating a new one."



      
