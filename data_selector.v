`timescale 1ns / 1ps

module data_selector(
    input wire [7:0] in,
    input wire [2:0] sel,
    input wire mux_enable,  
    output wire mux_out,
    output wire [7:0] demux_out
);

    wire mux_output;

    eight_1_mux u1 (
        .in(in),
        .sel(sel),
        .out2(mux_output)
    );

    wire demux_input = mux_enable ? mux_output : 1'b0;

    // Instantiate 1:8 DEMUX
    eight_1_demux u2 (
        .in(demux_input),
        .sel(sel),
        .out2(demux_out)
    );

    assign mux_out = mux_output;

endmodule

// 8:1 Multiplexer
module eight_1_mux(
    input wire [7:0] in,
    input wire [2:0] sel,
    output reg out2
);
    always @(*) begin
        case (sel)
            3'b000: out2 = in[0];
            3'b001: out2 = in[1];
            3'b010: out2 = in[2];
            3'b011: out2 = in[3];
            3'b100: out2 = in[4];
            3'b101: out2 = in[5];
            3'b110: out2 = in[6];
            3'b111: out2 = in[7];
            default: out2 = 1'b0;
        endcase
    end
endmodule

// 1:8 Demultiplexer
module eight_1_demux(
    input wire in,
    input wire [2:0] sel,
    output reg [7:0] out2
);
    always @(*) begin
        out2 = 8'b0;  // Reset all outputs
        case (sel)
            3'b000: out2[0] = in;
            3'b001: out2[1] = in;
            3'b010: out2[2] = in;
            3'b011: out2[3] = in;
            3'b100: out2[4] = in;
            3'b101: out2[5] = in;
            3'b110: out2[6] = in;
            3'b111: out2[7] = in;
        endcase
    end
endmodule
