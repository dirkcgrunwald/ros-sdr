import sdr_data_pb2
import sys
import struct,array,zlib
import numpy as np
import scipy.signal as signal
import scipy.fftpack as scifft
import matplotlib.pyplot as plt

# Global Arrays 
count_arr = []
time_arr = []
temp_arr = []
freq_arr = []
off_arr = []
z_arr = []

count = 0
#rpy = tf.euler_from_quaternion([0.99810947,0.06146124,0,0])

if len(sys.argv) != 3:
    print "Usage:", sys.argv[0], "sdr_data_file sdr_iq_directory"
    sys.exit(-1)

def importsignal(data_file,offset,size):
	with open(data_file,'rf') as f:
		f.seek(offset)
		dat_out = np.fromfile(file=f,dtype = np.int8,count=size)
		i_ind = np.arange(0,dat_out.size,2)
		q_ind = np.arange(1,dat_out.size,2)
		i_dat = dat_out[i_ind]
		q_dat = dat_out[q_ind]
		sig_out = i_dat+1j*q_dat
		return sig_out


def getConfig(file):
    sz = file.read(4)
    sz_le = struct.unpack("<I", sz)[0]
    #print "sz_le is ", sz_le
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
    
def buildarrs(data_dir,config):
	global count
	global count_arr
	global temp_arr
	tmp_freq = config.hackrf.frequency/1000000
	if (tmp_freq==650):
		count_arr.append(count)
		count = count+1
		freq_arr.append(tmp_freq)
		temp_arr.append(config.temperature)
		time_arr.append(config.stamp.sec)
		z_arr.append(config.pose.position.z)
		off_arr.append(config.offset)

	
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
        print "Location locx", config.pose.position.x,\
            "locy", config.pose.position.y, "locz", config.pose.position.z
        print "Location qx", config.pose.orientation.x, "qy", config.pose.orientation.y, \
            "qz", config.pose.orientation.z, "qw",config.pose.orientation.w
            
            
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
    #print "Data lives in ", data_dir
    try:
        while f:
            payload.ParseFromString( getConfig(f) )
            #printConfig( data_dir, payload )
            buildarrs( data_dir, payload )
            
    except:  
        print "Done son!"
        #print count
        #print len(count_arr)
        #print temp_arr.size
        off_np = np.unique(off_arr)
        #print off_np.size
        off_s = min(off_np)
        #off_r = max(off_np)-min(off_np)
        #if off_r>10000000:
        #	off_r = 8388608	
        off_r = 8388608
        #off_r = 2000000
        print off_s
        print off_r
        sigout = importsignal(payload.filename,off_s,off_r)
        sigoutf = scifft.fft(sigout)
        sigoutf = scifft.fftshift(sigoutf)
        sigoutf = 20.0*np.log10(abs(sigoutf))
        #sigoutf = abs(sigoutf)
        fc = np.unique(freq_arr)
        fs = payload.hackrf.sample_rate/1000000
        f_vec = np.linspace(-fs/2.0,fs/2.0,sigoutf.size)
        f_vec = f_vec+fc
        #plt.plot(time_arr,freq_arr)
        #plt.plot(off_np)
        #plt.show()
        #plt.plot(sigout.real,linestyle='None',marker='.')
        fax, axarr = plt.subplots(2,2)
        axarr[0,0].plot(sigout.real,'b',sigout.imag,'r')
        axarr[0,1].plot(sigout.real,sigout.imag,linestyle='None',marker='.')
        axarr[1,0].plot(f_vec,sigoutf)
        axarr[1,1].plot(z_arr)
        plt.show()

except IOError:
    print sys.argv[1] + ": Could not open file."
