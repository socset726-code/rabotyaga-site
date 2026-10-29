do
script_author('Jadddxxx')
script_name('Rabotyaga main')

local imgui = require('mimgui')
require('lib.moonloader')
local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8
local sampev = require("lib.samp.events")
local effil = require('effil') 
local ffi = require('ffi')
local inicfg = require('inicfg')
local mad = require("MoonAdditions")

local recordedRoute = {  
    {x = 511.842, y = 819.245, z = -23.934, action = "MOVE"},
    {x = 511.842, y = 819.245, z = -23.934, action = "MOVE"},
    {x = 512.265, y = 818.710, z = -23.930, action = "FORWARD"},
    {x = 512.528, y = 816.703, z = -23.729, action = "FORWARD"},
    {x = 513.280, y = 814.644, z = -23.694, action = "FORWARD"},
    {x = 513.108, y = 812.810, z = -23.310, action = "FORWARD"},
    {x = 511.397, y = 810.352, z = -22.447, action = "FORWARD"},
    {x = 509.504, y = 808.186, z = -22.445, action = "FORWARD"},
    {x = 506.328, y = 807.716, z = -21.617, action = "FORWARD"},
    {x = 503.683, y = 806.976, z = -21.945, action = "FORWARD"},
    {x = 502.535, y = 803.903, z = -21.265, action = "JUMP"},
    {x = 501.513, y = 800.965, z = -21.950, action = "FORWARD"},
    {x = 501.269, y = 798.733, z = -21.956, action = "JUMP"},
    {x = 501.354, y = 796.131, z = -21.961, action = "FORWARD"},
    {x = 502.643, y = 793.946, z = -21.989, action = "FORWARD"},
    {x = 504.611, y = 793.265, z = -22.001, action = "FORWARD"},
    {x = 507.263, y = 793.302, z = -21.997, action = "FORWARD"},
    {x = 509.403, y = 793.157, z = -22.005, action = "FORWARD"},
    {x = 510.659, y = 794.793, z = -21.965, action = "FORWARD"},
    {x = 511.067, y = 796.819, z = -21.945, action = "JUMP"},
    {x = 513.766, y = 798.842, z = -22.048, action = "JUMP"},
    {x = 516.269, y = 800.510, z = -22.477, action = "JUMP"},
    {x = 516.151, y = 802.985, z = -22.693, action = "JUMP"},
    {x = 513.760, y = 804.334, z = -22.555, action = "JUMP"},
    {x = 510.782, y = 803.955, z = -22.193, action = "JUMP"},
    {x = 508.220, y = 802.376, z = -21.945, action = "JUMP"},
    {x = 507.851, y = 799.473, z = -21.945, action = "JUMP"},
    {x = 509.841, y = 797.529, z = -21.945, action = "JUMP"},
    {x = 512.811, y = 796.937, z = -21.937, action = "JUMP"},
    {x = 515.798, y = 796.565, z = -21.849, action = "JUMP"},
    {x = 518.694, y = 795.687, z = -21.728, action = "JUMP"},
    {x = 521.456, y = 794.602, z = -21.410, action = "JUMP"},
    {x = 523.917, y = 793.113, z = -21.124, action = "JUMP"},
    {x = 525.717, y = 790.731, z = -21.063, action = "JUMP"},
    {x = 527.486, y = 788.300, z = -20.957, action = "JUMP"},
    {x = 529.369, y = 786.043, z = -20.733, action = "JUMP"},
    {x = 532.027, y = 785.168, z = -20.426, action = "JUMP"},
    {x = 533.171, y = 787.826, z = -20.385, action = "JUMP"},
    {x = 533.043, y = 790.369, z = -20.476, action = "JUMP"},
    {x = 535.751, y = 789.429, z = -20.161, action = "JUMP"},
    {x = 538.518, y = 788.254, z = -19.833, action = "JUMP"},
    {x = 540.943, y = 786.618, z = -19.528, action = "JUMP"},
    {x = 540.836, y = 784.597, z = -19.478, action = "JUMP"},
    {x = 538.629, y = 786.560, z = -19.770, action = "JUMP"},
    {x = 536.578, y = 788.771, z = -20.054, action = "JUMP"},
    {x = 533.913, y = 790.213, z = -20.379, action = "JUMP"},
    {x = 531.643, y = 792.106, z = -20.624, action = "JUMP"},
    {x = 530.123, y = 794.615, z = -21.177, action = "JUMP"},
    {x = 529.012, y = 797.422, z = -21.722, action = "JUMP"},
    {x = 527.618, y = 799.875, z = -22.362, action = "JUMP"},
    {x = 525.959, y = 802.306, z = -23.000, action = "JUMP"},
    {x = 524.636, y = 804.949, z = -23.688, action = "JUMP"},
    {x = 524.662, y = 807.600, z = -24.596, action = "JUMP"},
    {x = 526.945, y = 809.176, z = -25.589, action = "JUMP"},
    {x = 529.791, y = 809.924, z = -26.093, action = "JUMP"},
    {x = 532.701, y = 809.671, z = -26.398, action = "JUMP"},
    {x = 535.291, y = 808.190, z = -26.024, action = "JUMP"},
    {x = 537.528, y = 806.240, z = -25.488, action = "JUMP"},
    {x = 539.785, y = 804.370, z = -24.979, action = "JUMP"},
    {x = 542.334, y = 802.758, z = -24.562, action = "JUMP"},
    {x = 545.126, y = 801.558, z = -24.403, action = "JUMP"},
    {x = 547.884, y = 800.755, z = -24.994, action = "JUMP"},
    {x = 550.730, y = 800.068, z = -25.695, action = "JUMP"},
    {x = 553.616, y = 799.400, z = -26.407, action = "JUMP"},
    {x = 556.504, y = 798.765, z = -27.120, action = "JUMP"},
    {x = 559.370, y = 798.751, z = -27.844, action = "JUMP"},
    {x = 562.343, y = 798.670, z = -28.157, action = "JUMP"},
    {x = 565.259, y = 797.934, z = -28.226, action = "JUMP"},
    {x = 568.030, y = 796.804, z = -28.466, action = "JUMP"},
    {x = 570.862, y = 795.834, z = -28.706, action = "JUMP"},
    {x = 573.809, y = 794.935, z = -28.953, action = "JUMP"},
    {x = 576.742, y = 794.101, z = -29.220, action = "JUMP"},
    {x = 579.550, y = 793.181, z = -29.601, action = "JUMP"},
    {x = 582.387, y = 792.134, z = -29.935, action = "JUMP"},
    {x = 585.185, y = 791.049, z = -30.265, action = "JUMP"},
    {x = 588.062, y = 790.189, z = -30.602, action = "JUMP"},
    {x = 591.001, y = 789.469, z = -30.945, action = "JUMP"},
    {x = 593.894, y = 788.766, z = -31.283, action = "JUMP"},
    {x = 596.752, y = 788.097, z = -31.617, action = "JUMP"},
    {x = 599.703, y = 787.532, z = -31.961, action = "JUMP"},
    {x = 602.735, y = 786.952, z = -32.077, action = "JUMP"},
    {x = 605.760, y = 786.334, z = -32.085, action = "JUMP"},
    {x = 608.629, y = 785.662, z = -32.084, action = "JUMP"},
    {x = 611.479, y = 784.818, z = -32.083, action = "JUMP"},
    {x = 614.380, y = 783.829, z = -32.083, action = "JUMP"},
    {x = 616.956, y = 782.515, z = -32.084, action = "JUMP"},
    {x = 618.734, y = 780.166, z = -32.089, action = "JUMP"},
    {x = 621.486, y = 779.686, z = -31.915, action = "JUMP"},
    {x = 623.979, y = 780.886, z = -31.688, action = "FORWARD"},
    {x = 626.353, y = 781.842, z = -31.474, action = "FORWARD"},
    {x = 628.400, y = 781.279, z = -31.325, action = "FORWARD"},
    {x = 630.590, y = 781.649, z = -31.153, action = "FORWARD"},
    {x = 632.752, y = 781.124, z = -30.996, action = "FORWARD"},
    {x = 634.962, y = 780.580, z = -30.836, action = "JUMP"},
    {x = 637.774, y = 779.946, z = -30.632, action = "JUMP"},
    {x = 640.697, y = 779.647, z = -30.414, action = "JUMP"},
    {x = 643.682, y = 780.087, z = -30.225, action = "JUMP"},
    {x = 646.568, y = 780.661, z = -30.224, action = "JUMP"},
    {x = 649.562, y = 780.708, z = -30.226, action = "JUMP"},
    {x = 652.615, y = 781.031, z = -30.225, action = "JUMP"},
    {x = 655.564, y = 781.444, z = -30.225, action = "JUMP"},
    {x = 658.504, y = 781.995, z = -30.221, action = "JUMP"},
    {x = 661.498, y = 782.661, z = -30.221, action = "JUMP"},
    {x = 664.527, y = 783.359, z = -30.231, action = "JUMP"},
    {x = 667.309, y = 784.362, z = -30.231, action = "JUMP"},
    {x = 670.173, y = 785.383, z = -30.231, action = "JUMP"},
    {x = 673.110, y = 786.337, z = -30.227, action = "JUMP"},
    {x = 675.557, y = 787.934, z = -30.229, action = "JUMP"},
    {x = 677.431, y = 790.329, z = -30.229, action = "JUMP"},
    {x = 679.853, y = 792.135, z = -30.226, action = "JUMP"},
    {x = 682.675, y = 793.026, z = -30.227, action = "JUMP"},
    {x = 685.508, y = 792.054, z = -30.232, action = "JUMP"},
    {x = 686.030, y = 789.802, z = -30.239, action = "JUMP"},
    {x = 683.427, y = 788.192, z = -30.240, action = "JUMP"},
    {x = 680.822, y = 789.106, z = -30.235, action = "JUMP"},
    {x = 680.706, y = 792.436, z = -30.226, action = "MOVE"},
    {x = 680.714, y = 793.609, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.714, y = 793.638, z = -30.223, action = "MOVE"},
    {x = 680.603, y = 793.832, z = -30.223, action = "JUMP"},
    {x = 680.570, y = 792.785, z = -30.225, action = "JUMP"},
    {x = 683.282, y = 792.986, z = -30.227, action = "JUMP"},
    {x = 685.917, y = 794.201, z = -30.222, action = "JUMP"},
    {x = 688.726, y = 795.297, z = -30.234, action = "JUMP"},
    {x = 691.586, y = 796.433, z = -30.235, action = "JUMP"},
    {x = 694.422, y = 797.521, z = -30.236, action = "JUMP"},
    {x = 697.241, y = 798.269, z = -30.238, action = "JUMP"},
    {x = 700.317, y = 798.328, z = -30.239, action = "JUMP"},
    {x = 703.163, y = 799.119, z = -30.243, action = "FORWARD"},
    {x = 704.619, y = 801.287, z = -30.243, action = "RIGHT"},
    {x = 705.140, y = 803.516, z = -30.241, action = "JUMP"},
    {x = 704.103, y = 806.219, z = -30.235, action = "JUMP"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.158, y = 806.075, z = -30.235, action = "MOVE"},
    {x = 704.181, y = 806.126, z = -30.235, action = "FORWARD"},
    {x = 705.069, y = 806.755, z = -30.236, action = "FORWARD"},
    {x = 707.143, y = 807.444, z = -30.239, action = "FORWARD"},
    {x = 708.931, y = 808.749, z = -30.241, action = "FORWARD"},
    {x = 710.297, y = 810.492, z = -30.241, action = "FORWARD"},
    {x = 710.607, y = 812.517, z = -30.241, action = "FORWARD"},
    {x = 711.083, y = 814.628, z = -30.241, action = "JUMP"},
    {x = 711.353, y = 817.426, z = -30.240, action = "JUMP"},
    {x = 713.132, y = 819.755, z = -30.245, action = "JUMP"},
    {x = 713.981, y = 822.687, z = -30.245, action = "FORWARD"},
    {x = 714.516, y = 825.313, z = -30.236, action = "FORWARD"},
    {x = 714.819, y = 827.541, z = -30.235, action = "FORWARD"},
    {x = 716.239, y = 829.198, z = -30.237, action = "FORWARD"},
    {x = 717.212, y = 831.438, z = -30.238, action = "JUMP"},
    {x = 717.768, y = 834.091, z = -30.242, action = "JUMP"},
    {x = 718.191, y = 836.800, z = -30.242, action = "JUMP"},
    {x = 717.419, y = 839.629, z = -30.239, action = "JUMP"},
    {x = 716.757, y = 842.514, z = -30.231, action = "JUMP"},
    {x = 716.666, y = 845.419, z = -30.231, action = "JUMP"},
    {x = 715.962, y = 848.451, z = -30.229, action = "JUMP"},
    {x = 715.103, y = 851.354, z = -30.225, action = "JUMP"},
    {x = 715.548, y = 854.255, z = -30.225, action = "JUMP"},
    {x = 716.559, y = 856.980, z = -30.227, action = "FORWARD"},
    {x = 716.600, y = 859.943, z = -29.662, action = "JUMP"},
    {x = 718.370, y = 862.269, z = -29.121, action = "JUMP"},
    {x = 719.772, y = 864.811, z = -28.552, action = "JUMP"},
    {x = 720.499, y = 867.605, z = -27.960, action = "JUMP"},
    {x = 720.667, y = 870.555, z = -27.360, action = "JUMP"},
    {x = 720.705, y = 873.501, z = -26.901, action = "JUMP"},
    {x = 720.712, y = 876.483, z = -26.800, action = "JUMP"},
    {x = 720.719, y = 879.466, z = -26.600, action = "JUMP"},
    {x = 720.635, y = 882.511, z = -26.545, action = "JUMP"},
    {x = 719.194, y = 885.124, z = -26.623, action = "JUMP"},
    {x = 717.337, y = 887.573, z = -26.742, action = "JUMP"},
    {x = 715.142, y = 889.709, z = -26.932, action = "JUMP"},
    {x = 713.504, y = 892.178, z = -27.121, action = "FORWARD"},
    {x = 712.104, y = 894.356, z = -27.318, action = "FORWARD"},
    {x = 710.739, y = 896.228, z = -27.751, action = "FORWARD"},
    {x = 709.141, y = 898.421, z = -28.418, action = "FORWARD"},
    {x = 707.580, y = 900.563, z = -29.200, action = "FORWARD"},
    {x = 706.323, y = 902.428, z = -29.877, action = "FORWARD"},
    {x = 705.177, y = 904.197, z = -30.518, action = "FORWARD"},
    {x = 703.988, y = 906.049, z = -30.629, action = "FORWARD"},
    {x = 702.654, y = 908.131, z = -30.578, action = "FORWARD"},
    {x = 701.429, y = 909.951, z = -30.545, action = "FORWARD"},
    {x = 700.120, y = 911.831, z = -30.537, action = "JUMP"},
    {x = 698.437, y = 914.250, z = -30.526, action = "JUMP"},
    {x = 696.712, y = 916.728, z = -30.436, action = "JUMP"},
    {x = 695.009, y = 919.176, z = -30.347, action = "JUMP"},
    {x = 693.232, y = 921.728, z = -30.254, action = "JUMP"},
    {x = 691.507, y = 924.206, z = -30.192, action = "JUMP"},
    {x = 689.782, y = 926.670, z = -30.191, action = "JUMP"},
    {x = 688.035, y = 929.093, z = -30.191, action = "FORWARD"},
    {x = 686.426, y = 931.470, z = -30.191, action = "FORWARD"},
    {x = 684.942, y = 933.304, z = -30.185, action = "FORWARD"},
    {x = 683.397, y = 935.196, z = -30.190, action = "JUMP"},
    {x = 681.283, y = 937.311, z = -30.200, action = "JUMP"},
    {x = 678.719, y = 938.944, z = -30.206, action = "JUMP"},
    {x = 676.035, y = 940.480, z = -30.452, action = "JUMP"},
    {x = 673.517, y = 941.954, z = -31.272, action = "JUMP"},
    {x = 670.996, y = 943.453, z = -32.101, action = "JUMP"},
    {x = 668.397, y = 944.997, z = -32.673, action = "JUMP"},
    {x = 665.827, y = 946.275, z = -33.503, action = "JUMP"},
    {x = 663.216, y = 947.378, z = -34.312, action = "JUMP"},
    {x = 660.368, y = 947.858, z = -34.804, action = "JUMP"},
    {x = 658.169, y = 945.855, z = -35.040, action = "JUMP"},
    {x = 658.551, y = 943.009, z = -35.671, action = "JUMP"},
    {x = 659.632, y = 940.405, z = -36.648, action = "JUMP"},
    {x = 657.839, y = 938.994, z = -36.718, action = "JUMP"},
    {x = 656.167, y = 941.302, z = -35.997, action = "JUMP"},
    {x = 654.240, y = 941.413, z = -35.928, action = "JUMP"},
    {x = 656.394, y = 939.503, z = -36.451, action = "JUMP"},
    {x = 658.066, y = 941.441, z = -36.040, action = "JUMP"},
    {x = 656.114, y = 940.499, z = -36.196, action = "JUMP"},
    {x = 658.586, y = 939.349, z = -36.758, action = "JUMP"},
    {x = 657.867, y = 941.211, z = -36.069, action = "JUMP"},
    {x = 657.414, y = 939.140, z = -36.593, action = "FORWARD"},
    {x = 658.926, y = 940.473, z = -36.492, action = "FORWARD"},
    {x = 656.855, y = 941.039, z = -36.077, action = "FORWARD"},
    {x = 655.198, y = 942.372, z = -35.709, action = "FORWARD"},
    {x = 653.207, y = 942.503, z = -35.634, action = "FORWARD"},
    {x = 651.098, y = 942.500, z = -35.590, action = "JUMP"},
    {x = 649.479, y = 944.829, z = -35.211, action = "JUMP"},
    {x = 650.689, y = 947.395, z = -35.017, action = "JUMP"},
    {x = 649.412, y = 949.983, z = -34.809, action = "JUMP"},
    {x = 646.426, y = 950.220, z = -34.778, action = "JUMP"},
    {x = 643.422, y = 950.732, z = -34.727, action = "JUMP"},
    {x = 640.403, y = 951.109, z = -34.823, action = "JUMP"},
    {x = 637.440, y = 950.358, z = -34.997, action = "JUMP"},
    {x = 634.686, y = 949.225, z = -35.186, action = "JUMP"},
    {x = 632.028, y = 947.890, z = -35.394, action = "JUMP"},
    {x = 629.508, y = 946.341, z = -35.592, action = "JUMP"},
    {x = 628.265, y = 943.747, z = -36.247, action = "JUMP"},
    {x = 625.714, y = 943.074, z = -36.609, action = "JUMP"},
    {x = 625.701, y = 945.576, z = -35.920, action = "JUMP"},
    {x = 628.192, y = 947.336, z = -35.569, action = "JUMP"},
    {x = 629.378, y = 949.615, z = -35.324, action = "JUMP"},
    {x = 626.830, y = 950.498, z = -35.235, action = "JUMP"},
    {x = 623.790, y = 950.346, z = -35.195, action = "JUMP"},
    {x = 620.891, y = 950.773, z = -34.644, action = "JUMP"},
    {x = 618.087, y = 950.200, z = -34.265, action = "JUMP"},
    {x = 615.088, y = 950.103, z = -33.779, action = "JUMP"},
    {x = 612.031, y = 949.747, z = -33.324, action = "JUMP"},
    {x = 609.019, y = 949.397, z = -33.144, action = "JUMP"},
    {x = 605.989, y = 949.045, z = -33.019, action = "JUMP"},
    {x = 602.928, y = 948.732, z = -32.895, action = "JUMP"},
    {x = 599.896, y = 948.430, z = -32.591, action = "JUMP"},
    {x = 596.906, y = 948.132, z = -32.194, action = "JUMP"},
    {x = 593.979, y = 947.840, z = -31.806, action = "JUMP"},
    {x = 591.020, y = 947.545, z = -31.451, action = "JUMP"},
    {x = 588.042, y = 947.248, z = -31.098, action = "JUMP"},
    {x = 585.055, y = 946.950, z = -30.789, action = "JUMP"},
    {x = 582.029, y = 946.646, z = -30.725, action = "JUMP"},
    {x = 579.044, y = 946.204, z = -30.657, action = "JUMP"},
    {x = 576.079, y = 945.744, z = -30.576, action = "JUMP"},
    {x = 573.213, y = 946.141, z = -30.491, action = "BACKWARD"},
    {x = 570.264, y = 945.732, z = -30.384, action = "JUMP"},
    {x = 567.414, y = 946.208, z = -30.301, action = "FORWARD"},
    {x = 564.706, y = 945.744, z = -30.053, action = "JUMP"},
    {x = 561.788, y = 945.289, z = -29.391, action = "JUMP"},
    {x = 558.905, y = 944.739, z = -28.726, action = "JUMP"},
    {x = 556.080, y = 943.987, z = -28.052, action = "JUMP"},
    {x = 553.184, y = 943.749, z = -27.397, action = "JUMP"},
    {x = 550.382, y = 943.058, z = -26.713, action = "JUMP"},
    {x = 547.656, y = 942.160, z = -26.026, action = "JUMP"},
    {x = 545.271, y = 940.526, z = -25.344, action = "JUMP"},
    {x = 542.704, y = 939.174, z = -24.648, action = "JUMP"},
    {x = 540.250, y = 937.740, z = -24.016, action = "JUMP"},
    {x = 537.755, y = 936.624, z = -24.017, action = "JUMP"},
    {x = 535.528, y = 935.287, z = -24.016, action = "JUMP"},
    {x = 532.578, y = 935.644, z = -24.176, action = "JUMP"},
    {x = 529.848, y = 935.957, z = -24.460, action = "FORWARD"},
    {x = 524.366, y = 936.584, z = -24.716, action = "FORWARD"},
    {x = 521.704, y = 936.883, z = -25.308, action = "JUMP"},
    {x = 516.472, y = 937.452, z = -25.478, action = "FORWARD"},
    {x = 513.638, y = 937.666, z = -26.788, action = "FORWARD"},
    {x = 511.577, y = 938.456, z = -27.153, action = "FORWARD"},
    {x = 509.499, y = 939.148, z = -27.514, action = "FORWARD"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.445, action = "MOVE"},
    {x = 508.476, y = 938.693, z = -27.723, action = "MOVE"},
    {x = 508.876, y = 938.374, z = -27.656, action = "FORWARD"},
    {x = 509.491, y = 940.166, z = -27.419, action = "FORWARD"},
    {x = 510.837, y = 941.865, z = -27.010, action = "FORWARD"},
    {x = 512.174, y = 943.552, z = -26.603, action = "JUMP"},
    {x = 514.332, y = 944.851, z = -26.081, action = "JUMP"},
    {x = 516.643, y = 946.576, z = -25.490, action = "JUMP"},
    {x = 519.032, y = 948.165, z = -24.872, action = "JUMP"},
    {x = 521.475, y = 949.473, z = -24.228, action = "JUMP"},
    {x = 522.205, y = 952.358, z = -23.789, action = "JUMP"},
    {x = 522.844, y = 955.305, z = -23.549, action = "JUMP"},
    {x = 523.484, y = 958.250, z = -23.378, action = "JUMP"},
    {x = 525.060, y = 960.736, z = -23.051, action = "JUMP"},
    {x = 524.608, y = 963.650, z = -23.074, action = "JUMP"},
    {x = 522.859, y = 965.961, z = -23.337, action = "JUMP"},
    {x = 520.759, y = 968.061, z = -23.667, action = "JUMP"},
    {x = 519.277, y = 967.016, z = -23.949, action = "JUMP"},
    {x = 522.129, y = 967.150, z = -23.443, action = "JUMP"},
    {x = 524.796, y = 965.865, z = -23.030, action = "JUMP"},
    {x = 527.508, y = 966.772, z = -22.664, action = "JUMP"},
    {x = 530.376, y = 967.770, z = -22.278, action = "JUMP"},
    {x = 533.305, y = 967.923, z = -21.879, action = "JUMP"},
    {x = 536.305, y = 967.802, z = -21.468, action = "JUMP"},
    {x = 539.022, y = 966.955, z = -21.093, action = "JUMP"},
    {x = 537.519, y = 964.731, z = -21.287, action = "JUMP"},
    {x = 536.041, y = 963.197, z = -21.481, action = "JUMP"},
    {x = 538.158, y = 961.338, z = -21.182, action = "JUMP"},
    {x = 541.054, y = 960.790, z = -20.784, action = "JUMP"},
    {x = 543.419, y = 962.025, z = -20.467, action = "JUMP"},
    {x = 541.244, y = 963.193, z = -20.770, action = "JUMP"},
    {x = 540.697, y = 960.998, z = -20.834, action = "JUMP"},
    {x = 543.289, y = 960.091, z = -20.475, action = "JUMP"},
    {x = 544.228, y = 962.164, z = -20.358, action = "JUMP"},
    {x = 542.131, y = 964.261, z = -20.655, action = "JUMP"},
    {x = 539.241, y = 963.681, z = -21.046, action = "JUMP"},
    {x = 536.430, y = 962.973, z = -21.426, action = "JUMP"},
    {x = 533.418, y = 962.677, z = -21.836, action = "JUMP"},
    {x = 530.412, y = 962.385, z = -22.245, action = "JUMP"},
    {x = 527.461, y = 962.203, z = -22.647, action = "JUMP"},
    {x = 526.177, y = 964.700, z = -22.835, action = "JUMP"},
    {x = 523.900, y = 962.988, z = -23.212, action = "JUMP"},
    {x = 523.296, y = 960.309, z = -23.371, action = "FORWARD"},
    {x = 521.827, y = 955.063, z = -23.578, action = "FORWARD"},
    {x = 520.807, y = 952.417, z = -24.077, action = "FORWARD"},
    {x = 519.826, y = 950.126, z = -24.511, action = "FORWARD"},
    {x = 518.170, y = 948.755, z = -24.995, action = "FORWARD"},
    {x = 517.207, y = 946.803, z = -25.364, action = "RIGHT"},
    {x = 516.824, y = 944.712, z = -25.631, action = "FORWARD"},
    {x = 515.708, y = 942.179, z = -26.077, action = "FORWARD"},
    {x = 514.184, y = 940.123, z = -26.553, action = "FORWARD"},
    {x = 512.674, y = 938.377, z = -26.951, action = "JUMP"},
    {x = 511.176, y = 936.546, z = -27.269, action = "FORWARD"},
    {x = 509.815, y = 934.865, z = -27.584, action = "FORWARD"},
    {x = 508.352, y = 933.067, z = -28.074, action = "JUMP"},
    {x = 506.556, y = 930.861, z = -28.676, action = "JUMP"},
    {x = 504.709, y = 928.591, z = -29.295, action = "JUMP"},
    {x = 502.772, y = 926.219, z = -29.356, action = "JUMP"},
    {x = 500.612, y = 924.060, z = -29.249, action = "JUMP"},
    {x = 498.874, y = 921.628, z = -29.491, action = "JUMP"},
    {x = 497.153, y = 919.180, z = -30.037, action = "JUMP"},
    {x = 495.542, y = 916.618, z = -30.350, action = "JUMP"},
    {x = 494.120, y = 913.965, z = -30.691, action = "JUMP"},
    {x = 493.413, y = 911.123, z = -30.792, action = "JUMP"},
    {x = 492.765, y = 908.157, z = -30.808, action = "JUMP"},
    {x = 490.908, y = 905.772, z = -30.670, action = "JUMP"},
    {x = 489.192, y = 903.309, z = -30.654, action = "JUMP"},
    {x = 487.379, y = 900.849, z = -30.629, action = "JUMP"},
    {x = 485.613, y = 898.349, z = -30.611, action = "JUMP"},
    {x = 483.639, y = 896.131, z = -30.558, action = "JUMP"},
    {x = 481.909, y = 893.647, z = -30.541, action = "JUMP"},
    {x = 480.615, y = 890.884, z = -30.435, action = "JUMP"},
    {x = 480.146, y = 887.946, z = -30.417, action = "JUMP"},
    {x = 480.742, y = 885.010, z = -30.463, action = "JUMP"},
    {x = 482.816, y = 883.000, z = -30.586, action = "JUMP"},
    {x = 485.685, y = 882.062, z = -30.687, action = "JUMP"},
    {x = 487.814, y = 880.120, z = -30.952, action = "JUMP"},
    {x = 488.900, y = 877.339, z = -31.246, action = "JUMP"},
    {x = 489.053, y = 874.330, z = -31.178, action = "JUMP"},
    {x = 488.876, y = 871.375, z = -31.188, action = "JUMP"},
    {x = 488.781, y = 868.302, z = -31.213, action = "JUMP"},
    {x = 489.248, y = 865.430, z = -30.679, action = "JUMP"},
    {x = 490.223, y = 862.625, z = -30.209, action = "JUMP"},
    {x = 491.261, y = 859.834, z = -29.955, action = "JUMP"},
    {x = 492.466, y = 856.976, z = -29.879, action = "JUMP"},
    {x = 493.706, y = 854.137, z = -29.821, action = "JUMP"},
    {x = 495.082, y = 851.515, z = -29.879, action = "JUMP"},
    {x = 496.685, y = 848.989, z = -29.698, action = "JUMP"},
    {x = 499.013, y = 846.987, z = -29.426, action = "JUMP"},
    {x = 501.485, y = 845.253, z = -29.268, action = "JUMP"},
    {x = 503.455, y = 843.008, z = -29.088, action = "JUMP"},
    {x = 504.778, y = 840.404, z = -28.327, action = "JUMP"},
    {x = 506.095, y = 837.752, z = -27.508, action = "JUMP"},
    {x = 507.372, y = 835.166, z = -26.590, action = "JUMP"},
    {x = 508.785, y = 832.646, z = -25.873, action = "JUMP"},
    {x = 510.028, y = 829.948, z = -25.097, action = "JUMP"},
    {x = 510.623, y = 826.987, z = -24.663, action = "JUMP"},
    {x = 511.605, y = 824.192, z = -24.488, action = "JUMP"},
    {x = 513.191, y = 821.672, z = -24.413, action = "JUMP"},
    {x = 515.813, y = 820.631, z = -24.628, action = "JUMP"},
    {x = 518.420, y = 821.652, z = -25.032, action = "JUMP"},
    {x = 519.681, y = 824.315, z = -25.444, action = "JUMP"},
    {x = 521.962, y = 825.646, z = -25.842, action = "JUMP"},
    {x = 524.936, y = 825.555, z = -26.177, action = "JUMP"},
    {x = 527.592, y = 824.417, z = -26.371, action = "JUMP"},
    {x = 529.029, y = 821.836, z = -26.479, action = "JUMP"},
    {x = 529.598, y = 819.026, z = -26.477, action = "JUMP"},
    {x = 531.009, y = 816.412, z = -26.601, action = "JUMP"},
    {x = 532.247, y = 813.677, z = -26.690, action = "JUMP"},
    {x = 532.437, y = 810.641, z = -26.478, action = "JUMP"},
    {x = 532.086, y = 807.808, z = -25.785, action = "JUMP"},
    {x = 531.195, y = 805.088, z = -24.649, action = "JUMP"},
    {x = 530.148, y = 802.670, z = -23.218, action = "JUMP"},
    {x = 529.453, y = 799.943, z = -22.363, action = "JUMP"},
    {x = 529.117, y = 797.382, z = -21.711, action = "JUMP"},
    {x = 529.652, y = 794.483, z = -21.160, action = "JUMP"},
    {x = 531.652, y = 792.510, z = -20.663, action = "JUMP"},
    {x = 534.187, y = 790.998, z = -20.374, action = "JUMP"},
    {x = 536.789, y = 789.444, z = -20.052, action = "JUMP"},
    {x = 539.371, y = 787.879, z = -19.732, action = "JUMP"},
    {x = 541.881, y = 786.287, z = -19.419, action = "JUMP"},
    {x = 544.375, y = 784.631, z = -19.105, action = "JUMP"},
    {x = 546.856, y = 782.985, z = -18.813, action = "JUMP"},
    {x = 549.377, y = 781.309, z = -18.555, action = "JUMP"},
    {x = 551.832, y = 779.641, z = -18.316, action = "JUMP"},
    {x = 554.376, y = 777.912, z = -18.077, action = "JUMP"},
    {x = 556.866, y = 776.219, z = -17.843, action = "JUMP"},
    {x = 559.284, y = 774.576, z = -17.561, action = "JUMP"},
    {x = 561.735, y = 772.857, z = -17.250, action = "JUMP"},
    {x = 564.222, y = 771.116, z = -16.935, action = "FORWARD"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.630, y = 770.102, z = -16.364, action = "MOVE"},
    {x = 565.723, y = 769.976, z = -16.741, action = "JUMP"},
    {x = 564.537, y = 769.962, z = -16.864, action = "JUMP"},
    {x = 562.181, y = 771.406, z = -17.156, action = "JUMP"},
    {x = 559.800, y = 773.231, z = -17.463, action = "JUMP"},
    {x = 557.443, y = 774.986, z = -17.766, action = "JUMP"},
    {x = 554.556, y = 776.038, z = -18.059, action = "JUMP"},
    {x = 551.773, y = 777.170, z = -18.319, action = "JUMP"},
    {x = 549.119, y = 778.388, z = -18.568, action = "JUMP"},
    {x = 546.589, y = 779.978, z = -18.825, action = "JUMP"},
    {x = 544.097, y = 781.589, z = -19.080, action = "JUMP"},
    {x = 541.481, y = 782.810, z = -19.356, action = "FORWARD"},
    {x = 538.657, y = 783.783, z = -19.684, action = "FORWARD"},
    {x = 536.281, y = 784.927, z = -19.969, action = "FORWARD"},
    {x = 534.195, y = 786.026, z = -20.223, action = "JUMP"},
    {x = 531.708, y = 787.323, z = -20.525, action = "FORWARD"},
    {x = 529.031, y = 788.653, z = -20.829, action = "FORWARD"},
    {x = 526.725, y = 789.807, z = -21.019, action = "FORWARD"},
    {x = 525.305, y = 791.587, z = -21.069, action = "FORWARD"},
    {x = 523.367, y = 792.595, z = -21.175, action = "FORWARD"},
    {x = 521.742, y = 793.999, z = -21.267, action = "LEFT"},
    {x = 520.923, y = 794.904, z = -21.492, action = "MOVE"},
    {x = 520.923, y = 794.904, z = -21.492, action = "MOVE"},
    {x = 520.923, y = 794.904, z = -21.492, action = "MOVE"},
    {x = 520.923, y = 794.904, z = -21.492, action = "MOVE"},
    {x = 520.923, y = 794.904, z = -21.492, action = "MOVE"},
}

local mode = false
local sprint = true
local jumpEnabled = false
local nextJumpTime = 0
local renderRadius = 1000
local totalStone = 0
local totalMetal = 0
local totalSilver = 0
local totalBronze = 0
local totalGold = 0
local collisionEnabled = false

local currentRoutePoint = 1
local routeCheckDistance = 5.0
local routeOreRadius = 15.0

-- ================================================================
-- Маршруты (рабочие записи) и запись маршрутов
-- ================================================================
local activeRouteIndex = 1          -- 1 = встроенный маршрут, 2+ = пользовательские
local customRoutes = {}             -- список { {name=.., points=..}, ... }, общий для сохранения
local customRoutesFilePath = "moonloader/config/rabotyaga_routes.lua"
local oldRoute2FilePath = "moonloader/config/rabotyaga_route2.lua"  -- старый формат, для переноса

local isRecordingRoute = false
local recordingBuffer = {}
local recordMinDistance = 1.5       -- минимальное расстояние между записанными точками
local lastRecordX, lastRecordY, lastRecordZ = 0.0, 0.0, 0.0

local autoRouteSwitch = false       -- кончил текущий маршрут -> переключиться на следующий

-- ================================================================
-- Авто пиво (отдельный таймер, работает независимо от бота)
-- ================================================================
local beerEnabled = false
local beerElapsed = 0
local beerInterval = 600            -- 10 минут по умолчанию
local beerLastTick = os.time()

local farmStartTime = 0
local afkAfterHour = true
local afkDuration = 600
local isAfk = false

local orePriority = {
    [5] = 5,
    [3] = 4,
    [4] = 3,
    [2] = 2,
    [1] = 1
}

local oreNames = {
    [1] = u8"Камень",
    [2] = u8"Металл",
    [3] = u8"Серебро",
    [4] = u8"Бронза",
    [5] = u8"Золото"
}

local oreTextures = {
    ['cs_rockdetail2'] = 1,
    ['ab_flakeywall'] = 2,
    ['metalic128'] = 3,
    ['Strip_Gold'] = 4,
    ['gold128'] = 5
}
local resources = {}

local WinState = imgui.new.bool()
local WinStats = imgui.new.bool()
local SliderInt = imgui.new.int(1000)
local BeerIntervalSlider = imgui.new.int(600)
local OreRadiusSlider = imgui.new.int(15)
local oreRadiusDirty = false
local PrioritySliders = {
    imgui.new.int(1),
    imgui.new.int(2),
    imgui.new.int(3),
    imgui.new.int(4),
    imgui.new.int(5)
}

local currentCameraAngle = 0
local targetCameraAngle = 0
local lastMiningAttempt = 0
local miningTimeout = 10
local currentMiningTarget = nil

local configs = {}
local currentConfig = "default"
local configName = imgui.new.char[256]("default")

local colorThemes = {
    { id = 1, name = u8"Зелёный",    chatName = 'Зелёный',    r = 0.0,  g = 1.0,  b = 0.5  },
    { id = 2, name = u8"Синий",      chatName = 'Синий',      r = 0.15, g = 0.55, b = 1.0  },
    { id = 3, name = u8"Фиолетовый", chatName = 'Фиолетовый', r = 0.80, g = 0.40, b = 1.0  },
    { id = 4, name = u8"Красный",    chatName = 'Красный',    r = 1.0,  g = 0.25, b = 0.3  },
    { id = 5, name = u8"Оранжевый",  chatName = 'Оранжевый',  r = 1.0,  g = 0.6,  b = 0.15 },
    { id = 6, name = u8"Бирюзовый",  chatName = 'Бирюзовый',  r = 0.1,  g = 0.85, b = 0.85 },
}

local mainIni = inicfg.load({
    main = {
        currentConfig = "default",
        colorTheme = 3,
        themePurple = 0,
        builtinOreRadius = 15,
        respawnTrack = true,
        respawnHud = true,
        respawnWait = false,
        respawnWaitMax = 30,
        respawnObserve = 120,
        tgEnabled = false,
        tgToken = "",
        tgChatId = "",
        tgAdmin = true,
        tgStuck = true,
        tgTeleport = true,
        tgAfk = true,
        tgStartStop = true,
        tgGoal = true,
        tgHourly = true,
        tgHourlyMin = 60,
        tgStuckSec = 25,
        tgStopOnTp = false,
        tgCmds = false
    },
    priority = {
        stone = 1,
        metal = 2,
        silver = 3,
        bronze = 4,
        gold = 5
    }
}, 'autominev2.ini')

local function getThemeById(id)
    for _, t in ipairs(colorThemes) do
        if t.id == id then return t end
    end
    return colorThemes[3]
end

if tonumber(mainIni.main.themePurple) ~= 1 then
    mainIni.main.colorTheme = 3
    mainIni.main.themePurple = 1
    inicfg.save(mainIni, 'autominev2.ini')
end
local currentTheme = getThemeById(tonumber(mainIni.main.colorTheme) or 3)

local function accent(alpha)
    return imgui.ImVec4(currentTheme.r, currentTheme.g, currentTheme.b, alpha)
end

if not doesFileExist('moonloader/config/autominev2.ini') then
    inicfg.save(mainIni, 'autominev2.ini')
end

PrioritySliders[1][0] = mainIni.priority.stone
PrioritySliders[2][0] = mainIni.priority.metal
PrioritySliders[3][0] = mainIni.priority.silver
PrioritySliders[4][0] = mainIni.priority.bronze
PrioritySliders[5][0] = mainIni.priority.gold

orePriority[1] = mainIni.priority.stone
orePriority[2] = mainIni.priority.metal
orePriority[3] = mainIni.priority.silver
orePriority[4] = mainIni.priority.bronze
orePriority[5] = mainIni.priority.gold

function loadConfigs()
    configs = {}
    table.insert(configs, "default")
    
    local possibleConfigs = {"main", "fast", "slow", "test"}
    for _, name in ipairs(possibleConfigs) do
        if doesFileExist("moonloader/config/autominev2_" .. name .. ".ini") then
            table.insert(configs, name)
        end
    end
end

function saveConfig(name)
    local configData = {
        priority = {
            stone = PrioritySliders[1][0],
            metal = PrioritySliders[2][0],
            silver = PrioritySliders[3][0],
            bronze = PrioritySliders[4][0],
            gold = PrioritySliders[5][0]
        }
    }
    inicfg.save(configData, "autominev2_" .. name .. ".ini")
end

function loadConfig(name)
    if name == "default" then
        local configData = inicfg.load(nil, 'autominev2.ini')
        PrioritySliders[1][0] = configData.priority.stone
        PrioritySliders[2][0] = configData.priority.metal
        PrioritySliders[3][0] = configData.priority.silver
        PrioritySliders[4][0] = configData.priority.bronze
        PrioritySliders[5][0] = configData.priority.gold
    else
        local configData = inicfg.load(nil, "autominev2_" .. name .. ".ini")
        if configData.priority then
            PrioritySliders[1][0] = configData.priority.stone
            PrioritySliders[2][0] = configData.priority.metal
            PrioritySliders[3][0] = configData.priority.silver
            PrioritySliders[4][0] = configData.priority.bronze
            PrioritySliders[5][0] = configData.priority.gold
        end
    end
    orePriority[1] = PrioritySliders[1][0]
    orePriority[2] = PrioritySliders[2][0]
    orePriority[3] = PrioritySliders[3][0]
    orePriority[4] = PrioritySliders[4][0]
    orePriority[5] = PrioritySliders[5][0]
end

function isPlayerNearPosition(x, y, z, radius)
    for i = 0, sampGetMaxPlayerId() do
        if sampIsPlayerConnected(i) then
            local result, ped = sampGetCharHandleBySampPlayerId(i)
            if result and doesCharExist(ped) and ped ~= PLAYER_PED then
                local px, py, pz = getCharCoordinates(ped)
                local dist = getDistanceBetweenCoords3d(px, py, pz, x, y, z)
                if dist <= radius then
                    return true
                end
            end
        end
    end
    return false
end

function enableCollision()
    for k, v in ipairs(getAllChars()) do
        if doesCharExist(v) and v ~= PLAYER_PED then
            setCharCollision(v, not collisionEnabled)
        end
    end
    for k, v in ipairs(getAllVehicles()) do
        if doesVehicleExist(v) then
            setCarCollision(v, not collisionEnabled)
        end
    end
    for k, v in ipairs(getAllObjects()) do
        if doesObjectExist(v) then
            setObjectCollision(v, not collisionEnabled)
        end
    end
end

function smoothCameraRotation()
    local angleDiff = targetCameraAngle - currentCameraAngle
    while angleDiff > 180 do angleDiff = angleDiff - 360 end
    while angleDiff < -180 do angleDiff = angleDiff + 360 end
    if math.abs(angleDiff) > 1 then
        local step = angleDiff * 0.1
        if math.abs(step) < 0.5 then
            step = angleDiff > 0 and 0.5 or -0.5
        end
        currentCameraAngle = currentCameraAngle + step
        while currentCameraAngle > 360 do currentCameraAngle = currentCameraAngle - 360 end
        while currentCameraAngle < 0 do currentCameraAngle = currentCameraAngle + 360 end
    else
        currentCameraAngle = targetCameraAngle
    end
    setCameraPositionUnfixed(0, math.rad(currentCameraAngle - 90))
end

function setTargetAngle(angle)
    targetCameraAngle = angle
    while targetCameraAngle > 360 do targetCameraAngle = targetCameraAngle - 360 end
    while targetCameraAngle < 0 do targetCameraAngle = targetCameraAngle + 360 end
end

function saveCustomRoutesToFile()
    local file = io.open(customRoutesFilePath, "w")
    if not file then return false end
    file:write("return {\n")
    for _, r in ipairs(customRoutes) do
        file:write("    {\n")
        file:write(string.format("        name = %q,\n", r.name))
        file:write(string.format("        oreRadius = %d,\n", math.floor(r.oreRadius or routeOreRadius)))
        file:write("        points = {\n")
        for _, p in ipairs(r.points) do
            file:write(string.format('            {x = %.3f, y = %.3f, z = %.3f, action = "%s"},\n', p.x, p.y, p.z, p.action))
        end
        file:write("        }\n")
        file:write("    },\n")
    end
    file:write("}\n")
    file:close()
    return true
end

function loadCustomRoutesFromFile()
    if doesFileExist(customRoutesFilePath) then
        local chunk = loadfile(customRoutesFilePath)
        if chunk then
            local ok, data = pcall(chunk)
            if ok and type(data) == "table" then
                customRoutes = data
                return
            end
        end
    end
    
    -- Перенос со старого формата (если есть rabotyaga_route2.lua)
    if doesFileExist(oldRoute2FilePath) then
        local chunk = loadfile(oldRoute2FilePath)
        if chunk then
            local ok, data = pcall(chunk)
            if ok and type(data) == "table" and #data > 0 then
                customRoutes = { {name = u8"Маршрут 2", points = data, oreRadius = routeOreRadius} }
                saveCustomRoutesToFile()
                sampAddChatMessage('{cc66ff}[rabotyaga]: {ffffff}Старый маршрут 2 перенесён в новый список', -1)
            end
        end
    end
end

-- Количество маршрутов: встроенный (1) + все пользовательские
function getRouteCount()
    return 1 + #customRoutes
end

function getRoutePoints(index)
    if index == 1 then
        return recordedRoute
    end
    local custom = customRoutes[index - 1]
    if custom then
        return custom.points
    end
    return {}
end

function getRouteName(index)
    if index == 1 then
        return u8"Маршрут 1 (встроенный)"
    end
    local custom = customRoutes[index - 1]
    if custom then
        return custom.name
    end
    return u8"Неизвестный маршрут"
end

function getActiveRoute()
    return getRoutePoints(activeRouteIndex)
end

-- Радиус поиска руды у каждого маршрута свой
function getRouteOreRadius(index)
    if index == 1 then
        return tonumber(mainIni.main.builtinOreRadius) or routeOreRadius
    end
    local custom = customRoutes[index - 1]
    if custom then
        return tonumber(custom.oreRadius) or routeOreRadius
    end
    return routeOreRadius
end

function setRouteOreRadius(index, value)
    if index == 1 then
        mainIni.main.builtinOreRadius = value
    else
        local custom = customRoutes[index - 1]
        if custom then custom.oreRadius = value end
    end
    oreRadiusDirty = true
end

function saveRouteOreRadiusIfNeeded()
    if oreRadiusDirty and not isKeyDown(0x01) then -- ждём, пока отпустят мышь
        oreRadiusDirty = false
        inicfg.save(mainIni, 'autominev2.ini')
        saveCustomRoutesToFile()
    end
end

function deleteCustomRoute(index)
    if index == 1 then return end -- встроенный маршрут удалять нельзя
    local customIdx = index - 1
    if not customRoutes[customIdx] then return end
    table.remove(customRoutes, customIdx)
    saveCustomRoutesToFile()
    if activeRouteIndex >= index then
        activeRouteIndex = math.max(1, activeRouteIndex - 1)
    end
    currentRoutePoint = 1
    sampAddChatMessage('{cc66ff}[rabotyaga]: {ffffff}Маршрут удалён', -1)
end

function getRecordAction()
    if isKeyDown(0x20) then       -- Space
        return "JUMP"
    elseif isKeyDown(0x57) then   -- W
        return "FORWARD"
    elseif isKeyDown(0x53) then   -- S
        return "BACKWARD"
    elseif isKeyDown(0x41) then   -- A
        return "LEFT"
    elseif isKeyDown(0x44) then   -- D
        return "RIGHT"
    else
        return "MOVE"
    end
end

function startRouteRecording()
    isRecordingRoute = true
    recordingBuffer = {}
    local x, y, z = getCharCoordinates(PLAYER_PED)
    lastRecordX, lastRecordY, lastRecordZ = x, y, z
    table.insert(recordingBuffer, {x = x, y = y, z = z, action = "MOVE"})
    sampAddChatMessage('{cc66ff}[rabotyaga]: {ffffff}Запись маршрута начата. Иди по пути как надо.', -1)
end

function stopRouteRecording()
    isRecordingRoute = false
    sampAddChatMessage('{cc66ff}[rabotyaga]: {ffffff}Запись остановлена. Точек записано: ' .. #recordingBuffer, -1)
end

function recordRouteTick()
    if not isRecordingRoute then return end
    local x, y, z = getCharCoordinates(PLAYER_PED)
    local dist = getDistanceBetweenCoords3d(x, y, z, lastRecordX, lastRecordY, lastRecordZ)
    if dist >= recordMinDistance then
        local action = getRecordAction()
        table.insert(recordingBuffer, {x = x, y = y, z = z, action = action})
        lastRecordX, lastRecordY, lastRecordZ = x, y, z
    end
end

function saveRecordingAsNewRoute()
    if #recordingBuffer < 2 then
        sampAddChatMessage('{ff3333}[rabotyaga]: {ffffff}Слишком мало точек, ничего не сохранено!', -1)
        return
    end
    local newIndex = getRouteCount() + 1
    local newName = u8"Маршрут " .. newIndex
    table.insert(customRoutes, {name = newName, points = recordingBuffer, oreRadius = routeOreRadius})
    saveCustomRoutesToFile()
    sampAddChatMessage('{cc66ff}[rabotyaga]: {ffffff}Записан новый маршрут (' .. #recordingBuffer .. ' точек), всего маршрутов: ' .. getRouteCount(), -1)
end

function switchToNextRoute()
    local total = getRouteCount()
    if total <= 1 then
        return -- другого маршрута нет, переключаться не на что
    end
    activeRouteIndex = activeRouteIndex + 1
    if activeRouteIndex > total then
        activeRouteIndex = 1
    end
    currentRoutePoint = 1
    sampAddChatMessage('{cc66ff}[rabotyaga]: {ffffff}Следующий: маршрут ' .. u8:decode(getRouteName(activeRouteIndex)), -1)
end

function beerAutoTick()
    if beerEnabled and not licPro() then
        beerEnabled = false
        licDeny('Авто-пиво')
    end
    if beerEnabled then
        local now = os.time()
        local delta = now - beerLastTick
        if delta > 0 then
            beerElapsed = beerElapsed + delta
            beerLastTick = now
            if beerElapsed >= beerInterval then
                if isSampAvailable() and not sampIsChatInputActive() and not sampIsDialogActive() then
                    sampSendChat("/beer")
                    sampAddChatMessage('{8888FF}[BeerBot]: {ffffff}Отправлена команда /beer (пиво пьём).', -1)
                end
                beerElapsed = 0
            end
        end
    else
        beerLastTick = os.time()
    end
end

-- RS_BLOCK_BEGIN
-- ================================================================
-- Учёт респавна руды: куда пришла, когда пропала, сколько ждать
-- Всё держится в одной таблице RS (чтобы не превышать лимит локальных переменных Lua).
-- ================================================================
local RS = {
    spots = {},                  -- {x,y,z,types={[тип]=раз},samples={сек,...},med,present,depletedAt,depletedValid}
    filePath = "moonloader/config/rabotyaga_spots.lua",
    dirty = false,
    settingsDirty = false,
    lastSave = 0,
    lastScan = 0,
    maxSpots = 3000,             -- предел по количеству мест, чтобы не раздувать память и файл
    mergeRadius = 2.0,           -- руды ближе этого расстояния считаются одним местом
    observeRadius = 120,         -- смысл: дальше этого = не считаем; иначе: учёт только вблизи
    trackEnabled = true,
    hudEnabled = true,
    waitEnabled = false,
    waitMax = 30,                -- до скольки секунд ждать возрождения руды на месте
    waitGrace = 15,              -- сколько секунд ещё ждём после ожидаемого времени
    maxSamples = 15,
    posById = {},                -- [id объекта] = {x,y,z}
    spotById = {},               -- [id объекта] = место из базы
    font = nil,
    waitingSpot = nil,
    summary = nil,
    summaryAt = 0,
    waitSlider = imgui.new.int(30),
    observeSlider = imgui.new.int(120),
    stats = {destroyed = 0, seen = 0, samples = 0, streamedOut = 0, lostSight = 0},
}

function rsMedian(list)
    local n = #list
    if n == 0 then return nil end
    local t = {}
    for i = 1, n do t[i] = list[i] end
    table.sort(t)
    if n % 2 == 1 then
        return t[(n + 1) / 2]
    end
    return (t[n / 2] + t[n / 2 + 1]) / 2
end

function rsFmtTime(sec)
    sec = math.floor(sec + 0.5)
    if sec < 0 then sec = 0 end
    return string.format("%d:%02d", math.floor(sec / 60), sec % 60)
end

function rsFindSpot(x, y, z)
    local best, bestD = nil, RS.mergeRadius
    for i = 1, #RS.spots do
        local s = RS.spots[i]
        local dx, dy = s.x - x, s.y - y
        if math.abs(dx) <= RS.mergeRadius and math.abs(dy) <= RS.mergeRadius then
            local dz = s.z - z
            local d = math.sqrt(dx * dx + dy * dy + dz * dz)
            if d <= bestD then
                best, bestD = s, d
            end
        end
    end
    return best
end

-- Самый частый тип руды на этом месте
function rsSpotType(spot)
    local bestT, bestN = nil, 0
    for t, n in pairs(spot.types) do
        if n > bestN then
            bestT, bestN = t, n
        end
    end
    return bestT
end

function rsAddSample(spot, sec)
    table.insert(spot.samples, sec)
    while #spot.samples > RS.maxSamples do
        table.remove(spot.samples, 1)
    end
    spot.med = rsMedian(spot.samples)
    RS.stats.samples = RS.stats.samples + 1
    RS.dirty = true
end

-- Сколько секунд до возрождения (отрицательное = просрочено), nil если данных нет
function rsSpotEta(spot)
    if spot.present or not spot.depletedAt or not spot.med then
        return nil
    end
    return spot.depletedAt + spot.med - os.time()
end

-- Руда добыта (событие onDestroyObject)
function rsOnOreDestroyed(id)
    local spot = RS.spotById[id]
    if spot and RS.trackEnabled and licPro() then
        spot.present = false
        local px, py = getCharCoordinates(PLAYER_PED)
        local dx, dy = spot.x - px, spot.y - py
        if dx * dx + dy * dy <= RS.observeRadius * RS.observeRadius then
            spot.depletedAt = os.time()
            spot.depletedValid = true
            RS.stats.destroyed = RS.stats.destroyed + 1
        else
            spot.depletedAt = nil
            RS.stats.streamedOut = RS.stats.streamedOut + 1
        end
    end
    RS.spotById[id] = nil
    RS.posById[id] = nil
end

-- Раз в полсекунды: запоминаем новые руды в районе, видим возрождение уже добытых
function rsScan()
    local now = os.time()
    for id, oreType in pairs(resources) do
        if not RS.posById[id] then
            local object = sampGetObjectHandleBySampId(id)
            if doesObjectExist(object) then
                local _, ox, oy, oz = getObjectCoordinates(object)
                RS.posById[id] = {ox, oy, oz}
                local spot = rsFindSpot(ox, oy, oz)
                if not spot and #RS.spots < RS.maxSpots then
                    spot = {x = ox, y = oy, z = oz, types = {}, samples = {}}
                    table.insert(RS.spots, spot)
                end
                if spot then
                    RS.spotById[id] = spot
                    spot.types[oreType] = (spot.types[oreType] or 0) + 1
                    if spot.depletedAt then
                        if spot.depletedValid then
                            local dt = now - spot.depletedAt
                            if dt >= 1 and dt <= 3600 then
                                rsAddSample(spot, dt)
                            end
                        else
                            RS.stats.lostSight = RS.stats.lostSight + 1
                        end
                        spot.depletedAt = nil
                    end
                    spot.present = true
                    RS.stats.seen = RS.stats.seen + 1
                    RS.dirty = true
                end
            end
        end
    end

    -- Если место уже добыто, но мы больше его не видим: время снимать нельзя
    local px, py = getCharCoordinates(PLAYER_PED)
    local limit = RS.observeRadius * RS.observeRadius
    for i = 1, #RS.spots do
        local s = RS.spots[i]
        if s.depletedAt and s.depletedValid then
            local dx, dy = s.x - px, s.y - py
            if dx * dx + dy * dy > limit then
                s.depletedValid = false
            end
        end
    end
end

-- Место, у которого стоит подождать возрождение (рядом с текущей точкой маршрута)
function rsFindWaitSpot(routeX, routeY, routeZ, radius)
    if not (RS.trackEnabled and RS.waitEnabled and licPro()) then
        return nil
    end
    local best, bestAbs = nil, nil
    for i = 1, #RS.spots do
        local s = RS.spots[i]
        if s.depletedAt and not s.present then
            local eta = rsSpotEta(s)
            if eta and eta <= RS.waitMax and eta >= -RS.waitGrace then
                local dx, dy, dz = s.x - routeX, s.y - routeY, s.z - routeZ
                if math.sqrt(dx * dx + dy * dy + dz * dz) <= radius then
                    if not bestAbs or math.abs(eta) < bestAbs then
                        best, bestAbs = s, math.abs(eta)
                    end
                end
            end
        end
    end
    if best then
        local c = os.clock()
        if not best.nearCheckAt or c - best.nearCheckAt > 1.0 then
            best.nearCheckAt = c
            best.nearBlocked = isPlayerNearPosition(best.x, best.y, best.z, 5)
        end
        if best.nearBlocked then
            return nil
        end
    end
    return best
end

-- Подписи над местами, где руда ещё не выросла
function rsDrawHud()
    if not (RS.trackEnabled and RS.hudEnabled and RS.font and licPro()) then
        return
    end
    local px, py = getCharCoordinates(PLAYER_PED)
    local now = os.time()
    for i = 1, #RS.spots do
        local s = RS.spots[i]
        if s.depletedAt and not s.present then
            local dx, dy = s.x - px, s.y - py
            if dx * dx + dy * dy <= 3600 and isPointOnScreen(s.x, s.y, s.z, 1) then
                local sx, sy = convert3DCoordsToScreen(s.x, s.y, s.z + 1.0)
                if sx and sy then
                    local t = rsSpotType(s)
                    local name = t and u8:decode(oreNames[t]) or "Руда"
                    local eta = rsSpotEta(s)
                    local text, color
                    if not eta then
                        text = name .. " (прошло " .. rsFmtTime(now - s.depletedAt) .. ")"
                        color = 0xFFAAAAAA
                    elseif eta > 0 then
                        text = name .. " ~" .. rsFmtTime(eta)
                        color = eta <= 5 and 0xFF55FF55 or 0xFFFFD84D
                    else
                        text = name .. " уже +" .. rsFmtTime(-eta)
                        color = 0xFFFF8844
                    end
                    renderFontDrawText(RS.font, text, sx, sy, color)
                end
            end
        end
    end
end

function rsSaveSpots()
    local file = io.open(RS.filePath, "w")
    if not file then return false end
    file:write("return {\n")
    for _, s in ipairs(RS.spots) do
        local types = {}
        for t, n in pairs(s.types) do
            table.insert(types, string.format("[%d]=%d", t, n))
        end
        file:write(string.format("    {x=%.2f,y=%.2f,z=%.2f,types={%s},samples={%s}},\n",
            s.x, s.y, s.z, table.concat(types, ","), table.concat(s.samples, ",")))
    end
    file:write("}\n")
    file:close()
    RS.dirty = false
    RS.lastSave = os.time()
    return true
end

function rsLoadSpots()
    RS.lastSave = os.time()
    if not doesFileExist(RS.filePath) then return end
    local chunk = loadfile(RS.filePath)
    if not chunk then return end
    local ok, data = pcall(chunk)
    if ok and type(data) == "table" then
        RS.spots = {}
        for _, s in ipairs(data) do
            if type(s.x) == "number" and type(s.y) == "number" and type(s.z) == "number" then
                local spot = {x = s.x, y = s.y, z = s.z, types = s.types or {}, samples = s.samples or {}}
                spot.med = rsMedian(spot.samples)
                table.insert(RS.spots, spot)
            end
        end
    end
end

function rsLoadSettings()
    local m = mainIni.main
    local function flag(v, default)
        if v == nil then return default end
        return v == true or v == 'true' or v == 1
    end
    RS.trackEnabled = flag(m.respawnTrack, true)
    RS.hudEnabled = flag(m.respawnHud, true)
    RS.waitEnabled = flag(m.respawnWait, false)
    RS.waitMax = tonumber(m.respawnWaitMax) or 30
    RS.observeRadius = tonumber(m.respawnObserve) or 120
end

function rsSaveSettings()
    local m = mainIni.main
    m.respawnTrack = RS.trackEnabled
    m.respawnHud = RS.hudEnabled
    m.respawnWait = RS.waitEnabled
    m.respawnWaitMax = RS.waitMax
    m.respawnObserve = RS.observeRadius
    inicfg.save(mainIni, 'autominev2.ini')
    RS.settingsDirty = false
end

-- Вызывается каждый кадр из основного цикла
function rsTick()
    if RS.trackEnabled and licPro() and os.clock() - RS.lastScan >= 0.5 then
        RS.lastScan = os.clock()
        rsScan()
    end
    if RS.dirty and os.time() - RS.lastSave >= 60 then
        rsSaveSpots()
    end
    if RS.settingsDirty and not isKeyDown(0x01) then -- ждём, пока отпустят мышь
        rsSaveSettings()
    end
end

-- Сводка для вкладки (обновляется раз в секунду)
function rsRefreshSummary()
    local byType, withSamples, pending = {}, 0, {}
    for _, s in ipairs(RS.spots) do
        if #s.samples > 0 then
            withSamples = withSamples + 1
            local t = rsSpotType(s)
            if t then
                byType[t] = byType[t] or {}
                for _, v in ipairs(s.samples) do
                    table.insert(byType[t], v)
                end
            end
        end
        if s.depletedAt and not s.present then
            table.insert(pending, {spot = s, eta = rsSpotEta(s)})
        end
    end
    table.sort(pending, function(a, b)
        local ka, kb = a.eta or math.huge, b.eta or math.huge
        if ka ~= kb then return ka < kb end
        return a.spot.depletedAt > b.spot.depletedAt
    end)
    local medians = {}
    for t, list in pairs(byType) do
        medians[t] = {med = rsMedian(list), n = #list}
    end
    RS.summary = {medians = medians, withSamples = withSamples, pending = pending}
    RS.summaryAt = os.clock()
end
-- RS_BLOCK_END

-- TOOLS_BLOCK_BEGIN
-- ================================================================
-- Инструменты: оптимизация маршрутов, авто-маршрут, карта и цель бота
-- ================================================================
BOT = {kind = nil, x = 0, y = 0, z = 0}   -- что бот делает сейчас: mine / ore / wait / route / afk

local TL = {
    optTol = imgui.new.float(1.5),     -- допуск упрощения, м
    optGap = imgui.new.int(12),        -- максимальный шаг между точками, м
    optSmooth = true,
    optClose = true,
    arRadius = imgui.new.int(150),     -- радиус выборки мест вокруг игрока, м
    arStep = imgui.new.int(8),         -- шаг дополнительных точек, м
    arRespawn = true,
    maxNodes = 250,
    speed = 6.0,                       -- м/с, для оценки времени круга
    mineTime = 2.0,                    -- сек на добычу одной руды
    msg = nil,
    msgOk = true,
}

local MAP = {
    follow = true,
    showAll = false,
    showPlayers = true,
    showBot = true,
    viewMeters = 250,                  -- ширина карты в метрах
    cx = 0, cy = 0,                    -- центр, когда карта не следует за игроком
    zoomSlider = imgui.new.int(250),
    cov = {},                          -- [номер маршрута] = {n, states, cursor}
    grid = nil,
    gridAt = -100,
    gridCell = 25,
    W = 540, H = 290,
}

-- ---------- Геометрия ----------
function toolsDist2d(ax, ay, bx, by)
    local dx, dy = ax - bx, ay - by
    return math.sqrt(dx * dx + dy * dy)
end

-- расстояние от точки p до отрезка a-b на плоскости
function toolsPointSegDist(p, a, b)
    local abx, aby = b.x - a.x, b.y - a.y
    local len2 = abx * abx + aby * aby
    if len2 == 0 then
        return toolsDist2d(p.x, p.y, a.x, a.y)
    end
    local t = ((p.x - a.x) * abx + (p.y - a.y) * aby) / len2
    if t < 0 then t = 0 elseif t > 1 then t = 1 end
    return toolsDist2d(p.x, p.y, a.x + t * abx, a.y + t * aby)
end

function toolsRouteLength(pts, closed)
    local len = 0
    for i = 1, #pts - 1 do
        len = len + toolsDist2d(pts[i].x, pts[i].y, pts[i + 1].x, pts[i + 1].y)
    end
    if closed and #pts > 2 then
        len = len + toolsDist2d(pts[#pts].x, pts[#pts].y, pts[1].x, pts[1].y)
    end
    return len
end

-- точки с действием (прыжок и т.д.) нельзя убирать; FORWARD убираем так же, как и обычные точки
function toolsIsAnchor(p)
    local a = p.action
    return a == "JUMP" or a == "LEFT" or a == "RIGHT" or a == "BACKWARD"
end

-- ---------- Оптимизация записанных маршрутов ----------
function toolsSimplify(pts, tol)
    local n = #pts
    local keep = {}
    keep[1], keep[n] = true, true
    for i = 1, n do
        if toolsIsAnchor(pts[i]) then keep[i] = true end
    end
    local anchors = {}
    for i = 1, n do
        if keep[i] then anchors[#anchors + 1] = i end
    end
    for a = 1, #anchors - 1 do
        local stack = {{anchors[a], anchors[a + 1]}}
        while #stack > 0 do
            local seg = table.remove(stack)
            local i0, i1 = seg[1], seg[2]
            local maxD, idx = 0, nil
            for i = i0 + 1, i1 - 1 do
                local d = toolsPointSegDist(pts[i], pts[i0], pts[i1])
                if d > maxD then maxD, idx = d, i end
            end
            if idx and maxD > tol then
                keep[idx] = true
                stack[#stack + 1] = {i0, idx}
                stack[#stack + 1] = {idx, i1}
            end
        end
    end
    local out = {}
    for i = 1, n do
        if keep[i] then out[#out + 1] = pts[i] end
    end
    return out
end

-- Лёгкое сглаживание маршрута (точки с действием не трогаем)
function toolsSmooth(pts)
    local n = #pts
    if n < 3 then return pts end
    local out = {}
    for i = 1, n do
        local p = pts[i]
        if i == 1 or i == n or toolsIsAnchor(p) then
            out[i] = {x = p.x, y = p.y, z = p.z, action = p.action}
        else
            local a, b = pts[i - 1], pts[i + 1]
            out[i] = {x = 0.25 * a.x + 0.5 * p.x + 0.25 * b.x,
                      y = 0.25 * a.y + 0.5 * p.y + 0.25 * b.y,
                      z = p.z, action = p.action}
        end
    end
    return out
end

-- Добавляем промежуточные точки, чтобы шаг не превышал maxGap (нужно для поиска руды рядом с путём)
function toolsDensify(pts, maxGap, closed)
    local n = #pts
    local out = {}
    for i = 1, n do
        local a = pts[i]
        out[#out + 1] = a
        local b = pts[i + 1]
        if not b and closed and n > 2 then b = pts[1] end
        if b then
            local d = toolsDist2d(a.x, a.y, b.x, b.y)
            if d > maxGap then
                local k = math.ceil(d / maxGap) - 1
                for j = 1, k do
                    local t = j / (k + 1)
                    out[#out + 1] = {x = a.x + (b.x - a.x) * t, y = a.y + (b.y - a.y) * t,
                                     z = a.z + (b.z - a.z) * t, action = "MOVE"}
                end
            end
        end
    end
    return out
end

-- Копия маршрута index -> новый оптимизированный маршрут. Возвращает таблицу с итогами или nil, текст ошибки
function toolsOptimizeRoute(index, tol, maxGap, smooth, close)
    if not licPro() then
        return nil, u8'Оптимизация маршрутов доступна по подписке Про'
    end
    local src = getRoutePoints(index)
    if #src < 3 then
        return nil, u8"В маршруте слишком мало точек"
    end
    local pts = {}
    for i, p in ipairs(src) do
        pts[i] = {x = p.x, y = p.y, z = p.z, action = p.action or "MOVE"}
    end
    local before = #pts
    local lenBefore = toolsRouteLength(pts, false)

    -- 1) убираем стоячие точки
    local kept = {pts[1]}
    for i = 2, #pts do
        local p, last = pts[i], kept[#kept]
        if i == #pts or toolsIsAnchor(p) or toolsDist2d(p.x, p.y, last.x, last.y) >= 0.8 then
            kept[#kept + 1] = p
        end
    end
    pts = kept

    -- 2) сглаживание, 3) убираем лишние точки на прямых
    if smooth then pts = toolsSmooth(pts) end
    pts = toolsSimplify(pts, tol)

    -- 4) замыкаем в круг: хвост совпадает с началом, тогда одну точку убираем
    if close and #pts > 3 then
        local last = pts[#pts]
        if toolsDist2d(last.x, last.y, pts[1].x, pts[1].y) <= 3 and not toolsIsAnchor(last) then
            table.remove(pts)
        end
    end

    -- 5) ограничиваем шаг
    pts = toolsDensify(pts, maxGap, close)

    local name = getRouteName(index) .. u8" (опт.)"
    table.insert(customRoutes, {name = name, points = pts, oreRadius = getRouteOreRadius(index)})
    saveCustomRoutesToFile()
    return {before = before, after = #pts, lenBefore = lenBefore,
            lenAfter = toolsRouteLength(pts, close), newIndex = getRouteCount()}
end

-- ---------- Авто-маршрут по базе мест ----------
function toolsTwoOpt(order)
    local n = #order
    if n < 4 then return order end
    local improved, passes = true, 0
    while improved and passes < 30 do
        improved = false
        passes = passes + 1
        for i = 1, n - 1 do
            for j = i + 2, n do
                local a, b = order[i], order[i + 1]
                local c, d = order[j], order[j % n + 1]
                if a ~= d then
                    local before = toolsDist2d(a.x, a.y, b.x, b.y) + toolsDist2d(c.x, c.y, d.x, d.y)
                    local after = toolsDist2d(a.x, a.y, c.x, c.y) + toolsDist2d(b.x, b.y, d.x, d.y)
                    if after < before - 1e-6 then
                        local lo, hi = i + 1, j
                        while lo < hi do
                            order[lo], order[hi] = order[hi], order[lo]
                            lo = lo + 1
                            hi = hi - 1
                        end
                        improved = true
                    end
                end
            end
        end
    end
    return order
end

-- Строим маршрут по найденным местам руды вокруг (cx, cy)
function toolsBuildAutoRoute(cx, cy, radius, useRespawn, step)
    if not licPro() then
        return nil, u8'Авто-маршрут доступен по подписке Про'
    end
    local now = os.time()
    local nodes = {}
    for _, s in ipairs(RS.spots) do
        local d = toolsDist2d(s.x, s.y, cx, cy)
        if d <= radius then
            local avail = 0
            if useRespawn and not s.present and s.depletedAt and s.med then
                avail = math.max(0, s.depletedAt + s.med - now)
            end
            nodes[#nodes + 1] = {x = s.x, y = s.y, z = s.z, avail = avail, d = d, med = s.med}
        end
    end
    if #nodes < 3 then
        return nil, u8"Мало мест руды в базе (нужно хотя бы 3). Походи по шахте - база пополнится"
    end
    table.sort(nodes, function(a, b) return a.d < b.d end)
    while #nodes > TL.maxNodes do
        table.remove(nodes)
    end

    -- Жадный выбор: берём место, где раньше всего можно начать добычу (дорога + ожидание респавна)
    local order, used, t = {}, {}, 0
    local curX, curY = cx, cy
    for _ = 1, #nodes do
        local best, bestFin, bestD
        for i, nd in ipairs(nodes) do
            if not used[i] then
                local d = toolsDist2d(curX, curY, nd.x, nd.y)
                local fin = math.max(t + d / TL.speed, nd.avail)
                if not bestFin or fin < bestFin or (fin == bestFin and d < bestD) then
                    best, bestFin, bestD = i, fin, d
                end
            end
        end
        used[best] = true
        order[#order + 1] = nodes[best]
        t = bestFin + TL.mineTime
        curX, curY = nodes[best].x, nodes[best].y
    end

    -- без учёта респавна идём по кругу с оптимизацией перестановкой
    if not useRespawn then
        order = toolsTwoOpt(order)
        local bi, bd = 1, math.huge
        for i, nd in ipairs(order) do
            local d = toolsDist2d(cx, cy, nd.x, nd.y)
            if d < bd then bi, bd = i, d end
        end
        local rotated = {}
        for k = 0, #order - 1 do
            rotated[#rotated + 1] = order[(bi - 1 + k) % #order + 1]
        end
        order = rotated
    end

    local pts = {}
    for _, nd in ipairs(order) do
        pts[#pts + 1] = {x = nd.x, y = nd.y, z = nd.z, action = "MOVE"}
    end
    pts = toolsDensify(pts, step, true)

    local length = toolsRouteLength(pts, true)
    local loopSec = length / TL.speed + #order * TL.mineTime
    local maxMed = 0
    for _, nd in ipairs(order) do
        if nd.med and nd.med > maxMed then maxMed = nd.med end
    end

    local newIndex = getRouteCount() + 1
    table.insert(customRoutes, {name = u8"Авто " .. newIndex .. u8" (" .. #order .. u8" м.)",
                                points = pts, oreRadius = 12})
    saveCustomRoutesToFile()
    return {spots = #order, points = #pts, length = length, loopSec = loopSec,
            maxMed = maxMed, newIndex = newIndex}
end

-- ---------- Данные для карты ----------
function mapRebuildGrid()
    local g, cell = {}, MAP.gridCell
    for i = 1, #RS.spots do
        local s = RS.spots[i]
        local key = math.floor(s.x / cell) * 100003 + math.floor(s.y / cell)
        local b = g[key]
        if not b then
            b = {}
            g[key] = b
        end
        b[#b + 1] = s
    end
    MAP.grid = g
    MAP.gridAt = os.clock()
end

-- 0 = рядом нет живой руды (пустой участок), 1 = места есть, но живой руды нет, 2 = руда есть
function mapPointState(x, y, radius)
    local cell = MAP.gridCell
    local r2 = radius * radius
    local state = 0
    for gx = math.floor((x - radius) / cell), math.floor((x + radius) / cell) do
        for gy = math.floor((y - radius) / cell), math.floor((y + radius) / cell) do
            local b = MAP.grid[gx * 100003 + gy]
            if b then
                for i = 1, #b do
                    local s = b[i]
                    local dx, dy = s.x - x, s.y - y
                    if dx * dx + dy * dy <= r2 then
                        if s.present then return 2 end
                        state = 1
                    end
                end
            end
        end
    end
    return state
end

-- считаем покрытие порциями, чтобы не просаживать кадры
function mapUpdateCoverage(routeIdx, budget)
    if not MAP.grid or os.clock() - MAP.gridAt > 2 then
        mapRebuildGrid()
    end
    local pts = getRoutePoints(routeIdx)
    local c = MAP.cov[routeIdx]
    if not c or c.n ~= #pts then
        c = {n = #pts, states = {}, cursor = 1}
        MAP.cov[routeIdx] = c
    end
    if #pts == 0 then return c end
    local radius = getRouteOreRadius(routeIdx)
    for _ = 1, math.min(budget, #pts) do
        local i = c.cursor
        local p = pts[i]
        c.states[i] = mapPointState(p.x, p.y, radius)
        c.cursor = i + 1
        if c.cursor > #pts then c.cursor = 1 end
    end
    return c
end

-- Показать всё: маршрут, игрок и ближайшие места руды
function mapFitAll()
    local minx, maxx, miny, maxy
    local function add(x, y)
        if not minx then
            minx, maxx, miny, maxy = x, x, y, y
        else
            if x < minx then minx = x end
            if x > maxx then maxx = x end
            if y < miny then miny = y end
            if y > maxy then maxy = y end
        end
    end
    local px, py = getCharCoordinates(PLAYER_PED)
    add(px, py)
    for _, p in ipairs(getActiveRoute()) do add(p.x, p.y) end
    for _, s in ipairs(RS.spots) do
        if toolsDist2d(s.x, s.y, px, py) <= 600 then add(s.x, s.y) end
    end
    MAP.follow = false
    MAP.cx, MAP.cy = (minx + maxx) / 2, (miny + maxy) / 2
    local need = math.max(maxx - minx, (maxy - miny) * MAP.W / MAP.H) * 1.15
    MAP.viewMeters = math.max(60, math.min(3000, need))
end
-- TOOLS_BLOCK_END

-- TG_BLOCK_BEGIN
-- ================================================================
-- TELEGRAM: уведомления и управление ботом из Telegram
-- Сеть работает в отдельном потоке (effil), игру не подвешивает.
-- Всё держится в одной таблице TG (чтобы не превышать лимит локальных переменных Lua).
-- ================================================================
local TG = {
    enabled = false,
    token = "",
    chatId = "",
    -- события
    evAdmin = true, evStuck = true, evTeleport = true, evAfk = true,
    evStartStop = true, evGoal = true, evHourly = true,
    hourlyMin = 60,
    stuckSec = 25,
    stopOnTp = false,
    cmds = false,                      -- принимать команды из Telegram
    -- рабочее
    thread = nil, ctl = nil, outCh = nil, inCh = nil,
    transport = nil,
    status = "",
    statusOk = true,
    queue = {},
    cooldown = {},
    lastSend = 0, lastTick = 0,
    discover = false, found = nil,
    skipBacklog = false,
    testUntil = 0,
    booted = false, lastMode = false, lastAfk = false,
    goalSent = false,
    sessionStart = nil, nextReport = nil,
    reportBase = nil, reportAt = nil,
    lastPos = nil, stuckRef = nil,
    settingsDirty = false,
    failAt = nil,
    sent = 0, failed = 0, received = 0,
    tokenBuf = ffi.new("char[128]"),
    chatBuf = ffi.new("char[32]"),
    hourlySlider = imgui.new.int(60),
    stuckSlider = imgui.new.int(25),
    -- эмодзи в сообщениях: байты UTF-8 в виде escape-последовательностей
    E = {
        ok = "\xE2\x9C\x85", warn = "\xE2\x9A\xA0\xEF\xB8\x8F", stop = "\xF0\x9F\x9B\x91",
        play = "\xE2\x96\xB6\xEF\xB8\x8F", pick = "\xE2\x9B\x8F\xEF\xB8\x8F", beer = "\xF0\x9F\x8D\xBA",
        chart = "\xF0\x9F\x93\x8A", pin = "\xF0\x9F\x93\x8D", zzz = "\xF0\x9F\x92\xA4",
        alarm = "\xF0\x9F\x9A\xA8", flag = "\xF0\x9F\x8F\x81", bolt = "\xE2\x9A\xA1",
    },
}

-- ---------- Поток: сеть, внутри нет доступа к игре (самодостаточная функция, без upvalue) ----------
TG.threadMain = function(ctl, outCh, inCh)
    local effil = require('effil')
    local https, ltn12, requests
    local okS, s = pcall(require, 'ssl.https')
    if okS then https = s end
    local okL, l = pcall(require, 'ltn12')
    if okL then ltn12 = l end
    local okR, r = pcall(require, 'requests')
    if okR then requests = r end
    if https then
        pcall(function() require('socket.http').TIMEOUT = 15 end)
    end
    local name = ""
    if https and ltn12 then name = "ssl.https" elseif requests then name = "requests" end
    inCh:push({t = "transport", name = name})

    local function post(url, body)
        local headers = {["Content-Type"] = "application/json", ["Content-Length"] = tostring(#body)}
        if https and ltn12 then
            local resp = {}
            local okc, ok, code = pcall(https.request, {
                url = url, method = "POST", headers = headers,
                source = ltn12.source.string(body), sink = ltn12.sink.table(resp)
            })
            if not okc then return false, nil, tostring(ok) end
            if not ok then return false, nil, tostring(code) end
            return true, table.concat(resp), nil, tonumber(code)
        elseif requests then
            local okc, resp = pcall(requests.post, {url = url, data = body, headers = headers})
            if not okc then return false, nil, tostring(resp) end
            return true, resp.text, nil, tonumber(resp.status_code)
        end
        return false, nil, "no-transport"
    end

    while ctl.run do
        local base = "https://api.telegram.org/bot" .. tostring(ctl.token) .. "/"
        local sentAny = false
        local item = outCh:pop(0)
        while item do
            sentAny = true
            local ok, text, err, code = post(base .. item.method, item.body)
            local good = ok and code == 200
            local msg = err
            if ok and not good then
                msg = "HTTP " .. tostring(code) .. " " .. tostring(text):sub(1, 120)
            end
            inCh:push({t = "sent", ok = good and true or false, err = msg, tag = item.tag})
            item = outCh:pop(0)
        end
        if ctl.poll then
            local off = tonumber(ctl.offset) or 0
            local body = string.format('{"offset":%d,"timeout":2,"allowed_updates":["message"]}', off)
            local ok, text, err, code = post(base .. "getUpdates", body)
            if ok and code == 200 then
                inCh:push({t = "updates", body = text})
            else
                local msg = err
                if ok then msg = "HTTP " .. tostring(code) .. " " .. tostring(text):sub(1, 120) end
                inCh:push({t = "pollerr", err = msg})
                effil.sleep(3000, "ms")
            end
        else
            effil.sleep(300, "ms")
        end
    end
end

-- ---------- Строки в JSON ----------
function tgUtf8Char(cp)
    if cp < 0x80 then return string.char(cp) end
    if cp < 0x800 then return string.char(0xC0 + math.floor(cp / 64), 0x80 + cp % 64) end
    if cp >= 0xD800 and cp <= 0xDFFF then return "?" end
    if cp < 0x10000 then
        return string.char(0xE0 + math.floor(cp / 4096), 0x80 + math.floor(cp / 64) % 64, 0x80 + cp % 64)
    end
    return string.char(0xF0 + math.floor(cp / 262144), 0x80 + math.floor(cp / 4096) % 64,
                       0x80 + math.floor(cp / 64) % 64, 0x80 + cp % 64)
end

-- оставляем только корректный UTF-8 (иначе Telegram вернёт 400)
function tgUtf8Clean(s)
    local out, i, n = {}, 1, #s
    while i <= n do
        local c = s:byte(i)
        local len = 0
        if c < 0x80 then len = 1
        elseif c >= 0xC2 and c < 0xE0 then len = 2
        elseif c >= 0xE0 and c < 0xF0 then len = 3
        elseif c >= 0xF0 and c < 0xF5 then len = 4 end
        local ok = len > 0 and i + len - 1 <= n
        if ok and len > 1 then
            for k = 1, len - 1 do
                local b = s:byte(i + k)
                if b < 0x80 or b > 0xBF then ok = false break end
            end
            if ok then
                local b2 = s:byte(i + 1)
                if (c == 0xE0 and b2 < 0xA0) or (c == 0xED and b2 >= 0xA0) or
                   (c == 0xF0 and b2 < 0x90) or (c == 0xF4 and b2 >= 0x90) then
                    ok = false
                end
            end
        end
        if ok then
            out[#out + 1] = s:sub(i, i + len - 1)
            i = i + len
        else
            out[#out + 1] = "?"
            i = i + 1
        end
    end
    return table.concat(out)
end

function tgJsonEsc(s)
    s = tgUtf8Clean(s)
    return (s:gsub('[%c"\\]', function(ch)
        if ch == '"' then return '\\"' end
        if ch == '\\' then return '\\\\' end
        if ch == '\n' then return '\\n' end
        if ch == '\r' then return '\\r' end
        if ch == '\t' then return '\\t' end
        return string.format('\\u%04x', ch:byte())
    end))
end

-- читаем JSON-строку; pos - первая буква после открывающей кавычки. Возвращает строку и позицию после закрывающей
function tgReadJsonString(s, pos)
    local out, i, n = {}, pos, #s
    local simple = {n = "\n", r = "\r", t = "\t", b = "\b", f = "\f", ['"'] = '"', ["\\"] = "\\", ["/"] = "/"}
    while i <= n do
        local a, b = s:find('^[^"\\]+', i)
        if a then
            out[#out + 1] = s:sub(a, b)
            i = b + 1
        else
            local c = s:sub(i, i)
            if c == '"' then
                return table.concat(out), i + 1
            end
            local nx = s:sub(i + 1, i + 1)
            if simple[nx] then
                out[#out + 1] = simple[nx]
                i = i + 2
            elseif nx == "u" then
                local cp = tonumber(s:sub(i + 2, i + 5), 16)
                if not cp then return nil end
                i = i + 6
                if cp >= 0xD800 and cp <= 0xDBFF and s:sub(i, i + 1) == "\\u" then
                    local lo = tonumber(s:sub(i + 2, i + 5), 16)
                    if lo and lo >= 0xDC00 and lo <= 0xDFFF then
                        cp = 0x10000 + (cp - 0xD800) * 0x400 + (lo - 0xDC00)
                        i = i + 6
                    end
                end
                out[#out + 1] = tgUtf8Char(cp)
            else
                out[#out + 1] = nx
                i = i + 2
            end
        end
    end
    return nil
end

-- Текст игры (CP1251) -> UTF-8 для Telegram, без цветовых кодов {RRGGBB}
function tgToUtf8(s)
    s = tostring(s or ""):gsub("{%x%x%x%x%x%x}", "")
    local ok, res = pcall(function() return u8(s) end)
    if ok and type(res) == "string" then s = res end
    return tgUtf8Clean(s)
end

function tgBuildSend(chat, text)
    if #text > 3900 then
        text = tgUtf8Clean(text:sub(1, 3900))
    end
    local id
    if tostring(chat):match("^%-?%d+$") then id = tostring(chat) else id = '"' .. tgJsonEsc(tostring(chat)) .. '"' end
    return '{"chat_id":' .. id .. ',"text":"' .. tgJsonEsc(text) .. '","disable_web_page_preview":true}'
end

-- ---------- Разбор getUpdates ----------
function tgParseUpdates(body)
    local list, maxId, starts, p = {}, nil, {}, 1
    while true do
        local a = body:find('{"update_id":', p, true)
        if not a then break end
        starts[#starts + 1] = a
        p = a + 1
    end
    for k, a in ipairs(starts) do
        local chunk = body:sub(a, (starts[k + 1] or (#body + 1)) - 1)
        local id = tonumber(chunk:match('^{"update_id":(%d+)'))
        if id then
            if not maxId or id > maxId then maxId = id end
            local u = {id = id}
            local chatPos = chunk:find('"chat":{"id":', 1, true)
            if chatPos then
                u.chat = chunk:match('"chat":{"id":(%-?%d+)')
                local tail = chunk:sub(chatPos, chatPos + 400)
                for _, key in ipairs({"first_name", "title", "username"}) do
                    local q = tail:find('"' .. key .. '":"', 1, true)
                    if q then
                        u.chatName = tgReadJsonString(tail, q + #key + 4)
                        break
                    end
                end
            end
            u.from = chunk:match('"from":{"id":(%d+)')
            local tq = chunk:find('"text":"', 1, true)
            if tq then u.text = tgReadJsonString(chunk, tq + 8) end
            list[#list + 1] = u
        end
    end
    return list, maxId
end

-- ---------- Настройки ----------
function tgTrim(s)
    return (tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

function tgLoadSettings()
    local m = mainIni.main
    local function flag(v, default)
        if v == nil then return default end
        return v == true or v == "true" or v == 1
    end
    TG.enabled = flag(m.tgEnabled, false)
    TG.token = tgTrim(m.tgToken)
    TG.chatId = tgTrim(m.tgChatId)
    TG.evAdmin = flag(m.tgAdmin, true)
    TG.evStuck = flag(m.tgStuck, true)
    TG.evTeleport = flag(m.tgTeleport, true)
    TG.evAfk = flag(m.tgAfk, true)
    TG.evStartStop = flag(m.tgStartStop, true)
    TG.evGoal = flag(m.tgGoal, true)
    TG.evHourly = flag(m.tgHourly, true)
    TG.hourlyMin = math.max(5, math.min(240, tonumber(m.tgHourlyMin) or 60))
    TG.stuckSec = math.max(10, math.min(120, tonumber(m.tgStuckSec) or 25))
    TG.stopOnTp = flag(m.tgStopOnTp, false)
    TG.cmds = flag(m.tgCmds, false)
    ffi.fill(TG.tokenBuf, ffi.sizeof(TG.tokenBuf), 0)
    ffi.fill(TG.chatBuf, ffi.sizeof(TG.chatBuf), 0)
    ffi.copy(TG.tokenBuf, TG.token)
    ffi.copy(TG.chatBuf, TG.chatId)
end

function tgSaveSettings()
    local m = mainIni.main
    m.tgEnabled = TG.enabled
    m.tgToken = TG.token
    m.tgChatId = TG.chatId
    m.tgAdmin = TG.evAdmin
    m.tgStuck = TG.evStuck
    m.tgTeleport = TG.evTeleport
    m.tgAfk = TG.evAfk
    m.tgStartStop = TG.evStartStop
    m.tgGoal = TG.evGoal
    m.tgHourly = TG.evHourly
    m.tgHourlyMin = TG.hourlyMin
    m.tgStuckSec = TG.stuckSec
    m.tgStopOnTp = TG.stopOnTp
    m.tgCmds = TG.cmds
    inicfg.save(mainIni, 'autominev2.ini')
    TG.settingsDirty = false
end

function tgApplyCredentials(token, chat)
    TG.token = tgTrim(token)
    TG.chatId = tgTrim(chat)
    TG.skipBacklog = true
    tgSaveSettings()
end

function tgTokenLooksValid(token)
    return token:match("^%d+:[%w_%-]+$") ~= nil
end

function tgReady()
    return TG.token ~= "" and TG.chatId ~= ""
end

-- ---------- Очередь отправки ----------
-- key + cooldown: не слать одно и то же событие чаще, чем раз в cooldown секунд
function tgSend(text, key, cooldown, force)
    if not licPro() then return false end
    if not (force or TG.enabled) or not tgReady() then return false end
    local now = os.time()
    if key and cooldown and cooldown > 0 then
        local last = TG.cooldown[key]
        if last and now - last < cooldown then return false end
        TG.cooldown[key] = now
    end
    if #TG.queue >= 30 then table.remove(TG.queue, 1) end
    TG.queue[#TG.queue + 1] = {text = text}
    return true
end

function tgFlush()
    if #TG.queue == 0 or not TG.outCh or not tgReady() then return end
    if os.clock() - TG.lastSend < 1.2 then return end   -- Telegram: не чаще ~1 сообщения в секунду в один чат
    local item = table.remove(TG.queue, 1)
    TG.lastSend = os.clock()
    TG.outCh:push({method = "sendMessage", body = tgBuildSend(TG.chatId, item.text), tag = "msg"})
end

-- ---------- Поток ----------
function tgEnsureThread()
    if TG.thread then return true end
    if TG.failAt and os.clock() - TG.failAt < 10 then return false end
    local ok, err = pcall(function()
        TG.ctl = effil.table({run = true, poll = false, offset = 0, token = TG.token})
        TG.outCh = effil.channel()
        TG.inCh = effil.channel()
        TG.thread = effil.thread(TG.threadMain)(TG.ctl, TG.outCh, TG.inCh)
    end)
    if not ok then
        TG.thread, TG.ctl, TG.outCh, TG.inCh = nil, nil, nil, nil
        TG.failAt = os.clock()
        TG.status = "effil: " .. tostring(err)
        TG.statusOk = false
        return false
    end
    TG.failAt = nil
    return true
end

function tgStop()
    if TG.ctl then TG.ctl.run = false end
    TG.thread, TG.ctl, TG.outCh, TG.inCh = nil, nil, nil, nil
    TG.transport = nil
end

-- Сообщения из потока
function tgPump()
    if not TG.inCh then return end
    for _ = 1, 20 do
        local ev = TG.inCh:pop(0)
        if not ev then break end
        if ev.t == "transport" then
            TG.transport = ev.name
            if ev.name == "" then
                TG.status = "Нет библиотеки для HTTPS (нужны ssl.https + ltn12 или requests)"
                TG.statusOk = false
            end
        elseif ev.t == "sent" then
            if ev.ok then
                TG.sent = TG.sent + 1
                TG.status = "Отправлено"
                TG.statusOk = true
            else
                TG.failed = TG.failed + 1
                TG.status = "Ошибка отправки: " .. tostring(ev.err)
                TG.statusOk = false
            end
        elseif ev.t == "updates" then
            tgHandleUpdates(ev.body)
        elseif ev.t == "pollerr" then
            TG.status = "Ошибка опроса: " .. tostring(ev.err)
            TG.statusOk = false
        end
    end
end

function tgHandleUpdates(body)
    if not body:find('"ok":true', 1, true) then
        TG.status = "Ошибка опроса: ответ без ok"
        TG.statusOk = false
        return
    end
    local list, maxId = tgParseUpdates(body)
    if maxId and TG.ctl then TG.ctl.offset = maxId + 1 end
    if TG.skipBacklog then
        -- старые сообщения, накопившиеся пока нас не было, пропускаем
        if #list == 0 then TG.skipBacklog = false end
        return
    end
    for _, u in ipairs(list) do
        TG.received = TG.received + 1
        tgHandleMessage(u)
    end
end

function tgHandleMessage(u)
    if not u.chat or not u.text then return end
    if TG.discover then
        TG.found = {id = u.chat, name = u.chatName or ""}
    end
    -- команды принимаем только из заданного чата
    if not (TG.enabled and TG.cmds and TG.chatId ~= "" and u.chat == TG.chatId) then return end
    local reply = tgRunCommand(u.text)
    if reply then tgSend(reply, nil, 0, true) end
end

-- ---------- Тексты ----------
function tgNick()
    local ok, id = pcall(function() return select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) end)
    if ok and id then
        local ok2, nick = pcall(sampGetPlayerNickname, id)
        if ok2 and nick then return tostring(nick) end
    end
    return "?"
end

function tgHead()
    return "[" .. tgNick() .. "] "
end

function tgTotals()
    local sum = totalStone + totalMetal + totalSilver + totalBronze + totalGold
    return {stone = totalStone, metal = totalMetal, silver = totalSilver, bronze = totalBronze, gold = totalGold, sum = sum}
end

function tgOreLine(t)
    return oreNames[1] .. " " .. t.stone .. ", " .. oreNames[2] .. " " .. t.metal .. ", " .. oreNames[3] .. " " ..
           t.silver .. ", " .. oreNames[4] .. " " .. t.bronze .. ", " .. oreNames[5] .. " " .. t.gold
end

function tgFmtDuration(sec)
    sec = math.max(0, math.floor(sec))
    return string.format("%d:%02d:%02d", math.floor(sec / 3600), math.floor(sec / 60) % 60, sec % 60)
end

function tgBotStateText()
    if not mode then return u8"Остановлен" end
    if isAfk or BOT.kind == "afk" then return u8"АФК-отдых" end
    local names = {mine = u8"Копает руду", ore = u8"Идёт к руде", wait = u8"Ждёт респавна у места",
                   route = u8"Идёт по маршруту"}
    return names[BOT.kind] or u8"Работает"
end

function tgPendingCount()
    local n = 0
    for _, s in ipairs(RS.spots) do
        if s.depletedAt and not s.present then n = n + 1 end
    end
    return n
end

function tgStatusText()
    local E, t = TG.E, tgTotals()
    local px, py, pz = getCharCoordinates(PLAYER_PED)
    local lines = {}
    lines[#lines + 1] = tgHead() .. (mode and E.play or E.stop) .. " " .. u8"Бот: " .. tgBotStateText()
    lines[#lines + 1] = E.pin .. " " .. u8"Маршрут: " .. getRouteName(activeRouteIndex) ..
        " (" .. currentRoutePoint .. "/" .. #getActiveRoute() .. ")"
    lines[#lines + 1] = E.pick .. " " .. u8"Добыто: " .. t.sum .. u8" из цели " .. SliderInt[0]
    lines[#lines + 1] = tgOreLine(t)
    if mode and TG.sessionStart then
        lines[#lines + 1] = u8"В работе: " .. tgFmtDuration(os.time() - TG.sessionStart)
    end
    lines[#lines + 1] = u8"Позиция: " .. math.floor(px) .. ", " .. math.floor(py) .. ", " .. math.floor(pz)
    lines[#lines + 1] = E.beer .. " " .. u8"Авто-пиво: " .. (beerEnabled and u8"вкл" or u8"выкл")
    lines[#lines + 1] = u8"База руды: мест " .. #RS.spots .. u8", ждут респавна " .. tgPendingCount()
    return table.concat(lines, "\n")
end

function tgReportText()
    local E, t = TG.E, tgTotals()
    local lines = {tgHead() .. E.chart .. " " .. u8"Отчёт"}
    lines[#lines + 1] = u8"Всего добыто: " .. t.sum .. u8" из цели " .. SliderInt[0]
    lines[#lines + 1] = tgOreLine(t)
    if TG.reportBase and TG.reportAt then
        local dt = math.max(1, os.time() - TG.reportAt)
        local d = t.sum - TG.reportBase.sum
        lines[#lines + 1] = u8"За " .. math.floor(dt / 60) .. u8" мин: +" .. d .. " (" ..
            math.floor(d * 3600 / dt) .. u8" в час)"
    end
    if mode and TG.sessionStart then
        lines[#lines + 1] = u8"В работе: " .. tgFmtDuration(os.time() - TG.sessionStart)
    end
    lines[#lines + 1] = u8"Бот: " .. tgBotStateText() .. u8", маршрут: " .. getRouteName(activeRouteIndex)
    return table.concat(lines, "\n")
end

function tgHelpText()
    return u8"Команды:\n/status - состояние бота\n/report - отчёт за период\n/run - запустить бота\n/stop - остановить бота\n" ..
           u8"/route - список маршрутов, /route N - выбрать маршрут\n/beer on|off - авто-пиво\n/pos - где персонаж"
end

-- ---------- Команды ----------
function tgRunCommand(text)
    local cmd, arg = text:match("^/(%w+)@?[%w_]*%s*(.-)%s*$")
    if not cmd then return nil end
    cmd = cmd:lower()
    local E = TG.E
    if cmd == "start" or cmd == "help" then
        return tgHelpText()
    elseif cmd == "status" then
        return tgStatusText()
    elseif cmd == "report" then
        return tgReportText()
    elseif cmd == "run" then
        if mode then return tgHead() .. u8"Бот уже запущен" end
        mode = true
        return tgHead() .. E.play .. " " .. u8"Бот запущен"
    elseif cmd == "stop" then
        if not mode then return tgHead() .. u8"Бот уже остановлен" end
        mode = false
        return tgHead() .. E.stop .. " " .. u8"Бот остановлен"
    elseif cmd == "route" then
        local n = tonumber(arg)
        if arg == "" then
            local lines = {tgHead() .. u8"Маршруты:"}
            for i = 1, math.min(getRouteCount(), 25) do
                lines[#lines + 1] = (i == activeRouteIndex and "> " or "  ") .. i .. ". " .. getRouteName(i) ..
                    " (" .. #getRoutePoints(i) .. u8" т.)"
            end
            lines[#lines + 1] = u8"Выбрать: /route N"
            return table.concat(lines, "\n")
        end
        if not n or n < 1 or n > getRouteCount() or n ~= math.floor(n) then
            return tgHead() .. E.warn .. " " .. u8"Нет такого маршрута. Всего: " .. getRouteCount()
        end
        activeRouteIndex = n
        currentRoutePoint = 1
        return tgHead() .. E.ok .. " " .. u8"Выбран маршрут " .. n .. ": " .. getRouteName(n)
    elseif cmd == "beer" then
        if arg == "on" then beerEnabled = true
        elseif arg == "off" then beerEnabled = false
        else beerEnabled = not beerEnabled end
        return tgHead() .. E.beer .. " " .. u8"Авто-пиво " .. (beerEnabled and u8"включено" or u8"выключено")
    elseif cmd == "pos" then
        local x, y, z = getCharCoordinates(PLAYER_PED)
        return tgHead() .. E.pin .. string.format(" %.1f, %.1f, %.1f", x, y, z)
    end
    return tgHead() .. E.warn .. " " .. u8"Неизвестная команда. /help - список"
end

-- ---------- События ----------
function tgNotifyAdmin(text)
    if not TG.enabled or not TG.evAdmin then return end
    local clean = tgToUtf8(text)
    if #clean > 300 then clean = tgUtf8Clean(clean:sub(1, 300)) end
    tgSend(tgHead() .. TG.E.alarm .. " " .. u8"Администратор в игре:\n" .. clean, "admin", 20)
end

function tgEvents()
    local E, now = TG.E, os.time()
    local px, py, pz = getCharCoordinates(PLAYER_PED)

    if not TG.booted then
        TG.booted = true
        TG.lastMode, TG.lastAfk = mode, isAfk
        TG.lastPos = {px, py, pz}
        tgSend(tgHead() .. E.ok .. " " .. u8"Telegram подключён. /help - список команд" ..
               (TG.cmds and "" or u8" (команды выключены)"), nil, 0)
        return
    end

    -- запуск / остановка
    if mode ~= TG.lastMode then
        TG.lastMode = mode
        if mode then
            TG.sessionStart = now
            TG.reportBase, TG.reportAt = tgTotals(), now
            TG.nextReport = now + TG.hourlyMin * 60
            TG.stuckRef = nil
        end
        if TG.evStartStop then
            tgSend(tgHead() .. (mode and (E.play .. " " .. u8"Бот запущен") or (E.stop .. " " .. u8"Бот остановлен")), nil, 0)
        end
    end

    -- АФК-отдых
    if isAfk ~= TG.lastAfk then
        TG.lastAfk = isAfk
        if TG.evAfk then
            tgSend(tgHead() .. E.zzz .. " " .. (isAfk and u8"АФК-отдых начался" or u8"Бот продолжает, АФК закончился"), nil, 0)
        end
    end

    -- цель добычи
    if TG.evGoal and mode then
        local sum = tgTotals().sum
        if sum >= SliderInt[0] then
            if not TG.goalSent then
                TG.goalSent = true
                tgSend(tgHead() .. E.flag .. " " .. u8"Цель добычи выполнена: " .. sum .. u8" из " .. SliderInt[0], nil, 0)
            end
        else
            TG.goalSent = false
        end
    end

    -- периодический отчёт
    if TG.evHourly and mode and TG.nextReport and now >= TG.nextReport then
        tgSend(tgReportText(), nil, 0)
        TG.reportBase, TG.reportAt = tgTotals(), now
        TG.nextReport = now + TG.hourlyMin * 60
    end

    -- телепорт / откат: резкий скачок координат
    if TG.lastPos then
        local dx, dy, dz = px - TG.lastPos[1], py - TG.lastPos[2], pz - TG.lastPos[3]
        local d = math.sqrt(dx * dx + dy * dy + dz * dz)
        if d > 60 then
            local stopped = false
            if TG.stopOnTp and mode then
                mode = false
                stopped = true
            end
            if TG.evTeleport or stopped then
                tgSend(tgHead() .. E.warn .. " " .. u8"Резкий скачок координат на " .. math.floor(d) .. u8" м (телепорт или откат?)" ..
                       (stopped and (" " .. u8"Бот остановлен.") or ""), "tp", 60)
            end
        end
    end
    TG.lastPos = {px, py, pz}

    -- застревание: бот в пути, но не двигается
    if mode and not isAfk and (BOT.kind == "route" or BOT.kind == "ore") then
        local ref = TG.stuckRef
        local moved = ref and math.sqrt((px - ref.x) ^ 2 + (py - ref.y) ^ 2) or 0
        if not ref or moved > 1.5 then
            TG.stuckRef = {x = px, y = py, t = now}
        elseif now - ref.t >= TG.stuckSec then
            if TG.evStuck then
                tgSend(tgHead() .. E.warn .. " " .. u8"Бот стоит на месте уже " .. (now - ref.t) .. u8" сек. (" ..
                       tgBotStateText() .. u8", маршрут " .. getRouteName(activeRouteIndex) .. ")", "stuck", 300)
            end
            ref.t = now
        end
    else
        TG.stuckRef = nil
    end
end

-- Вызывается каждый кадр из основного цикла, работа только при включённом Telegram
function tgTick()
    if not licPro() then
        if TG.thread then tgStop() end
        return
    end
    local c = os.clock()
    if c - TG.lastTick < 0.25 then return end
    TG.lastTick = c
    if TG.settingsDirty and not isKeyDown(0x01) then tgSaveSettings() end

    local active = TG.token ~= "" and (TG.enabled or TG.discover or TG.testUntil > c)
    if not active then
        if TG.thread then tgStop() end
        return
    end
    if not tgEnsureThread() then return end

    local wantPoll = TG.discover or (TG.enabled and TG.cmds and TG.chatId ~= "")
    if wantPoll and not TG.ctl.poll then TG.skipBacklog = true end
    TG.ctl.poll = wantPoll and true or false
    TG.ctl.token = TG.token

    tgPump()
    if TG.enabled and tgReady() then tgEvents() end
    tgFlush()
end

function tgSendTest()
    if TG.token == "" or TG.chatId == "" then
        TG.status = "Сначала введи токен и chat_id и нажми Сохранить"
        TG.statusOk = false
        return
    end
    TG.testUntil = os.clock() + 30
    TG.status = "Отправляю тест..."
    TG.statusOk = true
    tgSend(tgHead() .. TG.E.ok .. " " .. u8"Тест связи: всё работает", nil, 0, true)
end
-- TG_BLOCK_END

function lookForOreNearRoute(routeX, routeY, routeZ)
    local nearbyOres = {}
    local searchRadius = getRouteOreRadius(activeRouteIndex)
    for k, v in pairs(resources) do
        local object = sampGetObjectHandleBySampId(k)
        if doesObjectExist(object) and isObjectOnScreen(object) then
            local _, ox, oy, oz = getObjectCoordinates(object)
            local distToRoute = getDistanceBetweenCoords3d(routeX, routeY, routeZ, ox, oy, oz)
            
            if distToRoute <= searchRadius and not isPlayerNearPosition(ox, oy, oz, 5) and not navIsBad(ox, oy) then
                local myX, myY, myZ = getCharCoordinates(PLAYER_PED)
                local dist = getDistanceBetweenCoords3d(myX, myY, myZ, ox, oy, oz)
                local priority = orePriority[v] or 0
                table.insert(nearbyOres, {['position'] = {ox, oy, oz}, ['distance'] = dist, ['type'] = v, ['priority'] = priority})
            end
        end
    end
    
    if #nearbyOres > 0 then
        table.sort(nearbyOres, function(a, b) 
            if a.priority ~= b.priority then
                return a.priority > b.priority
            else
                return a.distance < b.distance
            end
        end)
        return true, nearbyOres[1].position, nearbyOres[1].type
    end
    
    return false
end

-- LIC_BLOCK_BEGIN
-- ================================================================
-- ПОДПИСКА "ПРО"
-- Платные функции: авто-пиво, ИИ пути, ожидание респавна у места, Telegram, оптимизация маршрутов.
-- Ключ проверяется на вашем сервере: GET LIC_SERVER?key=КЛЮЧ&hwid=HWID&v=1
--   ответ "OK|1767225600"  (время окончания подписки, unix) или "ERR|invalid" / "ERR|expired" / "ERR|hwid"
-- LIC_DEV_UNLOCK = true открывает Про без ключа (только для ваших тестов). В версии для людей должно быть false.
-- Адрес сервера проверки впишите в LIC_SERVER (https://.../api/check).
-- ================================================================
LIC_SERVER = "https://rabotyaga-site.vercel.app/api/check"
LIC_SITE = "https://rabotyaga-site.vercel.app"   -- страница покупки подписки
-- Запасные адреса проверки (зеркала). Если основной адрес не открывается без VPN, скрипт
-- по очереди пробует эти. Впишите сюда адрес вида "https://ваш-домен.ru/api/check".
LIC_MIRRORS = {
    "https://rm-check.dima67maslina.workers.dev/api/check",
    -- "https://ваш-домен.ru/api/check",
}
LIC_DEV_UNLOCK = false
LIC_RECHECK = 6 * 3600        -- как часто перепроверять ключ, сек
LIC_GRACE = 24 * 3600         -- сколько работать без связи с сервером после последней успешной проверки, сек

LIC = {
    key = "",
    untilTs = 0,
    okAt = 0,
    state = 'idle',
    msg = "",
    th = nil,
    want = false,
    nextAt = 0,
    started = os.clock(),
    lastDeny = -100,
    hwid = "",
    keyBuf = ffi.new("char[64]"),
    hwidBuf = ffi.new("char[32]"),
    siteBuf = ffi.new("char[128]"),
}

function licMakeHwid()
    local serial = ffi.new("unsigned long[1]")
    local ok = pcall(function()
        pcall(ffi.cdef, "int GetVolumeInformationA(const char*, char*, unsigned long, unsigned long*, unsigned long*, unsigned long*, char*, unsigned long);")
        ffi.C.GetVolumeInformationA("C:\\", nil, 0, serial, nil, nil, nil, 0)
    end)
    local n = ok and tonumber(serial[0]) or 0
    if n == 0 then return "UNKNOWN" end
    return string.format("%08X", n)
end

function licLoad()
    LIC.key = tostring(mainIni.main.licKey or "")
    if LIC.key == "0" or LIC.key == "false" then LIC.key = "" end
    ffi.copy(LIC.keyBuf, LIC.key:sub(1, 63))
    LIC.hwid = licMakeHwid()
    ffi.copy(LIC.hwidBuf, LIC.hwid:sub(1, 31))
    ffi.copy(LIC.siteBuf, LIC_SITE:sub(1, 127))
    if LIC_DEV_UNLOCK then
        sampAddChatMessage('{ff9933}[Подписка]: {ffffff}РЕЖИМ РАЗРАБОТЧИКА - функции Про открыты без ключа', -1)
    end
end

function licOpenSite()
    local ok = pcall(function()
        pcall(ffi.cdef, "void* ShellExecuteA(void*, const char*, const char*, const char*, const char*, int);")
        local shell = ffi.load("shell32")
        shell.ShellExecuteA(nil, "open", LIC_SITE, nil, nil, 1)
    end)
    if not ok then
        pcall(os.execute, 'start "" "' .. LIC_SITE .. '"')
    end
end

function licSaveKey()
    mainIni.main.licKey = LIC.key
    inicfg.save(mainIni, 'autominev2.ini')
end

function licPro()
    if LIC_DEV_UNLOCK then return true end
    local now = os.time()
    return LIC.untilTs > now and (now - LIC.okAt) <= LIC_GRACE
end

function licDeny(name)
    if os.clock() - LIC.lastDeny < 8 then return end
    LIC.lastDeny = os.clock()
    sampAddChatMessage('{cc66ff}[Подписка]: {ffffff}Функция "' .. name .. '" доступна по подписке Про (вкладка "Подписка")', -1)
end

function licUrlEnc(s)
    return (tostring(s):gsub("[^%w%-_%.~]", function(c) return string.format("%%%02X", c:byte()) end))
end

function licStartCheck()
    if LIC.th then return end
    if LIC_SERVER == "" then
        LIC.msg = "Сервер проверки не настроен"
        return
    end
    if LIC.key == "" then
        LIC.msg = "Введите ключ"
        return
    end
    local qs = "?key=" .. licUrlEnc(LIC.key) .. "&hwid=" .. licUrlEnc(LIC.hwid) .. "&v=1"
    local urls = {}
    for _, base in ipairs(LIC_MIRRORS) do
        if type(base) == "string" and base ~= "" then urls[#urls + 1] = base .. qs end
    end
    urls[#urls + 1] = LIC_SERVER .. qs
    local url = table.concat(urls, "\n")
    local ok, th = pcall(function()
        local effil = require('effil')
        return effil.thread(function(list)
            local https, ltn12, requests
            local okS, s = pcall(require, 'ssl.https')
            if okS then https = s end
            local okL, l = pcall(require, 'ltn12')
            if okL then ltn12 = l end
            local okR, r = pcall(require, 'requests')
            if okR then requests = r end
            if https then pcall(function() require('socket.http').TIMEOUT = 8 end) end
            local lastErr = "no-transport"
            for u in tostring(list):gmatch("[^\n]+") do
                if https and ltn12 then
                    local resp = {}
                    local okc, ok2, code = pcall(https.request, {url = u, method = "GET", sink = ltn12.sink.table(resp)})
                    if not okc then lastErr = tostring(ok2)
                    elseif not ok2 then lastErr = tostring(code)
                    elseif tonumber(code) == 200 then
                        return true, table.concat(resp), 200, ""
                    else
                        lastErr = "http " .. tostring(code)
                    end
                elseif requests then
                    local okc, resp = pcall(requests.get, {url = u})
                    if not okc then lastErr = tostring(resp)
                    elseif tonumber(resp.status_code) == 200 then
                        return true, tostring(resp.text), 200, ""
                    else
                        lastErr = "http " .. tostring(resp.status_code)
                    end
                end
            end
            return false, "", 0, lastErr
        end)(url)
    end)
    if ok and th then
        LIC.th = th
        LIC.state = 'checking'
        LIC.msg = "Проверка ключа..."
    else
        LIC.msg = "Не удалось запустить проверку"
        LIC.nextAt = os.clock() + 120
    end
end

function licHandle(ok, body, code, err)
    LIC.state = 'idle'
    if ok and code == 200 then
        local exp = tonumber(tostring(body):match("^%s*OK|(%d+)"))
        if exp then
            LIC.untilTs = exp
            LIC.okAt = os.time()
            if exp > os.time() then
                LIC.msg = "Подписка активна"
            else
                LIC.msg = "Срок подписки истёк"
            end
            LIC.nextAt = os.clock() + LIC_RECHECK
            return
        end
        local reason = tostring(body):match("^%s*ERR|([%w_%-]+)") or ""
        local texts = {
            invalid = "Ключ не найден",
            expired = "Срок ключа истёк",
            hwid = "Ключ привязан к другому компьютеру",
            banned = "Ключ заблокирован",
        }
        LIC.untilTs = 0
        LIC.msg = texts[reason] or ("Ключ не принят" .. (reason ~= "" and (": " .. reason) or ""))
        LIC.nextAt = os.clock() + LIC_RECHECK
    else
        LIC.msg = "Нет связи с сервером проверки"
        LIC.nextAt = os.clock() + 300
    end
end

function licTick()
    if LIC.th then
        local okS, st = pcall(function() return LIC.th:status() end)
        if not okS then
            LIC.th = nil
            LIC.state = 'idle'
            return
        end
        if st == 'completed' then
            local okG, a, b, c, d = pcall(function() return LIC.th:get() end)
            LIC.th = nil
            if okG then licHandle(a, b, c, d) else licHandle(false, "", 0, tostring(a)) end
        elseif st == 'failed' or st == 'canceled' then
            LIC.th = nil
            LIC.state = 'idle'
            LIC.msg = "Ошибка проверки"
            LIC.nextAt = os.clock() + 300
        end
        return
    end
    if LIC.want then
        LIC.want = false
        licStartCheck()
        return
    end
    if LIC_SERVER ~= "" and LIC.key ~= "" and os.clock() >= LIC.nextAt and os.clock() - LIC.started > 3 then
        licStartCheck()
    end
end
-- LIC_BLOCK_END

-- NAV_BLOCK_BEGIN
-- ================================================================
-- ИИ ПУТИ: анализ поверхности и обход препятствий
-- Бот идёт, а позиция не меняется -> сначала прыжок, если не помогло -> поиск обхода.
-- Обход ищется лучами (processLineOfSight): какие направления свободны, нет ли обрыва.
-- Если и обход не помог несколько раз - цель пропускается (руда в чёрный список, точка маршрута пропускается).
-- Всё держится в одной таблице NAV (чтобы не превышать лимит локальных переменных Lua).
-- ================================================================
NAV = {
    enabled = true,
    stuckTime = 1.2,         -- сек без движения до срабатывания
    minMove = 0.9,           -- меньше этого за stuckTime = стоим на месте, м
    maxJumps = 2,            -- сколько прыжков пробуем до обхода
    detourLen = 5,           -- максимальная длина обхода, м
    maxFails = 3,            -- сколько неудачных обходов до пропуска цели
    draw = true,             -- рисовать линию обхода в мире
    state = 'free',          -- free / jump / detour
    lastCall = nil,
    refX = 0, refY = 0, refT = nil,
    tries = 0, limit = 2, jumpAt = 0,
    dh = 0, dsx = 0, dsy = 0, dt0 = 0, dlen = 5, dside = 0,
    fails = 0, lastStuckAt = -100, lastDetourEnd = -100,
    badSide = 0, badSideUntil = 0,
    bad = {},                -- временно недоступные цели {x, y, t}
    info = "",
    conv = nil,
    stats = {jumps = 0, detours = 0, freed = 0, skipped = 0},
    sStuck = imgui.new.float(1.2),
    sJumps = imgui.new.int(2),
    sDetour = imgui.new.int(5),
    sFails = imgui.new.int(3),
    settingsDirty = false,
}

-- Добыча руды: бот подходит вплотную и копает, когда стоит на руде
MINE = {
    dist = 0.7,              -- копаем, когда до руды (по земле) не больше этого, м
    fallback = 0.9,          -- если дальше не подойти (руда с коллизией) - копаем через столько сек у руды
    nearSince = nil,
    sDist = imgui.new.float(0.7),
}

function navLoadSettings()
    local m = mainIni.main
    local function flag(v, default)
        if v == nil then return default end
        return v == true or v == 'true' or v == 1
    end
    NAV.enabled = flag(m.navEnabled, true)
    NAV.stuckTime = math.max(0.5, math.min(4, tonumber(m.navStuck) or 1.2))
    NAV.maxJumps = math.max(0, math.min(5, math.floor(tonumber(m.navJumps) or 2)))
    NAV.detourLen = math.max(3, math.min(15, math.floor(tonumber(m.navDetour) or 5)))
    NAV.maxFails = math.max(1, math.min(8, math.floor(tonumber(m.navFails) or 3)))
    NAV.draw = flag(m.navDraw, true)
    MINE.dist = math.max(0.3, math.min(1.5, tonumber(m.mineDist) or 0.7))
end

function navSaveSettings()
    local m = mainIni.main
    m.navEnabled = NAV.enabled
    m.navStuck = NAV.stuckTime
    m.navJumps = NAV.maxJumps
    m.navDetour = NAV.detourLen
    m.navFails = NAV.maxFails
    m.navDraw = NAV.draw
    m.mineDist = MINE.dist
    inicfg.save(mainIni, 'autominev2.ini')
    NAV.settingsDirty = false
end

function navAngDiff(a, b)
    return (a - b + 180) % 360 - 180
end

-- Подбираем формулу направления под getHeadingFromVector2d, чтобы лучи шли туда, куда смотрит бот
function navCalibrate()
    local maps = {
        function(h) return -math.sin(h), math.cos(h) end,
        function(h) return math.sin(h), math.cos(h) end,
        function(h) return math.cos(h), math.sin(h) end,
        function(h) return -math.cos(h), math.sin(h) end,
    }
    for _, f in ipairs(maps) do
        local ok = true
        for _, h in ipairs({25, 140, 250}) do
            local vx, vy = f(math.rad(h))
            if math.abs(navAngDiff(getHeadingFromVector2d(vx, vy), h)) > 2 then
                ok = false
                break
            end
        end
        if ok then
            NAV.conv = f
            return
        end
    end
    NAV.conv = maps[1]
end

function navDir(h)
    if not NAV.conv then navCalibrate() end
    return NAV.conv(math.rad(h))
end

function navHitPos(cp)
    if type(cp) ~= 'table' or type(cp.pos) ~= 'table' then return nil end
    local p = cp.pos
    if p[1] then return p[1], p[2], p[3] end
    if p.x then return p.x, p.y, p.z end
    return nil
end

-- Расстояние до препятствия по лучу на высоте zoff от центра персонажа (не больше len).
-- ign: цель (руда), её саму препятствием не считаем.
function navRayLen(x, y, z, h, len, zoff, ign)
    local dx, dy = navDir(h)
    local ok, res, cp = pcall(processLineOfSight, x, y, z + zoff, x + dx * len, y + dy * len, z + zoff,
        true, true, false, true, false, false, false, false)
    if not ok or not res then return len end
    local hx, hy = navHitPos(cp)
    if not hx then return len end
    if ign and toolsDist2d(hx, hy, ign.x, ign.y) < 1.4 then return len end
    return math.min(len, toolsDist2d(x, y, hx, hy))
end

-- Свободная длина направления: смотрим на уровне колена и груди
function navClearLen(x, y, z, h, len, ign)
    local a = navRayLen(x, y, z, h, len, -0.5, ign)
    local b = navRayLen(x, y, z, h, len, 0.3, ign)
    return math.min(a, b)
end

-- low = невысокое препятствие (бордюр, ящик), wall = стена, none = ничего не видно
function navObstacleKind(x, y, z, h, ign)
    local knee = navRayLen(x, y, z, h, 1.3, -0.5, ign) < 1.25
    local chest = navRayLen(x, y, z, h, 1.3, 0.3, ign) < 1.25
    local head = navRayLen(x, y, z, h, 1.3, 0.75, ign) < 1.25
    if knee and not chest then return 'low' end
    if knee or chest or head then return 'wall' end
    return 'none'
end

-- Есть ли земля впереди на разумной высоте (не обрыв и не яма)
function navGroundOk(x, y, z, h, dist)
    local dx, dy = navDir(h)
    local ok, a, b = pcall(getGroundZFor3dCoord, x + dx * dist, y + dy * dist, z)
    if not ok then return true end
    local gz = type(a) == 'number' and a or b
    if type(gz) ~= 'number' then return true end
    local d = gz - (z - 1.0)
    return d >= -1.8 and d <= 1.3
end

function navIsBad(x, y)
    local now = os.clock()
    for i = #NAV.bad, 1, -1 do
        local e = NAV.bad[i]
        if e.t < now then
            table.remove(NAV.bad, i)
        elseif toolsDist2d(x, y, e.x, e.y) < 1.2 then
            return true
        end
    end
    return false
end

function navApplyJump(j)
    if j then
        setGameKeyState(16, 0)
        setGameKeyState(14, 255)
    end
end

function navIdle()
    NAV.refT = nil
    NAV.state = 'free'
end

function navStartDetour(px, py, pz, desired, ign)
    local now = os.clock()
    local bestH, bestL, bestScore, bestTh
    for _, th in ipairs({35, -35, 70, -70, 110, -110, 150, -150}) do
        local h = (desired + th) % 360
        local L = navClearLen(px, py, pz, h, 8, ign)
        local score = -1000
        if L >= 2.5 then
            score = math.min(L, 6) - math.abs(th) / 30
            if not navGroundOk(px, py, pz, h, math.min(L, 4) - 0.3) then score = score - 50 end
            if NAV.badSideUntil > now and (th > 0) == (NAV.badSide > 0) then score = score - 4 end
        end
        if not bestScore or score > bestScore then
            bestH, bestL, bestScore, bestTh = h, L, score, th
        end
    end
    if not bestScore or bestScore <= -500 then
        bestH, bestL, bestTh = (desired + 180) % 360, 3.5, 180
    end
    NAV.dh = bestH
    NAV.dlen = math.max(2.5, math.min(bestL - 0.5, 6, NAV.detourLen))
    NAV.dside = bestTh
    NAV.dsx, NAV.dsy, NAV.dt0 = px, py, now
    NAV.refX, NAV.refY, NAV.refT = px, py, now
    NAV.state = 'detour'
    NAV.stats.detours = NAV.stats.detours + 1
    NAV.info = string.format("Обход: поворот на %d град., длина %.1f м", bestTh, NAV.dlen)
end

function navGiveUp(kind, obj)
    NAV.stats.skipped = NAV.stats.skipped + 1
    NAV.fails = 0
    NAV.state = 'free'
    NAV.refT = nil
    if kind == 'ore' and obj then
        NAV.bad[#NAV.bad + 1] = {x = obj[1], y = obj[2], t = os.clock() + 45}
        NAV.info = "Руда недоступна, пропускаю на 45 сек"
    elseif kind == 'wait' and obj then
        obj.navBlockedUntil = os.clock() + 60
        NAV.info = "К месту не пройти, больше не жду его"
    else
        local route = getActiveRoute()
        currentRoutePoint = currentRoutePoint + 1
        if currentRoutePoint > #route then currentRoutePoint = 1 end
        NAV.info = "Точка маршрута недоступна, иду к следующей"
    end
    sampAddChatMessage('{cc66ff}[ИИ пути]: {ffffff}' .. NAV.info, -1)
    tgSend(tgHead() .. TG.E.warn .. " " .. u8(NAV.info), "navskip", 120)
end

-- Главная функция: куда повернуться и нужно ли сейчас прыгать.
-- Вызывается каждый кадр, пока бот идёт к цели tx, ty (kind: route / ore / wait).
function navSteer(tx, ty, kind, obj)
    local px, py, pz = getCharCoordinates(PLAYER_PED)
    local desired = getHeadingFromVector2d(tx - px, ty - py)
    if not NAV.enabled or not licPro() or isCharInAnyCar(PLAYER_PED) then
        NAV.state = 'free'
        NAV.refT = nil
        return desired, false
    end
    local now = os.clock()
    if NAV.lastCall and now - NAV.lastCall > 0.5 then
        NAV.refT = nil
        NAV.state = 'free'
    end
    NAV.lastCall = now
    local ign = (kind == 'ore' or kind == 'wait') and {x = tx, y = ty} or nil

    if not NAV.refT then
        NAV.refX, NAV.refY, NAV.refT = px, py, now
    end
    local moved = toolsDist2d(px, py, NAV.refX, NAV.refY)

    if NAV.state == 'free' then
        if moved >= NAV.minMove then
            NAV.refX, NAV.refY, NAV.refT = px, py, now
            if now - NAV.lastStuckAt > 10 then NAV.fails = 0 end
        elseif now - NAV.refT >= NAV.stuckTime then
            NAV.lastStuckAt = now
            if now - NAV.lastDetourEnd < 8 then
                NAV.fails = NAV.fails + 1
                NAV.badSide, NAV.badSideUntil = NAV.dside, now + 10
            end
            if NAV.fails >= NAV.maxFails then
                navGiveUp(kind, obj)
                return desired, false
            end
            local k = navObstacleKind(px, py, pz, desired, ign)
            NAV.limit = (k == 'wall') and math.min(1, NAV.maxJumps) or NAV.maxJumps
            NAV.refX, NAV.refY, NAV.refT = px, py, now
            if NAV.limit >= 1 then
                NAV.state = 'jump'
                NAV.tries = 1
                NAV.jumpAt = now
                NAV.stats.jumps = NAV.stats.jumps + 1
                NAV.info = "Застрял (" .. (k == 'wall' and "стена" or (k == 'low' and "низкое препятствие" or "непонятно что")) .. "): прыгаю"
                return desired, true
            end
            navStartDetour(px, py, pz, desired, ign)
            return NAV.dh, false
        end
        return desired, false
    end

    if NAV.state == 'jump' then
        if moved >= 1.3 then
            NAV.state = 'free'
            NAV.refX, NAV.refY, NAV.refT = px, py, now
            NAV.stats.freed = NAV.stats.freed + 1
            NAV.info = "Прыжок помог"
            return desired, false
        end
        local jumpNow = (now - NAV.jumpAt) < 0.25
        if now - NAV.jumpAt >= 1.1 then
            if NAV.tries < NAV.limit then
                NAV.tries = NAV.tries + 1
                NAV.jumpAt = now
                NAV.stats.jumps = NAV.stats.jumps + 1
                jumpNow = true
            else
                navStartDetour(px, py, pz, desired, ign)
                return NAV.dh, false
            end
        end
        return desired, jumpNow
    end

    -- обход
    local traveled = toolsDist2d(px, py, NAV.dsx, NAV.dsy)
    if traveled >= NAV.dlen then
        NAV.state = 'free'
        NAV.refX, NAV.refY, NAV.refT = px, py, now
        NAV.lastDetourEnd = now
        NAV.stats.freed = NAV.stats.freed + 1
        NAV.info = "Обход пройден, иду к цели"
        return desired, false
    end
    if moved >= 0.6 then
        NAV.refX, NAV.refY, NAV.refT = px, py, now
    end
    local blocked = (now - NAV.refT) >= 0.9
    if blocked or now - NAV.dt0 > 4.5 then
        NAV.fails = NAV.fails + 1
        NAV.badSide, NAV.badSideUntil = NAV.dside, now + 10
        if NAV.fails >= NAV.maxFails then
            navGiveUp(kind, obj)
            return desired, false
        end
        navStartDetour(px, py, pz, desired, ign)
    end
    return NAV.dh, false
end

function navDrawDebug()
    if not (NAV.draw and NAV.state == 'detour') then return end
    local px, py, pz = getCharCoordinates(PLAYER_PED)
    local dx, dy = navDir(NAV.dh)
    DrawTracer(px, py, pz - 0.8, px + dx * NAV.dlen, py + dy * NAV.dlen, pz - 0.8, 0xFFFFAA00)
end

function navTick()
    if NAV.settingsDirty and not isKeyDown(0x01) then navSaveSettings() end
    navDrawDebug()
end
-- NAV_BLOCK_END

function followRecordedRoute()
    local route = getActiveRoute()
    if #route == 0 then
        return
    end
    if currentRoutePoint > #route then
        currentRoutePoint = 1
    end
    
    local point = route[currentRoutePoint]
    local px, py, pz = getCharCoordinates(PLAYER_PED)
    local dist = getDistanceBetweenCoords3d(px, py, pz, point.x, point.y, point.z)
    
    local hasOre, orePos, oreType = lookForOreNearRoute(point.x, point.y, point.z)
    if hasOre then
        local oreDist = getDistanceBetweenCoords3d(px, py, pz, orePos[1], orePos[2], orePos[3])
        
        local oreFlat = toolsDist2d(px, py, orePos[1], orePos[2])
        local atOre = oreFlat <= MINE.dist
        if oreDist > 1.5 or atOre then
            MINE.nearSince = nil
        elseif not atOre then
            if not MINE.nearSince then MINE.nearSince = os.clock() end
            if os.clock() - MINE.nearSince > MINE.fallback then atOre = true end
        end
        BOT.kind = atOre and 'mine' or 'ore'
        if atOre then navIdle() end
        BOT.x, BOT.y, BOT.z = orePos[1], orePos[2], orePos[3]
        
        local oreColor = 0xFF00FF00
        local oreRadius = math.max(MINE.dist, 0.3)
        
        Draw3DCircle(orePos[1], orePos[2], orePos[3] - 0.1, oreRadius, oreColor)
        DrawTracer(px, py, pz, orePos[1], orePos[2], orePos[3], oreColor)
        
        if atOre then
            MINE.nearSince = nil
            if currentMiningTarget == nil then
                currentMiningTarget = {orePos[1], orePos[2], orePos[3]}
                lastMiningAttempt = os.clock()
            end
            
            if os.clock() - lastMiningAttempt > miningTimeout then
                currentMiningTarget = nil
                lastMiningAttempt = 0
                return
            end
            
            setGameKeyState(1, 0)
            setGameKeyState(16, 0)
            setGameKeyState(21, -256)
            wait(200)
            setGameKeyState(21, 0)
            wait(500)
            currentMiningTarget = nil
            lastMiningAttempt = 0
            return
        else
            if currentMiningTarget then
                local targetDist = getDistanceBetweenCoords3d(px, py, pz, currentMiningTarget[1], currentMiningTarget[2], currentMiningTarget[3])
                if targetDist <= 1.5 and os.clock() - lastMiningAttempt <= miningTimeout then
                    local angle = getHeadingFromVector2d(currentMiningTarget[1] - px, currentMiningTarget[2] - py)
                    setTargetAngle(angle)
                    smoothCameraRotation()
                    setGameKeyState(1, -255)
                    if sprint then setGameKeyState(16, 1) end
                    return
                else
                    currentMiningTarget = nil
                end
            end
            
            local angle, oreJump = navSteer(orePos[1], orePos[2], 'ore', orePos)
            setTargetAngle(angle)
            smoothCameraRotation()
            setGameKeyState(1, -255)
            if sprint then setGameKeyState(16, 1) end
            navApplyJump(oreJump)
            return
        end
    else
        currentMiningTarget = nil
        lastMiningAttempt = 0
    end
    
    -- Бот ждёт: если руды рядом нет, но скоро вырастет - идёт к месту и ждёт
    local waitSpot = rsFindWaitSpot(point.x, point.y, point.z, getRouteOreRadius(activeRouteIndex))
    if waitSpot and (waitSpot.navBlockedUntil or 0) > os.clock() then waitSpot = nil end
    if waitSpot then
        RS.waitingSpot = waitSpot
        BOT.kind = 'wait'
        BOT.x, BOT.y, BOT.z = waitSpot.x, waitSpot.y, waitSpot.z
        local wx, wy = waitSpot.x - px, waitSpot.y - py
        local waitAngle = getHeadingFromVector2d(wx, wy)
        local waitJump = false
        local farFromSpot = math.sqrt(wx * wx + wy * wy) > 2.5
        if farFromSpot then
            waitAngle, waitJump = navSteer(waitSpot.x, waitSpot.y, 'wait', waitSpot)
        else
            navIdle()
        end
        setTargetAngle(waitAngle)
        smoothCameraRotation()
        if farFromSpot then
            setGameKeyState(1, -255)
            if sprint then setGameKeyState(16, 1) end
            navApplyJump(waitJump)
        end
        return
    end
    RS.waitingSpot = nil
    
    if dist <= routeCheckDistance then
        currentRoutePoint = currentRoutePoint + 1
        if currentRoutePoint > #route then
            currentRoutePoint = 1
            if autoRouteSwitch then
                switchToNextRoute()
                route = getActiveRoute()
            end
        end
    end
    
    local nextPoint = route[currentRoutePoint]
    BOT.kind = 'route'
    BOT.x, BOT.y, BOT.z = nextPoint.x, nextPoint.y, nextPoint.z
    local angle, navJump = navSteer(nextPoint.x, nextPoint.y, 'route', nextPoint)
    setTargetAngle(angle)
    smoothCameraRotation()
    
    setGameKeyState(1, -255)
    
    if sprint then 
        setGameKeyState(16, 1)
    end
    
    navApplyJump(navJump)

    if point.action == "JUMP" then
        setGameKeyState(0x20, 255)
    elseif point.action == "FORWARD" then
        setGameKeyState(0x57, -255)
    elseif point.action == "BACKWARD" then
        setGameKeyState(0x53, -255)
    elseif point.action == "LEFT" then
        setGameKeyState(0x41, -255)
    elseif point.action == "RIGHT" then
        setGameKeyState(0x44, -255)
    end
end

function DrawTracer(x1, y1, z1, x2, y2, z2, color)
    local sx1, sy1 = convert3DCoordsToScreen(x1, y1, z1)
    local sx2, sy2 = convert3DCoordsToScreen(x2, y2, z2)
    if sx1 and sx2 then
        renderDrawLine(sx1, sy1, sx2, sy2, 2, color)
    end
end

function Draw3DCircle(x, y, z, radius, color)
    local screen_x_line_old, screen_y_line_old
    for rot = 0, 360 do
        local rot_temp = math.rad(rot)
        local lineX, lineY, lineZ = radius * math.cos(rot_temp) + x, radius * math.sin(rot_temp) + y, z
        local screen_x_line, screen_y_line = convert3DCoordsToScreen(lineX, lineY, lineZ)
        if screen_x_line ~= nil and screen_x_line_old ~= nil and isPointOnScreen(lineX, lineY, lineZ, 1) then
            renderDrawLine(screen_x_line, screen_y_line, screen_x_line_old, screen_y_line_old, 2, color)
        end
        screen_x_line_old, screen_y_line_old = screen_x_line, screen_y_line
    end
end

function sampev.onSetObjectMaterial(id, data)
    local object = sampGetObjectHandleBySampId(id)
    if doesObjectExist(object) and getObjectModel(object) == 3930 then
        if oreTextures[data.textureName] then
            resources[id] = oreTextures[data.textureName]
        end
    end
end

function sampev.onDestroyObject(id)
    if resources[id] then
        rsOnOreDestroyed(id)
        resources[id] = nil
    end
end

function sampev.onDisplayGameText(style, tm, text)
    if text == "stone + 1" then totalStone = totalStone + 1
    elseif text == "metal + 1" then totalMetal = totalMetal + 1
    elseif text == "silver + 1" then totalSilver = totalSilver + 1
    elseif text == "bronze + 1" then totalBronze = totalBronze + 1
    elseif text == "gold + 1" then totalGold = totalGold + 1
    elseif text == "stone + 2" then totalStone = totalStone + 2
    elseif text == "metal + 2" then totalMetal = totalMetal + 2
    elseif text == "silver + 2" then totalSilver = totalSilver + 2
    elseif text == "bronze + 2" then totalBronze = totalBronze + 2
    elseif text == "gold + 2" then totalGold = totalGold + 2
    end
end

local function autoJumpThread()
    while true do
        wait(0)
        
        if mode and jumpEnabled and not isAfk then
            local t = os.clock()
            if t >= nextJumpTime then
                setGameKeyState(16, 0)
                setGameKeyState(14, 255)
                wait(150)
                setGameKeyState(14, 0)
                if sprint then setGameKeyState(16, 1) end
                nextJumpTime = t + math.random(4, 9)
            end
        end
    end
end

function sampev.onServerMessage(color, text)
    if text:find('Администратор') then
        sampAddChatMessage('{ff3333}[rabotyaga]: {ffffff}Внимание, администратор в игре!', -1)
        tgNotifyAdmin(text)
    end
end

function onScriptTerminate(s, quitGame)
    if s == thisScript() then
        if RS.dirty then
            rsSaveSpots()
        end
        tgStop()
    end
end

function main()
    while not isSampAvailable() do wait(0) end
    wait(200)
    sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}Скрипт запущен!', -1)
    loadCustomRoutesFromFile()
    rsLoadSettings()
    navLoadSettings()
    licLoad()
    rsLoadSpots()
    tgLoadSettings()
    RS.font = renderCreateFont("Arial", 10, 5)
    sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}Маршрутов загружено: ' .. getRouteCount(), -1)
    sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}F6 - запись маршрута, вкладка "Маршрут" в меню', -1)
    loadConfigs()
    loadConfig(mainIni.main.currentConfig)
    
    sampRegisterChatCommand('amine', function()
        WinState[0] = not WinState[0]
    end)
    
    sampRegisterChatCommand('beerbot', function(args)
        if args == "on" then
            beerEnabled = true
            sampAddChatMessage('{cc66ff}[BeerBot]: {ffffff}Авто-пиво включено.', -1)
        elseif args == "off" then
            beerEnabled = false
            sampAddChatMessage('{cc66ff}[BeerBot]: {ffffff}Авто-пиво выключено.', -1)
        elseif args == "toggle" or args == "" then
            beerEnabled = not beerEnabled
            sampAddChatMessage('{cc66ff}[BeerBot]: {ffffff}Авто-пиво ' .. (beerEnabled and 'включено' or 'выключено'), -1)
        else
            sampAddChatMessage('{cc66ff}[BeerBot]: {ffffff}Команды: /beerbot on/off/toggle (или F5)', -1)
        end
    end)
    
    lua_thread.create(autoJumpThread)
    
    while true do
        wait(0)
        
        if isKeyJustPressed(0x2D) then
            WinState[0] = not WinState[0]
        end
        
        if isKeyJustPressed(0x75) then -- F6
            if isRecordingRoute then
                stopRouteRecording()
            else
                startRouteRecording()
            end
        end
        
        if isKeyJustPressed(0x74) then -- F5
            beerEnabled = not beerEnabled
            sampAddChatMessage('{cc66ff}[BeerBot]: {ffffff}Авто-пиво ' .. (beerEnabled and 'включено' or 'выключено'), -1)
        end
        
        if isRecordingRoute then
            recordRouteTick()
        end
        
        beerAutoTick()
        saveRouteOreRadiusIfNeeded()
        rsTick()
        rsDrawHud()
        tgTick()
        navTick()
        licTick()
        
        if collisionEnabled and not licPro() then
            collisionEnabled = false
            enableCollision()
            licDeny('Коллизия')
        end
        if collisionEnabled then
            enableCollision()
        end
        
        if mode then
            if farmStartTime == 0 then
                farmStartTime = os.time()
            end
            
            if afkAfterHour and os.time() - farmStartTime >= 3600 and not isAfk then
                isAfk = true
                sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}АФК отдых на 10 минут', -1)
                BOT.kind = 'afk'
                local afkStart = os.time()
                while os.time() - afkStart < afkDuration do
                    wait(1000)
                end
                isAfk = false
                farmStartTime = os.time()
                sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}АФК закончен, продолжаю работу', -1)
            end
            
            if not isAfk then
                followRecordedRoute()
            end
        else
            if farmStartTime ~= 0 then
                farmStartTime = 0
            end
            BOT.kind = nil
        end
    end
end

local function theme()
    imgui.SwitchContext()
    local ImVec4 = imgui.ImVec4
    imgui.GetStyle().WindowPadding = imgui.ImVec2(10, 10)
    imgui.GetStyle().FramePadding = imgui.ImVec2(8, 6)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(8, 8)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(6, 6)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = 10
    imgui.GetStyle().GrabMinSize = 10
    imgui.GetStyle().WindowBorderSize = 0
    imgui.GetStyle().ChildBorderSize = 0
    imgui.GetStyle().PopupBorderSize = 0
    imgui.GetStyle().FrameBorderSize = 0
    imgui.GetStyle().WindowRounding = 8
    imgui.GetStyle().ChildRounding = 8
    imgui.GetStyle().FrameRounding = 6
    imgui.GetStyle().ScrollbarRounding = 6
    imgui.GetStyle().GrabRounding = 4
    imgui.GetStyle().Colors[imgui.Col.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TextDisabled] = ImVec4(0.60, 0.60, 0.60, 1.00)
    imgui.GetStyle().Colors[imgui.Col.WindowBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
    imgui.GetStyle().Colors[imgui.Col.ChildBg] = ImVec4(0.09, 0.09, 0.09, 0.85)
    imgui.GetStyle().Colors[imgui.Col.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.96)
    imgui.GetStyle().Colors[imgui.Col.Border] = ImVec4(0.15, 0.15, 0.15, 0.60)
    imgui.GetStyle().Colors[imgui.Col.FrameBg] = ImVec4(0.10, 0.10, 0.10, 0.85)
    imgui.GetStyle().Colors[imgui.Col.FrameBgHovered] = ImVec4(0.12, 0.12, 0.12, 0.90)
    imgui.GetStyle().Colors[imgui.Col.FrameBgActive] = accent(0.35)
    imgui.GetStyle().Colors[imgui.Col.TitleBg] = ImVec4(0.06, 0.06, 0.06, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBgActive] = ImVec4(0.07, 0.07, 0.07, 1.00)
    imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed] = ImVec4(0.06, 0.06, 0.06, 1.00)
    imgui.GetStyle().Colors[imgui.Col.MenuBarBg] = ImVec4(0.07, 0.07, 0.07, 1.00)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarBg] = ImVec4(0.07, 0.07, 0.07, 0.60)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab] = ImVec4(0.15, 0.15, 0.15, 0.85)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered] = ImVec4(0.20, 0.20, 0.20, 0.90)
    imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive] = ImVec4(0.25, 0.25, 0.25, 0.95)
    imgui.GetStyle().Colors[imgui.Col.CheckMark] = accent(1.00)
    imgui.GetStyle().Colors[imgui.Col.SliderGrab] = accent(0.75)
    imgui.GetStyle().Colors[imgui.Col.SliderGrabActive] = accent(1.00)
    imgui.GetStyle().Colors[imgui.Col.Button] = ImVec4(0.10, 0.10, 0.10, 0.85)
    imgui.GetStyle().Colors[imgui.Col.ButtonHovered] = ImVec4(0.12, 0.12, 0.12, 0.90)
    imgui.GetStyle().Colors[imgui.Col.ButtonActive] = accent(0.35)
    imgui.GetStyle().Colors[imgui.Col.Header] = accent(0.25)
    imgui.GetStyle().Colors[imgui.Col.HeaderHovered] = accent(0.35)
    imgui.GetStyle().Colors[imgui.Col.HeaderActive] = accent(0.45)
    imgui.GetStyle().Colors[imgui.Col.Separator] = ImVec4(0.15, 0.15, 0.15, 0.60)
    imgui.GetStyle().Colors[imgui.Col.SeparatorHovered] = ImVec4(0.20, 0.20, 0.20, 0.75)
    imgui.GetStyle().Colors[imgui.Col.SeparatorActive] = ImVec4(0.25, 0.25, 0.25, 0.90)
end

imgui.OnInitialize(function()
    theme()
    local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    mainFont = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 14.0, nil, glyph_ranges)
    titleFont = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 18.0, nil, glyph_ranges)
    headerFont = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 16.0, nil, glyph_ranges)
end)

local function renderSectionHeader(text)
    imgui.PushFont(headerFont)
    imgui.Dummy(imgui.ImVec2(0, 5))
    imgui.TextColored(accent(1.0), text)
    imgui.PopFont()
    
    local p = imgui.GetCursorScreenPos()
    local dl = imgui.GetWindowDrawList()
    local width = imgui.GetContentRegionAvail().x
    
    dl:AddRectFilledMultiColor(
        imgui.ImVec2(p.x, p.y),
        imgui.ImVec2(p.x + width * 0.3, p.y + 2),
        imgui.ColorConvertFloat4ToU32(accent(0.8)),
        imgui.ColorConvertFloat4ToU32(accent(0.0)),
        imgui.ColorConvertFloat4ToU32(accent(0.0)),
        imgui.ColorConvertFloat4ToU32(accent(0.8))
    )
    
    imgui.Dummy(imgui.ImVec2(0, 12))
end

local function renderMainTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()
    
    renderSectionHeader(u8"Основное")
    
    if imgui.Checkbox(u8"Включить бота", imgui.new.bool(mode)) then 
        mode = not mode 
    end
    imgui.SameLine()
    if imgui.Checkbox(u8"Бег", imgui.new.bool(sprint)) then 
        sprint = not sprint 
    end
    imgui.SameLine()
    if imgui.Checkbox(u8"Прыжок", imgui.new.bool(jumpEnabled)) then 
        jumpEnabled = not jumpEnabled 
        if jumpEnabled then
            nextJumpTime = os.clock() + math.random(4, 9)
        end
    end
    
    imgui.Dummy(imgui.ImVec2(0, 8))
    if imgui.Checkbox(u8"АФК после часа", imgui.new.bool(afkAfterHour)) then 
        afkAfterHour = not afkAfterHour 
    end
    
    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Text(u8"Цель добычи")
    imgui.SliderInt("##goal", SliderInt, 1, 10000)
    
    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Text(u8"Выбранный маршрут: " .. getRouteName(activeRouteIndex))
    imgui.Text(u8"Текущая точка: " .. currentRoutePoint .. u8" из " .. #getActiveRoute())
    if imgui.Button(u8"Сбросить маршрут", imgui.ImVec2(150, 25)) then
        currentRoutePoint = 1
        sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}Маршрут сброшен!', -1)
    end

    renderMineDistSection()
    
    imgui.EndGroup()
end

local function renderPriorityTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()
    
    renderSectionHeader(u8"Приоритет руд")
    
    imgui.Text(u8"Камень:")
    if imgui.SliderInt("##stone", PrioritySliders[1], 1, 5) then
        orePriority[1] = PrioritySliders[1][0]
        mainIni.priority.stone = PrioritySliders[1][0]
        inicfg.save(mainIni, 'autominev2.ini')
    end
    
    imgui.Text(u8"Металл:")
    if imgui.SliderInt("##metal", PrioritySliders[2], 1, 5) then
        orePriority[2] = PrioritySliders[2][0]
        mainIni.priority.metal = PrioritySliders[2][0]
        inicfg.save(mainIni, 'autominev2.ini')
    end
    
    imgui.Text(u8"Серебро:")
    if imgui.SliderInt("##silver", PrioritySliders[3], 1, 5) then
        orePriority[3] = PrioritySliders[3][0]
        mainIni.priority.silver = PrioritySliders[3][0]
        inicfg.save(mainIni, 'autominev2.ini')
    end
    
    imgui.Text(u8"Бронза:")
    if imgui.SliderInt("##bronze", PrioritySliders[4], 1, 5) then
        orePriority[4] = PrioritySliders[4][0]
        mainIni.priority.bronze = PrioritySliders[4][0]
        inicfg.save(mainIni, 'autominev2.ini')
    end
    
    imgui.Text(u8"Золото:")
    if imgui.SliderInt("##gold", PrioritySliders[5], 1, 5) then
        orePriority[5] = PrioritySliders[5][0]
        mainIni.priority.gold = PrioritySliders[5][0]
        inicfg.save(mainIni, 'autominev2.ini')
    end
    
    imgui.EndGroup()
end

local function renderConfigTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()
    
    renderSectionHeader(u8"Конфигурации")
    
    imgui.Text(u8"Текущий конфиг: " .. currentConfig)
    imgui.Dummy(imgui.ImVec2(0, 8))
    
    imgui.InputText(u8"Имя конфига", configName, 256)
    
    if imgui.Button(u8"Сохранить конфиг", imgui.ImVec2(150, 25)) then
        local name = ffi.string(configName)
        if name ~= "" then
            saveConfig(name)
            loadConfigs()
            sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}Конфиг сохранён: ' .. name, -1)
        end
    end
    
    imgui.SameLine()
    if imgui.Button(u8"Загрузить конфиг", imgui.ImVec2(150, 25)) then
        local name = ffi.string(configName)
        if name ~= "" then
            loadConfig(name)
            currentConfig = name
            mainIni.main.currentConfig = name
            inicfg.save(mainIni, 'autominev2.ini')
            sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}Конфиг загружен: ' .. name, -1)
        end
    end
    
    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Text(u8"Доступные конфиги:")
    
    for i, config in ipairs(configs) do
        if imgui.Button(config, imgui.ImVec2(120, 25)) then
            loadConfig(config)
            currentConfig = config
            mainIni.main.currentConfig = config
            inicfg.save(mainIni, 'autominev2.ini')
            sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}Конфиг загружен: ' .. config, -1)
        end
        if i % 2 == 1 then imgui.SameLine() end
    end
    
    imgui.EndGroup()
end

local function renderCollisionTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()
    
    renderSectionHeader(u8"Коллизия")
    
    if imgui.Checkbox(u8"Отключить коллизию", imgui.new.bool(collisionEnabled)) then 
        collisionEnabled = not collisionEnabled
        enableCollision()
        if collisionEnabled then
            sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}Коллизия отключена', -1)
        else
            sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}Коллизия включена', -1)
        end
    end
    
    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Text(u8"Отключает коллизию персонажей")
    imgui.Text(u8"машин, объектов и игроков")
    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Text(u8"Статус: " .. (collisionEnabled and u8"отключена" or u8"включена"))
    
    imgui.EndGroup()
end

local function renderMiscTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()
    
    renderSectionHeader(u8"Цвет интерфейса")
    
    imgui.Text(u8"Выберите цветовую тему интерфейса:")
    imgui.Dummy(imgui.ImVec2(0, 10))
    
    for i, t in ipairs(colorThemes) do
        local isActive = (currentTheme.id == t.id)
        
        imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(t.r, t.g, t.b, isActive and 0.9 or 0.35))
        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(t.r, t.g, t.b, 0.7))
        imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(t.r, t.g, t.b, 0.9))
        
        if imgui.Button((isActive and u8"* " or "") .. t.name, imgui.ImVec2(160, 32)) then
            currentTheme = t
            mainIni.main.colorTheme = t.id
            inicfg.save(mainIni, 'autominev2.ini')
            theme()
            sampAddChatMessage('{cc66ff}[rabotyaga]: {ffffff}Тема изменена: ' .. t.chatName, -1)
        end
        
        imgui.PopStyleColor(3)
        
        if i % 3 ~= 0 then imgui.SameLine() end
    end
    
    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.EndGroup()
end

local function renderRouteTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()
    
    renderSectionHeader(u8"Маршруты (" .. getRouteCount() .. u8")")
    
    imgui.BeginChild("##routelist", imgui.ImVec2(-1, 150), true)
    for i = 1, getRouteCount() do
        local isActive = (activeRouteIndex == i)
        local label = (isActive and "* " or "") .. getRouteName(i) .. " (" .. #getRoutePoints(i) .. u8" т., R" .. math.floor(getRouteOreRadius(i)) .. ")"
        
        if imgui.Button(label .. "##routesel" .. i, imgui.ImVec2(i > 1 and 300 or 380, 28)) then
            activeRouteIndex = i
            currentRoutePoint = 1
            sampAddChatMessage('{cc66ff}[rabotyaga]: {ffffff}Маршрут ' .. u8:decode(getRouteName(i)) .. ' (' .. #getRoutePoints(i) .. ' точек)', -1)
        end
        
        if i > 1 then
            imgui.SameLine()
            imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.5, 0.15, 0.15, 1.0))
            imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.65, 0.2, 0.2, 1.0))
            if imgui.Button(u8"Удалить##routedel" .. i, imgui.ImVec2(70, 28)) then
                deleteCustomRoute(i)
            end
            imgui.PopStyleColor(2)
        end
    end
    imgui.EndChild()
    
    imgui.Dummy(imgui.ImVec2(0, 10))
    imgui.Text(u8"Радиус поиска руды (текущий маршрут):")
    OreRadiusSlider[0] = math.floor(getRouteOreRadius(activeRouteIndex))
    if imgui.SliderInt("##oreradius", OreRadiusSlider, 3, 100) then
        setRouteOreRadius(activeRouteIndex, OreRadiusSlider[0])
    end
    imgui.TextDisabled(u8"Все руды в этом радиусе от пути бот будет добывать")
    
    imgui.Dummy(imgui.ImVec2(0, 10))
    if imgui.Checkbox(u8"Следующий маршрут (по кругу)", imgui.new.bool(autoRouteSwitch)) then
        autoRouteSwitch = not autoRouteSwitch
    end
    imgui.TextDisabled(u8"Круг пройден -> автоматически на следующий")
    
    imgui.Dummy(imgui.ImVec2(0, 16))
    imgui.Separator()
    imgui.Dummy(imgui.ImVec2(0, 12))
    
    renderSectionHeader(u8"Запись нового маршрута")
    imgui.Text(u8"Нажми Запись, потом иди пешком")
    imgui.Text(u8"(бег и прыжки запоминаются автоматически),")
    imgui.Text(u8"потом останови и сохрани маршрут -")
    imgui.Text(u8"он будет доступен в списке выше.")
    imgui.Text(u8"Горячая клавиша: F6")
    
    imgui.Dummy(imgui.ImVec2(0, 10))
    
    if not isRecordingRoute then
        if imgui.Button(u8"Начать запись", imgui.ImVec2(160, 32)) then
            startRouteRecording()
        end
    else
        imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.6, 0.15, 0.15, 1.0))
        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.7, 0.2, 0.2, 1.0))
        imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.7, 0.2, 0.2, 1.0))
        if imgui.Button(u8"Остановить запись", imgui.ImVec2(160, 32)) then
            stopRouteRecording()
        end
        imgui.PopStyleColor(3)
    end
    
    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Text(u8"Запись: " .. (isRecordingRoute and u8"ИДЁТ ЗАПИСЬ" or u8"остановлена"))
    imgui.Text(u8"Записано точек: " .. #recordingBuffer)
    
    imgui.Dummy(imgui.ImVec2(0, 10))
    if imgui.Button(u8"Сохранить как новый маршрут", imgui.ImVec2(220, 32)) then
        saveRecordingAsNewRoute()
    end
    
    renderRouteTools()
    
    imgui.EndGroup()
end

local function renderBeerTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()
    
    renderSectionHeader(u8"Авто пиво")
    
    licProBanner()
    if imgui.Checkbox(u8"Включить авто-пиво", imgui.new.bool(beerEnabled)) then
        beerEnabled = not beerEnabled
    end
    
    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Text(u8"Интервал (сек):")
    if imgui.SliderInt("##beerinterval", BeerIntervalSlider, 60, 3600) then
        beerInterval = BeerIntervalSlider[0]
    end
    
    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Text(u8"Статус: " .. (beerEnabled and u8"активно" or u8"выключено"))
    imgui.Text(u8"Интервал: " .. math.floor(beerInterval / 60) .. u8" мин.")
    
    local beerRemain = beerInterval - beerElapsed
    if beerRemain < 0 then beerRemain = 0 end
    imgui.Text(u8"До следующего пива: " .. math.floor(beerRemain) .. u8" сек.")
    
    imgui.Dummy(imgui.ImVec2(0, 10))
    imgui.Text(u8"Горячая клавиша: F5")
    imgui.Text(u8"Команда: /beerbot on/off/toggle")
    
    imgui.EndGroup()
end

function renderRespawnTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()

    renderSectionHeader(u8"Респавн руды")

    if imgui.Checkbox(u8"Отслеживать респавн", imgui.new.bool(RS.trackEnabled)) then
        RS.trackEnabled = not RS.trackEnabled
        RS.settingsDirty = true
    end
    if imgui.Checkbox(u8"Таймеры над рудами в мире", imgui.new.bool(RS.hudEnabled)) then
        RS.hudEnabled = not RS.hudEnabled
        RS.settingsDirty = true
    end
    licProBanner()
    if imgui.Checkbox(u8"Ждать респавна у места", imgui.new.bool(RS.waitEnabled)) then
        RS.waitEnabled = not RS.waitEnabled
        RS.settingsDirty = true
    end
    imgui.TextDisabled(u8"Если рядом руды нет, а скоро вырастет - бот ждёт у места")

    imgui.Dummy(imgui.ImVec2(0, 6))
    imgui.Text(u8"Ждать у места до (сек) до респавна:")
    RS.waitSlider[0] = math.floor(RS.waitMax)
    if imgui.SliderInt("##rswait", RS.waitSlider, 5, 120) then
        RS.waitMax = RS.waitSlider[0]
        RS.settingsDirty = true
    end
    imgui.Text(u8"Радиус наблюдения (м):")
    RS.observeSlider[0] = math.floor(RS.observeRadius)
    if imgui.SliderInt("##rsobserve", RS.observeSlider, 30, 200) then
        RS.observeRadius = RS.observeSlider[0]
        RS.settingsDirty = true
    end
    imgui.TextDisabled(u8"Дальше этого руда, пропавшая из виду, считается неточной")

    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Separator()
    imgui.Dummy(imgui.ImVec2(0, 8))

    if not RS.summary or os.clock() - RS.summaryAt > 1.0 then
        rsRefreshSummary()
    end
    local sm = RS.summary

    renderSectionHeader(u8"Что бот знает")
    imgui.Text(u8"Мест в базе: " .. #RS.spots .. u8", с замерами: " .. sm.withSamples)
    imgui.Text(u8"Добыто/засечено руды: " .. RS.stats.destroyed .. u8", замеров времени: " .. RS.stats.samples)
    imgui.TextDisabled(u8"Пропущено: вне зоны " .. RS.stats.streamedOut .. u8", потеряно из виду " .. RS.stats.lostSight)

    for t = 1, 5 do
        local m = sm.medians[t]
        if m then
            imgui.Text(oreNames[t] .. u8": обычно " .. rsFmtTime(m.med) .. u8" (замеров: " .. m.n .. ")")
        end
    end
    if next(sm.medians) == nil then
        imgui.TextDisabled(u8"Замеров пока нет - походи по шахте, пока руда добывается")
    end

    imgui.Dummy(imgui.ImVec2(0, 8))
    if RS.waitingSpot then
        imgui.TextColored(imgui.ImVec4(0.3, 1.0, 0.4, 1.0), u8"Сейчас бот ждёт респавна у места")
    end

    renderSectionHeader(u8"Ждёт респавна (" .. #sm.pending .. u8")")
    imgui.BeginChild("##rspending", imgui.ImVec2(-1, 150), true)
    local px, py = getCharCoordinates(PLAYER_PED)
    for i = 1, math.min(#sm.pending, 30) do
        local item = sm.pending[i]
        local s = item.spot
        local t = rsSpotType(s)
        local name = t and oreNames[t] or u8"Руда"
        local when
        if not item.eta then
            when = u8"неизвестно"
        elseif item.eta > 0 then
            when = u8"через " .. rsFmtTime(item.eta)
        else
            when = u8"просрочено на " .. rsFmtTime(-item.eta)
        end
        local dx, dy = s.x - px, s.y - py
        imgui.Text(name .. " | " .. when .. " | " .. math.floor(math.sqrt(dx * dx + dy * dy)) .. u8" м")
    end
    if #sm.pending == 0 then
        imgui.TextDisabled(u8"Пока нет мест, где руда ждёт респавна")
    end
    imgui.EndChild()

    imgui.EndGroup()
end

-- UI_BLOCK_BEGIN
-- ================================================================
-- Интерфейс: оптимизация маршрутов и авто-маршрут
-- ================================================================
function mapCol(r, g, b, a)
    return imgui.ColorConvertFloat4ToU32(imgui.ImVec4(r, g, b, a or 1.0))
end

function renderRouteTools()
    imgui.Dummy(imgui.ImVec2(0, 14))
    imgui.Separator()
    imgui.Dummy(imgui.ImVec2(0, 10))

    renderSectionHeader(u8"Оптимизация маршрута")
    licProBanner()
    imgui.Text(u8"Делает оптимизированную копию выбранного маршрута:")
    imgui.TextDisabled(u8"убирает лишние точки на прямых, сглаживает путь")
    imgui.Text(u8"Допуск упрощения (м):")
    imgui.SliderFloat("##opttol", TL.optTol, 0.3, 5.0, "%.1f")
    imgui.Text(u8"Макс. шаг между точками (м):")
    imgui.SliderInt("##optgap", TL.optGap, 5, 40)
    imgui.TextDisabled(u8"Чем меньше шаг, тем лучше бот видит руду рядом с путём")
    if imgui.Checkbox(u8"Сгладить маршрут", imgui.new.bool(TL.optSmooth)) then
        TL.optSmooth = not TL.optSmooth
    end
    if imgui.Checkbox(u8"Замкнуть в круг", imgui.new.bool(TL.optClose)) then
        TL.optClose = not TL.optClose
    end
    if imgui.Button(u8"Оптимизировать текущий маршрут", imgui.ImVec2(280, 32)) then
        local res, err = toolsOptimizeRoute(activeRouteIndex, TL.optTol[0], TL.optGap[0], TL.optSmooth, TL.optClose)
        if res then
            TL.msgOk = true
            TL.msg = u8"Готово: точек " .. res.before .. " -> " .. res.after ..
                u8", длина " .. math.floor(res.lenBefore) .. " -> " .. math.floor(res.lenAfter) ..
                u8" м. Новый маршрут " .. res.newIndex .. u8" добавлен в список"
        else
            TL.msgOk = false
            TL.msg = err
        end
    end

    imgui.Dummy(imgui.ImVec2(0, 14))
    imgui.Separator()
    imgui.Dummy(imgui.ImVec2(0, 10))

    renderSectionHeader(u8"Авто-маршрут по базе мест")
    licProBanner()
    imgui.Text(u8"Бот сам строит путь по найденным местам руды вокруг тебя")
    imgui.TextDisabled(u8"Мест руды в базе: " .. #RS.spots)
    imgui.Text(u8"Радиус выборки (м):")
    imgui.SliderInt("##arradius", TL.arRadius, 30, 500)
    imgui.Text(u8"Шаг между точками пути (м):")
    imgui.SliderInt("##arstep", TL.arStep, 4, 25)
    if imgui.Checkbox(u8"Учитывать время респавна", imgui.new.bool(TL.arRespawn)) then
        TL.arRespawn = not TL.arRespawn
    end
    imgui.TextDisabled(u8"Вкл: сначала места, где руда уже выросла. Выкл: просто короткий круг")
    if imgui.Button(u8"Построить маршрут по базе мест", imgui.ImVec2(280, 32)) then
        local px, py = getCharCoordinates(PLAYER_PED)
        local res, err = toolsBuildAutoRoute(px, py, TL.arRadius[0], TL.arRespawn, TL.arStep[0])
        if res then
            TL.msgOk = true
            TL.msg = u8"Маршрут " .. res.newIndex .. u8": мест руды " .. res.spots .. u8", точек пути " .. res.points ..
                u8", круг ~" .. rsFmtTime(res.loopSec) .. u8" (" .. math.floor(res.length) .. u8" м)"
            if res.maxMed > 0 and res.loopSec < res.maxMed then
                TL.msg = TL.msg .. u8". Круг короче респавна (" .. rsFmtTime(res.maxMed) ..
                    u8"): бот будет немного ждать у мест с рудой"
            end
        else
            TL.msgOk = false
            TL.msg = err
        end
    end

    if TL.msg then
        imgui.Dummy(imgui.ImVec2(0, 8))
        local col = TL.msgOk and imgui.ImVec4(0.4, 1.0, 0.5, 1.0) or imgui.ImVec4(1.0, 0.45, 0.4, 1.0)
        imgui.PushStyleColor(imgui.Col.Text, col)
        imgui.TextWrapped(TL.msg)
        imgui.PopStyleColor(1)
    end
end

function renderMapTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()

    renderSectionHeader(u8"Карта")

    if imgui.Checkbox(u8"Следить за мной", imgui.new.bool(MAP.follow)) then
        MAP.follow = not MAP.follow
    end
    imgui.SameLine()
    if imgui.Checkbox(u8"Все маршруты", imgui.new.bool(MAP.showAll)) then
        MAP.showAll = not MAP.showAll
    end
    imgui.SameLine()
    if imgui.Checkbox(u8"Игроки", imgui.new.bool(MAP.showPlayers)) then
        MAP.showPlayers = not MAP.showPlayers
    end
    imgui.SameLine()
    if imgui.Button(u8"Показать всё", imgui.ImVec2(110, 24)) then
        mapFitAll()
    end

    MAP.zoomSlider[0] = math.floor(MAP.viewMeters)
    if imgui.SliderInt("##mapzoom", MAP.zoomSlider, 30, 3000) then
        MAP.viewMeters = MAP.zoomSlider[0]
    end
    imgui.SameLine()
    imgui.Text(u8"Ширина карты, м")

    local W, H = MAP.W, MAP.H
    local px, py = getCharCoordinates(PLAYER_PED)
    if MAP.follow then
        MAP.cx, MAP.cy = px, py
    end

    local p0 = imgui.GetCursorScreenPos()
    imgui.InvisibleButton("##mapcanvas", imgui.ImVec2(W, H))
    local hovered = imgui.IsItemHovered()
    local scale = W / MAP.viewMeters
    if imgui.IsItemActive() and imgui.IsMouseDragging(0) then
        local d = imgui.GetIO().MouseDelta
        MAP.follow = false
        MAP.cx = MAP.cx - d.x / scale
        MAP.cy = MAP.cy + d.y / scale
    end
    if hovered then
        local wheel = imgui.GetIO().MouseWheel
        if wheel ~= 0 then
            MAP.viewMeters = math.max(30, math.min(3000, MAP.viewMeters * (wheel > 0 and 0.8 or 1.25)))
            scale = W / MAP.viewMeters
        end
    end

    local cx, cy = MAP.cx, MAP.cy
    local p1 = imgui.ImVec2(p0.x + W, p0.y + H)
    local function toScreen(wx, wy)
        return p0.x + W / 2 + (wx - cx) * scale, p0.y + H / 2 - (wy - cy) * scale
    end

    -- рисуем покрытие маршрута рудой
    local activeCov = mapUpdateCoverage(activeRouteIndex, 80)

    local dl = imgui.GetWindowDrawList()
    dl:PushClipRect(p0, p1, true)
    dl:AddRectFilled(p0, p1, mapCol(0.05, 0.06, 0.08, 1.0))

    -- маршруты
    local list = {}
    if MAP.showAll then
        for i = 1, getRouteCount() do list[#list + 1] = i end
    else
        list[1] = activeRouteIndex
    end
    for _, ri in ipairs(list) do
        local pts = getRoutePoints(ri)
        local n = #pts
        local isActive = (ri == activeRouteIndex)
        local states = isActive and activeCov.states or nil
        local thick = isActive and 2.5 or 1.2
        for i = 1, n do
            local a = pts[i]
            local b = pts[i % n + 1]
            if n > 1 then
                local ax, ay = toScreen(a.x, a.y)
                local bx, by = toScreen(b.x, b.y)
                local outside = (ax < p0.x and bx < p0.x) or (ax > p1.x and bx > p1.x) or
                                (ay < p0.y and by < p0.y) or (ay > p1.y and by > p1.y)
                if not outside then
                    local col
                    if isActive then
                        local st = states[i]
                        if st == 0 then col = mapCol(1.0, 0.3, 0.3, 0.95)
                        elseif st == 1 then col = mapCol(0.95, 0.8, 0.3, 0.95)
                        elseif st == 2 then col = mapCol(0.3, 0.9, 0.4, 0.95)
                        else col = mapCol(0.4, 0.6, 1.0, 0.9) end
                    else
                        col = mapCol(0.35, 0.5, 0.8, 0.55)
                    end
                    dl:AddLine(imgui.ImVec2(ax, ay), imgui.ImVec2(bx, by), col, thick)
                end
            end
        end
        if isActive and n > 0 then
            local sx, sy = toScreen(pts[1].x, pts[1].y)
            dl:AddCircle(imgui.ImVec2(sx, sy), 7, mapCol(1, 1, 1, 0.9), 16, 2)
            local cp = pts[currentRoutePoint]
            if cp then
                local tx, ty = toScreen(cp.x, cp.y)
                dl:AddCircleFilled(imgui.ImVec2(tx, ty), 4, mapCol(1, 1, 1, 1), 12)
            end
        end
    end

    -- места руды
    local mp = imgui.GetMousePos()
    local hoverSpot, hoverD = nil, 8
    for i = 1, #RS.spots do
        local s = RS.spots[i]
        local sx, sy = toScreen(s.x, s.y)
        if sx >= p0.x - 6 and sx <= p1.x + 6 and sy >= p0.y - 6 and sy <= p1.y + 6 then
            local col, r
            if s.present then
                col, r = mapCol(0.25, 0.9, 0.35, 1.0), 5
            elseif s.depletedAt then
                col, r = mapCol(1.0, 0.82, 0.25, 1.0), 5
            else
                col, r = mapCol(0.55, 0.55, 0.55, 1.0), 4
            end
            dl:AddCircleFilled(imgui.ImVec2(sx, sy), r, col, 12)
            if hovered then
                local d = toolsDist2d(sx, sy, mp.x, mp.y)
                if d < hoverD then hoverSpot, hoverD = s, d end
            end
        end
    end

    -- другие игроки
    if MAP.showPlayers then
        for _, ped in ipairs(getAllChars()) do
            if ped ~= PLAYER_PED then
                local ox, oy = getCharCoordinates(ped)
                local sx, sy = toScreen(ox, oy)
                dl:AddCircleFilled(imgui.ImVec2(sx, sy), 3, mapCol(1.0, 0.2, 0.2, 0.9), 8)
            end
        end
    end

    -- цель бота
    local mx, my = toScreen(px, py)
    if MAP.showBot and BOT.kind and BOT.kind ~= 'afk' then
        local tx, ty = toScreen(BOT.x, BOT.y)
        dl:AddLine(imgui.ImVec2(mx, my), imgui.ImVec2(tx, ty), mapCol(0.2, 0.9, 1.0, 0.9), 1.5)
        dl:AddCircle(imgui.ImVec2(tx, ty), 8, mapCol(0.2, 0.9, 1.0, 1.0), 16, 2)
    end

    -- Мы: стрелка по направлению взгляда
    local h = math.rad(getCharHeading(PLAYER_PED))
    local dx, dy = -math.sin(h), -math.cos(h)
    local qx, qy = -dy, dx
    dl:AddTriangleFilled(
        imgui.ImVec2(mx + dx * 11, my + dy * 11),
        imgui.ImVec2(mx - dx * 6 + qx * 6, my - dy * 6 + qy * 6),
        imgui.ImVec2(mx - dx * 6 - qx * 6, my - dy * 6 - qy * 6),
        mapCol(1.0, 1.0, 1.0, 1.0))

    -- масштабная линейка и север
    local barM = 10
    for _, v in ipairs({10, 25, 50, 100, 250, 500, 1000, 2000}) do
        barM = v
        if v * scale >= 60 then break end
    end
    local bx0, by0 = p0.x + 12, p1.y - 14
    local white = mapCol(0.85, 0.85, 0.85, 1.0)
    dl:AddLine(imgui.ImVec2(bx0, by0), imgui.ImVec2(bx0 + barM * scale, by0), white, 2)
    dl:AddText(imgui.ImVec2(bx0, by0 - 18), white, barM .. u8" м")
    dl:AddText(imgui.ImVec2(p1.x - 20, p0.y + 6), white, u8"С")
    dl:PopClipRect()

    -- подсказка на карте при наведении
    if hovered and hoverSpot and not imgui.IsMouseDragging(0) then
        local s = hoverSpot
        local t = rsSpotType(s)
        imgui.BeginTooltip()
        imgui.Text((t and oreNames[t] or u8"Руда") .. u8", " .. math.floor(toolsDist2d(s.x, s.y, px, py)) .. u8" м от тебя")
        if s.present then
            imgui.Text(u8"Статус: руда есть")
        elseif s.depletedAt then
            local eta = rsSpotEta(s)
            if not eta then
                imgui.Text(u8"Статус: нет сведений (вне зоны)")
            elseif eta > 0 then
                imgui.Text(u8"Статус: вырастет через " .. rsFmtTime(eta))
            else
                imgui.Text(u8"Статус: просрочено на " .. rsFmtTime(-eta))
            end
        else
            imgui.Text(u8"Статус: нет данных (ещё не видели)")
        end
        if s.med then
            imgui.Text(u8"Обычно растёт " .. rsFmtTime(s.med) .. u8" (замеров: " .. #s.samples .. ")")
        end
        imgui.EndTooltip()
    end

    -- легенда и сводка
    imgui.TextColored(imgui.ImVec4(0.25, 0.9, 0.35, 1.0), u8"Руда есть")
    imgui.SameLine()
    imgui.TextColored(imgui.ImVec4(1.0, 0.82, 0.25, 1.0), u8"Ждёт респавна")
    imgui.SameLine()
    imgui.TextColored(imgui.ImVec4(0.6, 0.6, 0.6, 1.0), u8"Нет данных")
    imgui.SameLine()
    imgui.TextColored(imgui.ImVec4(1.0, 0.3, 0.3, 1.0), u8"Пустой участок")
    imgui.SameLine()
    imgui.TextColored(imgui.ImVec4(0.2, 0.9, 1.0, 1.0), u8"Цель бота")

    local empty, total = 0, 0
    for i = 1, activeCov.n do
        local st = activeCov.states[i]
        if st ~= nil then
            total = total + 1
            if st == 0 then empty = empty + 1 end
        end
    end
    imgui.Text(u8"Маршрут: " .. getRouteName(activeRouteIndex))
    if total > 0 then
        imgui.Text(u8"Пустых участков: " .. empty .. u8" из " .. total .. u8" (" .. math.floor(empty * 100 / total) .. u8"%)")
    end

    local botText = u8"Выключен"
    if mode then
        local names = {mine = u8"Копает руду", ore = u8"Идёт к руде", wait = u8"Ждёт респавна у места",
                       route = u8"Идёт по маршруту", afk = u8"АФК-отдых"}
        botText = names[BOT.kind] or u8"Работает"
    end
    imgui.Text(u8"Бот: " .. botText)
    imgui.TextDisabled(u8"Колесо мыши - масштаб, перетаскивание - сдвиг карты")

    imgui.EndGroup()
end
-- UI_BLOCK_END

-- TGUI_BLOCK_BEGIN
-- ================================================================
-- Интерфейс: вкладка «Telegram»
-- ================================================================
function tgUiCheck(label, field)
    if imgui.Checkbox(label, imgui.new.bool(TG[field])) then
        TG[field] = not TG[field]
        TG.settingsDirty = true
    end
end

function renderTelegramTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()

    renderSectionHeader(u8"Telegram")

    licProBanner()
    if imgui.Checkbox(u8"Включить Telegram", imgui.new.bool(TG.enabled)) then
        TG.enabled = not TG.enabled
        TG.settingsDirty = true
    end

    imgui.Dummy(imgui.ImVec2(0, 4))
    imgui.Text(u8"Токен бота (получить у @BotFather):")
    imgui.PushItemWidth(400)
    imgui.InputText("##tgtoken", TG.tokenBuf, ffi.sizeof(TG.tokenBuf), imgui.InputTextFlags.Password)
    imgui.Text(u8"Chat ID (твой или чата):")
    imgui.InputText("##tgchat", TG.chatBuf, ffi.sizeof(TG.chatBuf))
    imgui.PopItemWidth()

    if imgui.Button(u8"Сохранить", imgui.ImVec2(120, 28)) then
        tgApplyCredentials(ffi.string(TG.tokenBuf), ffi.string(TG.chatBuf))
        if TG.token ~= "" and not tgTokenLooksValid(TG.token) then
            TG.status = "Токен выглядит неправильно: должен быть вида 123456:ABC..."
            TG.statusOk = false
        else
            TG.status = "Сохранено"
            TG.statusOk = true
        end
    end
    imgui.SameLine()
    if imgui.Button(u8"Проверить связь", imgui.ImVec2(150, 28)) then
        tgSendTest()
    end
    imgui.SameLine()
    if imgui.Button((TG.discover and u8"Остановить поиск" or u8"Найти мой chat_id"), imgui.ImVec2(170, 28)) then
        if TG.token == "" then
            TG.status = "Сначала введи токен и нажми Сохранить"
            TG.statusOk = false
        else
            TG.discover = not TG.discover
            TG.found = nil
        end
    end

    if TG.discover then
        imgui.TextWrapped(u8"Теперь открой бота в Telegram, нажми Start и пришли ему любое сообщение - тут появится чат.")
        if TG.found then
            imgui.TextColored(imgui.ImVec4(0.4, 1.0, 0.5, 1.0), u8"Найден чат: " .. TG.found.id .. (TG.found.name ~= "" and (" (" .. TG.found.name .. ")") or ""))
            if imgui.Button(u8"Использовать этот чат", imgui.ImVec2(200, 26)) then
                ffi.fill(TG.chatBuf, ffi.sizeof(TG.chatBuf), 0)
                ffi.copy(TG.chatBuf, TG.found.id)
                tgApplyCredentials(ffi.string(TG.tokenBuf), TG.found.id)
                TG.discover = false
                TG.found = nil
                TG.status = "Chat ID сохранён"
                TG.statusOk = true
            end
        end
    end

    if TG.status ~= "" then
        local col = TG.statusOk and imgui.ImVec4(0.4, 1.0, 0.5, 1.0) or imgui.ImVec4(1.0, 0.45, 0.4, 1.0)
        imgui.PushStyleColor(imgui.Col.Text, col)
        imgui.TextWrapped(TG.status)
        imgui.PopStyleColor(1)
    end
    local tr = TG.transport
    imgui.TextDisabled(u8"Канал: " .. (tr == nil and u8"поток не запущен" or (tr ~= "" and tr or u8"нет HTTPS-библиотеки")) ..
        u8" | отправлено " .. TG.sent .. u8", ошибок " .. TG.failed .. u8", в очереди " .. #TG.queue)
    if TG.chatId:sub(1, 1) == "-" and TG.cmds then
        imgui.TextColored(imgui.ImVec4(1.0, 0.7, 0.3, 1.0), u8"Это группа: управлять ботом сможет любой участник чата!")
    end

    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Separator()
    imgui.Dummy(imgui.ImVec2(0, 8))

    renderSectionHeader(u8"О чём сообщать")
    tgUiCheck(u8"Бот запущен / остановлен", "evStartStop")
    tgUiCheck(u8"Администратор в игре", "evAdmin")
    tgUiCheck(u8"Бот застрял", "evStuck")
    if TG.evStuck then
        imgui.Text(u8"Считать застреванием через (сек):")
        TG.stuckSlider[0] = math.floor(TG.stuckSec)
        if imgui.SliderInt("##tgstuck", TG.stuckSlider, 10, 120) then
            TG.stuckSec = TG.stuckSlider[0]
            TG.settingsDirty = true
        end
    end
    tgUiCheck(u8"Телепорт / откат (скачок координат)", "evTeleport")
    tgUiCheck(u8"Остановить бота при скачке координат", "stopOnTp")
    tgUiCheck(u8"АФК-отдых", "evAfk")
    tgUiCheck(u8"Цель добычи выполнена", "evGoal")
    tgUiCheck(u8"Периодический отчёт по добыче", "evHourly")
    if TG.evHourly then
        imgui.Text(u8"Раз в (мин):")
        TG.hourlySlider[0] = math.floor(TG.hourlyMin)
        if imgui.SliderInt("##tghourly", TG.hourlySlider, 5, 240) then
            TG.hourlyMin = TG.hourlySlider[0]
            TG.settingsDirty = true
        end
    end

    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Separator()
    imgui.Dummy(imgui.ImVec2(0, 8))

    renderSectionHeader(u8"Управление из Telegram")
    tgUiCheck(u8"Принимать команды", "cmds")
    imgui.TextWrapped(u8"Команды: /status /report /run /stop /route N /beer on|off /pos /help. " ..
        u8"Работают только из чата, указанного выше; остальные, незнакомые, игнорируются.")

    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.TextDisabled(u8"Токен хранится открытым текстом в autominev2.ini - не показывай этот файл другим.")

    imgui.EndGroup()
end
-- TGUI_BLOCK_END

local selectedTab = 1

function renderMineDistSection()
    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Separator()
    imgui.Dummy(imgui.ImVec2(0, 4))
    renderSectionHeader(u8"Добыча руды")
    imgui.Text(u8"Начинать добычу, когда до руды (м):")
    MINE.sDist[0] = MINE.dist
    if imgui.SliderFloat("##minedist", MINE.sDist, 0.3, 1.5, "%.1f") then
        MINE.dist = MINE.sDist[0]
        NAV.settingsDirty = true
    end
    imgui.TextDisabled(u8"Бот подходит к руде вплотную и копает, только когда стоит на ней")
end

-- Плавная прокрутка списков (колесо мыши плавно догоняет цель)
SMOOTH = {}
function smoothScrollBegin(id)
    pcall(function()
        local s = SMOOTH[id]
        if not s then
            s = {cur = 0, target = 0, last = 0}
            SMOOTH[id] = s
        end
        local actual = imgui.GetScrollY()
        if math.abs(actual - s.last) > 1.5 then
            s.cur, s.target = actual, actual
        end
        local wheel = imgui.GetIO().MouseWheel
        if wheel ~= 0 and imgui.IsWindowHovered() then
            local mx = imgui.GetScrollMaxY()
            s.target = math.max(0, math.min(mx, s.target - wheel * 70))
        end
        s.cur = s.cur + (s.target - s.cur) * 0.18
        if math.abs(s.target - s.cur) < 0.3 then s.cur = s.target end
        imgui.SetScrollY(s.cur)
        s.last = s.cur
    end)
end

function licProBanner()
    if licPro() then return end
    imgui.TextColored(imgui.ImVec4(1.0, 0.7, 0.3, 1.0), u8"Функция по подписке Про. Ключ вводится на вкладке Подписка")
    if imgui.SmallButton(u8"Купить подписку##banner") then licOpenSite() end
    imgui.Dummy(imgui.ImVec2(0, 4))
end

-- Разделы, целиком доступные только по подписке (номера вкладок): Коллизия, Пиво, Респавн, Карта, Telegram, ИИ пути
LIC_LOCKED_TABS = {[4] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true}

function licTabLocked(id)
    return LIC_LOCKED_TABS[id] == true and not licPro()
end

function licDrawLock(wdl, p, s)
    pcall(function()
        local col = imgui.ColorConvertFloat4ToU32(imgui.ImVec4(1.0, 0.7, 0.3, 1.0))
        local x = p.x + s.x - 26
        local y = p.y + (s.y - 16) / 2
        wdl:AddRect(imgui.ImVec2(x + 2, y), imgui.ImVec2(x + 10, y + 9), col, 3, 15, 2)
        wdl:AddRectFilled(imgui.ImVec2(x, y + 6), imgui.ImVec2(x + 12, y + 16), col, 2)
    end)
end

function renderLicTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()

    renderSectionHeader(u8"Подписка Про")

    if LIC_DEV_UNLOCK then
        imgui.TextColored(imgui.ImVec4(1.0, 0.7, 0.3, 1.0), u8"РЕЖИМ РАЗРАБОТЧИКА: Про открыт без ключа")
    elseif licPro() then
        if LIC.untilTs >= 4000000000 then
            imgui.TextColored(imgui.ImVec4(0.3, 1.0, 0.4, 1.0), u8"Подписка активна: навсегда")
        else
            imgui.TextColored(imgui.ImVec4(0.3, 1.0, 0.4, 1.0), u8"Подписка активна до " .. (os.date("%d.%m.%Y %H:%M", LIC.untilTs) or "?"))
        end
    else
        imgui.TextColored(imgui.ImVec4(1.0, 0.4, 0.4, 1.0), u8"Подписка не активна")
    end
    if LIC.msg ~= "" then
        imgui.TextWrapped(u8(LIC.msg))
    end

    if not licPro() then
        imgui.Dummy(imgui.ImVec2(0, 8))
        if imgui.Button(u8"Купить подписку", imgui.ImVec2(200, 32)) then licOpenSite() end
        imgui.SameLine()
        imgui.TextDisabled(u8"откроется сайт в браузере")
        imgui.Text(u8"Ссылка на сайт:")
        local ro0 = imgui.InputTextFlags and imgui.InputTextFlags.ReadOnly or 0
        imgui.InputText("##licsite", LIC.siteBuf, ffi.sizeof(LIC.siteBuf), ro0)
    end

    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Text(u8"Ключ:")
    imgui.InputText("##lickey", LIC.keyBuf, ffi.sizeof(LIC.keyBuf))
    if imgui.Button(u8"Активировать", imgui.ImVec2(150, 28)) then
        LIC.key = ffi.string(LIC.keyBuf):gsub("^%s+", ""):gsub("%s+$", "")
        licSaveKey()
        LIC.want = true
    end
    imgui.SameLine()
    if imgui.Button(u8"Проверить снова", imgui.ImVec2(150, 28)) then
        LIC.want = true
    end

    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Text(u8"Ваш ID компьютера (сообщите продавцу):")
    local ro = imgui.InputTextFlags and imgui.InputTextFlags.ReadOnly or 0
    imgui.InputText("##lichwid", LIC.hwidBuf, ffi.sizeof(LIC.hwidBuf), ro)

    if LIC_SERVER == "" and not LIC_DEV_UNLOCK then
        imgui.TextColored(imgui.ImVec4(1.0, 0.4, 0.4, 1.0), u8"Сервер проверки ключей не настроен (LIC_SERVER)")
    end

    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Separator()
    imgui.Dummy(imgui.ImVec2(0, 8))
    renderSectionHeader(u8"Что входит в Про")
    imgui.Text(u8"- ИИ пути (прыжок и обход препятствий)")
    imgui.Text(u8"- Респавн руды: таймеры и ожидание у места")
    imgui.Text(u8"- Карта покрытия маршрута")
    imgui.Text(u8"- Telegram: уведомления и управление")
    imgui.Text(u8"- Авто-пиво")
    imgui.Text(u8"- Оптимизация и авто-маршрут")
    imgui.Text(u8"- Отключение коллизии")
    imgui.Dummy(imgui.ImVec2(0, 4))
    imgui.TextDisabled(u8"Бесплатно: маршруты, авто-добыча, приоритет руд, конфиги, цвета")

    imgui.EndGroup()
end

function renderNavTab()
    imgui.SetCursorPos(imgui.ImVec2(20, 20))
    imgui.BeginGroup()

    renderSectionHeader(u8"ИИ пути")

    licProBanner()
    if imgui.Checkbox(u8"Включить ИИ обхода препятствий", imgui.new.bool(NAV.enabled)) then
        NAV.enabled = not NAV.enabled
        NAV.settingsDirty = true
    end
    imgui.TextWrapped(u8"Если бот бежит или идёт на месте - он прыгает. Если и это не помогло - ищет обходной путь лучами по поверхности (стены, обрывы) и обходит препятствие.")

    imgui.Dummy(imgui.ImVec2(0, 6))
    imgui.Text(u8"Считать застреванием через (сек):")
    NAV.sStuck[0] = NAV.stuckTime
    if imgui.SliderFloat("##navstuck", NAV.sStuck, 0.5, 4.0, "%.1f") then
        NAV.stuckTime = NAV.sStuck[0]
        NAV.settingsDirty = true
    end
    imgui.Text(u8"Сколько прыжков до поиска обхода:")
    NAV.sJumps[0] = NAV.maxJumps
    if imgui.SliderInt("##navjumps", NAV.sJumps, 0, 5) then
        NAV.maxJumps = NAV.sJumps[0]
        NAV.settingsDirty = true
    end
    imgui.Text(u8"Макс. длина обхода (м):")
    NAV.sDetour[0] = NAV.detourLen
    if imgui.SliderInt("##navdetour", NAV.sDetour, 3, 15) then
        NAV.detourLen = NAV.sDetour[0]
        NAV.settingsDirty = true
    end
    imgui.Text(u8"Неудачных обходов до пропуска цели:")
    NAV.sFails[0] = NAV.maxFails
    if imgui.SliderInt("##navfails", NAV.sFails, 1, 8) then
        NAV.maxFails = NAV.sFails[0]
        NAV.settingsDirty = true
    end
    imgui.TextDisabled(u8"Пропуск: руду прячет на 45 сек, точку маршрута перескакивает")
    if imgui.Checkbox(u8"Рисовать линию обхода в мире", imgui.new.bool(NAV.draw)) then
        NAV.draw = not NAV.draw
        NAV.settingsDirty = true
    end

    imgui.Dummy(imgui.ImVec2(0, 8))
    imgui.Separator()
    imgui.Dummy(imgui.ImVec2(0, 8))

    renderSectionHeader(u8"Что делает ИИ")
    local names = {free = u8"идёт свободно", jump = u8"прыгает", detour = u8"обходит препятствие"}
    imgui.Text(u8"Состояние: " .. (names[NAV.state] or NAV.state))
    imgui.Text(u8"Неудачных обходов подряд: " .. NAV.fails .. u8" из " .. NAV.maxFails)
    imgui.Text(u8"Прыжков: " .. NAV.stats.jumps .. u8", обходов: " .. NAV.stats.detours)
    imgui.Text(u8"Освободился: " .. NAV.stats.freed .. u8", целей пропущено: " .. NAV.stats.skipped)
    if NAV.info ~= "" then
        imgui.TextWrapped(u8"Последнее: " .. u8(NAV.info))
    end
    if imgui.Button(u8"Сбросить счётчики", imgui.ImVec2(160, 26)) then
        NAV.stats = {jumps = 0, detours = 0, freed = 0, skipped = 0}
        NAV.fails = 0
        NAV.info = ""
        NAV.bad = {}
    end

    imgui.EndGroup()
end

local newFrame = imgui.OnFrame(
    function() return WinState[0] end,
    function(player)
        local screenW, screenH = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(screenW / 2, screenH / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(800, 500), imgui.Cond.FirstUseEver)
        
        imgui.Begin("##main", WinState, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
        
        local sidebarWidth = 180
        local contentWidth = 800 - sidebarWidth - 15
        
        imgui.BeginChild("##sidebar", imgui.ImVec2(sidebarWidth, 500 - 20), true, imgui.WindowFlags.NoScrollWithMouse)
        smoothScrollBegin("side")
        
        imgui.PushFont(titleFont)
        local titleSize = imgui.CalcTextSize("RABOTYAGA MAIN")
        imgui.SetCursorPos(imgui.ImVec2((sidebarWidth - titleSize.x) / 2, 25))
        imgui.TextColored(accent(1.0), "RABOTYAGA MAIN")
        imgui.PopFont()
        
        imgui.Dummy(imgui.ImVec2(0, 15))
        
        local tabs = {
            {id = 1, label = u8"Основное"},
            {id = 2, label = u8"Приоритет"},
            {id = 3, label = u8"Конфиги"}, 
            {id = 4, label = u8"Коллизия"},
            {id = 5, label = u8"Цвета"},
            {id = 6, label = u8"Маршрут"},
            {id = 7, label = u8"Пиво"},
            {id = 8, label = u8"Респавн"},
            {id = 9, label = u8"Карта"},
            {id = 10, label = u8"Telegram"},
            {id = 11, label = u8"ИИ пути"},
            {id = 12, label = u8"Подписка"}
        }
        
        for _, tab in ipairs(tabs) do
            local isActive = (selectedTab == tab.id)
            
            imgui.SetCursorPosX(8)
            
            local buttonColor = imgui.ImVec4(0.08, 0.08, 0.08, 0.85)
            if isActive then
                buttonColor = accent(0.35)
            end
            
            imgui.PushStyleColor(imgui.Col.Button, buttonColor)
            imgui.PushStyleColor(imgui.Col.ButtonHovered, buttonColor)
            imgui.PushStyleColor(imgui.Col.ButtonActive, buttonColor)
            
            local locked = licTabLocked(tab.id)
            if imgui.Button("##tab" .. tab.id, imgui.ImVec2(sidebarWidth - 16, 32)) then
                selectedTab = locked and 12 or tab.id
            end
            
            local p = imgui.GetItemRectMin()
            local s = imgui.GetItemRectSize()
            local wdl = imgui.GetWindowDrawList()
            
            if isActive then
                wdl:AddRectFilled(
                    imgui.ImVec2(p.x, p.y + s.y - 3),
                    imgui.ImVec2(p.x + s.x, p.y + s.y),
                    imgui.ColorConvertFloat4ToU32(accent(1.0))
                )
            end
            
            imgui.SetCursorScreenPos(imgui.ImVec2(p.x + 12, p.y + (s.y - imgui.GetTextLineHeight()) / 2 - 1))
            
            local textColor = isActive and imgui.ImVec4(1.0, 1.0, 1.0, 1.0) or imgui.ImVec4(0.65, 0.65, 0.65, 1.0)
            if locked then textColor = imgui.ImVec4(0.5, 0.45, 0.55, 1.0) end
            imgui.TextColored(textColor, tab.label)
            if locked then licDrawLock(wdl, p, s) end
            
            imgui.PopStyleColor(3)
            imgui.Dummy(imgui.ImVec2(0, 2))
        end
        
        imgui.EndChild()
        imgui.SameLine()
        
        imgui.BeginChild("##content", imgui.ImVec2(contentWidth, 500 - 20), true, imgui.WindowFlags.NoScrollWithMouse)
        smoothScrollBegin("content")
        
        imgui.PushFont(mainFont)
        
        if licTabLocked(selectedTab) then selectedTab = 12 end
        if selectedTab == 1 then
            renderMainTab()
        elseif selectedTab == 2 then
            renderPriorityTab()
        elseif selectedTab == 3 then
            renderConfigTab()
        elseif selectedTab == 4 then
            renderCollisionTab()
        elseif selectedTab == 5 then
            renderMiscTab()
        elseif selectedTab == 6 then
            renderRouteTab()
        elseif selectedTab == 7 then
            renderBeerTab()
        elseif selectedTab == 8 then
            renderRespawnTab()
        elseif selectedTab == 9 then
            renderMapTab()
        elseif selectedTab == 10 then
            renderTelegramTab()
        elseif selectedTab == 11 then
            renderNavTab()
        elseif selectedTab == 12 then
            renderLicTab()
        end
        
        imgui.PopFont()
        imgui.EndChild()
        imgui.End()
    end
)

imgui.OnFrame(function() return WinStats[0] end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(getScreenResolution() / 2, select(2, getScreenResolution()) / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(350, 280), imgui.Cond.FirstUseEver)
    imgui.Begin(u8'Статистика добычи', WinStats, imgui.WindowFlags.NoResize)
    
    imgui.Spacing()
    imgui.Text(u8'Добыто ресурсов:')
    imgui.Spacing()
    imgui.Separator()
    imgui.Spacing()
    
    imgui.Columns(2, 'stats_columns', false)
    imgui.SetColumnWidth(0, 180)
    
    imgui.Text(u8'Камень:')
    imgui.NextColumn()
    imgui.Text(tostring(totalStone))
    imgui.NextColumn()
    
    imgui.Text(u8'Металл:')
    imgui.NextColumn()
    imgui.Text(tostring(totalMetal))
    imgui.NextColumn()
    
    imgui.Text(u8'Серебро:')
    imgui.NextColumn()
    imgui.Text(tostring(totalSilver))
    imgui.NextColumn()
    
    imgui.Text(u8'Бронза:')
    imgui.NextColumn()
    imgui.Text(tostring(totalBronze))
    imgui.NextColumn()
    
    imgui.Text(u8'Золото:')
    imgui.NextColumn()
    imgui.Text(tostring(totalGold))
    imgui.NextColumn()
    
    imgui.Columns(1)
    imgui.Spacing()
    imgui.Separator()
    imgui.Spacing()
    
    local totalMined = totalStone + totalMetal + totalSilver + totalBronze + totalGold
    imgui.Text(u8'Всего добыто: ' .. tostring(totalMined))
    local remaining = SliderInt[0] - totalMined
    imgui.Text(u8'Осталось до цели: ' .. (remaining > 0 and tostring(remaining) or '0'))
    
    imgui.Spacing()
    imgui.Separator()
    imgui.Spacing()
    
    if imgui.Button(u8'Сбросить статистику', imgui.ImVec2(200, 30)) then 
        totalStone, totalMetal, totalSilver, totalBronze, totalGold = 0, 0, 0, 0, 0 
        sampAddChatMessage('{cc66ff}[auto-mine]: {ffffff}Статистика сброшена!', -1)
    end
    
    imgui.End()
end)
end