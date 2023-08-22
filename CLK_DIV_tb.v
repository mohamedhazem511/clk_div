/*
   ****** Testbench of Clock Divider Block ******
   by:
       Mohamed Hazem Mamdouh
       7-9-2022
       12:54 PM   
*/

/****** Time Scale ******/

`timescale 1us/1ns

module CLK_DIV_tb ();

/****** Testbench Signals ******/
reg                 CLK_TB;
reg                 RST_TB;
reg                 CLK_EN_TB;
reg   [4:0]         DIV_RATIO_TB;
wire                DIV_CLK_TB;

/****** parameters ******/

parameter  CLK_PERIOD = 200 ; 

initial
 begin
/****** System Functions ******/

 $dumpfile("CLK_DIV.vcd") ;       
 $dumpvars; 
 
/******  initial values ******/

CLK_TB = 1'b0  ;
RST_TB = 1'b0  ;  // rst is activated

/****** Reset the design ******/
#1
RST_TB = 1'b1;    // rst is deactivated

/****** Test Cases ******/

$display(" TEST Case of Disable ");
CLK_EN_TB = 1'b0; // CLK_EN is deactivated
#CLK_PERIOD

CLK_EN_TB = 1'b1; // CLK_EN is activated

$display(" TEST Case 1 ");
DIV_RATIO_TB = 5'b00001;
#CLK_PERIOD
#80
CLK_EN_TB = 1'b1;
#70
$display(" TEST Case 2 ");
DIV_RATIO_TB = 5'b00010;
#CLK_PERIOD

$display(" TEST Case 3 ");
DIV_RATIO_TB = 5'b00011;
#CLK_PERIOD

$display(" TEST Case 4 ");
DIV_RATIO_TB = 5'b00100;
#CLK_PERIOD

$display(" TEST Case 5 ");
DIV_RATIO_TB = 5'b00101;
#CLK_PERIOD

$finish ;

end

/****** Clock Generator ******/
always #5 CLK_TB = !CLK_TB ;


/****** Design Instaniation and Port Mapping ******/
CLK_DIV DUT (
.CLK(CLK_TB),
.RST(RST_TB),
.CLK_EN(CLK_EN_TB),
.DIV_RATIO(DIV_RATIO_TB),
.DIV_CLK(DIV_CLK_TB)
);

endmodule