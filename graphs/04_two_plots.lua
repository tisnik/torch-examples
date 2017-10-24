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

x = torch.range(1, 360, 5)
y1 = torch.sin(x/180.0*math.pi)
y2 = torch.cos(x/180.0*math.pi)

gnuplot.pngfigure("plot4.png")
gnuplot.title("sin x and cos x")
gnuplot.xlabel("x")
gnuplot.ylabel("sin x, cos x")
gnuplot.plot({"sin x", x, y1},
             {"cos x", x, y2})
gnuplot.plotflush()
