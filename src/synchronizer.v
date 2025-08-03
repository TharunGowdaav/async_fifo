module synchronizer (
  input clk, rst_n,
  input [8:0] async_in,
  output reg [8:0] sync_out
);
  reg [8:0] stage1;
  always @(posedge clk) begin
    if (!rst_n) begin
      stage1 <= 0;
      sync_out <= 0;
    end
    else begin
      stage1 <= async_in;
      sync_out <= stage1;
    end
  end
endmodule
