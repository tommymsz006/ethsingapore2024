pragma circom 2.1.5;

include "@zk-email/zk-regex-circom/circuits/regex_helpers.circom";

// regex: subject:=\?UTF-8\?B\?WW91ciBlVGlja2V0IGlzIHJlYWR5OiB1c2UgYm9va2luZyByZWYg[A-Za-z0-9]+
template bookingRefRegex(msg_bytes) {
	signal input msg[msg_bytes];
	signal output out;

	var num_bytes = msg_bytes+1;
	signal in[num_bytes];
	in[0]<==255;
	for (var i = 0; i < msg_bytes; i++) {
		in[i+1] <== msg[i];
	}

	component eq[43][num_bytes];
	component lt[4][num_bytes];
	component and[74][num_bytes];
	component multi_or[2][num_bytes];
	signal states[num_bytes+1][72];
	signal states_tmp[num_bytes+1][72];
	signal from_zero_enabled[num_bytes+1];
	from_zero_enabled[num_bytes] <== 0;
	component state_changed[num_bytes];

	for (var i = 1; i < 72; i++) {
		states[0][i] <== 0;
	}

	for (var i = 0; i < num_bytes; i++) {
		state_changed[i] = MultiOR(71);
		states[i][0] <== 1;
		eq[0][i] = IsEqual();
		eq[0][i].in[0] <== in[i];
		eq[0][i].in[1] <== 115;
		and[0][i] = AND();
		and[0][i].a <== states[i][0];
		and[0][i].b <== eq[0][i].out;
		states_tmp[i+1][1] <== 0;
		eq[1][i] = IsEqual();
		eq[1][i].in[0] <== in[i];
		eq[1][i].in[1] <== 117;
		and[1][i] = AND();
		and[1][i].a <== states[i][1];
		and[1][i].b <== eq[1][i].out;
		states[i+1][2] <== and[1][i].out;
		eq[2][i] = IsEqual();
		eq[2][i].in[0] <== in[i];
		eq[2][i].in[1] <== 98;
		and[2][i] = AND();
		and[2][i].a <== states[i][2];
		and[2][i].b <== eq[2][i].out;
		states[i+1][3] <== and[2][i].out;
		eq[3][i] = IsEqual();
		eq[3][i].in[0] <== in[i];
		eq[3][i].in[1] <== 106;
		and[3][i] = AND();
		and[3][i].a <== states[i][3];
		and[3][i].b <== eq[3][i].out;
		states[i+1][4] <== and[3][i].out;
		eq[4][i] = IsEqual();
		eq[4][i].in[0] <== in[i];
		eq[4][i].in[1] <== 101;
		and[4][i] = AND();
		and[4][i].a <== states[i][4];
		and[4][i].b <== eq[4][i].out;
		states[i+1][5] <== and[4][i].out;
		eq[5][i] = IsEqual();
		eq[5][i].in[0] <== in[i];
		eq[5][i].in[1] <== 99;
		and[5][i] = AND();
		and[5][i].a <== states[i][5];
		and[5][i].b <== eq[5][i].out;
		states[i+1][6] <== and[5][i].out;
		eq[6][i] = IsEqual();
		eq[6][i].in[0] <== in[i];
		eq[6][i].in[1] <== 116;
		and[6][i] = AND();
		and[6][i].a <== states[i][6];
		and[6][i].b <== eq[6][i].out;
		states[i+1][7] <== and[6][i].out;
		eq[7][i] = IsEqual();
		eq[7][i].in[0] <== in[i];
		eq[7][i].in[1] <== 58;
		and[7][i] = AND();
		and[7][i].a <== states[i][7];
		and[7][i].b <== eq[7][i].out;
		states[i+1][8] <== and[7][i].out;
		eq[8][i] = IsEqual();
		eq[8][i].in[0] <== in[i];
		eq[8][i].in[1] <== 61;
		and[8][i] = AND();
		and[8][i].a <== states[i][8];
		and[8][i].b <== eq[8][i].out;
		states[i+1][9] <== and[8][i].out;
		eq[9][i] = IsEqual();
		eq[9][i].in[0] <== in[i];
		eq[9][i].in[1] <== 63;
		and[9][i] = AND();
		and[9][i].a <== states[i][9];
		and[9][i].b <== eq[9][i].out;
		states[i+1][10] <== and[9][i].out;
		eq[10][i] = IsEqual();
		eq[10][i].in[0] <== in[i];
		eq[10][i].in[1] <== 85;
		and[10][i] = AND();
		and[10][i].a <== states[i][10];
		and[10][i].b <== eq[10][i].out;
		states[i+1][11] <== and[10][i].out;
		eq[11][i] = IsEqual();
		eq[11][i].in[0] <== in[i];
		eq[11][i].in[1] <== 84;
		and[11][i] = AND();
		and[11][i].a <== states[i][11];
		and[11][i].b <== eq[11][i].out;
		states[i+1][12] <== and[11][i].out;
		eq[12][i] = IsEqual();
		eq[12][i].in[0] <== in[i];
		eq[12][i].in[1] <== 70;
		and[12][i] = AND();
		and[12][i].a <== states[i][12];
		and[12][i].b <== eq[12][i].out;
		states[i+1][13] <== and[12][i].out;
		eq[13][i] = IsEqual();
		eq[13][i].in[0] <== in[i];
		eq[13][i].in[1] <== 45;
		and[13][i] = AND();
		and[13][i].a <== states[i][13];
		and[13][i].b <== eq[13][i].out;
		states[i+1][14] <== and[13][i].out;
		eq[14][i] = IsEqual();
		eq[14][i].in[0] <== in[i];
		eq[14][i].in[1] <== 56;
		and[14][i] = AND();
		and[14][i].a <== states[i][14];
		and[14][i].b <== eq[14][i].out;
		states[i+1][15] <== and[14][i].out;
		and[15][i] = AND();
		and[15][i].a <== states[i][15];
		and[15][i].b <== eq[9][i].out;
		states[i+1][16] <== and[15][i].out;
		eq[15][i] = IsEqual();
		eq[15][i].in[0] <== in[i];
		eq[15][i].in[1] <== 66;
		and[16][i] = AND();
		and[16][i].a <== states[i][16];
		and[16][i].b <== eq[15][i].out;
		states[i+1][17] <== and[16][i].out;
		and[17][i] = AND();
		and[17][i].a <== states[i][17];
		and[17][i].b <== eq[9][i].out;
		states[i+1][18] <== and[17][i].out;
		eq[16][i] = IsEqual();
		eq[16][i].in[0] <== in[i];
		eq[16][i].in[1] <== 87;
		and[18][i] = AND();
		and[18][i].a <== states[i][18];
		and[18][i].b <== eq[16][i].out;
		states[i+1][19] <== and[18][i].out;
		and[19][i] = AND();
		and[19][i].a <== states[i][19];
		and[19][i].b <== eq[16][i].out;
		states[i+1][20] <== and[19][i].out;
		eq[17][i] = IsEqual();
		eq[17][i].in[0] <== in[i];
		eq[17][i].in[1] <== 57;
		and[20][i] = AND();
		and[20][i].a <== states[i][20];
		and[20][i].b <== eq[17][i].out;
		states[i+1][21] <== and[20][i].out;
		eq[18][i] = IsEqual();
		eq[18][i].in[0] <== in[i];
		eq[18][i].in[1] <== 49;
		and[21][i] = AND();
		and[21][i].a <== states[i][21];
		and[21][i].b <== eq[18][i].out;
		states[i+1][22] <== and[21][i].out;
		and[22][i] = AND();
		and[22][i].a <== states[i][22];
		and[22][i].b <== eq[5][i].out;
		states[i+1][23] <== and[22][i].out;
		eq[19][i] = IsEqual();
		eq[19][i].in[0] <== in[i];
		eq[19][i].in[1] <== 105;
		and[23][i] = AND();
		and[23][i].a <== states[i][23];
		and[23][i].b <== eq[19][i].out;
		states[i+1][24] <== and[23][i].out;
		and[24][i] = AND();
		and[24][i].a <== states[i][24];
		and[24][i].b <== eq[15][i].out;
		states[i+1][25] <== and[24][i].out;
		eq[20][i] = IsEqual();
		eq[20][i].in[0] <== in[i];
		eq[20][i].in[1] <== 108;
		and[25][i] = AND();
		and[25][i].a <== states[i][25];
		and[25][i].b <== eq[20][i].out;
		states[i+1][26] <== and[25][i].out;
		eq[21][i] = IsEqual();
		eq[21][i].in[0] <== in[i];
		eq[21][i].in[1] <== 86;
		and[26][i] = AND();
		and[26][i].a <== states[i][26];
		and[26][i].b <== eq[21][i].out;
		states[i+1][27] <== and[26][i].out;
		eq[22][i] = IsEqual();
		eq[22][i].in[0] <== in[i];
		eq[22][i].in[1] <== 71;
		and[27][i] = AND();
		and[27][i].a <== states[i][27];
		and[27][i].b <== eq[22][i].out;
		states[i+1][28] <== and[27][i].out;
		and[28][i] = AND();
		and[28][i].a <== states[i][28];
		and[28][i].b <== eq[20][i].out;
		states[i+1][29] <== and[28][i].out;
		and[29][i] = AND();
		and[29][i].a <== states[i][29];
		and[29][i].b <== eq[3][i].out;
		states[i+1][30] <== and[29][i].out;
		eq[23][i] = IsEqual();
		eq[23][i].in[0] <== in[i];
		eq[23][i].in[1] <== 97;
		and[30][i] = AND();
		and[30][i].a <== states[i][30];
		and[30][i].b <== eq[23][i].out;
		states[i+1][31] <== and[30][i].out;
		eq[24][i] = IsEqual();
		eq[24][i].in[0] <== in[i];
		eq[24][i].in[1] <== 50;
		and[31][i] = AND();
		and[31][i].a <== states[i][31];
		and[31][i].b <== eq[24][i].out;
		states[i+1][32] <== and[31][i].out;
		and[32][i] = AND();
		and[32][i].a <== states[i][32];
		and[32][i].b <== eq[21][i].out;
		states[i+1][33] <== and[32][i].out;
		eq[25][i] = IsEqual();
		eq[25][i].in[0] <== in[i];
		eq[25][i].in[1] <== 48;
		and[33][i] = AND();
		and[33][i].a <== states[i][33];
		and[33][i].b <== eq[25][i].out;
		states[i+1][34] <== and[33][i].out;
		eq[26][i] = IsEqual();
		eq[26][i].in[0] <== in[i];
		eq[26][i].in[1] <== 73;
		and[34][i] = AND();
		and[34][i].a <== states[i][34];
		and[34][i].b <== eq[26][i].out;
		states[i+1][35] <== and[34][i].out;
		and[35][i] = AND();
		and[35][i].a <== states[i][35];
		and[35][i].b <== eq[22][i].out;
		states[i+1][36] <== and[35][i].out;
		and[36][i] = AND();
		and[36][i].a <== states[i][36];
		and[36][i].b <== eq[20][i].out;
		states[i+1][37] <== and[36][i].out;
		eq[27][i] = IsEqual();
		eq[27][i].in[0] <== in[i];
		eq[27][i].in[1] <== 122;
		and[37][i] = AND();
		and[37][i].a <== states[i][37];
		and[37][i].b <== eq[27][i].out;
		states[i+1][38] <== and[37][i].out;
		and[38][i] = AND();
		and[38][i].a <== states[i][38];
		and[38][i].b <== eq[26][i].out;
		states[i+1][39] <== and[38][i].out;
		eq[28][i] = IsEqual();
		eq[28][i].in[0] <== in[i];
		eq[28][i].in[1] <== 72;
		and[39][i] = AND();
		and[39][i].a <== states[i][39];
		and[39][i].b <== eq[28][i].out;
		states[i+1][40] <== and[39][i].out;
		eq[29][i] = IsEqual();
		eq[29][i].in[0] <== in[i];
		eq[29][i].in[1] <== 74;
		and[40][i] = AND();
		and[40][i].a <== states[i][40];
		and[40][i].b <== eq[29][i].out;
		states[i+1][41] <== and[40][i].out;
		and[41][i] = AND();
		and[41][i].a <== states[i][41];
		and[41][i].b <== eq[20][i].out;
		states[i+1][42] <== and[41][i].out;
		eq[30][i] = IsEqual();
		eq[30][i].in[0] <== in[i];
		eq[30][i].in[1] <== 89;
		and[42][i] = AND();
		and[42][i].a <== states[i][42];
		and[42][i].b <== eq[30][i].out;
		states[i+1][43] <== and[42][i].out;
		and[43][i] = AND();
		and[43][i].a <== states[i][43];
		and[43][i].b <== eq[16][i].out;
		states[i+1][44] <== and[43][i].out;
		eq[31][i] = IsEqual();
		eq[31][i].in[0] <== in[i];
		eq[31][i].in[1] <== 82;
		and[44][i] = AND();
		and[44][i].a <== states[i][44];
		and[44][i].b <== eq[31][i].out;
		states[i+1][45] <== and[44][i].out;
		eq[32][i] = IsEqual();
		eq[32][i].in[0] <== in[i];
		eq[32][i].in[1] <== 53;
		and[45][i] = AND();
		and[45][i].a <== states[i][45];
		and[45][i].b <== eq[32][i].out;
		states[i+1][46] <== and[45][i].out;
		eq[33][i] = IsEqual();
		eq[33][i].in[0] <== in[i];
		eq[33][i].in[1] <== 79;
		and[46][i] = AND();
		and[46][i].a <== states[i][46];
		and[46][i].b <== eq[33][i].out;
		states[i+1][47] <== and[46][i].out;
		and[47][i] = AND();
		and[47][i].a <== states[i][47];
		and[47][i].b <== eq[19][i].out;
		states[i+1][48] <== and[47][i].out;
		and[48][i] = AND();
		and[48][i].a <== states[i][48];
		and[48][i].b <== eq[15][i].out;
		states[i+1][49] <== and[48][i].out;
		and[49][i] = AND();
		and[49][i].a <== states[i][49];
		and[49][i].b <== eq[18][i].out;
		states[i+1][50] <== and[49][i].out;
		and[50][i] = AND();
		and[50][i].a <== states[i][50];
		and[50][i].b <== eq[5][i].out;
		states[i+1][51] <== and[50][i].out;
		and[51][i] = AND();
		and[51][i].a <== states[i][51];
		and[51][i].b <== eq[24][i].out;
		states[i+1][52] <== and[51][i].out;
		and[52][i] = AND();
		and[52][i].a <== states[i][52];
		and[52][i].b <== eq[10][i].out;
		states[i+1][53] <== and[52][i].out;
		eq[34][i] = IsEqual();
		eq[34][i].in[0] <== in[i];
		eq[34][i].in[1] <== 103;
		and[53][i] = AND();
		and[53][i].a <== states[i][53];
		and[53][i].b <== eq[34][i].out;
		states[i+1][54] <== and[53][i].out;
		and[54][i] = AND();
		and[54][i].a <== states[i][54];
		and[54][i].b <== eq[30][i].out;
		states[i+1][55] <== and[54][i].out;
		eq[35][i] = IsEqual();
		eq[35][i].in[0] <== in[i];
		eq[35][i].in[1] <== 109;
		and[55][i] = AND();
		and[55][i].a <== states[i][55];
		and[55][i].b <== eq[35][i].out;
		states[i+1][56] <== and[55][i].out;
		and[56][i] = AND();
		and[56][i].a <== states[i][56];
		and[56][i].b <== eq[17][i].out;
		states[i+1][57] <== and[56][i].out;
		eq[36][i] = IsEqual();
		eq[36][i].in[0] <== in[i];
		eq[36][i].in[1] <== 118;
		and[57][i] = AND();
		and[57][i].a <== states[i][57];
		and[57][i].b <== eq[36][i].out;
		states[i+1][58] <== and[57][i].out;
		and[58][i] = AND();
		and[58][i].a <== states[i][58];
		and[58][i].b <== eq[23][i].out;
		states[i+1][59] <== and[58][i].out;
		and[59][i] = AND();
		and[59][i].a <== states[i][59];
		and[59][i].b <== eq[24][i].out;
		states[i+1][60] <== and[59][i].out;
		and[60][i] = AND();
		and[60][i].a <== states[i][60];
		and[60][i].b <== eq[20][i].out;
		states[i+1][61] <== and[60][i].out;
		and[61][i] = AND();
		and[61][i].a <== states[i][61];
		and[61][i].b <== eq[1][i].out;
		states[i+1][62] <== and[61][i].out;
		eq[37][i] = IsEqual();
		eq[37][i].in[0] <== in[i];
		eq[37][i].in[1] <== 90;
		and[62][i] = AND();
		and[62][i].a <== states[i][62];
		and[62][i].b <== eq[37][i].out;
		states[i+1][63] <== and[62][i].out;
		eq[38][i] = IsEqual();
		eq[38][i].in[0] <== in[i];
		eq[38][i].in[1] <== 121;
		and[63][i] = AND();
		and[63][i].a <== states[i][63];
		and[63][i].b <== eq[38][i].out;
		states[i+1][64] <== and[63][i].out;
		and[64][i] = AND();
		and[64][i].a <== states[i][64];
		and[64][i].b <== eq[15][i].out;
		states[i+1][65] <== and[64][i].out;
		and[65][i] = AND();
		and[65][i].a <== states[i][65];
		and[65][i].b <== eq[38][i].out;
		states[i+1][66] <== and[65][i].out;
		and[66][i] = AND();
		and[66][i].a <== states[i][66];
		and[66][i].b <== eq[37][i].out;
		states[i+1][67] <== and[66][i].out;
		and[67][i] = AND();
		and[67][i].a <== states[i][67];
		and[67][i].b <== eq[16][i].out;
		states[i+1][68] <== and[67][i].out;
		and[68][i] = AND();
		and[68][i].a <== states[i][68];
		and[68][i].b <== eq[30][i].out;
		states[i+1][69] <== and[68][i].out;
		and[69][i] = AND();
		and[69][i].a <== states[i][69];
		and[69][i].b <== eq[34][i].out;
		states[i+1][70] <== and[69][i].out;
		lt[0][i] = LessEqThan(8);
		lt[0][i].in[0] <== 65;
		lt[0][i].in[1] <== in[i];
		lt[1][i] = LessEqThan(8);
		lt[1][i].in[0] <== in[i];
		lt[1][i].in[1] <== 90;
		and[70][i] = AND();
		and[70][i].a <== lt[0][i].out;
		and[70][i].b <== lt[1][i].out;
		lt[2][i] = LessEqThan(8);
		lt[2][i].in[0] <== 97;
		lt[2][i].in[1] <== in[i];
		lt[3][i] = LessEqThan(8);
		lt[3][i].in[0] <== in[i];
		lt[3][i].in[1] <== 122;
		and[71][i] = AND();
		and[71][i].a <== lt[2][i].out;
		and[71][i].b <== lt[3][i].out;
		eq[39][i] = IsEqual();
		eq[39][i].in[0] <== in[i];
		eq[39][i].in[1] <== 51;
		eq[40][i] = IsEqual();
		eq[40][i].in[0] <== in[i];
		eq[40][i].in[1] <== 52;
		eq[41][i] = IsEqual();
		eq[41][i].in[0] <== in[i];
		eq[41][i].in[1] <== 54;
		eq[42][i] = IsEqual();
		eq[42][i].in[0] <== in[i];
		eq[42][i].in[1] <== 55;
		and[72][i] = AND();
		and[72][i].a <== states[i][70];
		multi_or[0][i] = MultiOR(12);
		multi_or[0][i].in[0] <== and[70][i].out;
		multi_or[0][i].in[1] <== and[71][i].out;
		multi_or[0][i].in[2] <== eq[25][i].out;
		multi_or[0][i].in[3] <== eq[18][i].out;
		multi_or[0][i].in[4] <== eq[24][i].out;
		multi_or[0][i].in[5] <== eq[39][i].out;
		multi_or[0][i].in[6] <== eq[40][i].out;
		multi_or[0][i].in[7] <== eq[32][i].out;
		multi_or[0][i].in[8] <== eq[41][i].out;
		multi_or[0][i].in[9] <== eq[42][i].out;
		multi_or[0][i].in[10] <== eq[14][i].out;
		multi_or[0][i].in[11] <== eq[17][i].out;
		and[72][i].b <== multi_or[0][i].out;
		and[73][i] = AND();
		and[73][i].a <== states[i][71];
		and[73][i].b <== multi_or[0][i].out;
		multi_or[1][i] = MultiOR(2);
		multi_or[1][i].in[0] <== and[72][i].out;
		multi_or[1][i].in[1] <== and[73][i].out;
		states[i+1][71] <== multi_or[1][i].out;
		from_zero_enabled[i] <== MultiNOR(71)([states_tmp[i+1][1], states[i+1][2], states[i+1][3], states[i+1][4], states[i+1][5], states[i+1][6], states[i+1][7], states[i+1][8], states[i+1][9], states[i+1][10], states[i+1][11], states[i+1][12], states[i+1][13], states[i+1][14], states[i+1][15], states[i+1][16], states[i+1][17], states[i+1][18], states[i+1][19], states[i+1][20], states[i+1][21], states[i+1][22], states[i+1][23], states[i+1][24], states[i+1][25], states[i+1][26], states[i+1][27], states[i+1][28], states[i+1][29], states[i+1][30], states[i+1][31], states[i+1][32], states[i+1][33], states[i+1][34], states[i+1][35], states[i+1][36], states[i+1][37], states[i+1][38], states[i+1][39], states[i+1][40], states[i+1][41], states[i+1][42], states[i+1][43], states[i+1][44], states[i+1][45], states[i+1][46], states[i+1][47], states[i+1][48], states[i+1][49], states[i+1][50], states[i+1][51], states[i+1][52], states[i+1][53], states[i+1][54], states[i+1][55], states[i+1][56], states[i+1][57], states[i+1][58], states[i+1][59], states[i+1][60], states[i+1][61], states[i+1][62], states[i+1][63], states[i+1][64], states[i+1][65], states[i+1][66], states[i+1][67], states[i+1][68], states[i+1][69], states[i+1][70], states[i+1][71]]);
		states[i+1][1] <== MultiOR(2)([states_tmp[i+1][1], from_zero_enabled[i] * and[0][i].out]);
		state_changed[i].in[0] <== states[i+1][1];
		state_changed[i].in[1] <== states[i+1][2];
		state_changed[i].in[2] <== states[i+1][3];
		state_changed[i].in[3] <== states[i+1][4];
		state_changed[i].in[4] <== states[i+1][5];
		state_changed[i].in[5] <== states[i+1][6];
		state_changed[i].in[6] <== states[i+1][7];
		state_changed[i].in[7] <== states[i+1][8];
		state_changed[i].in[8] <== states[i+1][9];
		state_changed[i].in[9] <== states[i+1][10];
		state_changed[i].in[10] <== states[i+1][11];
		state_changed[i].in[11] <== states[i+1][12];
		state_changed[i].in[12] <== states[i+1][13];
		state_changed[i].in[13] <== states[i+1][14];
		state_changed[i].in[14] <== states[i+1][15];
		state_changed[i].in[15] <== states[i+1][16];
		state_changed[i].in[16] <== states[i+1][17];
		state_changed[i].in[17] <== states[i+1][18];
		state_changed[i].in[18] <== states[i+1][19];
		state_changed[i].in[19] <== states[i+1][20];
		state_changed[i].in[20] <== states[i+1][21];
		state_changed[i].in[21] <== states[i+1][22];
		state_changed[i].in[22] <== states[i+1][23];
		state_changed[i].in[23] <== states[i+1][24];
		state_changed[i].in[24] <== states[i+1][25];
		state_changed[i].in[25] <== states[i+1][26];
		state_changed[i].in[26] <== states[i+1][27];
		state_changed[i].in[27] <== states[i+1][28];
		state_changed[i].in[28] <== states[i+1][29];
		state_changed[i].in[29] <== states[i+1][30];
		state_changed[i].in[30] <== states[i+1][31];
		state_changed[i].in[31] <== states[i+1][32];
		state_changed[i].in[32] <== states[i+1][33];
		state_changed[i].in[33] <== states[i+1][34];
		state_changed[i].in[34] <== states[i+1][35];
		state_changed[i].in[35] <== states[i+1][36];
		state_changed[i].in[36] <== states[i+1][37];
		state_changed[i].in[37] <== states[i+1][38];
		state_changed[i].in[38] <== states[i+1][39];
		state_changed[i].in[39] <== states[i+1][40];
		state_changed[i].in[40] <== states[i+1][41];
		state_changed[i].in[41] <== states[i+1][42];
		state_changed[i].in[42] <== states[i+1][43];
		state_changed[i].in[43] <== states[i+1][44];
		state_changed[i].in[44] <== states[i+1][45];
		state_changed[i].in[45] <== states[i+1][46];
		state_changed[i].in[46] <== states[i+1][47];
		state_changed[i].in[47] <== states[i+1][48];
		state_changed[i].in[48] <== states[i+1][49];
		state_changed[i].in[49] <== states[i+1][50];
		state_changed[i].in[50] <== states[i+1][51];
		state_changed[i].in[51] <== states[i+1][52];
		state_changed[i].in[52] <== states[i+1][53];
		state_changed[i].in[53] <== states[i+1][54];
		state_changed[i].in[54] <== states[i+1][55];
		state_changed[i].in[55] <== states[i+1][56];
		state_changed[i].in[56] <== states[i+1][57];
		state_changed[i].in[57] <== states[i+1][58];
		state_changed[i].in[58] <== states[i+1][59];
		state_changed[i].in[59] <== states[i+1][60];
		state_changed[i].in[60] <== states[i+1][61];
		state_changed[i].in[61] <== states[i+1][62];
		state_changed[i].in[62] <== states[i+1][63];
		state_changed[i].in[63] <== states[i+1][64];
		state_changed[i].in[64] <== states[i+1][65];
		state_changed[i].in[65] <== states[i+1][66];
		state_changed[i].in[66] <== states[i+1][67];
		state_changed[i].in[67] <== states[i+1][68];
		state_changed[i].in[68] <== states[i+1][69];
		state_changed[i].in[69] <== states[i+1][70];
		state_changed[i].in[70] <== states[i+1][71];
	}

	component is_accepted = MultiOR(num_bytes+1);
	for (var i = 0; i <= num_bytes; i++) {
		is_accepted.in[i] <== states[i][71];
	}
	out <== is_accepted.out;
	signal is_consecutive[msg_bytes+1][3];
	is_consecutive[msg_bytes][2] <== 0;
	for (var i = 0; i < msg_bytes; i++) {
		is_consecutive[msg_bytes-1-i][0] <== states[num_bytes-i][71] * (1 - is_consecutive[msg_bytes-i][2]) + is_consecutive[msg_bytes-i][2];
		is_consecutive[msg_bytes-1-i][1] <== state_changed[msg_bytes-i].out * is_consecutive[msg_bytes-1-i][0];
		is_consecutive[msg_bytes-1-i][2] <== ORAnd()([(1 - from_zero_enabled[msg_bytes-i+1]), states[num_bytes-i][71], is_consecutive[msg_bytes-1-i][1]]);
	}
	// substrings calculated: [{(70, 71), (71, 71)}]
	signal prev_states0[2][msg_bytes];
	signal is_substr0[msg_bytes];
	signal is_reveal0[msg_bytes];
	signal output reveal0[msg_bytes];
	for (var i = 0; i < msg_bytes; i++) {
		 // the 0-th substring transitions: [(70, 71), (71, 71)]
		prev_states0[0][i] <== (1 - from_zero_enabled[i+1]) * states[i+1][70];
		prev_states0[1][i] <== (1 - from_zero_enabled[i+1]) * states[i+1][71];
		is_substr0[i] <== MultiOR(2)([prev_states0[0][i] * states[i+2][71], prev_states0[1][i] * states[i+2][71]]);
		is_reveal0[i] <== MultiAND(3)([out, is_substr0[i], is_consecutive[i][2]]);
		reveal0[i] <== in[i+1] * is_reveal0[i];
	}
}