`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:25:11 07/31/2015 
// Design Name: 
// Module Name:    counter10 
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
module counter10(en,clr,clk,q);
input en,clr,clk;
output [3:0] q;
reg [3:0] q;

always@(posedge clk)
begin
if(clr) q<=4'd0;//clr=0时，清零
else if(~en) q<=q;// EN=0，暂停计数
else if (q==4'b1001) q<=4'b0000;
else q<=q+1;//计数器加1
end
endmodule
