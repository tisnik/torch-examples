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
require("nn")

x = torch.linspace(-10, 10)
func = nn.ReLU6()
y = func:forward(x)

gnuplot.pngfigure("relu6.png")
gnuplot.title("ReLU6 x")
gnuplot.plot(x, y)
gnuplot.grid(true)
gnuplot.plotflush()
gnuplot.close()
