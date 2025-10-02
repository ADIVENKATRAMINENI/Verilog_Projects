module d_ff_tb;
reg D,Clk,reset;
wire Q,Q_bar;
d_ff dut(.Clk(Clk),.reset(reset),.D(D),.Q(Q),.Q_bar(Q_bar));

initial begin
Clk=1'b0;
always #5 Clk = ~Clk;
end

initial begin 
reset =1;#10;
reset=0;D=1'b0;#10;
D=1'b0;#10;
D=1'b1;#10;
D=1'b0;#10;
reset=1;D=1'b1;#10;
reset=0;D=1'b1;#10;
end
initial begin 
$monitor("%0t | D=%b, Q=%b, Q_bar=%b  Clk=%b, reset=%b  ", $time, D, Q, Q_bar, Clk, reset);
#200 $finish;
end
endmodule




/*

1.module D_flipflop_tb;
Declares the testbench module named D_flipflop_tb.
Testbenches usually don?t have any ports because they?re top-level modules meant only for simulation.
Everything inside this block drives and observes the DUT (Device Under Test).



2.
reg D;
reg clk;
reg rst;
wire Q;

Testbench signals:
i. reg D; ? drives the D input of the flip-flop.
We use reg because we?ll assign values to it inside procedural blocks (initial/always).

ii.reg clk; ? drives the clock signal. Same reason: it will toggle in an always block.

iii.reg rst; ? drives the reset input.

iv.wire Q; ? connected to the DUT?s output.
We use wire because outputs of DUT are driven by the DUT, not by testbench code.



3. // Instantiate DUT
D_flipflop dut(.D(D), .clk(clk), .rst(rst), .Q(Q));
i. Instantiates the Device Under Test (the D flip-flop you wrote earlier).
ii. dut is the instance name.
iii. The dot-notation connects testbench signals to DUT ports:
.D(D) means DUT?s D input connects to testbench?s D signal.
Similarly for clk, rst, and Q.




4.// Clock generation
initial clk = 0;
always #5 clk = ~clk;  // 10-time-unit period

Clock generator for sequential circuit:
initial clk = 0; ? sets clock low at simulation start.
always #5 clk = ~clk; ? after every 5 time units, toggle (~) the clock.

This creates a square wave:
5 units HIGH, 5 units LOW ? total period = 10 time units.
Clock edges occur every 5 units ? your flip-flop will trigger on posedge clk.



5.initial begin
    // Initialize
    rst = 1; D = 0;
    #10 rst = 0;         // release reset
First stimulus block:
rst = 1; ? activate reset at the start of simulation.
D = 0; ? initialize D input to 0.

#10 rst = 0; ? after 10 time units, release the reset (so the flip-flop can start capturing D).
#10 is a delay control statement ? it pauses this block?s execution for 10 simulation units.



6.// Apply test inputs
    D = 1; #10;
    D = 0; #10;
    D = 1; #20;
This applies a series of stimulus patterns to test the flip-flop:
D = 1; #10; ? set D high, hold it for 10 time units.
D = 0; #10; ? set D low, hold for 10 time units.
D = 1; #20; ? set D high again, hold for 20 time units.

Since the flip-flop samples D only on rising clock edges, the exact times of these changes relative to the clock edges will affect Q.



7.$finish;
end
$finish; ? tells the simulator to end the simulation after all the above delays complete.

Without it, the clock generator would keep toggling forever.



8.  initial begin
    $monitor("Time: %0t | D=%b, Q=%b, clk=%b, rst=%b", $time, D, Q, clk, rst);
end
$monitor ? a system task that prints values to the simulation log whenever any listed signal changes.

"%0t" ? prints current simulation time using $time.
%b ? prints binary values for each signal.

This allows you to observe all important signals (D, Q, clk, rst) over time without manually dumping waves.



9.endmodule
Marks the end of the testbench module.



10.Simulation Timeline (What Happens Step by Step)
Time 0:
clk = 0, rst = 1, D = 0 ? Flip-flop is held in reset ? Q = 0.

Time 5:
Clock rises ? but reset = 1 ? Q stays 0.

Time 10:
Reset released ? now flip-flop ready to sample D.

After this:
On every rising edge of clk, Q updates to whatever D is at that moment.



11. ?? Key Takeaways:
You always need a clock generator for sequential circuits.
Use initial blocks for setup and test vectors.
Use $monitor (or waveform viewers) to observe behavior.
#<time> delays are essential to model real-time stimulus changes.

*/


