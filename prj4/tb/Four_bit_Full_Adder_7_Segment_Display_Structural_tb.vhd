library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Four_bit_Full_Adder_7_Segment_Display_Structural_tb is
end entity;

architecture sim of Four_bit_Full_Adder_7_Segment_Display_Structural_tb is

	signal 	    SW	     :	std_logic_vector(8 downto 0) := (others => '0');
	signal 	    LEDR     :  std_logic_vector(9 downto 0) := (others => '0');
	signal	    HEX0     :  std_logic_vector(7 downto 0) := (others => '1');
	signal	    HEX1     :  std_logic_vector(7 downto 0) := (others => '1');
	signal	    HEX3     :  std_logic_vector(7 downto 0) := (others => '1');
	signal	    HEX5     :  std_logic_vector(7 downto 0) := (others => '1');
	
begin
	-- DUT
	I_FA : entity work.Four_bit_Full_Adder_7_Segment_Display_Structural(rtl) 
	port map(
		SW 		=> SW,
		LEDR    => LEDR, 
		HEX0    => HEX0,
		HEX1    => HEX1,
		HEX3    => HEX3,
		HEX5    => HEX5
		);
		
	-- Test bench sequence
	process
	begin
		for i in 1 to 100+1 loop
			SW <= std_logic_vector(unsigned(SW) + 1);
			wait for 10 ns;
		end loop;
		
		wait;
	end process;
		
		
end architecture;