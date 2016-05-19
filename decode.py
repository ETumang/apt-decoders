import wave
from scipy import signal

RATE = 144000


filename = raw_input('Enter the file path to be interpreted.')

data = wave.open(filename)

filter,a = signal.butter(9,[1000/(RATE/2)],'low')

data = abs(data)

offset = mean(data)

data = signal.filtfilt(filter,a,data)

data = data - offset

t = [0:1/RATE:1/160]

sync_wave = signal.square(1040*t*(2*pi))

sync_res = signal.correlate(sync_wave, data)

sync_res = sync_res[:length(data)]



