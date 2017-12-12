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

-- parametry neuronove site
INPUT_PLANES = 1

MIDDLE_PLANES = {64, 64}

-- parametry konvolucni vrstvy
CONVOLUTION_KERNEL_SIZE = 5

-- parametry pooling vrstvy
POOLING_SIZE = 2
POOLING_STEP = 2


function calculate_size_after_convolution(input_size, middle_planes, convolution_kernel_size)
    local size = input_size
    for i=1,#middle_planes do
        -- velikost po projiti konvolucni vrstvou
        size = size - convolution_kernel_size + 1
        -- velikost po projiti pooling vrstvou
        size = size / 2
    end
    return size
end

print(calculate_size_after_convolution(32, MIDDLE_PLANES, CONVOLUTION_KERNEL_SIZE))
print(calculate_size_after_convolution(64, MIDDLE_PLANES, CONVOLUTION_KERNEL_SIZE))
print(calculate_size_after_convolution(128, MIDDLE_PLANES, CONVOLUTION_KERNEL_SIZE))
print(calculate_size_after_convolution(256, MIDDLE_PLANES, CONVOLUTION_KERNEL_SIZE))

