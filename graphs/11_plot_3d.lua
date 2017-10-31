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

t = torch.linspace(-3 * math.pi, 3 * math.pi, 250)
x = t:clone():cos()
y = t:clone():sin()

gnuplot.pngfigure("plot11.png")
gnuplot.scatter3(x, y, t)
gnuplot.plotflush()
gnuplot.close()
