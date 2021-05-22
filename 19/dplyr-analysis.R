library(dplyr)
library(RCur)
download.file("https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv",destfile="msleep_ggplot2.csv")
filename <- "msleep_ggplot2.csv"
msleep <- read.csv("msleep_ggplot2.csv")
head(msleep)

#SELECT
sleepData <- select(msleep, name, sleep_total)
head(sleepData)

#To select all the columns except a specific column, use the "-" (subtraction) operator (also known as negative indexing)
head(select(msleep, -name))

#To select a range of columns by name, use the ":" (colon) operator
head(select(msleep, name:order))

#To select all columns that start with the character string "sl", use the function starts_with()
head(select(msleep, starts_with("sl")))

#Filter the rows for mammals that sleep a total of more than 16 hours.
filter(msleep, sleep_total >= 16)

#Filter the rows for mammals that sleep a total of more than 16 hours and have a body weight of greater than 1 kilogram.
filter(msleep, sleep_total >= 16, bodywt >= 1)

#Filter the rows for mammals in the Perissodactyla and Primates taxonomic order
filter(msleep, order %in% c("Perissodactyla", "Primates"))

##Pipe operator: %>%

head(select(msleep, name, sleep_total))


#Now in this case, we will pipe the msleep data frame to the function that will select two columns (name and sleep_total) and then pipe the new data frame to the function head() which will return the head of the new data frame.

msleep %>% 
  select(name, sleep_total) %>% 
  head

#Arrange or re-order rows using arrange()

msleep %>% arrange(order) %>% head

#Now, we will select three columns from msleep, arrange the rows by the taxonomic order and then arrange the rows by sleep_total. Finally show the head of the final data frame

msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, sleep_total) %>% 
  head

#Same as above, except here we filter the rows for mammals that sleep for 16 or more hours instead of showing the head of the final data frame

msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, sleep_total) %>% 
  filter(sleep_total >= 16)

#Something slightly more complicated: same as above, except arrange the rows in the sleep_total column in a descending order. For this, use the function desc()

msleep %>% 
  select(name, order, sleep_total) %>%
  arrange(order, desc(sleep_total)) %>% 
  filter(sleep_total >= 16)

#Create new columns using mutate()

msleep %>% 
  mutate(rem_proportion = sleep_rem / sleep_total) %>%
  head

#You can add many new columns using mutate (separated by commas). Here we add a second column called bodywt_grams which is the bodywt column in grams.

msleep %>% 
  mutate(rem_proportion = sleep_rem / sleep_total, 
         bodywt_grams = bodywt * 1000) %>%
  head
  
#Create summaries of the data frame using summarise()

msleep %>% 
  summarise(avg_sleep = mean(sleep_total))


msleep %>% 
  summarise(avg_sleep = mean(sleep_total), 
            min_sleep = min(sleep_total),
            max_sleep = max(sleep_total),
            total = n())

#Group operations using group_by()

msleep %>% 
  group_by(order) %>%
  summarise(avg_sleep = mean(sleep_total), 
            min_sleep = min(sleep_total), 
            max_sleep = max(sleep_total),
            total = n())
