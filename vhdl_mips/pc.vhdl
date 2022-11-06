library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc is
	port
	(
		clk		: in  std_logic;
		rst		: in  std_logic;
		jump		: in  std_logic;
		pc_in		: in  std_logic_vector (31 downto 0);
		pc_add		: out std_logic_vector (31 downto 0);
		pc		: out std_logic_vector (31 downto 0)
	);
end pc;

architecture behavior of pc is
	signal current_pc, next_pc, add_pc	: unsigned (31 downto 0);
begin
	pc <= std_logic_vector (current_pc);
	pc_add <= std_logic_vector (add_pc);

	process (clk, rst)
	begin
		if (rising_edge (clk)) then
			if (rst = '1') then
				current_pc <= to_unsigned (0, 32);
			else
				current_pc <= next_pc;
			end if;
		end if;
	end process;

	add_pc <= current_pc + to_unsigned (4, 32);

	with jump select
		next_pc <=	unsigned (pc_in)	when '1',
				add_pc 			when others;
end behavior;
