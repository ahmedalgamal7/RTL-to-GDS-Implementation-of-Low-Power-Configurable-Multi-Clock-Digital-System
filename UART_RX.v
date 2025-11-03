module UART_RX (
    input wire rx_in_top,
    input wire [5:0] prescale_top,
    input wire par_en_top,
    input wire par_typ_top,
    input wire clk_top,
    input wire rst_top,
    output wire [7:0] p_data_top,
    output wire par_error_top,
    output wire stop_error_top,
    output wire data_valid_top
);
wire data_sampled_en_top;
wire [5:0] edge_cnt_top;
wire sampled_bit_top;
wire done_top;
wire [3:0] bit_cnt_top;
wire enable_top;
wire deser_en_top;
wire par_chk_en_top;
wire calculated_par_top;
wire stop_chk_en_top;
wire strt_chk_en_top;
wire strt_glitch_top;




data_sampled u1 (.rx_in(rx_in_top),.prescale(prescale_top),.edge_cnt(edge_cnt_top),.clk(clk_top),.rst(rst_top),.sampled_bit(sampled_bit_top),.done(done_top),.data_sampled_en(data_sampled_en_top));
edge_bit_counter u2 (.clk(clk_top),.par_en(par_en_top),.enable(enable_top),.prescale(prescale_top),.rst(rst_top),.bit_cnt(bit_cnt_top),.edge_cnt(edge_cnt_top));
deserializer u3 (.clk(clk_top),.rst(rst_top),.sampled_bit(sampled_bit_top),.done(done_top),.deser_en(deser_en_top),.p_data(p_data_top));
par_chk u4 (.bit_cnt(bit_cnt_top),.par_chk_en(par_chk_en_top),.sampled_bit(sampled_bit_top),.done(done_top),.clk(clk_top),.rst(rst_top),.calculated_par(calculated_par_top),.par_error(par_error_top));
stop_chk u5 (.bit_cnt(bit_cnt_top),.clk(clk_top),.rst(rst_top),.done(done_top),.sampled_bit(sampled_bit_top),.stop_chk_en(stop_chk_en_top),.stop_error(stop_error_top));
strt_chk u6 (.clk(clk_top),.rst(rst_top),.done(done_top),.sampled_bit(sampled_bit_top),.strt_chk_en(strt_chk_en_top),.strt_glitch(strt_glitch_top));
fsm_rx u7(.clk(clk_top),.rst(rst_top),.par_en(par_en_top),.rx_in(rx_in_top),.edge_cnt(edge_cnt_top),.bit_cnt(bit_cnt_top),.par_error(par_error_top),
.strt_glitch(strt_glitch_top),.stop_error(stop_error_top),.par_chk_en(par_chk_en_top),.stop_chk_en(stop_chk_en_top),.strt_chk_en(strt_chk_en_top),.data_valid(data_valid_top),
.deser_en(deser_en_top),.data_sampled_en(data_sampled_en_top),.enable(enable_top),.prescale(prescale_top));
parity_calc u8 (.p_data(p_data_top),.calculated_par(calculated_par_top),.par_typ(par_typ_top));











    
endmodule