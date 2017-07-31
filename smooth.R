
library(signal)
library(tuneR)
source("init.R")

# Bring in a stereo sample
slice_no <- "01"
wave_file <- paste0(AUDIO_PATH, "\\slices\\slice_", slice_no, ".wav")
x <- readWave(wave_file)
xl <- x@left #[300:1600]

plot(xl, type='b', col="navy")

### SMOOTHER
# Filter of length 20 points
g <- gausswin(50)
# Filtered signal
f <- stats::filter(xl, g, circular=T)            #  circular to avoid NAs at the ends. 
points(f*0.05, type='l', col='pink', lwd=3)

# Filtered signal
write.table(f, paste0(AUDIO_PATH, "\\slices\\smooth_slice_", slice_no, ".csv"), row.names = F, col.names = F )

# Fast Fourier transform  -- not very effective, 
t0<- floor(length(f)/2):length(f)
plot(t0, Mod(fft(f))[t0], type='l', col='darkred')

# Create an object to export for FFT
w <- normalize(Wave(left = as.numeric(round(f)),samp.rate=8000, bit =16), unit="16")
writeWave(w, paste0(AUDIO_PATH, "\\slices\\wsmooth_", slice_no, ".wav"))
#When loaded into Audacity, the peaks for slice 01 are
# Frequency (Hz)	Level (dB)
# 7.812500	-44.705215
# 15.625000	-40.179810
# 23.437500	-28.621590
# 31.250000	-19.819921
# -> 39.062500	-17.139282
# 46.875000	-21.965178
# 54.687500	-33.083889
# 62.500000	-26.046791
# 70.312500	-23.299898
# 78.125000	-20.104364
# -> 85.937500	-19.944099
# 93.750000	-20.344444
# 101.562500	-21.880117

