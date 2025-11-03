module ClkDiv #( 
 parameter RATIO_WD = 8 
)
(
    input wire i_ref_clk,
    input wire i_rst,
    input wire i_clk_en,
    input wire [7:0] i_div_ratio,
    output wire o_div_clk
);
wire ClK_DIV_EN;
reg [RATIO_WD-1:0] counter;
wire [RATIO_WD-2:0] half_clk;
wire [RATIO_WD-1:0] odd_half_clk;
wire odd;
reg flag;
reg o_div_clk_reg;
assign odd = (i_div_ratio[0])?1'b1:1'b0;
assign ClK_DIV_EN = i_clk_en && ( i_div_ratio != 0) && ( i_div_ratio != 1);
assign half_clk = (i_div_ratio/2);
assign odd_half_clk = (i_div_ratio/2)+1;
assign o_div_clk= (ClK_DIV_EN)?~o_div_clk_reg:i_ref_clk;

always @(posedge i_ref_clk or negedge i_rst ) begin
    if (!i_rst)
    begin
        counter<=0;
        o_div_clk_reg<=0;
        flag<=0;
    end
    else if (ClK_DIV_EN && !odd && (counter ==half_clk ))
    begin
        o_div_clk_reg<=!o_div_clk_reg;
        counter<=1;
    end
     else if (ClK_DIV_EN && odd && (((counter ==half_clk) && !flag)||((counter == odd_half_clk) && flag)))
    begin
        o_div_clk_reg<=!o_div_clk_reg;
        counter<=1;
        flag <=!flag;
    end
    else begin
        counter <=counter+1;
    
    end
end
    
endmodule

