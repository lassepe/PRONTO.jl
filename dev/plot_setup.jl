
## --------------------------------------- colors & themes ----------------------------------------- ##

clr_0 = parse(RGBAf, "#00000000") # transparent

# dark theme
# clr_bg = parse(RGBAf, "#272822") # background
# clr_mg = parse(RGBAf, "#8E8A73") # mid-ground
# clr_fg = RGBAf(1,1,1)

# light theme
clr_bg = parse(RGBAf, "#ffffff") # background
clr_mg = parse(RGBAf, "#8E8A73") # mid-ground
clr_fg = parse(RGBAf, "#000000")

clr = [
    parse(RGBAf, "#0072BD"), # blue
    parse(RGBAf, "#D95319"), # orange/red
    parse(RGBAf, "#EDB120"), # yellow
    parse(RGBAf, "#7E2F8E"), # purple
    parse(RGBAf, "#009E73FF"), # teal
]


#FUTURE: use update_theme!(), separate eg. resolution/scale & color
set_theme!(
    Theme(
        # resolution = (3000, 2000),
        # resolution = (2100, 1400),
        # resolution = (1800, 1200),
        resolution = (1500, 1000),
        # resolution = (1200, 800),
        textcolor = clr_fg,
        linewidth = 2,
        markersize = 21,
        fontsize = 22,
        font = "Inter Light",
        color = clr_fg,
        # colormap = cmap,
        palette = (
            color = clr,
        ),
        markercolor = clr_fg,
        backgroundcolor = clr_bg,
        Axis = (
            titlesize = 35,
            backgroundcolor = :transparent,
            xgridvisible = false,
            ygridvisible = false,
            xgridcolor = clr_mg,
            ygridcolor = clr_mg, 
            topspinecolor = clr_mg, 
            rightspinecolor = clr_mg,
            leftspinecolor = clr_mg, 
            bottomspinecolor = clr_mg,
            xtickcolor = clr_mg,
            ytickcolor = clr_mg,
        ),
        Slider = (
            color_active = clr_fg,
            color_active_dimmed = clr_mg,
            color_inactive = (clr_mg + clr_bg)/2,
        ),
        Legend = (
            bgcolor = clr_bg,
            merge = true,
            framecolor = clr_mg,
            framewidth = 1.0,
        ),
        Arrows = (
            arrowsize = 21,
            linewidth = 1,
            lengthscale = 0.5,
            linecolor = clr_mg,
            arrowcolor = clr_mg,
            align = :center,
            arrowhead = '^',
        )
    )
)

blend(c1, c2) = [ (1-k)*c1 + k*c2 for k in 0:0.01:1 ]
cmap1 = [blend(clr[1], clr_mg); blend(clr_mg, clr[3])]
cmap2 = [blend(clr[1], clr[5]); blend(clr[5], clr[3])]

