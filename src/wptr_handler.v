module wptr_handler (
  input wclk, wrst_n, wen,
  input [8:0] rptr_sync,
  output reg [8:0] wptr_bin, wptr_gray,
  output reg full
);
  reg [8:0] wptr_bin_next;
  reg [8:0] wptr_gray_next;
  wire is_full;
  
  assign wptr_bin_next = wptr_bin + (wen & !full);
  assign wptr_gray_next = (wptr_bin_next >> 1) ^ wptr_bin_next;
  
  always @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n) begin
      wptr_bin <= 0;
      wptr_gray <= 0;
    end
    else begin
      wptr_bin <= wptr_bin_next;
      wptr_gray <= wptr_gray_next;
    end
  end
  
  always @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n) full <= 0;
    else full <= is_full;
  end

  assign is_full = (wptr_gray_next == {~rptr_sync[8:7], rptr_sync[6:0]});
endmodule
