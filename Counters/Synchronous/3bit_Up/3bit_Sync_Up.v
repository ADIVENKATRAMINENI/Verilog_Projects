`timescale 1ns/1ps

module threebit_Sync_Up(input Clk,rst,output reg [2:0]Count);

always @(posedge Clk or posedge rst) begin
if(rst)
Count <=3'b000;
else begin
Count <= Count +3'b111;
end
end


endmodule

