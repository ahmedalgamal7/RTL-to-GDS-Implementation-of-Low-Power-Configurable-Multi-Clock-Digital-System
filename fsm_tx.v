module fsm_tx (
    input wire data_valid,
    input wire ser_done,
    input wire par_en,
    input clk,
    input rst,
    output reg ser_en,
    output reg [1:0] mux_sel,
    output reg busy
    
);

localparam idle =3'b0 ;
localparam start =3'b1 ;
localparam data =3'b10 ;
localparam parity =3'b11 ;
localparam stop =3'b100 ;


reg [2:0] cs,ns;
always @(posedge clk or negedge rst ) begin
    if (!rst)
    cs<=idle;
    else 
    cs<=ns;
    
end
always @(*) begin
    case (cs)
        idle: begin
            if (data_valid==1)
            ns=start;
            else 
            ns=idle;
        end
        start:ns=data;
        data:
        begin
            if(ser_done==0)
            ns=data;
            else if (ser_done==1 && par_en==1)
             ns=parity;
             else 
            begin
                ns=stop;
            end
        end
        parity:begin
            ns=stop;
        end    
        stop:begin
            ns=idle;
        end
        default: ns=idle;
    endcase
    
end
always @(*) begin
    case (cs)
        idle:begin
            mux_sel=1;
            ser_en=0;
            busy=0;
        end 
        start:begin
            mux_sel=0;
            ser_en=1;
            busy=1;
        end 
         data:begin
            mux_sel=2;
            ser_en=1;
            busy=1;
        end 
         parity:begin
            mux_sel=3;
            ser_en=0;
            busy=1;
        end 
         stop:begin
            mux_sel=1;
            ser_en=0;
            busy=1;
        end 
        default: begin
            mux_sel=1;
            ser_en=0;
            busy=0;
        end
    endcase
    
end
    
endmodule