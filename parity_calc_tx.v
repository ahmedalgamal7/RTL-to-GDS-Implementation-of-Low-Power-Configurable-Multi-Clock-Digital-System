module parity_calc_tx (
    input wire par_typ,
    input wire [7:0] data_mem, /// we will join this with the memory in the serializer
    output reg par_bit
);

always @(*) begin
    if(par_typ==0)
    begin
        par_bit=^data_mem;
    end
    else
    begin
        par_bit=~^data_mem;
    end
end
    
endmodule