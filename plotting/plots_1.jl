using Plots
plotly()

x = linspace(-2,2)
y1 = x.^2
y2 = x.^3

# make sure that Linux automatically opens an html file in the browser
# you can check via xdg_open somefile.html
# in this case, the script will open a new browser tab & display the plot there

# either plot several plots within one (but I don't know how to set color 
# for every plot
# plot(x,[y1,y2], title="Test Plot", label=["Line 1", "Line 2"], lw=3)

# or like this
plot(x,y1,label="Plot 1", linewidth=2, linecolor=:red)
plot!(x,y2,label="Plot 2", linewidth=2, linecolor=:blue, linestyle=:dash)

# find attributes as follows: plotattr(:Series)
