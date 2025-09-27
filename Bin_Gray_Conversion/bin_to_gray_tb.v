module bin_gray_tb;

reg [3:0]B1;
wire [3:0]G1;

bin_gray dut(.B(B1),.G(G1));

initial
begin
$display("Time B1 | G1");
$monitor("%0t %b  | %b",$time,B1,G1);
repeat(10) begin
{B1}=$random;#10;
end

$display("Testbench is successfull");
$finish;


end

endmodule

