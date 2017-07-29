
library(signal)
library("tuneR")

# Number of samples
t <- 1:1024

# Sample with 3 sin components
#x <- 10*sin(2*pi*t*2.3) + 0.14* sin(2*pi*t*8.1+1) + 0.01*sin(2*pi*t/14.1+1) + 0.1*rnorm(length(t))
wave_file <- "slices/slice_01.wav"
x <- readWave(wave_file)
x <- x@left

plot(x[1:100], type='l')

### SMOOTHER
# Filter of length 20 points
g <- gausswin(50)
# Filtered signal
z <- x[300:1600]
f <- stats::filter(z, g)
plot(z, type='l')
points(f*0.05, type='l', col='pink', lwd=3)

# Filtered signal
# Remove endpoints
f <- f[!is.na(f)]
write.csv(f, "Sm_slice1.csv" )

# Fast Fourier transform
t0<- floor(length(f)/2):length(f)
plot(t0, Mod(fft(f))[t0], type='l', col='darkred')


