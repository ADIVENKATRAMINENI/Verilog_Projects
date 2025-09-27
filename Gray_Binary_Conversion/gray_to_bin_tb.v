module gray_bin_tb;

reg [3:0]G1;
wire [3:0]B1;

gray_bin dut(.G(G1),.B(B1));

initial
begin
$display("Time G1 | B1");
$monitor("%0t %b | %b",$time,G1,B1);
repeat(10) begin
{G1}=$random;#10;
end

$display("Testbench is successfull");
$finish;


end

endmodule

