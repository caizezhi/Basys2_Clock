`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:26:17 07/31/2015 
// Design Name: 
// Module Name:    counter6 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter6(en,clr,clk,q);
input en,clr,clk;
output [3:0] q;
reg [3:0] q;

always@(posedge clk)
begin
if(clr) q<=4'b0000;//clr=0，清零
else if(~en) q<=q;//EN=0，暂停计数
else if(q==4'b0101) q<=4'b0000;
else q<=q+1'b1;//计数器增1
end
endmodule
