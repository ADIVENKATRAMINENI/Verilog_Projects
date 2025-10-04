`timescale 1ns/1ps

module threebit_Sync_Up_tb;

reg Clk,rst;
wire [2:0]Count;

threebit_Sync_Up dut(.Clk(Clk),.rst(rst),.Count(Count));

initial Clk=1'b0;
always #5 Clk=~Clk;

initial begin
$display("Time Clk rst | Count");
$monitor("%0t %b %b | %b",$time,Clk,rst,Count);
rst=1'b1;#20;
#25;
rst=1'b0;#30;
#35;
rst=1'b1;#40;
#45;
rst=1'b0;#50;
#55;
$finish;
end

endmodule



/*
Mistake I made:
I didn't initialise Count to 3bit [2:0] where I did to Count(single bit) s I got 0,1 values in output.*/