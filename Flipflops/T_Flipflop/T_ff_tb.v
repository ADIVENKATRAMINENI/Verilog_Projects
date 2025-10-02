module T_ff_tb;

reg Clk,T,rst;
wire Q,Q_bar;

t_ff dut(.Clk(Clk),.T(T),.rst(rst),.Q(Q),.Q_bar(Q_bar));


initial begin
Clk =1'b0;
forever #5 Clk = ~Clk;
end

initial begin
rst=1;T=1'b1;#10;
T=1'b0;#10;
rst=0;T=1'b1;#10;
T=1'b1;#10;
T=1'b0;#10;
T=1'b0;#10;
T=1'b1;#10;
end

initial begin
$monitor("%0t Clk=%b T=%b  rst=%b  | Q=%b  Q_bar=%b",$time, Clk,T,rst,Q,Q_bar);
#200 $finish;
end

endmodule
