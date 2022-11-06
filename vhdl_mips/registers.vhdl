library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registers is
	port
	(
		clk				: in  std_logic;
		rst				: in  std_logic;
		regwrite			: in  std_logic;
		readreg1			: in  std_logic_vector ( 4 downto 0);
		readreg2			: in  std_logic_vector ( 4 downto 0);
		writereg			: in  std_logic_vector ( 4 downto 0);
		writedata			: in  std_logic_vector (31 downto 0);
		readdata1			: out std_logic_vector (31 downto 0);
		readdata2			: out std_logic_vector (31 downto 0)
	);
end registers;

architecture behavior of registers is
	type registerfile is array (1 to 31) of std_logic_vector (31 downto 0);
	signal registers			: registerfile;
	signal selector1, selector2, selector3	: natural range 0 to 31;
begin
	selector1 <= to_integer (unsigned (readreg1));
	selector2 <= to_integer (unsigned (readreg2));
	selector3 <= to_integer (unsigned (writereg));

	process (clk, rst, regwrite, readreg1, readreg2, writereg, writedata)
	begin
		if (rising_edge (clk)) then
			if (rst = '1') then
				for i in 1 to 31 loop
					registers (i) <= std_logic_vector (to_unsigned (0, 32));
				end loop;
			else
				if (regwrite = '1' and selector3 /= 0) then
					registers (selector3) <= writedata;
				end if;
			end if;
		end if;
	end process;

	with selector1 select
		readdata1 <=	std_logic_vector (to_unsigned (0, 32))	when 0,
				registers (selector1) 			when others;
	with selector2 select
		readdata2 <=	std_logic_vector (to_unsigned (0, 32))	when 0,
				registers (selector2)			when others;

end behavior;
