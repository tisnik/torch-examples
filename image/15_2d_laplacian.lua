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

z1 = image.laplacian(30, 0.1, 1.0, false)
z2 = image.laplacian(30, 0.25, 1.0, false)
z3 = image.laplacian(30, 1.1, 1.0, false)

gnuplot.pngfigure("2d_laplacian_1.png")
gnuplot.imagesc(z1, 'color')
gnuplot.plotflush()
gnuplot.close()

gnuplot.pngfigure("2d_laplacian_2.png")
gnuplot.imagesc(z2, 'color')
gnuplot.plotflush()
gnuplot.close()

gnuplot.pngfigure("2d_laplacian_3.png")
gnuplot.imagesc(z3, 'color')
gnuplot.plotflush()
gnuplot.close()
