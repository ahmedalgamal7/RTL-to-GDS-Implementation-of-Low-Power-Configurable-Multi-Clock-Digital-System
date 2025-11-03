module mux_tx (
    input wire x1,
    input wire x2,
    input wire x3,
    input wire x4,
    input wire [1:0] sel,
    output reg out
);
always @(*) begin
    case (sel)
    2'b00: begin
        out=x1;
    end
     2'b01: begin
        out=x2;
    end
     2'b10: begin
        out=x3;
    end
     2'b11: begin
        out=x4;
    end
    default :out=1'b0;

    endcase
    
end
    
endmodule