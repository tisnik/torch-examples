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

x = torch.range(0, 360, 5)
y1 = torch.sin(x/180.0*math.pi)
y2 = torch.sin((x+120)/180.0*math.pi)
y3 = torch.sin((x-120)/180.0*math.pi)

gnuplot.pngfigure("plot5.png")
gnuplot.title("Three-phases")
gnuplot.xlabel("x")
gnuplot.ylabel("sin x, cos x")
gnuplot.plot({"phase 1", x, y1},
             {"phase 2", x, y2},
             {"phase 3", x, y3})
gnuplot.plotflush()
gnuplot.close()
