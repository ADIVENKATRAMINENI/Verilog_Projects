`timescale 1ns/1ps
module twobit_async_uprst(input rst,Clk,output [1:0]Count);// primary clock (drives LSB) // asynchronous active-high reset

reg q1=1'b0;reg q0=1'b0;

 // LSB: toggle on main clock; asynchronous reset clears it instantly
always @(negedge Clk or posedge rst) begin
if(rst)
q0 <= 1'b0;
else 
q0<= ~q0;
end

// MSB: toggle on rising edge of q0; asynchronous reset also clears it
// NOTE: posedge q0 is an asynchronous clock for this FF: it creates the ripple.
always @(negedge q0 or posedge rst) begin
if({rst})
q1 <= 1'b0;
else 
q1<= ~q1;
end


assign Count ={q1,q0};

endmodule






/*-----------------------------------------------------------------------------------------------------------------------
Why ripple counters behave differently (ripple delay)------ important for a DVE
Timing: 
LSB changes on clock edge, MSB changes later.
In real silicon this is because the LSB?s output must propagate through gate delays and then clock the next stage.

Sampling hazard: 
If another block samples the count bus while the ripple is still in progress, it could capture an invalid intermediate value 
(e.g., 01 for a half-complete 10 transition). 
That?s why synchronous counters (all FFs clocked by the same clock) are preferred in high-speed or multi-flop parallel-sampling contexts.

Design/Verification note: 
When you see ripple counters in designs, expect to see constraints about how the bus is used and where sampling occurs. 
As a verification engineer you?ll check that critical signals are stable when sampled.


notes(summary for a Design Verification Engineer)--------------------------------------
1.Always prefer having a reset (sync or async) to ensure deterministic startup. 
For teaching you saw the ?no reset? version, but for real verification you must check reset behavior.

2.Ripple counters are asynchronous ? MSB is not clocked by the same clock; expect propagation delays and hazards.

3.Synchronous counters (all FFs triggered by same clock) eliminate ripple hazards and are preferable in most RTL designs.

4.For verification:
Check reset assertion/release behavior.
Run random/stress sequences and ensure no metastability or invalid bus reads when sampled by other logic.
Check for correct modulo behavior (mod-4 for 2-bit up counter).

5.When writing testbenches, always run the simulation long enough to see multiple cycles and add $finish inside an initial block.

/*-----------------------------------------------------------------------------------------------------------------------
1. What is a Counter?
A counter is a sequential circuit made up of flip-flops that counts the number of clock pulses.
Each time it gets a clock edge (like a tick), the stored value changes (increases, decreases, or follows a specific sequence).

So, a counter essentially stores a count value and changes it in response to a clock.


2. Key Features of Counters
Driven by a clock ? counts on rising or falling edges.
Outputs change in a fixed sequence (binary, Gray code, BCD, etc.).
Can count up, down, or both.
Often has reset to bring it back to a known state (e.g., 0).


3.Types of Counters
Counters can be classified in two main ways:

(A)Based on Clocking
1. Asynchronous (Ripple) Counter
Only the first flip-flop gets the clock input.
Each flip-flop?s output clocks the next flip-flop ? the clock pulse ?ripples? through.
Slower because changes propagate from one stage to the next.
Easier hardware but not suitable for high-speed systems.

Example: A 4-bit ripple counter using T or JK flip-flops.

2. Synchronous Counter
All flip-flops receive the same clock simultaneously.
Outputs change at the same time (no ripple delay).
Faster and widely used in modern designs.
Requires combinational logic to decide how each flip-flop toggles.

Example: A 4-bit synchronous up-counter with enable/reset.



(B)Based on Counting Sequence
1. Up Counter
Counts from 0 1 2....maximum then rolls over to 0.

2. Down Counter
Counts backward: maximum ? ? ? 2 ? 1 ? 0 ? wraps to maximum.

3. Up/Down Counter
Can count both up and down based on a control signal (e.g., up_down).

4. Decade (BCD) Counter
Counts 0?9 (Binary Coded Decimal), then resets to 0.

5. Ring Counter
A circular shift register with a single ?1? circulating through positions.

6. Johnson Counter (Twisted Ring)
Similar to a ring counter but the inverted last output is fed back to the first flip-flop.

7. Modulo-n Counter
Counts from 0 to n-1, then resets to 0.
e.g., MOD-10, MOD-6, MOD-12 counters.




4.Visual Example ? 3-Bit Up Counter
Clock pulse	Q2 Q1 Q0
0	         000
1	         001
2	         010
3	         011
4	         100
5	         101
6	         110
7	         111
8	         000 ? wraps



5. Key Signals in a Counter
clk: clock input to trigger counting.
rst (reset): sets the counter to zero (can be sync/async).
enable (optional): allows counting only when high.
count [N-1:0]: output that shows current count value.
up_down (optional): direction control for up/down counters.

-----------------------------------------------------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------------------------------------------------
1.Why Resets Are Used
Reset is like the start over button for digital circuits.

Some examples:
When you power up a device ? you want the counter to start at 0.
If an error occurs ? you may want to restart the counter at 0.
In microcontrollers ? reset is often used to reinitialize everything.
In these cases, losing the previous count is intentional.



2. But What If You Don?t Want to Lose the Count?
Then you shouldn?t assert reset during operation.

You can:
Use pause/enable signals instead of reset.
Or use a different register to save the last count before resetting.



3. For example, with an enable signal:

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 0;
    else if (enable)
        count <= count + 1;
    // if enable = 0 ? hold the count, don?t change it
end

Here, toggling enable pauses counting without clearing it.


4. Key Idea
reset = 1 ? forces the counter to 0; previous value is lost by design.
If you don?t want to lose the previous count, you shouldn?t use reset ? instead use enable or a save/hold mechanism.



Real-World Analogy
Think of a stopwatch:
Reset button ? clears the time to 0:00. (You lose your recorded time.)
Pause button ? stops counting but keeps the current time.
Your reset is like the reset button on a stopwatch ? it?s not a mistake; it?s just not what you?d use if you wanted to keep the count.



5. Summary
Reset in your counter is working as intended ? it clears the count.
This isn?t an error, but if you need to pause instead of reset, use an enable control.
Designers typically use reset only at startup or recovery, not during normal counting.

-----------------------------------------------------------------------------------------------------------------------*/


/*-----------------------------------------------------------------------------------------------------------------------
Alternative method:
5.1 T-Flip-Flop (with asynchronous reset)
`timescale 1ns/1ps
module t_ff (
    input clk,
    input rst,       // active-high asynchronous reset
    input T,         // toggle control
    output reg Q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 0;
        else if (T)
            Q <= ~Q;  // toggle output
    end
endmodule


5.2 2-bit Asynchronous Up Counter

`timescale 1ns/1ps
module up_counter_async_2bit (
    input clk,          // external clock
    input rst,          // active-high reset
    output [1:0] Q      // 2-bit count
);
    // First FF toggles every clock edge
    t_ff ff0 (.clk(clk),  .rst(rst), .T(1'b1), .Q(Q[0]));

    // Second FF toggles whenever Q0 goes from 0->1->0->1...
    t_ff ff1 (.clk(Q[0]), .rst(rst), .T(1'b1), .Q(Q[1]));
endmodule

-----------------------------------------------------------------------------------------------------------------------*/
