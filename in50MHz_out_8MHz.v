`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:24:24 07/31/2015 
// Design Name: 
// Module Name:    in50MHz_out_8MHz 
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
module in50MHz_out_8MHz(in_50MHz,out_500hz);
input in_50MHz;
output out_500hz;
reg out_500hz;
reg [31:0]cnt; //use cnt to count
always@(posedge in_50MHz)
begin if(cnt < 32'd50000)//
begin
cnt <= cnt + 1'B1;
end
else begin cnt <= 32'b0;
out_500hz <= ~out_500hz; //ÆµÂÊÎª1HZ
end
end
endmodule