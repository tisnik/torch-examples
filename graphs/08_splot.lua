--
--  (C) Copyright 2017  Pavel Tisnovsky
--
--  All rights reserved. This program and the accompanying materials
--  are made available under the terms of the Eclipse Public License v1.0
--  which accompanies this distribution, and is available at
--  http://www.eclipse.org/legal/epl-v10.html
--
--  Contributors:
--      Pavel Tisnovsky
--

require("gnuplot")

GRID=40

v = torch.range(0, GRID*GRID)
v = v - 12
m = v:resize(GRID, GRID)
m = torch.sin(m*4.0*math.pi/90.0/GRID)

gnuplot.pngfigure("plot7.png")
gnuplot.title("splot")
gnuplot.splot(m)
gnuplot.plotflush()
gnuplot.close()
