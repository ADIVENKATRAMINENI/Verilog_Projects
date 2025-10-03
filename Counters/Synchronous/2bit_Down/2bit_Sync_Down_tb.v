`timescale 1ns/1ps
module twobit_Sync_Down_tb;
reg Clk,rst;
wire Count;

twobit_Sync_Down dut(.Clk(Clk),.rst(rst),.Count(Count));

initial Clk =1'b0;
always #5 Clk=~Clk;

initial begin
$display("Time Clk rst | Count");
$monitor("%0t %b %b | %b ",$time,Clk,rst,Count);
rst=1'b1;#25;
rst=1'b0;#30;
rst=1'b1;#35;
#40;
rst=1'b0;#45;
#50;
$finish;
end

endmodule
