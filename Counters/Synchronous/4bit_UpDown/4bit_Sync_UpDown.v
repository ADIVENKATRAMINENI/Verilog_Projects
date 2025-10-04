`timescale 1ns/1ps

module fourbit_Sync_UpDown(input Clk,rst,Up_Down,output reg [3:0]Count);

always @(posedge Clk or posedge rst) begin
if(rst)
Count <=4'b0000;
else if(Up_Down)
Count <= Count +4'b0001;
else if(!Up_Down)
Count <=Count-4'b0001;
end

endmodule
