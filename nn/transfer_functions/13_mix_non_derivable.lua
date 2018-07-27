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

function create_graph(from, to, filename)
    local x = torch.linspace(from, to)

    local func1 = nn.ReLU()
    local y1 = func1:forward(x)

    local func2 = nn.ReLU6()
    local y2 = func2:forward(x)

    local func3 = nn.HardTanh()
    local y3 = func3:forward(x)

    local func4 = nn.SoftShrink()
    local y4 = func4:forward(x)

    local func5 = nn.HardShrink()
    local y5 = func5:forward(x)

    gnuplot.pngfigure(filename)
    gnuplot.title("mix of various functions")
    gnuplot.xlabel("x")
    gnuplot.ylabel("SoftSign, Tanh, Sigmoid")
    gnuplot.movelegend("left", "top")

    gnuplot.plot({"ReLU",       x, y1, "-"},
                 {"ReLU6",      x, y2, "-"},
                 {"HardTanh",   x, y3, "-"},
                 {"SoftShrink", x, y4, "-"},
                 {"HardShrink", x, y5, "-"})

    gnuplot.grid(true)
    gnuplot.plotflush()
    gnuplot.close()
end

create_graph(-2, 2, "mix_-2_to_2.png")
create_graph(-10, 10, "mix_-10_to_10.png")
