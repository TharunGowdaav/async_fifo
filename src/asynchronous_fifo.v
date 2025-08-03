module asynchronous_fifo (
  input wclk, wrst_n,
  input rclk, rrst_n,
  input wen, ren,
  input [31:0] din,
  output reg [31:0] dout,
  output reg full, empty
);
  reg [8:0] wptr_sync, rptr_sync;
  reg [8:0] wptr_bin, rptr_bin;
  reg [8:0] wptr_gray, rptr_gray;

  synchronizer sync_wptr (rclk, rrst_n, wptr_gray, wptr_sync);
  synchronizer sync_rptr (wclk, wrst_n, rptr_gray, rptr_sync);
  
  wptr_handler wptr_h (wclk, wrst_n, wen, rptr_sync, wptr_bin, wptr_gray, full);
  rptr_handler rptr_h (rclk, rrst_n, ren, wptr_sync, rptr_bin, rptr_gray, empty);
  fifo_mem fifom (wclk, wen, rclk, ren, wptr_bin, rptr_bin, din, full, empty, dout);

endmodule
