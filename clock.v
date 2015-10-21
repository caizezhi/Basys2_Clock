`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:20:01 07/31/2015 
// Design Name: 
// Module Name:    clock 
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
module clock(clk,clr,switch,ad,adj,o_seg,a,led);
input clk,clr,switch,ad;
input [3:0]adj;
output [2:0]led;//led��
output [6:0]o_seg;//7�������
output [3:0]a; //ɨ�����
reg [6:0]segs;//����ܼĴ���
reg [3:0]a;
reg [15:0] temp;//��ʾ���̵��м����
wire [23:0] cnt;//��ʱģʽ��Уʱģʽ��ʱ����
wire[23:0] cnt1;
wire en0,enp1,enp2,enp3,enp4,enp5,cp1hz,cp,out_500hz;
//switch - N3 ת���ź� ��������һ����Сʱ/���ӣ�һ���Ƿ���/��
//clr - E2 �����ź�
//adj[3]����Сʱ��ʮλ����
//adj[2]����Сʱ�ĸ�λ����
//adj[1]���Ʒ��ӵ�ʮλ����
//adj[0]���Ʒ��ӵĸ�λ����

initial begin
a=4'b1110;
end //��ʼ��

assign cp=cp1hz,//�ж�ad�Ƿ����1��������ڣ�cp�����cp10hz��������cp1hz,
en0=(~ad)|(switch&adj[0]),
enp1=~ad?(cnt[3:0]==4'd9):(adj[1]&switch),
enp2=~ad?(cnt[7:4]==4'd5)&(cnt[3:0]==4'd9):(adj[0]&switch==0),
enp3=~ad?(enp2&(cnt[11:8]==4'd9)):(adj[1]&switch==0),

enp4=~ad?(enp3&(cnt[15:12]==4'd5)):(adj[2]&switch==0),

enp5=~ad?(enp4&((cnt[19:16]==4'd9)|(cnt[23:20]==4'b0010&cnt[19:16]==4'd3))):(adj[3]&switch==0),
o_seg=segs;

in50MHz_out1Hz u0(clk,cp1hz);//���Ƶ��1HZ
in50MHz_out_8MHz u7(clk,out_500hz);//���500HZ
counter10 u1(en0,clr,cp,cnt[3:0]); //second��λ����
counter6 u2(enp1,clr,cp,cnt[7:4]);//secondʮλ����
counter10 u3(enp2,clr,cp,cnt[11:8]);//minutes��λ����
counter6 u4(enp3,clr,cp,cnt[15:12]);//minutesʮλ����
counter10_h u5(enp4,clr,cp,cnt[19:16],cnt[23:20]);//hours��λ���� 
counter3 u6(enp5,clr,cp,cnt[23:20]); //hoursʮλ����
//bell u9(switch,set,bcrl,adj,cp3,cnt,cnt1,led[1:0]);
//adjust u9(clk,ad,switch,adj,cnt1);
//
// always@(ad ) begin //��ʾģʽѡ��
// if((~ad)) begin temp[15:0]<=cnt1[15:0];temp[31:16]<=cnt1[23:8];end // else begin temp[15:0]<=cnt;temp[31:16]<=cnt[23:8];end
// end
always@(posedge clk)
begin
if(switch==1'b0)
temp<=cnt[23:8];
else if(switch==1'b1)
temp<=cnt[15:0];
end

always@(posedge out_500hz)
begin
if(a==4'b1110)
a<=4'b1101;//M13
else if(a==4'b1101)
a<=4'b1011;//J12
else if(a==4'b1011)
a<=4'b0111;//F12
else
a<=4'b1110;//K14
end

always@(posedge clk) //�������ʾ����
if(switch==1'b0)
begin
if(a==4'b1110)//K14
begin
case(temp[3:0])
4'd0: segs <= 7'b1000000;//0
4'd1: segs <= 7'b1111001;//1
4'd2: segs <= 7'b0100100;
4'd3: segs <= 7'b0110000;
4'd4: segs <= 7'b0011001;
4'd5: segs <= 7'b0010010;
4'd6: segs <= 7'b0000010;
4'd7: segs <= 7'b1111000;
4'd8: segs <= 7'b0000000;
4'd9: segs <= 7'b0010000;//9
default segs <= 7'b1111111;
endcase
end
else if(a==4'b1101)//M13
begin
case(temp[7:4])
4'd0: segs <= 7'b1000000;
4'd1: segs <= 7'b1111001;
4'd2: segs <= 7'b0100100;
4'd3: segs <= 7'b0110000;
4'd4: segs <= 7'b0011001;
4'd5: segs <= 7'b0010010;
default segs <= 7'b1111111;
endcase
end
else if(a==4'b1011)
begin
case(temp[11:8])//hours��λ
4'h0: segs <= 7'b1000000;
4'h1: segs <= 7'b1111001;
4'h2: segs <= 7'b0100100;
4'h3: segs <= 7'b0110000;
4'h4: segs <= 7'b0011001;
4'h5: segs <= 7'b0010010;
4'h6: segs <= 7'b0000010;
4'h7: segs <= 7'b1111000;
4'h8: segs <= 7'b0000000;
4'h9: segs <= 7'b0010000;
4'ha: segs <= 7'b0001000;
default segs <= 7'b1111111;
endcase
end
else if(a==4'b0111)
begin
case(temp[15:12])//hoursʮλ
4'h0: segs <= 7'b1000000;
4'h1: segs <= 7'b1111001;
default segs <= 7'b1111111;
endcase
end
end
else if(switch==1)
begin
if(a==4'b1110)
begin
case(temp[3:0])
4'd0: segs <= 7'b1000000;
4'd1: segs <= 7'b1111001;
4'd2: segs <= 7'b0100100;
4'd3: segs <= 7'b0110000;
4'd4: segs <= 7'b0011001;
4'd5: segs <= 7'b0010010;
4'd6: segs <= 7'b0000010;
4'd7: segs <= 7'b1111000;
4'd8: segs <= 7'b0000000;
4'd9: segs <= 7'b0010000;
default segs <= 7'b1111111;
endcase
end
else if(a==4'b1101)
begin
case(temp[7:4])
4'd0: segs <= 7'b1000000;
4'd1: segs <= 7'b1111001;
4'd2: segs <= 7'b0100100;
4'd3: segs <= 7'b0110000;
4'd4: segs <= 7'b0011001;
4'd5: segs <= 7'b0010010;
// 4'd6: segs <= 7'b0000010;
// 4'd7: segs <= 7'b1111000;
// 4'd8: segs <= 7'b0000000;
// 4'd9: segs <= 7'b0010000;
default segs <= 7'b1111111;
endcase
end
else if(a==4'b1011)
begin
case(temp[11:8])
4'd0: segs <= 7'b1000000;
4'd1: segs <= 7'b1111001;
4'd2: segs <= 7'b0100100;
4'd3: segs <= 7'b0110000;
4'd4: segs <= 7'b0011001;
4'd5: segs <= 7'b0010010;
4'd6: segs <= 7'b0000010;
4'd7: segs <= 7'b1111000;
4'd8: segs <= 7'b0000000;
4'd9: segs <= 7'b0010000;
default segs <= 7'b1111111;
endcase
end
else if(a==4'b0111)
begin
case(temp[15:12])
4'd0: segs <= 7'b1000000;
4'd1: segs <= 7'b1111001;
4'd2: segs <= 7'b0100100;
4'd3: segs <= 7'b0110000;
4'd4: segs <= 7'b0011001;
4'd5: segs <= 7'b0010010;
default segs <= 7'b1111111;
endcase
end
end
endmodule
