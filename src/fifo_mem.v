module fifo_mem (
  input wclk, wen, rclk, ren,
  input [8:0] wptr, rptr,
  input [31:0] din,
  input full, empty,
  output reg [31:0] dout
);
  reg [31:0] fifo[0:255];
  
  always @(posedge wclk) begin
    if (wen & !full) begin
      fifo[wptr[7:0]] <= din;
    end
  end
  
  assign dout = fifo[rptr[7:0]];
endmodule
