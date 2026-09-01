`timescale 1ns/1ps

module edge_detection_tb;
    reg [7:0] p00,p01,p02,p10,p11,p12,p20,p21,p22;
    wire [7:0] sobel_edge;
    wire [7:0] prewitt_edge;
    wire [7:0] canny_edge;

    sobel_3x3 u_sobel (
        .p00(p00), .p01(p01), .p02(p02),
        .p10(p10), .p11(p11), .p12(p12),
        .p20(p20), .p21(p21), .p22(p22),
        .edge(sobel_edge)
    );

    prewitt_3x3 u_prewitt (
        .p00(p00), .p01(p01), .p02(p02),
        .p10(p10), .p11(p11), .p12(p12),
        .p20(p20), .p21(p21), .p22(p22),
        .edge(prewitt_edge)
    );

    canny_threshold u_canny (
        .gradient_magnitude(sobel_edge),
        .low_threshold(8'd40),
        .high_threshold(8'd100),
        .edge(canny_edge)
    );

    initial begin
        $monitor("t=%0t Sobel=%0d Prewitt=%0d Canny=%0d",
                 $time, sobel_edge, prewitt_edge, canny_edge);

        // Example 3x3 grayscale window with a vertical intensity change.
        p00=8'd10;  p01=8'd10;  p02=8'd220;
        p10=8'd10;  p11=8'd10;  p12=8'd220;
        p20=8'd10;  p21=8'd10;  p22=8'd220;

        #10;

        // Flat window should produce little/no edge response.
        p00=8'd100; p01=8'd100; p02=8'd100;
        p10=8'd100; p11=8'd100; p12=8'd100;
        p20=8'd100; p21=8'd100; p22=8'd100;

        #10;
        $finish;
    end
endmodule
