library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity TrafficLightSignal_tb is
end entity;



architecture sim of TrafficLightSignal_tb is

	--We're slowing down th clock to speed up simulation time
	constant ClockFreq  : integer := 50000000; -- 10 Hz
	
	constant ClockPeriod : time := 1000 ms / ClockFreq;
	
	signal clk 			: std_logic := '1';
	signal nrst			: std_logic := '0';
	signal NorthRed		: std_logic;
	signal NorthYellow	: std_logic;
	signal NorthGreen	: std_logic;
	signal WestRed		: std_logic;
	signal WestYellow	: std_logic;
	signal WestGreen	: std_logic;
	
	
	
begin

	-- Instance the device under test (DUT)
	I_trafficLight : entity work.TrafficLightSignal(rtl)
	generic map	(ClockFreq => ClockFreq)
	port map(
		clk 		=> clk,
		nrst  		=> nrst,
		NorthRed	=> NorthRed,	
		NorthYellow	=> NorthYellow,	
		NorthGreen	=> NorthGreen,	
		WestRed		=> WestRed,		
		WestYellow	=> WestYellow,	
		WestGreen	=> WestGreen	
		);


		
	-- Process for generating a clock
	clk <= not clk after ClockPeriod/2;
	
	-- Test bench sequence
	process
	begin
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		
		-- Take DUT ut of reset
		nrst 	<= '1';
		
		wait;
	end process;
	
	
end architecture;
