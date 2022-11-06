library IEEE;
use IEEE.std_logic_1164.ALL;

entity mips_tb is
end mips_tb;

architecture behaviour of mips_tb is

component mips
	port
	(
		clk		: in  std_logic;   
		rst		: in  std_logic
	);
end component;

	signal	clk		: std_logic;   
	signal	rst		: std_logic;     

begin

	mips_0:		mips port map (	clk	=> clk,
					rst	=> rst);

	clk		<=	'1' after  0 ns,
				'0' after  1 ns when clk /= '0' else '1' after  1 ns;
	rst		<=	'1' after  0 ns,
				'0' after  10 ns;

end behaviour;
