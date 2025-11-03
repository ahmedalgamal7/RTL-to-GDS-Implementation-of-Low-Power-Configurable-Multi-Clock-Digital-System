module SYS_CTRL # ( parameter DATA_WIDTH = 8 ,  RF_ADDR = 4 ) (
    input wire CLK,
    input wire RST,
    input wire [DATA_WIDTH-1:0] RF_RdData,
    input wire RF_RdData_VLD,
    input wire FIFO_FULL,
    input wire [DATA_WIDTH-1:0] UART_RX_DATA,
    input wire UART_RX_VLD,
    input wire [DATA_WIDTH*2-1:0] ALU_OUT,
    input wire ALU_OUT_VLD,

    output reg RF_WrEn,
    output reg RF_RdEn,
    output reg [RF_ADDR-1:0] RF_Address,
    output reg [DATA_WIDTH-1:0] RF_WrData,
    output reg ALU_EN,
    output reg [3:0] ALU_FUN,
    output reg CLKG_EN,
    output reg CLKDIV_EN,
    output reg [DATA_WIDTH-1:0] UART_TX_DATA,
    output reg UART_TX_VLD
);
reg [RF_ADDR-1:0] addr_reg;
reg addr_store_;
//wire addr_store;
reg [DATA_WIDTH-1:0] data;
localparam idle =4'b0000,
s1 =4'b0001,
s2 =4'b0010,
s3 =4'b0011,
s4 =4'b0100,
s5 =4'b0101,
s6 =4'b0110,
s7 =4'b0111,
s8 =4'b1000,
s9 =4'b1001,
s10=4'b1010,
s11=4'b1011,
s12=4'b1100;

localparam AA=8'hAA,    
           BB=8'hBB
           ,CC=8'hCC
           ,DD=8'hDD; 

reg [3:0] cs ,ns ;
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        cs <= idle;
    end else begin
        cs <= ns;
    end
end


always @(*) begin
    case (cs)
       idle : begin
        if (UART_RX_VLD) begin
       case (UART_RX_DATA)
       AA: ns = s1;
       BB:ns=s4;
       CC :ns = s7;
       DD: ns =s12;
       default : ns =idle;
         endcase
        end
        else 
        ns=idle;
       end
       s1: begin
       if (UART_RX_VLD)
       ns=s2;
       else 
       ns=s1;
       end
       s2: begin
       if (UART_RX_VLD)
       ns=s3;
       else 
       ns=s2;
       end
       s3: begin
       ns=idle;
       end
       /////////////////////////////////////////////////////
       s4: begin
       if (UART_RX_VLD)
       ns=s5;
       else 
       ns=s4;
       end
       s5: begin
         if (RF_RdData_VLD)
       ns=s6;
       else ns=s5;
       end
       s6:begin
         if (FIFO_FULL)
       ns=s6;
       else 
       ns=idle;
       end
       ////////////////////////////
       s7: begin
       if (UART_RX_VLD)
       ns=s8;
       else 
       ns=s7;
       end
       s8: begin
       if (UART_RX_VLD)
       ns=s9;
       else 
       ns=s8;
       end
       s9: begin
       if (UART_RX_VLD)
       ns=s10;
       else 
       ns=s9;
       end
        s10:if (ALU_OUT_VLD && (ALU_FUN ==4'b0000 || ALU_FUN ==4'b1110 || ALU_FUN ==4'b0010))
        ns=s11;
        else if (ALU_OUT_VLD)
        ns=idle ;
        else 
        ns=s10;
        s11:ns=idle;
        s12:begin
       if (UART_RX_VLD)
       ns=s10;
       else 
       ns=s12;
       end
       
        default: ns=idle;
    endcase
    
end
always @(*) begin
    case (cs)
        idle:begin
           RF_WrEn=0;
           addr_store_=0;
              RF_RdEn=0;
              addr_reg=0;
                RF_WrData=0;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=0;
                CLKDIV_EN=1;
                UART_TX_DATA=0;
                UART_TX_VLD=0; 
        end
        s1:
        begin
           RF_WrEn=0;
           addr_store_=0;
              RF_RdEn=0;
              addr_reg=0;
                RF_WrData=0;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=0;
                CLKDIV_EN=1;
                UART_TX_DATA=0;
                UART_TX_VLD=0; 
        end
        s2:
        begin
           RF_WrEn=0;
              RF_RdEn=0;
              addr_reg=UART_RX_DATA[3:0];
              addr_store_=1;
                RF_WrData=0;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=0;
                CLKDIV_EN=1;
                UART_TX_DATA=0;
                UART_TX_VLD=0; 
        end
        s3:
        begin
           RF_WrEn=1;
              RF_RdEn=0;
              addr_store_=0;
               addr_reg=0;
                RF_WrData=UART_RX_DATA;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=0;
                CLKDIV_EN=1;
                UART_TX_DATA=0;
                UART_TX_VLD=0; 
        end
        s4:begin
           RF_WrEn=0;
              RF_RdEn=0;
              addr_reg=0;
              addr_store_=0;
                RF_WrData=0;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=0;
                CLKDIV_EN=1;
                UART_TX_DATA=0;
                UART_TX_VLD=0; 
        end
        s5:
        begin
           RF_WrEn=0;
              RF_RdEn=1;
              addr_store_=1;
              addr_reg=UART_RX_DATA[3:0];
                RF_WrData=0;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=0;
                CLKDIV_EN=1;
                UART_TX_DATA=0;
                UART_TX_VLD=0; 
        end
        s6:begin
           RF_WrEn=0;
              RF_RdEn=0;
              addr_store_=0;
              addr_reg=0;
                RF_WrData=0;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=0;
                CLKDIV_EN=1;
                  UART_TX_DATA=RF_RdData; 
                  UART_TX_VLD=RF_RdData_VLD;
                end
                
        
        s7:begin
            RF_WrEn=0;
              RF_RdEn=0;
              addr_store_=1;
              addr_reg=0;
                RF_WrData=0;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=0;
                CLKDIV_EN=1;
                  UART_TX_DATA=0; 
                  UART_TX_VLD=0; 
        end
        s8:begin
           RF_WrEn=1;
              RF_RdEn=0;
              addr_store_=1;
              addr_reg=1;
                RF_WrData=UART_RX_DATA;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=1;
                CLKDIV_EN=0;
                UART_TX_DATA=0;
                UART_TX_VLD=0; 
        end
        s9:begin
           RF_WrEn=1;
           addr_store_=0;
              RF_RdEn=0;
              addr_reg=0;
                RF_WrData=data;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=1;
                CLKDIV_EN=1;
                UART_TX_DATA=0;
                UART_TX_VLD=0; 
        end
        s10:begin
         addr_store_=0;
           RF_WrEn=0;
              RF_RdEn=0;
              addr_reg=0;
                RF_WrData=0;
                ALU_EN=1;
                ALU_FUN=UART_RX_DATA[3:0];
                CLKG_EN=1;
                CLKDIV_EN=1;
                UART_TX_DATA=ALU_OUT[7:0];
                UART_TX_VLD=ALU_OUT_VLD; 
        end
        s11: begin
           addr_store_=0;
           RF_WrEn=0;
              RF_RdEn=0;
              addr_reg=0;
                RF_WrData=0;
                ALU_EN=1;
                ALU_FUN=UART_RX_DATA[3:0];
                CLKG_EN=1;
                CLKDIV_EN=1;
                UART_TX_DATA=ALU_OUT[15:8];
                UART_TX_VLD=ALU_OUT_VLD; 
          
        end
        s12:begin
              RF_WrEn=0;
              RF_RdEn=0;
              addr_reg=0;
                RF_WrData=0;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=1;
                CLKDIV_EN=1;
                UART_TX_DATA=0;
                UART_TX_VLD=0; 
        end
        default: begin
           RF_WrEn=0;
              RF_RdEn=0;
              addr_reg=0;
                RF_WrData=0;
                ALU_EN=0;
                ALU_FUN=0;
                CLKG_EN=0;
                CLKDIV_EN=1;
                UART_TX_DATA=0;
                UART_TX_VLD=0; 
        end
    endcase
end
always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        addr_reg <= 0;
        RF_Address<=0;
    end else begin
        if (addr_store_ && (ns==s2 || ns==s5 || ns==s7 || ns==s8) ) begin
            RF_Address <= addr_reg;
        end
    end
end


   // PULSE_GEN pulser(.clk(CLK),.rst(RST),.lvl_sig(addr_store_),.pulse_sig(addr_store));

    always @(posedge CLK or negedge RST) begin
      if (!RST) begin
        data <= 0;
      end
      else if (ns==s9)
      data<=UART_RX_DATA;
    end
endmodule