module counter_4bit (
    input logic clk,           // Clock input
    input logic reset,         // Reset input
    input logic enable,        // Enable input
    output logic [3:0] count   // 4-bit counter output
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 4'b0000;  // Reset the counter
        end else if (enable) begin
            count <= count + 1;  // Increment the counter
        end
    end
endmodule
