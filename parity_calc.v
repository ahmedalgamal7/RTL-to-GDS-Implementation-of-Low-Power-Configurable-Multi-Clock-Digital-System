module parity_calc (
    input wire par_typ,
    input wire [7:0] p_data,
    output reg calculated_par
);
always @(*) begin
    if ( par_typ==0)
    calculated_par=^p_data;
    else if ( par_typ==1)
    calculated_par=~^p_data;
    else 
    calculated_par=0;
end
    
endmodule
