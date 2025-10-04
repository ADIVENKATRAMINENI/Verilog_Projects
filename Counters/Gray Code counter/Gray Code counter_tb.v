 module test_bench;
 parameter N=4;
 reg clk,reset;
 wire[N-1:0]gray_count;
 gray_counter dut(clk,reset,gray_count);
 initial clk=1'b0;
 always #5 clk=~clk;

 initial begin
 $monitor("\t\tcounter:%d",gray_count);
 reset=1'b1;
 #10;
 reset=1'b0;
 #175$finish;

 end
 endmodule
