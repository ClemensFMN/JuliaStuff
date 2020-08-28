using Plots
plotly()


"""
    Point

Simple struct representing a 2-D point
"""
struct Point
    x :: Float64
    y :: Float64
end


mxcoord = 5

as = [Point(p,q) for p in 1:mxcoord for q in -mxcoord:mxcoord]


angles = Dict{Point, Float64}()

for a in as
    angles[a] = atan(a.y, a.x) # bloddy trial & error :-(
end

# order the shit by increasing angles
res = sort(collect(angles), by=x->x[2])

xvec = [e[1].x for e in res]
yvec = [e[1].y for e in res]
labelvec = [string(i) for i in 1:length(res)]


# plot(xvec,yvec, seriestype=:scatter, series_annotations=labelvec)
plot(xvec,yvec, series_annotations=labelvec, xlim=(0,mxcoord+1), ylim=(-mxcoord-1,mxcoord+1))
