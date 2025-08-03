module rptr_handler (
  input rclk, rrst_n, ren,
  input [8:0] wptr_sync,
  output reg [8:0] rptr_bin, rptr_gray,
  output reg empty
);
  reg [8:0] rptr_bin_next;
  reg [8:0] rptr_gray_next;
  wire is_empty;
  
  assign rptr_bin_next = rptr_bin + (ren & !empty);
  assign rptr_gray_next = (rptr_bin_next >> 1) ^ rptr_bin_next;
  
  always @(posedge rclk or negedge rrst_n) begin
    if (!rrst_n) begin
      rptr_bin <= 0;
      rptr_gray <= 0;
    end
    else begin
      rptr_bin <= rptr_bin_next;
      rptr_gray <= rptr_gray_next;
    end
  end
  
  always @(posedge rclk or negedge rrst_n) begin
    if (!rrst_n) empty <= 1;
    else empty <= is_empty;
  end
  
  assign is_empty = (wptr_sync == rptr_gray_next);
  
endmodule
