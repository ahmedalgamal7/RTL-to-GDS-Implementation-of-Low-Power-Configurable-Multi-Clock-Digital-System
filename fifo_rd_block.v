module fifo_rd_block #(
   parameter bus_width =8
) (
    input wire r_clk,
    input wire r_en,
    input wire r_rst,
    input wire [3:0] wptr,
    output wire r_empty,
    output reg [2:0] r_addr,
    output wire [3:0] rptr_out
);
reg [3:0] rptr;
wire [3:0] v;
assign rptr_out=v;
bin_grey dut (.x(rptr),.y(v));
assign r_empty = ( rptr_out==wptr)? 1'b1 : 1'b0;


always @(posedge r_clk or negedge r_rst) begin
    if (!r_rst)
    begin
        r_addr<=0;
        rptr<=0;
    end
    else if (r_en && !r_empty) begin
        r_addr<=r_addr+1;
        rptr<=rptr+1;
    end
    
end

endmodule
