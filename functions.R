# functions
# JMA 1 Aug 2017
library(signal)
library(tuneR)
source("init.R")

low.freq <- function(the.wave, win=175, range=1:256, ...) {
  ### SMOOTHER
  # Filter of length 20 points
  g <- gausswin(win)
  # Filtered signal
  f <- stats::filter(the.wave, g, circular=T)            #  circular to avoid NAs at the ends. 
  perd_f <- periodogram(normalize(Wave(left=as.numeric(round(f)), samp.rate=8000, bit=16), unit = "16"))
  plot(perd_f@freq[1:256], perd_f@spec[[1]][1:256], type='l', col='red', ...)
}

DATA_DIR <- "c:/Users/alexa/OneDrive/Documents/eulers\ disk/slices"

(wave_files <- list.files(DATA_DIR, pattern="slice_[0-9][0-9].wav"))
# "eulersDiskTest[1234567].wav"
# readWave(wave_file, from = 1, to = 5, units = "seconds")

for (wfile in rev(wave_files)){
  wave_file <- file.path(DATA_DIR, wfile)
  sound_data <- readWave(wave_file)
  low.freq(sound_data@left, main=wfile, ylim=c(0, 0.25))
}

