library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Four_bit_Full_Adder_7_Segment_Display_Structural is
port(
	   SW       : in std_logic_vector(8 downto 0);
	   LEDR	    : out std_logic_vector(9 downto 0);
	   HEX0     : out std_logic_vector(7 downto 0);
	   HEX1     : out std_logic_vector(7 downto 0);
	   HEX3     : out std_logic_vector(7 downto 0);
	   HEX5     : out std_logic_vector(7 downto 0)
);
end entity;

architecture rtl of Four_bit_Full_Adder_7_Segment_Display_Structural is

	signal X	    : integer; -- BCD
	signal Y	    : integer; -- BCD
	signal xy	    : integer; -- BCD
	signal Xsw      : std_logic_vector(3 downto 0); -- Output of X and Y
	signal Ysw      : std_logic_vector(3 downto 0); -- Output of X and Y
	
	
	signal S1	  : integer; -- BCD
	signal S0	  : integer; -- BCD
	signal Cin	  : std_logic;
	signal Cout	  : std_logic;
	signal Sot    : std_logic_vector(3 downto 0); -- Output of X and Y
	signal Sout   : std_logic_vector(4 downto 0); -- Output of X and Y
	signal Sout_i : integer; -- Output of X and Y
	
	component C4M1P3  is 
	port (
			A		: in std_logic_vector(3 downto 0);
			B		: in std_logic_vector(3 downto 0);
			Cin		: in std_logic;
			Sot		: out std_logic_vector(3 downto 0);
			Cout	: out std_logic
			);
	end component;
	
	begin
	
		Xsw 	<= SW(7 downto 4);
		Ysw 	<= SW(3 downto 0);
		X 		<= to_integer(unsigned(Xsw));
		Y 		<= to_integer(unsigned(Ysw));
		Cin 	<= SW(8);
		xy <= X + Y;
		
		Adding: C4M1P3 port map(A=>Xsw, B=>Ysw, Cin=>Cin ,Sot=>Sot ,Cout=>Cout);
		LEDR(4)		        <=	Cout;
		LEDR(3 downto 0)	<=	Sot;
		Sout 				<=  Cout&Sot;
		Sout_i 				<=  to_integer(unsigned(Cout&Sot));
		
		-- Process for turning on LEDR9
		process(X,Y) is 
		begin
			If X>9 or Y>9 then
				LEDR(9 downto 5) <= "10000";
				HEX3             <= "11111111";
				HEX5             <= "11111111";
			else
				LEDR(9 downto 5) <= "00000";
				
				case Xsw is
					when "0000" => HEX5 <= "11000000"; -- 0
					when "0001" => HEX5 <= "11111001"; -- 1
					when "0010" => HEX5 <= "10100100"; -- 2
					when "0011" => HEX5 <= "10110000"; -- 3
					when "0100" => HEX5 <= "10011001"; -- 4
					when "0101" => HEX5 <= "10010010"; -- 5
					when "0110" => HEX5 <= "10000010"; -- 6
					when "0111" => HEX5 <= "11111000"; -- 7
					when "1000" => HEX5 <= "10000000"; -- 8
					when "1001" => HEX5 <= "10010000"; -- 9
					when others => HEX5 <= "11111111";
				end case;
				
				case Ysw is
					when "0000" => HEX3 <= "11000000"; -- 0
					when "0001" => HEX3 <= "11111001"; -- 1
					when "0010" => HEX3 <= "10100100"; -- 2
					when "0011" => HEX3 <= "10110000"; -- 3
					when "0100" => HEX3 <= "10011001"; -- 4
					when "0101" => HEX3 <= "10010010"; -- 5
					when "0110" => HEX3 <= "10000010"; -- 6
					when "0111" => HEX3 <= "11111000"; -- 7
					when "1000" => HEX3 <= "10000000"; -- 8
					when "1001" => HEX3 <= "10010000"; -- 9
					when others => HEX3 <= "11111111";
				end case;
				
			end if;
		end process;
		
		process(Sout_i) is 
		variable S1sw     : std_logic_vector(3 downto 0); -- Output of X and Y
		variable S0sw     : std_logic_vector(3 downto 0); -- Output of X and Y
		begin
			If Sout_i <= 19 then
				if Sout_i>9 then
					S0  <= Sout_i - 10;
					S1  <= 1;
				else
					S0 <= Sout_i;
					S1 <= 0;
				end if;
				
				if    S0 = 0 then
					S0sw := "0000";
				elsif S0 = 1 then
					S0sw := "0001";
				elsif S0 = 2 then
					S0sw := "0010";
				elsif S0 = 3 then
					S0sw := "0011";
				elsif S0 = 4 then
					S0sw := "0100";
				elsif S0 = 5 then
					S0sw := "0101";
				elsif S0 = 6 then
					S0sw := "0110";
				elsif S0 = 7 then
					S0sw := "0111";
				elsif S0 = 8 then
					S0sw := "1000";
				elsif S0 = 9 then
					S0sw := "1001";
				else
					S0sw := "0000";
				end if;
				
				if 	  S1 = 0 then
					S1sw := "0000";
				elsif S1 = 1 then
					S1sw := "0001";
				elsif S1 = 2 then
					S1sw := "0010";
				elsif S1 = 3 then
					S1sw := "0011";
				elsif S1 = 4 then
					S1sw := "0100";
				elsif S1 = 5 then
					S1sw := "0101";
				elsif S1 = 6 then
					S1sw := "0110";
				elsif S1 = 7 then
					S1sw := "0111";
				elsif S1 = 8 then
					S1sw := "1000";
				elsif S1 = 9 then
					S1sw := "1001";
				else
					S1sw := "0000";
				end if;
				
				case S1sw is
					when "0000" => HEX1 <= "11000000"; -- 0
					when "0001" => HEX1 <= "11111001"; -- 1
					when "0010" => HEX1 <= "10100100"; -- 2
					when "0011" => HEX1 <= "10110000"; -- 3
					when "0100" => HEX1 <= "10011001"; -- 4
					when "0101" => HEX1 <= "10010010"; -- 5
					when "0110" => HEX1 <= "10000010"; -- 6
					when "0111" => HEX1 <= "11111000"; -- 7
					when "1000" => HEX1 <= "10000000"; -- 8
					when "1001" => HEX1 <= "10010000"; -- 9
					when others => HEX1 <= "11111111";
				end case;
				
				case S0sw is
					when "0000" => HEX0 <= "11000000"; -- 0
					when "0001" => HEX0 <= "11111001"; -- 1
					when "0010" => HEX0 <= "10100100"; -- 2
					when "0011" => HEX0 <= "10110000"; -- 3
					when "0100" => HEX0 <= "10011001"; -- 4
					when "0101" => HEX0 <= "10010010"; -- 5
					when "0110" => HEX0 <= "10000010"; -- 6
					when "0111" => HEX0 <= "11111000"; -- 7
					when "1000" => HEX0 <= "10000000"; -- 8
					when "1001" => HEX0 <= "10010000"; -- 9
					when others => HEX0 <= "11111111";
				end case;
				
			end if;
			
		end process;
	
end architecture;



library ieee;
use ieee.std_logic_1164.all;

entity C4M1P3 is
port(
		A	    : in std_logic_vector(3 downto 0);
		B	    : in std_logic_vector(3 downto 0);
		Cin	    : in std_logic;
		Sot		: out std_logic_vector(3 downto 0);
		Cout	: out std_logic
);
end entity;

architecture C4M1P3_rtl of C4M1P3 is

	signal temp1, temp2, temp3 : std_logic;
	
	component fullAdder  is 
	port (
			a,b,cin 	: in std_logic;
			sout,cout	: out std_logic
			);
	end component;
	
begin
	-- Port maping
	F0:fullAdder port map(a=>A(0), b=>B(0), cin=>Cin,   cout=>temp1, sout => Sot(0));
	F1:fullAdder port map(a=>A(1), b=>B(1), cin=>temp1, cout=>temp2, sout => Sot(1));
	F2:fullAdder port map(a=>A(2), b=>B(2), cin=>temp2, cout=>temp3, sout => Sot(2));
	F3:fullAdder port map(a=>A(3), b=>B(3), cin=>temp3, cout=>Cout , sout => Sot(3));
		
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity fullAdder is
port(
		a,b,cin 	: in std_logic;
		sout,cout	: out std_logic
);
end entity;

architecture full_adder_rtl of fullAdder is
begin
	sout <= a xor b xor cin;
	cout <= (a and b) or (cin and (a or b));
		
end architecture;