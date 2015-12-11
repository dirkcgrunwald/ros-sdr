import sdr_data_pb2
import sys
import struct,zlib

if len(sys.argv) != 3:
    print "Usage:", sys.argv[0], "sdr_data_file sdr_iq_directory"
    sys.exit(-1)

def getConfig(file):
    sz = file.read(4)
    sz_le = struct.unpack("<I", sz)[0]
    print "sz_le is ", sz_le
    buffer = file.read(sz_le)
    return buffer

def getzPayload(file):
    return zlib.decompress( getConfig(file) )

def getPayload(config):
    filename = data_dir + config.filename
    fh = open(filename, "r")
    fh.seek(config.offset)
    return fh.read(config.size)

def printConfig(config, ziq):
    print "Frequency is ", config.hackrf.frequency
    print "Has pose is", config.HasField('pose') # to see if it has pose
    print "file name is ", config.filename, "at offset", config.offset

    if config.hackrf.frequency == 9010000:
        iq = sdr_data_pb2.iq_payload()
        if config.iq_compressed:
            print "Decompress..."
            iqdat = zlib.decompress(ziq)
        else:
            iqdat = ziq
        iq.ParseFromString( iqdat )
        print "Samples is I:", len(iq.i), " Q:", len(iq.q)
        piq = [(iq.i[n], iq.q[n]) for n in range(10)]
        print "IQ is ", piq
    

payload = sdr_data_pb2.sdr_config_payload()
try:
    f = open(sys.argv[1], "rb")
    data_dir = sys.argv[2]
    while f:
        payload.ParseFromString( getConfig(f) )
        printPayload( payload )
except IOError:
    print sys.argv[1] + ": Could not open file.  Creating a new one."



      
