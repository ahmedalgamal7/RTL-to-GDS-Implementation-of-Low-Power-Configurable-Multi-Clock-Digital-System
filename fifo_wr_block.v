module fifo_wr_block #(
   parameter bus_width =8
) (
    input wire w_clk,
    input wire w_en,
    input wire w_rst,
    input wire [3:0] rptr,
    output wire w_full,
    output reg [2:0] w_addr,
    output wire [3:0] wptr_out,
    output wire write_enable
);
reg [3:0] wptr;
wire [3:0] v;
assign wptr_out= v;

bin_grey dut (.x(wptr),.y(v));
always @(posedge w_clk or negedge w_rst) begin
    if (!w_rst)
    begin
    w_addr<=0;
    wptr<=0;
    end
    else if (write_enable)
    begin
    w_addr<=w_addr+1;
    wptr<=wptr+1;

    end
end
assign w_full = (wptr_out[3]!=rptr[3] && wptr_out[2]!=rptr[2] && wptr_out[1:0]==rptr[1:0])?1:0;
assign write_enable=w_en && !w_full;
    
endmodule