library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Four_bit_Ful_Adder_7_Segment_Display_Behavioral is
port(
		SW  :	in std_logic_vector(8 downto 0);
	
		-- The MSB of HEX is the anode therefore they are 8 intead of 7
		-- Here the pin are active low as mentioned in the datasheet
		
	   LEDR	    :   out std_logic_vector(9 downto 0);
	   HEX0     :   out std_logic_vector(7 downto 0);
	   HEX1     :   out std_logic_vector(7 downto 0);
	   HEX3     :   out std_logic_vector(7 downto 0);
	   HEX5     :   out std_logic_vector(7 downto 0)
);
end entity;

architecture rtl of Four_bit_Ful_Adder_7_Segment_Display_Behavioral is

	signal A	    : integer; -- BCD
	signal B	    : integer; -- BCD
	signal T0	    : integer; -- BCD
	signal Z0	    : integer := 0; -- BCD
	signal Asw      : std_logic_vector(3 downto 0); -- Output of A and B
	signal Bsw      : std_logic_vector(3 downto 0); -- Output of A and B
	
	
	signal S1	    : integer; -- BCD
	signal S0	    : integer; -- BCD
	signal C0	    : std_logic_vector(3 downto 0); 
	signal C1	    : integer := 0;
	
	begin
	
		Asw 	<= SW(7 downto 4);
		Bsw 	<= SW(3 downto 0);
		A 		<= to_integer(unsigned(Asw));
		B 		<= to_integer(unsigned(Bsw));
		C0 		<= "000"&SW(8);
		T0 		<= A + B + to_integer(unsigned(C0));
		
		
		-- Process for turning on LEDR9
		process(A, B) is 
		begin
			If A>9 or B>9 then
				LEDR(9 downto 5) <= "10000";
				HEX3             <= "11111111";
				HEX5             <= "11111111";
			else
				LEDR(9 downto 5) <= "00000";
				
				case Asw is
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
				
				case Bsw is
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
		
		process(T0) is 
		begin
			
			If T0 > 9 then
				Z0 <= 10;
				C1 <= 1;
			else
				Z0 <= 0;
				C1 <= 0;
			end if;
		end process;
		
		process(T0, Z0) is 
		variable S1sw     : std_logic_vector(3 downto 0); -- Output of A and B
		variable S0sw     : std_logic_vector(3 downto 0); -- Output of A and B
		begin
			S0 <= T0 - Z0;
			S1 <= C1;
				
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
			
		end process;
	
end architecture;



