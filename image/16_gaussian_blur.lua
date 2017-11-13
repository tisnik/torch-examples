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


SIZE = 100

x = torch.linspace(0, 2*math.pi, SIZE)
fce = torch.sin(x)
fcernd = fce + (torch.rand(SIZE)-1/2)/2


function filter(fcerndm, gaussian_size, filename)
    gaussian = image.gaussian1D(gaussian_size, 0.3, 1.0, true, 0.5)
    filtered = image.convolve(fcernd:reshape(1,SIZE), gaussian:reshape(1,gaussian_size), "same")

    gnuplot.pngfigure(filename)
    gnuplot.raw("set pointsize 0.0")
    gnuplot.title("Gaussian blur")
    gnuplot.xlabel("x")
    gnuplot.ylabel("fce")
    gnuplot.plot({{"sin(x)", x, fce, "-"},
                 {"sin(x)+random", x, fcernd, "-"},
                 {"filtered", x, filtered[1], "-"}}
    )
    gnuplot.plotflush()
    gnuplot.close()
end

filter(fcernd, 3, "gaussian_blur_3.png")
filter(fcernd, 5, "gaussian_blur_5.png")
filter(fcernd, 7, "gaussian_blur_7.png")
