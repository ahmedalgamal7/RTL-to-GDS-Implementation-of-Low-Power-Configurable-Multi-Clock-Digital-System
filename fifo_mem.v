module fifo_mem #(
    parameter bus_width =8
) (
    input wire [bus_width-1:0] w_data,
    input wire w_clk_en,
    input [2:0] w_addr,
    input wire [2:0] r_addr,
    input wire clk,
    input wire rst,
    output wire [bus_width-1:0] r_data
);
reg [bus_width-1:0] mem [0:7] ;             // minimum fifo depth 6 
integer i;


always @(posedge clk or negedge rst) begin
    if (!rst)
    begin
        for (i=0;i<bus_width;i=i+1)
        begin
            mem [i] <=0;
        end
    end
    else begin
        if (w_clk_en)
        mem[w_addr] <=w_data;
    end
    
end
assign r_data = mem [r_addr];

    
endmodule