`timescale 1ns/1ps

module fourbit_Sync_UpDown_tb;

reg Clk,rst,Up_Down;
wire [3:0]Count;

fourbit_Sync_UpDown dut(.Clk(Clk),.rst(rst),.Up_Down(Up_Down),.Count(Count));

initial Clk=1'b0;
always #5 Clk=~Clk;

initial begin
$display("Time Clk rst Up_Down | Count");
$monitor("%0t %b %b %b | %b",$time,Clk,rst,Up_Down,Count);
rst=1'b1;Up_Down=1'b0;#20;
rst=1'b0;#25;
#25;
#30;
rst=1'b1;Up_Down=1'b1;#20;
rst=1'b0;#20;
#30;
#40;
rst=1'b0;Up_Down=1'b0;#20;#30;
Up_Down=1'b1;#20;
Up_Down=1'b0;#25;
#35;
$finish;
end

endmodule


