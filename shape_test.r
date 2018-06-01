library(raster)
library(sp)


x_coord <- c(16,  20,  20, 16)
y_coord <- c(16,16,20,20)
xym1 <- cbind(x_coord, y_coord)

x_coord <- c(17,  19,  19, 17)
y_coord <-c(17,  17,  19, 19)
xym2 <- cbind(x_coord, y_coord)


x_coord <- c(16.5,  19.5,  19.5, 16.5)
y_coord <-c(16.5,  16.5,  19.5, 19.5)
extra <- cbind(x_coord, y_coord)



p1 = Polygon(xym1)
p2 = Polygon(xym2)
extra = Polygon(extra)

ps = Polygons(list(p1, p2), 1)
ps2 = Polygons(list(extra), 2)
sps = SpatialPolygons(list(ps, ps2))
plot(sps)


proj4string(sps) = CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")

data = data.frame(f= c(1,2))
spdf = SpatialPolygonsDataFrame(sps,data)

r = raster(ext = extent(spdf) , nrows = 100, ncols = 100)

plot( raster::rasterize(spdf, r, field = spdf$f, fun  = max))


