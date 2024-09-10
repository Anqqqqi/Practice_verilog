module tb_timeclk3();

  // Inputs
  reg clk;
  reg reset;

  // Outputs
  wire q;

  // Instantiate the Unit Under Test (UUT)
  timeclk3 uut (
    .clk(clk), 
    .reset(reset), 
    .q(q)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns period clock
  end

  // Test sequence
  initial begin
    // Initialize Inputs
    reset = 1;
    
    // Wait for global reset
    #20;
    reset = 0;

    // Monitor outputs
    $monitor("At time %t, reset = %b, q = %b", $time, reset, q);

    // Apply test cases
    #100; // Let the clock run for 100 time units

    // Finish simulation
    $finish;
  end

endmodule
