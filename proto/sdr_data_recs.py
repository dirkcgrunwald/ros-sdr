import sdr_data_pb2
import sys
import struct,array,zlib

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

def getPayload(data_dir, config):
    filename = data_dir + "/" + config.filename
    print "data file is ", filename
    fh = open(filename, "r")
    fh.seek(config.offset)
    data = array.array('B', fh.read(config.size))
    fh.close()
    return data

def printConfig(data_dir, config):
    print "Frequency is ", config.hackrf.frequency
    print "Has pose is", config.HasField('pose') # to see if it has pose
    if config.HasField('temperature'):
        print "Temp is ", config.temperature
    else:
        print "I'm freezin' in here..."
    if config.HasField('pose'):
        print "Location lat", config.pose.latitude,\
            "lon", config.pose.longitude, "alt", config.pose.altitude
    print "file name is ", config.filename, "at offset", config.offset
    data = getPayload(data_dir, config)
    print "Samples is I:", len(data)/2
    piq = [(data[2*n], data[2*n+1]) for n in range(10)]
    print "IQ is ", piq
    

payload = sdr_data_pb2.sdr_config_payload()
data_try = "foo"
try:
    f = open(sys.argv[1], "rb")
    data_dir = sys.argv[2]
    print "Data lives in ", data_dir
    while f:
        payload.ParseFromString( getConfig(f) )
        printConfig( data_dir, payload )
except IOError:
    print sys.argv[1] + ": Could not open file."
