`timescale 1ns/1ps
module fourbit_Async_updown_tb;

reg rst=1'b1,up_down=1'b1,Clk;
wire [3:0]Count;

fourbit_Async_updown dut(.rst(rst),.up_down(up_down),.Clk(Clk),.Count(Count));

initial Clk=1'b0;
always #5 Clk =~Clk;


initial begin
$display("Time   Up_Down   rst   Clk  |  Count");
$monitor("%0t     %b   %b  %b  | %b",$time,up_down,rst,Clk,Count);
rst =1'b1;up_down=1'b1;#20;
rst=1'b0;#15;
rst=1'b0;#30;
rst=1'b1;up_down=1'b0;#15
rst=1'b0;up_down=1'b0;#25
rst=1'b0;#35

$display("Simulation finished.");
$finish;
end
endmodule
