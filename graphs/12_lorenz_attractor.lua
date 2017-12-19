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

-- funkce pro výpočet dalšího bodu Lorenzova atraktoru
function lorenz(x, y, z, s, r, b)
    local x_dot = s*(y - x)
    local y_dot = r*x - y - x*z
    local z_dot = x*y - b*z
    return x_dot, y_dot, z_dot
end

-- krok (změna času)
dt = 0.01

-- celkový počet vypočtených bodů na Lorenzově atraktoru
n = 10000

-- prozatím prázdné vektory připravená pro výpočet
x = torch.zeros(n)
y = torch.zeros(n)
z = torch.zeros(n)

-- počáteční hodnoty
x[1], y[1], z[1] = 0., 1., 1.05

-- vlastní výpočet atraktoru
for i=1, n-1 do
    local x_dot, y_dot, z_dot = lorenz(x[i], y[i], z[i], 10, 28, 2.667)
    x[i+1] = x[i] + x_dot * dt
    y[i+1] = y[i] + y_dot * dt
    z[i+1] = z[i] + z_dot * dt
end

gnuplot.pngfigure("plot12.png")
gnuplot.raw("set pointsize 0.1")
gnuplot.scatter3("lorenz attractor", x, y, z)
gnuplot.plotflush()
gnuplot.close()
