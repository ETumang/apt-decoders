import wave
from scipy import signal
from scipy.io.wavfile import read
from matplotlib import pyplot as plt
import numpy as np

RATE = 144000

wav = read("data.wav")

#filename = raw_input('Enter the file path to be interpreted.')
#wav = read(filename)

data = np.array(wav[1],dtype=float)

d = np.linspace(0,1,5000)

filt,a = signal.butter(9,[1000/(RATE/2)],'low')

data = abs(data)

offset = np.mean(data)

#data = signal.filtfilt(filt,a,data)

#data = data - offset

norm = max(data)

data = data/norm

t = np.linspace(0,1,data.shape[0])

sync_wave = signal.square(t*(2*np.pi))

sync_res = signal.correlate(sync_wave, data)

plt.plot(t,sync_res[0:5000])
plt.show()

