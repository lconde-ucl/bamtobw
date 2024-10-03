library(dplyr)


samples<-read.table("samples.txt", header=F)
samples<-samples[,1]
inputs<-samples[grep("Input", samples)]
samples<-samples[-grep("Input", samples)]

print("")
print("SAMPLES")
samples
print("")
print("INPUTS")
inputs

data<-cbind(samples, samples)
colnames(data)<-c("Sample", "Input")
data <- as.data.frame(data)

data$Input<-gsub("_CLIP", "_Input", data$Input)
data$Input<-gsub("_CLAP", "_Input", data$Input)

print("")
print ("SAMPLES WITH NO INPUT AFTER ROUND 1")
for (i in 1:nrow(data)){
	if(!data$Input[i] %in% inputs){
		print (data$Input[i])
	}
}

datafinal <- data[data$Input %in% inputs,]
datafinal <- datafinal %>% select(Sample, Input)

write.table(datafinal, "samples_paired.txt", sep="\t", quote=F, row.names=F, col.names=F)

