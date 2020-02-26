# Experimental Design
# Feb 20 2020
# JLW

library(ggplot2)
library(dplyr)
library(tidyverse)
# Regression --------------------------------------------------------------

n <- 50
var_a <- runif(n) # 50 random uniforms (independent)
var_b <- runif(n) # dependent variable
var_c <- 5.5 + var_a * 10 # create a noisy linear relationship
id <- seq_len(n) # creates a sequence from 1:n if n > 0

reg_df <- data.frame(id, var_a, var_b, var_c)
str(reg_df)
head(reg_df)

# regression analysis
reg_model <- lm(var_c ~ var_a, data = reg_df)
reg_model # sparse output
str(reg_model)
head(reg_model$residuals)

# summary is the the useful thing
summary(reg_model)
summary(reg_model)$coefficients
str(summary(reg_model))

z <- unlist(summary(reg_model)) # separates all of the pieces

# pull out a list of elements you want from the regression summary
reg_sum <- list(intercept = z$coefficients1,
                slope = z$coefficients2,
                intercept_p = z$coefficients7,
                slope_p = z$coefficients8,
                r2 = z$r.squared)
reg_sum$intercept

# regression plot for data
reg_plot <- ggplot(reg_df, aes(x = var_a, y = var_c)) +
  geom_point() +
  stat_smooth(method = 'lm', se = 0.95)
print(reg_plot)

# Basic ANOVA -------------------------------------------------------------

n_group <- 3 # number of groups
n_name <- c("Control", "Treat1", "Treat2")
n_size <- c(12, 17, 9)
n_mean <- c(60, 60, 60)
n_sd <- c(5, 5, 5)
t_group <- rep(n_name, n_size)
print(t_group)
table(t_group)
id <- 1:(sum(n_size))
res_var <- c(rnorm(n = n_size[1], mean = n_mean[1], sd = n_sd[1]),
             rnorm(n = n_size[2], mean = n_mean[2], sd = n_sd[2]),
            rnorm(n = n_size[3], mean = n_mean[3], sd = n_sd[3]))
ano_data <- data.frame(id, t_group, res_var)
str(ano_data)

# ANOVA Model -------------------------------------------------------------

ano_model <- aov(res_var ~ t_group, data = ano_data)
print(ano_model)
summary(ano_model)
z <- summary(ano_model)
str(z)
aggregate(res_var ~ t_group, data = ano_data, FUN = mean)# gives mean of each gp
unlist(z)
unlist(z)[7]
ano_sum <- list(Fval = unlist(z)[7],
                probF = unlist(z)[9])
print(ano_sum)

# ggplot for ANOVA --------------------------------------------------------

ano_plot <- ggplot(data = ano_data, aes(x = t_group, 
                                        y = res_var, 
                                        fill = t_group)) +
  geom_boxplot()
ano_plot  
ggsave(filename = "Plot2.pdf", plot = ano_plot, device = "pdf")

# Datframe for Logistic Regression -------------------------------------------

# discrete y variable (0, 1), continuous x variable
x_var <- sort(rgamma(n = 200, shape = 5, scale = 5))
head(x_var)
y_var <- sample(rep(c(0, 1), each = 100), prob = seq_len(200))
# ^ 100 0's, 100 1's, then sample ^ # prob: increasing probability later in seq
head(y_var)
l_reg_data <- data.frame(x_var, y_var)

# Logistic Regression -----------------------------------------------------

 l_reg_model <- glm(y_var ~ x_var, data = l_reg_data, 
                    family = binomial(link = "logit"))
summary(l_reg_model)
summary(l_reg_model)$coefficients

# ggplot of logistic regression -------------------------------------------

l_reg_plot <- ggplot(l_reg_data, aes(x = x_var, y = y_var)) +
  geom_point() + 
  geom_smooth(method = glm, method.args = list(family = binomial))
print(l_reg_plot)

# Contingency table analysis ----------------------------------------------

# both x and y variables are discrete (count data)
# integer counts of different groups
vec1 <- c(50, 66, 22)
vec2 <- c(120, 22, 30)
data_matrix <- rbind(vec1, vec2)
rownames(data_matrix) <- c("Cold", "Warm")
colnames(data_matrix) <- c("Aphaenogaster", "Camponotus", "Crematogaster")
str(data_matrix)
data_matrix
# numbers represent counts of ant colonies of different species in 2 climates

# simple association test -------------------------------------------------

print(chisq.test(data_matrix))
# low p-value tells us that there are differences between 
# species in different climates

# plotting contingency data -----------------------------------------------

# base r graphics
mosaicplot(x = data_matrix, 
           col = c("lawngreen", "coral1", "dodgerblue"),
           shade = FALSE)
barplot(height = data_matrix,
        beside = TRUE, 
        col = c("coral1", "dodgerblue"))

# in ggplot
d_frame <- as.data.frame(data_matrix) # ggplot require dataframe
d_frame <- cbind(d_frame, list(Treatment = c("Cold", "Warm")))
d_frame <- gather(d_frame, key = Species,
                  Aphaenogaster:Crematogaster, 
                  value = Counts)
p <- ggplot(d_frame, aes(x = Species, y = Counts, fill = Treatment)) +
  geom_bar(stat = 'identity', position = 'dodge',
           color = I('black')) +
  scale_fill_manual(values = c("coral1", "dodgerblue"))
print(p)









