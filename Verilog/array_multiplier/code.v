`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:        14:36:43 10/16/2020
// Design Name:
// Module Name:        array_mul_16x16
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

module array_mul_16x16(
        input [15:0] a,
        input [15:0] b,
        output [31:0] out
        );
reg [15:0]p[15:0];


integer i;
    always @(a or b)
    begin            
            for(i=0; i<=15; i=i+1)
            begin


                    if(b[i] === 1)
                    begin
                            p[i]<=a;
                    end
                    else
                            p[i] <=16'b0000000000000000;
            end




    end


buf(out[0],p[0][0]); //1st bit is found






wire s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s110,s111,s112,s113,s114,s115,cout1,cin;
twoRowAdder lv1(p[0][1],p[0][2],p[0][3],p[0][4],p[0][5],p[0][6],p[0][7],p[0][8],p[0][9],p[0][10],p[0][11],p[0][12],p[0][13],p[0][14],p[0][15],1'b0,p[1][0],p[1][1],p[1][2],p[1][3],p[1][4],p[1][5],p[1][6],p[1][7],p[1][8],p[1][9],p[1][10],p[1][11],p[1][12],p[1][13],p[1][14],p[1][15],s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s110,s111,s112,s113,s114,s115,cout1);
buf(out[1],s10);    //2nd bit found


wire s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s210,s211,s212,s213,s214,s215,cout2;
twoRowAdder lv2(s11,s12,s13,s14,s15,s16,s17,s18,s19,s110,s111,s112,s113,s114,s115,cout1,p[2][0],p[2][1],p[2][2],p[2][3],p[2][4],p[2][5],p[2][6],p[2][7],p[2][8],p[2][9],p[2][10],p[2][11],p[2][12],p[2][13],p[2][14],p[2][15],s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s210,s211,s212,s213,s214,s215,cout2);
buf(out[2],s20);            //3rd bit


wire s30,s31,s32,s33,s34,s35,s36,s37,s38,s39,s310,s311,s312,s313,s314,s315,cout3;
twoRowAdder lv3(s21,s22,s23,s24,s25,s26,s27,s28,s29,s210,s211,s212,s213,s214,s215,cout2,p[3][0],p[3][1],p[3][2],p[3][3],p[3][4],p[3][5],p[3][6],p[3][7],p[3][8],p[3][9],p[3][10],p[3][11],p[3][12],p[3][13],p[3][14],p[3][15],s30,s31,s32,s33,s34,s35,s36,s37,s38,s39,s310,s311,s312,s313,s314,s315,cout3);
buf(out[3],s30);            //4th bit


wire s40,s41,s42,s43,s44,s45,s46,s47,s48,s49,s410,s411,s412,s413,s414,s415,cout4;
twoRowAdder lv4(s31,s32,s33,s34,s35,s36,s37,s38,s39,s310,s311,s312,s313,s314,s315,cout3,p[4][0],p[4][1],p[4][2],p[4][3],p[4][4],p[4][5],p[4][6],p[4][7],p[4][8],p[4][9],p[4][10],p[4][11],p[4][12],p[4][13],p[4][14],p[4][15],s40,s41,s42,s43,s44,s45,s46,s47,s48,s49,s410,s411,s412,s413,s414,s415,cout4);
buf(out[4],s40);            //5th bit


wire s50,s51,s52,s53,s54,s55,s56,s57,s58,s59,s510,s511,s512,s513,s514,s515,cout5;
twoRowAdder lv5(s41,s42,s43,s44,s45,s46,s47,s48,s49,s410,s411,s412,s413,s414,s415,cout4,p[5][0],p[5][1],p[5][2],p[5][3],p[5][4],p[5][5],p[5][6],p[5][7],p[5][8],p[5][9],p[5][10],p[5][11],p[5][12],p[5][13],p[5][14],p[5][15],s50,s51,s52,s53,s54,s55,s56,s57,s58,s59,s510,s511,s512,s513,s514,s515,cout5);
buf(out[5],s50);          //6th bit


wire s60,s61,s62,s63,s64,s65,s66,s67,s68,s69,s610,s611,s612,s613,s614,s615,cout6;
twoRowAdder lv6(s51,s52,s53,s54,s55,s56,s57,s58,s59,s510,s511,s512,s513,s514,s515,cout5,p[6][0],p[6][1],p[6][2],p[6][3],p[6][4],p[6][5],p[6][6],p[6][7],p[6][8],p[6][9],p[6][10],p[6][11],p[6][12],p[6][13],p[6][14],p[6][15],s60,s61,s62,s63,s64,s65,s66,s67,s68,s69,s610,s611,s612,s613,s614,s615,cout6);
buf(out[6],s60);            //7th bit


wire s70,s71,s72,s73,s74,s75,s76,s77,s78,s79,s710,s711,s712,s713,s714,s715,cout7;
twoRowAdder lv7(s61,s62,s63,s64,s65,s66,s67,s68,s69,s610,s611,s612,s613,s614,s615,cout6,p[7][0],p[7][1],p[7][2],p[7][3],p[7][4],p[7][5],p[7][6],p[7][7],p[7][8],p[7][9],p[7][10],p[7][11],p[7][12],p[7][13],p[7][14],p[7][15],s70,s71,s72,s73,s74,s75,s76,s77,s78,s79,s710,s711,s712,s713,s714,s715,cout7);
buf(out[7],s70);            //8th bit


wire s80,s81,s82,s83,s84,s85,s86,s87,s88,s89,s810,s811,s812,s813,s814,s815,cout8;
twoRowAdder lv8(s71,s72,s73,s74,s75,s76,s77,s78,s79,s710,s711,s712,s713,s714,s715,cout7,p[8][0],p[8][1],p[8][2],p[8][3],p[8][4],p[8][5],p[8][6],p[8][7],p[8][8],p[8][9],p[8][10],p[8][11],p[8][12],p[8][13],p[8][14],p[8][15],s80,s81,s82,s83,s84,s85,s86,s87,s88,s89,s810,s811,s812,s813,s814,s815,cout8);
buf(out[8],s80);            //9th bit


wire s90,s91,s92,s93,s94,s95,s96,s97,s98,s99,s910,s911,s912,s913,s914,s915,cout9;
twoRowAdder lv9(s81,s82,s83,s84,s85,s86,s87,s88,s89,s810,s811,s812,s813,s814,s815,cout8,p[9][0],p[9][1],p[9][2],p[9][3],p[9][4],p[9][5],p[9][6],p[9][7],p[9][8],p[9][9],p[9][10],p[9][11],p[9][12],p[9][13],p[9][14],p[9][15],s90,s91,s92,s93,s94,s95,s96,s97,s98,s99,s910,s911,s912,s913,s914,s915,cout9);
buf(out[9],s90);            //10th bit


wire s100,s101,s102,s103,s104,s105,s106,s107,s108,s109,s1010,s1011,s1012,s1013,s1014,s1015,cout10;
twoRowAdder lv10(s91,s92,s93,s94,s95,s96,s97,s98,s99,s910,s911,s912,s913,s914,s915,cout9,p[10][0],p[10][1],p[10][2],p[10][3],p[10][4],p[10][5],p[10][6],p[10][7],p[10][8],p[10][9],p[10][10],p[10][11],p[10][12],p[10][13],p[10][14],p[10][15],s100,s101,s102,s103,s104,s105,s106,s107,s108,s109,s1010,s1011,s1012,s1013,s1014,s1015,cout10);
buf(out[10],s100);    //11th bit


wire s110_,s111_,s112_,s113_,s114_,s115_,s116,s117,s118,s119,s1110,s1111,s1112,s1113,s1114,s1115,cout11;
twoRowAdder lv11(s101,s102,s103,s104,s105,s106,s107,s108,s109,s1010,s1011,s1012,s1013,s1014,s1015,cout10,p[11][0],p[11][1],p[11][2],p[11][3],p[11][4],p[11][5],p[11][6],p[11][7],p[11][8],p[11][9],p[11][10],p[11][11],p[11][12],p[11][13],p[11][14],p[11][15],s110_,s111_,s112_,s113_,s114_,s115_,s116,s117,s118,s119,s1110,s1111,s1112,s1113,s1114,s1115,cout11);
buf(out[11],s110_);    //12th bit


wire s120,s121,s122,s123,s124,s125,s126,s127,s128,s129,s1210,s1211,s1212,s1213,s1214,s1215,cout12;
twoRowAdder lv12(s111_,s112_,s113_,s114_,s115_,s116,s117,s118,s119,s1110,s1111,s1112,s1113,s1114,s1115,cout11,p[12][0],p[12][1],p[12][2],p[12][3],p[12][4],p[12][5],p[12][6],p[12][7],p[12][8],p[12][9],p[12][10],p[12][11],p[12][12],p[12][13],p[12][14],p[12][15],s120,s121,s122,s123,s124,s125,s126,s127,s128,s129,s1210,s1211,s1212,s1213,s1214,s1215,cout12);
buf(out[12],s120);    //13th bit


wire s130,s131,s132,s133,s134,s135,s136,s137,s138,s139,s1310,s1311,s1312,s1313,s1314,s1315,cout13;
twoRowAdder lv13(s121,s122,s123,s124,s125,s126,s127,s128,s129,s1210,s1211,s1212,s1213,s1214,s1215,cout12,p[13][0],p[13][1],p[13][2],p[13][3],p[13][4],p[13][5],p[13][6],p[13][7],p[13][8],p[13][9],p[13][10],p[13][11],p[13][12],p[13][13],p[13][14],p[13][15],s130,s131,s132,s133,s134,s135,s136,s137,s138,s139,s1310,s1311,s1312,s1313,s1314,s1315,cout13);
buf(out[13],s130);    //14th bit


wire s140,s141,s142,s143,s144,s145,s146,s147,s148,s149,s1410,s1411,s1412,s1413,s1414,s1415,cout14;
twoRowAdder lv14(s131,s132,s133,s134,s135,s136,s137,s138,s139,s1310,s1311,s1312,s1313,s1314,s1315,cout13,p[14][0],p[14][1],p[14][2],p[14][3],p[14][4],p[14][5],p[14][6],p[14][7],p[14][8],p[14][9],p[14][10],p[14][11],p[14][12],p[14][13],p[14][14],p[14][15],s140,s141,s142,s143,s144,s145,s146,s147,s148,s149,s1410,s1411,s1412,s1413,s1414,s1415,cout14);
buf(out[14],s140);    //15th bit




twoRowAdder lv15(s141,s142,s143,s144,s145,s146,s147,s148,s149,s1410,s1411,s1412,s1413,s1414,s1415,cout14,p[15][0],p[15][1],p[15][2],p[15][3],p[15][4],p[15][5],p[15][6],p[15][7],p[15][8],p[15][9],p[15][10],p[15][11],p[15][12],p[15][13],p[15][14],p[15][15],out[15],out[16],out[17],out[18],out[19],out[20],out[21],out[22],out[23],out[24],out[25],out[26],out[27],out[28],out[29],out[30],out[31]);
//bit 16 to 32


endmodule





module ha(
input a,b,
output s,c);
xor xor1(s,a,b);
and and1(c,a,b);
endmodule


module fa(a, b, cin, s, cout);
input a, b, cin;
output s,cout;
reg s, cout;
always @(a or b or cin)
begin
    s= a ^ b ^ cin;
    cout = (a & b) | (a & cin) | (b & cin);
end
endmodule


module twoRowAdder(


input a11,a12,a13,a14,a15,a16,a17,a18,a19,a110,a111,a112,a113,a114,a115,cin,b00,b01,b02,b03,b04,b05,b06,b07,b08,b09,b010,b011,b012,b013,b014,b015,
output s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s110,s111,s112,s113,s114,s115,cout);


wire c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c110,c111,c112,c113,c114,c115;
ha ha1(a11,b00,s10,c10);
fa fa1(a12,b01,c10,s11,c11);
fa fa2(a13,b02,c11,s12,c12);
fa fa3(a14,b03,c12,s13,c13);
fa fa4(a15,b04,c13,s14,c14);
fa fa5(a16,b05,c14,s15,c15);
fa fa6(a17,b06,c15,s16,c16);
fa fa7(a18,b07,c16,s17,c17);
fa fa8(a19,b08,c17,s18,c18);
fa fa9(a110,b09,c18,s19,c19);
fa fa10(a111,b010,c19,s110,c110);
fa fa11(a112,b011,c110,s111,c111);
fa fa12(a113,b012,c111,s112,c112);
fa fa13(a114,b013,c112,s113,c113);
fa fa14(a115,b014,c113,s114,c114);
fa fa15(b015,c114,cin,s115,cout);




endmodule
