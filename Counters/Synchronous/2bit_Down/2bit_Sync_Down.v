
`timescale 1ns/1ps

module twobit_Sync_Down(input Clk,rst,output reg [1:0]Count);

always @(posedge Clk or posedge rst) begin
if(rst)
Count <=2'b00;
else begin
Count <= Count -1;
if(Count == 2'b00) 
Count <=2'b11;
end
end


endmodule