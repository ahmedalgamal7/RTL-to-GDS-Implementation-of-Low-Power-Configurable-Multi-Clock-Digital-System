module Async_fifo # ( 
	 parameter D_SIZE = 8 ,
     parameter A_SIZE = 3 ,
     parameter P_SIZE = 4  
     )
(
    input wire i_w_inc,
    input wire [D_SIZE-1:0] i_w_data,
    input wire i_w_clk,
    input wire i_r_clk,
    input wire i_r_inc,
    input wire i_r_rstn,
    input wire i_w_rstn,
    output wire [D_SIZE-1:0] o_r_data,
    output wire o_empty,
    output wire o_full
);
wire write_enable;
wire [P_SIZE-1:0] rptr_sync;
wire [P_SIZE-1:0] wptr_sync;
wire [A_SIZE-1:0] w_addr;
wire [A_SIZE-1:0] r_addr;
wire [P_SIZE-1:0] wptr;
wire [P_SIZE-1:0] rptr;
wire [D_SIZE-1:0] r_data;
bit_sync  rptr_sync_inst (
    .CLK(i_w_clk),
    .RST(i_w_rstn),
    .ASYNC(rptr),
    .SYNC(rptr_sync)
);
bit_sync wptr_sync_inst (
    .CLK(i_r_clk),
    .RST(i_r_rstn),
    .ASYNC(wptr),
    .SYNC(wptr_sync)
);


fifo_wr_block m1 ( 
    .w_clk(i_w_clk),
    .w_en(i_w_inc),
    .w_rst(i_w_rstn),
    .rptr(rptr_sync),
    .w_full(o_full),
    .w_addr(w_addr),
    .wptr_out(wptr),
    .write_enable(write_enable)
);
fifo_mem m2 (
    .w_data(i_w_data),
    .w_clk_en(write_enable),
    .w_addr(w_addr),
    .r_addr(r_addr),
    .clk(i_w_clk),
    .rst(i_w_rstn),
    .r_data(o_r_data)
);
fifo_rd_block m3 (
    .r_clk(i_r_clk),
    .r_en(i_r_inc),
    .r_rst(i_r_rstn),
    .wptr(wptr_sync),
    .r_empty(o_empty),
    .r_addr(r_addr),
    .rptr_out(rptr)
);

    
endmodule