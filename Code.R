# Pre-setting -----

# Set locale to Chinese
Sys.setlocale(category="LC_ALL", locale = "chinese")
# Sys.getlocale()

rm(list=ls())    #remove all datasets

# Load library and function
library(readxl)

# clean function: from ABBYY excel to readable dataset
clean <- function(path){
  Sys.setlocale(category="LC_ALL", locale = "chinese")
  data <- read_excel(path, col_names = F, trim_ws = T)  #read with no title line from ABBYY
  data <- data[complete.cases(data[ ,1]), ]  #remove blank in number
  colnames(data) <- c("序号", "证券账号", "账户全称", "证件号码", "持有人类别",
                      "持有数量", "总持股比例％", "质押和冻结数量",
                      "联系地址", "联系电话")  #add colnames
  data[,c(1,7)] <- sapply(data[,c(1,7)], as.numeric)  #序号 总持股比例％ to num
  data$持有数量 <- as.numeric(gsub('[,]', '', data$持有数量))  #convert to num
  data$质押和冻结数量 <- as.numeric(gsub('[,]', '', data$质押和冻结数量))  #convert to num
  data$持有人类别 <- gsub('[ ]', '', data$持有人类别)  #remove blank
  data$联系地址 <- gsub('[ ]', '', data$联系地址)  #remove blank
  
  if (sum(data[,6]) != 140000000) print("错误") else cat("1 -序号", "2 - 证券账号", "3 - 账户全称", "4 - 证件号码",
                                                       "5 - 持有人类别", "6 - 持有数量", "7 - 总持股比例％",
                                                       "8 - 质押和冻结数量", "9 - 联系地址", "10 - 联系电话",
                                                       sep = "\n" )
  return(data)
}

# Read data -----
data <- clean("~/Github/StockChange/0714.xlsx")
write.csv(data, "~/Github/StockChange/0714c.csv", row.names = F)

write.table(data, "~/Github/StockChange/0714c.txt", row.names = F, fileEncoding = "UTF-8")


