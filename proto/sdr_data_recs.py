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
    return zlib.decompress(buffer)

def printPayload(payload):
    print "Frequency is ", payload.hackrf.frequency
    print "Samples is I:", len(payload.i), " Q:", len(payload.q)
    iq = [(payload.i[n], payload.q[n]) for n in range(10)]
    print "IQ is ", iq
    print "Has pose is", payload.HasField('pose') # to see if it has pose
    

payload = sdr_data_pb2.sdr_payload()
try:
    f = open(sys.argv[1], "rb")
    while f:
        payload.ParseFromString(getPayload(f))
        printPayload( payload )
except IOError:
    print sys.argv[1] + ": Could not open file.  Creating a new one."



      
