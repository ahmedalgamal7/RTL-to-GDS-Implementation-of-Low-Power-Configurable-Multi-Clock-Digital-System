module strt_chk (
    input wire strt_chk_en,
    input wire sampled_bit,
    input wire done,
    input wire clk,
    input wire rst,
    output reg strt_glitch
);
always @(posedge clk , negedge rst) begin
    if (!rst)
    begin
        strt_glitch<=0;
    end
    else if (strt_chk_en && done)
    case (sampled_bit)
        0: strt_glitch<=0 ;
        1: strt_glitch<=1;
        default: strt_glitch<=0 ;
    endcase
    
end

    
endmodule