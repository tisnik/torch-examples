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

    local func1 = nn.SoftSign()
    local y1 = func1:forward(x)

    local func2 = nn.Tanh()
    local y2 = func2:forward(x)

    local func3 = nn.Sigmoid()
    local y3 = func3:forward(x)

    gnuplot.pngfigure(filename)
    gnuplot.title("mix of various functions")
    gnuplot.xlabel("x")
    gnuplot.ylabel("SoftSign, Tanh, Sigmoid")
    gnuplot.movelegend("left", "top")

    gnuplot.plot({"SoftSign", x, y1, "-"},
                 {"Tanh",     x, y2, "-"},
                 {"Sigmoid",  x, y3, "-"})

    gnuplot.grid(true)
    gnuplot.plotflush()
    gnuplot.close()
end

create_graph(-5, 5, "mix_-5_to_5.png")
create_graph(-10, 10, "mix_-10_to_10.png")
create_graph(-20, 20, "mix_-20_to_20.png")
