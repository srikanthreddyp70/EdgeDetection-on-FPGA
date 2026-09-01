`timescale 1ns/1ps
// Educational Canny-style thresholding core.
// This module represents the final threshold stage after
// Gaussian filtering, gradient calculation and non-maximum
// suppression have been performed by preceding blocks.
//
// It is intentionally kept as a small, viewable RTL block.
// It is NOT a complete streaming Canny implementation.
module canny_threshold (
    input  [7:0] gradient_magnitude,
    input  [7:0] low_threshold,
    input  [7:0] high_threshold,
    output reg [7:0] edge
);
    always @* begin
        if (gradient_magnitude >= high_threshold)
            edge = 8'hFF;       // strong edge
        else if (gradient_magnitude >= low_threshold)
            edge = 8'h80;       // weak/potential edge
        else
            edge = 8'h00;       // non-edge
    end
endmodule
