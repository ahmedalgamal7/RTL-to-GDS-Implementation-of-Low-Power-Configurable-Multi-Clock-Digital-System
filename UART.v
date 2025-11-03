
module UART # ( parameter DATA_WIDTH = 8)

(
 input   wire                          RST,
 input   wire                          TX_CLK,
 input   wire                          RX_CLK,
 input   wire                          RX_IN_S,
 output  wire   [DATA_WIDTH-1:0]       RX_OUT_P, 
 output  wire                          RX_OUT_V,
 input   wire   [DATA_WIDTH-1:0]       TX_IN_P, 
 input   wire                          TX_IN_V, 
 output  wire                          TX_OUT_S,
 output  wire                          TX_OUT_V,  
 input   wire   [5:0]                  Prescale, 
 input   wire                          parity_enable,
 input   wire                          parity_type,
 output  wire                          parity_error,
 output  wire                          framing_error
);


UART_TX U0_UART_TX (
.clk_top(TX_CLK),
.rst_top(RST),
.p_data_top(TX_IN_P),
.data_valid_top(TX_IN_V),
.par_typ_top(parity_type),
.par_en_top(parity_enable),
.tx_out_top(TX_OUT_S),
.busy_top(TX_OUT_V)
);
 
 
UART_RX U0_UART_RX (
.rx_in_top(RX_IN_S),
.prescale_top(Prescale),
.clk_top(RX_CLK),
.rst_top(RST),
.p_data_top(RX_OUT_P),
.par_error_top(parity_error),
.par_en_top(parity_enable),
.par_typ_top(parity_type),
.stop_error_top(framing_error),
.data_valid_top(RX_OUT_V)
);
 



endmodule
 
