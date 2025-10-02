 module jk_flipflop(Clk,reset,J,K,Q,Q_bar);
 input J,K;
 input Clk,reset;
 output reg Q;
 output Q_bar;
 always@(posedge Clk)
 begin
 if({reset})
 Q<=1'b0;
 else
 begin
 case({J,K})
 2'b00: Q <= Q;
 2'b01: Q <= 1'b0;
 2'b10: Q <= 1'b1;
 2'b11: Q <= ~Q;
 endcase
 end
 end
 assign Q_bar = ~Q;
 endmodule
