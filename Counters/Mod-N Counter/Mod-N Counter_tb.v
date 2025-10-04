`timescale 1ns/1ps
module modn_counter_tb;
parameter n=11 ;
reg Clk,rst;
wire[10:0]Count;

modn_counter dut(.Clk(Clk),.rst(rst),.Count(Count));

initial Clk=1'b0;
always #5 Clk =~Clk;

initial begin
$display("Time clk rst | Count");
$monitor("%0t %b  %b | %b",$time,Clk,rst,Count);
rst=1'b1;#25;
rst=1'b0;#30;
#35;
#40;
#45;
#50;
rst=1'b1;#55;
rst=1'b0;#60;
$finish;

end
endmodule



