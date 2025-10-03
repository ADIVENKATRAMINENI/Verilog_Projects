`timescale 1ns/1ps

module threebit_async_downrst_tb;

reg Clk;reg rst;
wire [2:0]Count;

threebit_async_downrst dut(.rst(rst),.Clk(Clk),.Count(Count)); // Instantiate

 // Clock: 10 ns period
initial begin
Clk=1'b0;
end

always #5 Clk = ~Clk;


initial begin
$display("Time   rst  Clk  | Count");
$monitor("%0t  %b  %b |  %b", $time, rst,Clk, Count);
        rst = 1; // Apply reset
        #10 rst = 0; // Deassert reset after 10 time units

        // Allow the counter to run for a few cycles
        #100;

        // Apply reset again to check reset functionality
        rst = 1;
        #10 rst = 0;
        #100;

        $display("Simulation finished.");
        $finish; // End the simulation
    end

endmodule
