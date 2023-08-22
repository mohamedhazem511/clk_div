// port list of clock divider module
module CLK_DIV(
    input       wire           RST ,
    input       wire           CLK ,
    input       wire           CLK_EN,
    input       wire  [4:0]    DIV_RATIO ,
    output      reg            DIV_CLK
);

// internal signal

reg  [4:0]      Count;
reg             divclk_even;
wire [4:0]      H,L;
wire            divclk_odd;
wire            DIV_CLK;

assign divclk_odd =(CLK_EN & DIV_RATIO ==1) ? CLK :( H > (DIV_RATIO>>1)) || (L >(DIV_RATIO >>1));
assign DIV_CLK = ( !RST || !CLK_EN) ? 1'b0 :(! DIV_RATIO[0] ) ? divclk_even : divclk_odd ;

// sequential always block

always @(posedge CLK or negedge RST)
   begin
// check rset the block or not 
    if(!RST)
        begin
        divclk_even <= 0 ;
        end
// check if even number or not and the counter is reach the required value or not
    else 
        begin
        divclk_even  <= (CLK_EN && (H==0)) ? ~divclk_even : divclk_even;
        end
   end
    
// assign even and odd flags    
assign LSB  = (DIV_RATIO[0] == 1'b1) ? 1'b1 : 1'b0;
assign L    = (DIV_RATIO>>1); 
assign H    =   L + 5'b1;
assign x    = ((DIV_RATIO == 5'b00000) || (DIV_RATIO == 5'b00001));
endmodule