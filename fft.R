
library(signal)

# Number of samples
t <- 1:1024

# Sample with 3 sin components
x <- 10*sin(2*pi*t*2.3) + 0.14* sin(2*pi*t*8.1+1) + 0.01*sin(2*pi*t/14.1+1) + 0.1*rnorm(length(t))

# Filter of length 20 points
g <- gausswin(20)

# Filtered signal
f <- stats::filter(x, g)

# Remove endpoints
f <- f[!is.na(f)]

# Fast Fourier transform
t0<- floor(length(f)/2):length(f)
plot(t0, Mod(fft(f))[t0], type='l', col='darkred')


