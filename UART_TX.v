module UART_TX (
    input wire clk_top,
    input wire rst_top,
    input wire [7:0] p_data_top,
    input wire data_valid_top,
    input wire par_typ_top,
    input wire par_en_top,
    output wire tx_out_top,
    output wire busy_top
);
wire ser_en_top;
wire ser_done_top;
wire [1:0] mux_sel_top;
wire ser_data_top;
wire par_bit_top;
wire start_bit=1'b0;
wire stop_bit=1'b1;
wire [7:0] memory_top;
serializer u1 (.clk(clk_top),.rst(rst_top),.ser_en(ser_en_top),.p_data(p_data_top),.ser_done(ser_done_top),.ser_data(ser_data_top),.memory(memory_top),.data_valid(data_valid_top),.busy(busy_top));
fsm_tx u2 (.data_valid(data_valid_top),.ser_done(ser_done_top),.par_en(par_en_top),.clk(clk_top),.rst(rst_top),.ser_en(ser_en_top),.mux_sel(mux_sel_top),.busy(busy_top));
parity_calc_tx u3 (.par_typ(par_typ_top),.data_mem(memory_top),.par_bit(par_bit_top));
mux_tx u4 (.x1(start_bit),.x2(stop_bit),.x3(ser_data_top),.x4(par_bit_top),.sel(mux_sel_top),.out(tx_out_top));
    
endmodule