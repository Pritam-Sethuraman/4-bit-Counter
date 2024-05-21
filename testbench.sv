module tb_counter_4bit;
  // Testbench signals
  logic clk;
  logic rst;
  logic en;
  logic [3:0] count;
  
  // Instantiate UUT
  counter_4bit uut (
    .clk(clk),
    .reset(rst),
    .enable(en),
    .count(count)
  );
  
  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Clock period of 10 time units
  end
  
  // Task for applying reset
  task apply_reset();
    begin
      rst = 1;
      #10;
      rst = 0;
    end
  endtask
  
  // Task for enabling and disabling counter
  task enable_counter(input logic enable, input int duration);
    begin
      en = enable;
      #duration;
    end
  endtask

  // Task for checking the counter value
  task check_count(input logic [3:0] expected_count);
    begin
      if (count !== expected_count) begin
        $display("Error at time %0t: expected count = %0d, actual count = %0d", $time, expected_count, count);
        $stop;
      end else begin
        $display("At time %0t: count = %0d", $time, count);
      end
    end
  endtask
  
  // Test sequence
  initial begin
    // Initialize signals
    rst = 0;
    en = 0;
    
    // Apply reset
    apply_reset();
    
    // Enable the counter and observe counting
    enable_counter(1, 50);
    #50 check_count(5);  // Assuming the initial count is 0 and count should be 5 after 50 time units
    #50 check_count(10); // Check if the count has incremented correctly
    
    // Disable the counter and observe no counting
    enable_counter(0, 50);
    #50 check_count(10); // Count should remain the same
    
    // Enable again and observe counting
    enable_counter(1, 50);
    #50 check_count(15); // Check if the count resumes correctly
    
    $finish;
  end
  
  // Monitor outputs
  initial begin
    $monitor("Time=%0t, rst=%b, en=%b, count=%0d", $time, rst, en, count);
  end
endmodule
