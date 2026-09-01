`timescale 1ns/1ps
// Educational 3x3 Prewitt edge detector.
// Input pixels are 8-bit grayscale. The 3x3 window is supplied directly.
module prewitt_3x3 (
    input  [7:0] p00, p01, p02,
    input  [7:0] p10, p11, p12,
    input  [7:0] p20, p21, p22,
    output [7:0] edge
);
    integer gx, gy, mag;
    integer ax, ay;

    always @* begin
        gx = -p00 + p02 - p10 + p12 - p20 + p22;
        gy =  p00 + p01 + p02 - p20 - p21 - p22;

        ax = (gx < 0) ? -gx : gx;
        ay = (gy < 0) ? -gy : gy;
        mag = ax + ay;

        if (mag > 255)
            mag = 255;
    end

    assign edge = mag[7:0];
endmodule
