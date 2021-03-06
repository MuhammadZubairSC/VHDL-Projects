library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Four_bit_Full_Adder_LED_Display_tb is
end entity;

architecture sim of Four_bit_Full_Adder_LED_Display_tb is

	signal 	    SW		 :  std_logic_vector(8 downto 0) := (others => '0');
	signal 	    LEDR	 :  std_logic_vector(4 downto 0) := (others => '0');
	
begin
	-- DUT
	I_FA : entity work.Four_bit_Full_Adder_LED_Display(rtl) 
	port map(
		SW 	=> SW,
		LEDR    => LEDR
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