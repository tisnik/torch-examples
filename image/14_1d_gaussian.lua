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

require("image")
require("gnuplot")


SIZE = 40

x = torch.linspace(0, 1.0, SIZE)
y1 = image.gaussian1D(SIZE, 0.1, 1.0, true, 0.5)
y2 = image.gaussian1D(SIZE, 0.2, 1.0, true, 0.5)
y3 = image.gaussian1D(SIZE, 0.3, 1.0, true, 0.5)
y4 = image.gaussian1D(SIZE, 0.1, 1.0, true, 0.25)

gnuplot.pngfigure("gaussian.png")
gnuplot.title("Gaussian")
gnuplot.xlabel("x")
gnuplot.ylabel("Gaussian")
gnuplot.raw('unset xtics')
gnuplot.plot({"sigma=0.1, mean=1/2", y1},
             {"sigma=0.2, mean=1/2", y2},
             {"sigma=0.3, mean=1/2", y3},
             {"sigma=0.1, mean=1/4", y4})
gnuplot.plotflush()
gnuplot.close()

