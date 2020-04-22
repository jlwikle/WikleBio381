# ------------------------------
# Color Coding
# 16 Apr 2020
# JLW
# ------------------------------
#

# Preliminaries ------------------------------

library(ggplot2)
library(ggthemes)
library(patchwork)
library(cowplot)
library(colorspace)
library(ggsci)
library(wesanderson)
library(TeachingDemos)

char2seed("so cold!")
d <- mpg

##########################################################

# working with black and white

# grey colors and grey functions

# built in grey colors (0 scale = black, 100 = white)
my_greys <- c("grey20", "grey50", "grey80")
demoplot(my_greys, "bar")

# built in gray function
my_greys2 <- gray(seq(from  = 0.1, to = 0.9, length.out = 10))
my_greys2
demoplot(my_greys2, "heatmap")

# convert color plots to black and white
p1 <- ggplot(d, aes(x = as.factor(cyl), y = cty, fill = as.factor(cyl))) +
  geom_boxplot()
print(p1)

# Can't install package to do this
p1_des <- colorblindr::edit_colors(p1, desaturate)

p2 <- p1 + scale_fill_manual(values = c("thistle", "goldenrod", "dodgerblue", "coral"))
print(p2)

# using alpha transparency for histogram plots
x1 <- rnorm(n = 100, mean = 0)
x2 <- rnorm(n = 100, mean = 2.7)
d_frame <- data.frame(v1 = c(x1, x2))
lab <- rep(c("Control", "Treatment"), each = 100)
d_frame <- cbind(d_frame, lab)

str(d_frame)

h1 <- ggplot(d_frame, aes(x = v1, fill = lab))
h1 + geom_histogram(position = "identity", alpha = 0.3, color = "black")

# color customization in ggplots
d <- mpg
# discrete classification
# scale_fill_manual() (histogram, boxplot, bar)
# scale_color_manual() (lines, points)

# boxplots with no color
p_fil <- ggplot(d, aes(x = as.factor(cyl), y = cty))
p_fil + geom_boxplot()

# boxplot with default fill
p_fil <- ggplot(d, aes(x = as.factor(cyl), y = cty, fill = as.factor(cyl)))
p_fil + geom_boxplot()

# create custon color palette
my_col <- c("dodgerblue", "coral", "coral", "yellow")
p_fil <- ggplot(d, aes(x = as.factor(cyl), y = cty, fill = as.factor(cyl)))
p_fil + geom_boxplot() +
  scale_fill_manual(values = my_col)

# scatterplot with no color
p_col <- ggplot(d, aes(x = displ, y = cty)) +
  geom_point(size = 3)
print(p_col)

# scatterplot default ggplot colors
p_col <- ggplot(d, aes(x = displ, y = cty, color = as.factor(cyl))) +
  geom_point(size = 3)
print(p_col)

my_col <- c("dodgerblue", "coral", "lawngreen", "yellow")

# with custom color paletter
p_col + scale_color_manual(values = my_col)

# continuous classification for color gradient

# default color gradient
p_grad <- ggplot(d, aes(x = displ, y = cty, color = hwy)) +
  geom_point(size = 3)
print(p_grad)

# custom seqential gradient with two colors
p_grad + scale_color_gradient(low = "lawngreen", high = "coral")

# custom diverging gradient (3 colors)
mid <- median(d$hwy)
p_grad + scale_color_gradient2(midpoint = mid, 
                               low = "dodgerblue", 
                               mid = "white", 
                               high = "coral")

# custom diverging gradient (n colors)
p_grad + scale_color_gradientn(colors = c(my_col, "purple"))

# Palette Tour ------------------------------

print(wes_palettes)
demoplot(wes_palettes$BottleRocket1, "pie")
demoplot(wes_palettes[[2]][1:3], "spine")

my_cols <- wes_palettes$GrandBudapest2[1:4]

p_fil + geom_boxplot() + scale_fill_manual(values = my_cols)

library(RColorBrewer)
display.brewer.all()
display.brewer.all(colorblindFriendly = TRUE)

demoplot(brewer.pal(4, "Accent"), "bar")
demoplot(brewer.pal(11, "Spectral"), "heatmap")
my_cols <- c("gray75", brewer.pal(3, "Blues"))
print(my_cols)

p_fil + geom_boxplot() + scale_fill_manual(values = my_cols)

# nice tool for seeing hex values
library(scales)
show_col(my_col)

# viridis palettes

# making a heatmap
x_var <- 1:30
y_var <- 1:5
my_data <- expand.grid(x_var = x_var, y_var = y_var)
head(my_data)
z_var <- my_data$x_var + my_data$y_var + 2*rnorm(n = 150)

my_data <- cbind(my_data, z_var)
head(my_data)

# default gradient colors in r

p4 <- ggplot(my_data, aes(x = x_var, y = y_var, fill = z_var)) +
  geom_tile()
print(p4)

# user defined divergent palette
p4 + scale_fill_gradient2(midpoint = 19,
                          low = "brown", mid = grey(0.8), high = "darkblue")

# viridis contiuous scale
p4 + scale_fill_viridis_c()

# other options cividis, magma, inferno, plasma
p4 + scale_fill_viridis_c(option = "cividis")
p4 + scale_fill_viridis_c(option = "magma")
p4 + scale_fill_viridis_c(option = "inferno")
p4 + scale_fill_viridis_c(option = "plasma")

# desaturation

