

module snakeGameV3(
	output reg[0:7] LedR,LedG,LedB,
	output reg[2:0] comm,
	output reg enable,
	output reg [7:0] point,
	input SYS_CLK,RST,PAUSE,UP,DOWN,LEFT,RIGHT);
	
	reg [1:0]state;//01 is gameing 10 is end
	
	reg game_clk;
	reg led_clk;	
	
	reg [7:0] map [7:0];// LED map 8*8  map[x][~y]
	
	reg [2:0] X,Y;//snake head pos
	reg [2:0] body_mem_x[63:0]; //postion of X *64
	reg [2:0] body_mem_y[63:0]; //postion of Y *64
	reg [5:0]length;		//include head
	
	reg [2:0] item_x,item_y;
//	reg got_item;

	reg pass;
	reg [7:0] pass_pic [7:0];
	
	reg [6:0] i;
	reg [5:0] j;
	//reg ISPAUSED;
	
	reg [24:0] led_counter;
	reg [24:0] move_counter;
	reg [1:0] move_dir;
	
	
	
	integer led_count_to =50000;//led clk  1khz display
	integer count_to = 4500000; //game_clk 0.5hz
	
	initial begin
		//initial Led
		LedR = 8'b11111111;
		LedG = 8'b11111111;
		LedB = 8'b11111111;
		enable = 1'b1;
		comm = 3'b000;
		
		pass= 1'b0;
		
		pass_pic[3'b000]=8'b00000000;
		pass_pic[3'b001]=8'b11110110;
		pass_pic[3'b010]=8'b11110110;
		pass_pic[3'b011]=8'b11110110;
		pass_pic[3'b100]=8'b11110110;
		pass_pic[3'b101]=8'b11110110;
		pass_pic[3'b110]=8'b11110110;
		pass_pic[3'b111]=8'b11110000;
		/*
		map[3'b000] = 8'b00011001;
		map[3'b001] = 8'b00011001;
		map[3'b010] = 8'b00011001;
		map[3'b011] = 8'b00011001;
		map[3'b100] = 8'b00011001;
		map[3'b110] = 8'b00011001;
		map[3'b111] = 8'b00011001;
		
		map[3'b101][~3'b100]=1'b1;
		map[3'b101][~3'b101]=1'b1;
		map[3'b101][~3'b110]=1'b1;
		map[3'b101][~3'b111]=1'b1;
		*/
		//map[3'b101] = 8'b00011000;
//
		////initial [2,2] to the start pos
		map[3'b010][~3'b010]=1'b1;//head
		map[3'b001][~3'b010]=1'b1;//body
		map[3'b000][~3'b010]=1'b1;//body

		
		item_x = 3'b110;
		item_y = 3'b110;
		
		point =8'b00000000;
		
		X = 3'b010;
		Y = 3'b010;
		//head
		body_mem_x[0] =3'b010;
		body_mem_y[0] =3'b010;
		//body1
		body_mem_x[1] =3'b010;
		body_mem_y[1] =3'b001;		
		//body2
		body_mem_x[2] =3'b010;
		body_mem_y[2] =3'b000;		
		length = 3;
		state =2'b01;
		move_dir = 2'b00;//when game start ,snake dir//
	end
	
	
//////system clk to game_clk and led_clk
	always @(posedge SYS_CLK) begin
		/*
		if(RST == 1'b1) begin
			move_counter <= 0;
			game_clk <= 0;
			//ISPAUSED <= 1;
		end else */
		if(PAUSE == 1'b1) ; // Do nothing to counter if paused  //ISPAUSED <= 1 
	/*	else if(point ==8'b11111111) begin
			game_clk <= 0;
			pass = 1'b1;*/
		else if(move_counter < count_to) begin
			//ISPAUSED <= 0;
			move_counter <= move_counter+1;
		end
		else begin
			//ISPAUSED <= 0;
			game_clk <= ~game_clk;
			move_counter <= 25'b0;
		end
		
		//led	clk
		if(led_counter < led_count_to)
			led_counter <= led_counter + 1;
		else	begin
			led_counter <= 25'b0;
			led_clk <= ~led_clk;
		end
	end	
	


	/////8*8LED display
/////change comm(s0s1s2)
	always @(posedge led_clk) begin/**/		
		if(comm == 3'b111) comm <= 3'b000;
		else 	begin			
			comm <= comm + 1'b1;
		end					
	end	
//// print map info to led
	always@(comm) begin
		
		if(state==2'b10) begin
		/*	LedG=pass_pic[comm];
			LedB=8'b11111111;
			LedR=8'b11111111;*/
			LedG = ~map[comm];
		end else 
			LedB = ~map[comm];
		if(comm == item_x ) LedR[item_y] = 1'b0;
		else LedR =8'b11111111;
		
	end
	

	
	
//// update mover direction	
  always @( UP or DOWN or LEFT or RIGHT) begin // 這四個方向不能都用"posedge"

		if(UP == 1'b1 && DOWN !=1'b1 && LEFT != 1'b1 && RIGHT != 1'b1 && move_dir != 2'b01)     move_dir = 2'b00;  
		else if(DOWN == 1'b1  && UP !=1'b1 && LEFT != 1'b1 && RIGHT != 1'b1 && move_dir != 2'b00)  move_dir = 2'b01; 
		else if(LEFT == 1'b1 && UP !=1'b1 && DOWN != 1'b1 && RIGHT != 1'b1 && move_dir != 2'b11)   move_dir = 2'b10; 
		else if(RIGHT == 1'b1 && UP != 1'b1 && DOWN !=1'b1 && LEFT != 1'b1 &&  move_dir != 2'b10 ) move_dir = 2'b11; 
		else ;
  end
  
 
////game_clk gamebody
	always@(posedge game_clk) begin
	/*	 if(RST ==1'b1) begin
			move_dir = 2'b00;
			map[body_mem_x[0]][body_mem_y[0]]=0;
			map[body_mem_x[1]][body_mem_y[1]]=0;
			map[body_mem_x[2]][body_mem_y[2]]=0;
			//map[3'b010][~3'b010]=1'b1;

			point =8'b00000000;
			item_x = 3'b110;
			item_y = 3'b110;		
			
			X = 3'b010;
			Y = 3'b010;

			//head
			body_mem_x[0] =3'b010;
			body_mem_y[0] =3'b010;
			//body1
			body_mem_x[1] =3'b010;
			body_mem_y[1] =3'b001;		
			//body2
			body_mem_x[2] =3'b010;
			body_mem_y[2] =3'b000;		
			length = 3;
		end else begin*/
	
			if(move_dir == 2'b00) Y <= Y+1;
			else if(move_dir == 2'b01) Y <= Y-1;
			else if(move_dir == 2'b10) X <= X-1;
			else if(move_dir == 2'b11) X <= X+1;
			//else Y<=Y+1;end
		
		/*
		case(move_dir)
        2'b00 : Y <= Y+1;
        2'b01 : Y <= Y-1;
        2'b10 : X <= X-1;
        2'b11 : X <= X+1;
      endcase
		*/
		
	
	
/**/
// update snake body
	//always@(X or Y) begin
		//length = length +1;
		
		//update map
			map[X][~Y] <= 1'b1;
			
			if(point<8'b00000001)	state=2'b01;
			//get item
			if(X==item_x && Y==item_y) begin
				if(point>8'b11111110) state=2'b10;
				point = point*2 + 1'b1;
				
				//change item pos
				if(move_dir==2'b00 || move_dir == 2'b01) begin	
					item_x = X +3'b011 +game_clk*2;
					item_y = Y -3'b011 +game_clk;
				end else begin
					item_x = X -3'b011 -game_clk;
					item_y = Y +3'b011 -game_clk*2;
				end
			end
			
////		
//			if(got_item == 1'b1) begin
//				length = length+1;				
//			end else begin	
			map[body_mem_x[length-1]][~body_mem_y[length-1]] = 1'b0;				
//			end
//			if(length > 1) begin
			for(i = 1; i < length;i = i+1) begin
				body_mem_x[length-i] <= body_mem_x[length-i-1];
				body_mem_y[length-i] <= body_mem_y[length-i-1];
			end
//			end 
			body_mem_x[0] = X;
			body_mem_y[0] = Y;

			
	end
	//
endmodule
	
	
	