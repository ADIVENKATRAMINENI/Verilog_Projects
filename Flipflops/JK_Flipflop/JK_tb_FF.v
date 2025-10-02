 module jk_ff_tb();
 reg Clk,reset,J,K;
 wire Q,Q_bar;
 jk_flipflop dut(Clk,reset,J,K,Q,Q_bar);
 initial begin
 Clk=1'b0;
 forever #5 Clk = ~Clk;
 end
 initial begin
 reset = 1;
 #10;
 J = 1'b0; K = 1'b0; #10; //Initial memory
 reset = 0;
 J = 1'b0; K = 1'b1; #10; //Reset State
 J = 1'b0; K = 1'b0; #10; //Memory State
 J = 1'b1; K = 1'b0; #10; //Set State
 J = 1'b0; K = 1'b0; #10; //Memory State
 J = 1'b1; K = 1'b1; #10; //Toggle State
 end
 initial begin
 $monitor("\t Clk = %d, J=%d,K=%d,Q=%d",Clk,J,K,Q);
 #100 $finish;
 end
 endmodule
