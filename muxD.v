`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:43:04 03/16/2023 
// Design Name: 
// Module Name:    muxD 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module muxD (
    input [MUX_BIT_WIDTH-1:0] data_0,
    input [MUX_BIT_WIDTH-1:0] data_1,
    input [MUX_BIT_WIDTH-1:0] data_2,
    input [1:0] sel,
    output reg [MUX_BIT_WIDTH-1:0] data_out
);

parameter MUX_BIT_WIDTH = 8;


// Case Statement for MUX Logic

always @ (*)
begin
    case(sel)
        0: data_out = data_0;
        1: data_out = data_1;
        2: data_out = data_2;
        3: data_out = 8'bz; // No value for "11"
    endcase
end

endmodule
