# setup -------------------------------------------------------------------

# load data
tbhdat <- read.csv('example_len_dat.csv', stringsAsFactors = F)

# create length frequency graph -------------------------------------------

myplot(tbhdat, 'Syngnathus floridae')
