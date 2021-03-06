library ieee;
use ieee.std_logic_1164.all;

entity Binary_to_BCD_7_Segment_Display is
port(
		SW:	in std_logic_vector(7 downto 0);
	
		-- The MSB of HEX is the anode therefore they are 8 intead of 7
		-- Here the pin are active low as mentioned in the datasheet
		
	   HEX1: out std_logic_vector(7 downto 0);
	   HEX0: out std_logic_vector(7 downto 0)
);
end entity;

architecture rtl of Binary_to_BCD_7_Segment_Display is

	signal SW_LSB	: std_logic_vector(3 downto 0);
	signal SW_MSB	: std_logic_vector(3 downto 0);
	
begin
	-- process statement
	
	process(SW)
	begin
		SW_LSB <= SW(3 downto 0);
		SW_MSB <= SW(7 downto 4);
		-- use case statement
		
		case SW_LSB is
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
			when others => 
				HEX0 <= "11111111";
			end case;
			
		case SW_MSB is
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
			when others => 
				HEX1 <= "11111111";
			end case;
		
	end process;
	
end architecture;