library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory is
	port
	(
		clk			: in  std_logic;
		rst			: in  std_logic;
		memread			: in  std_logic;
		memwrite		: in  std_logic;
		address1		: in  std_logic_vector (31 downto 0);
		address2		: in  std_logic_vector (31 downto 0);
		writedata		: in  std_logic_vector (31 downto 0);
		instruction		: out std_logic_vector (31 downto 0);
		readdata		: out std_logic_vector (31 downto 0)
	);
end memory;

architecture behavior of memory is
	type ramcell is array (0 to 255) of std_logic_vector (7 downto 0);
	signal ram			: ramcell;
	signal masked1, masked2		: std_logic_vector (7 downto 0);
	signal selector1, selector2	: natural range 0 to 255;
begin
	masked1 <= address1 (7 downto 2) & "00";
	masked2 <= address2 (7 downto 2) & "00";
	selector1 <= to_integer (unsigned (masked1));
	selector2 <= to_integer (unsigned (masked2));

	process (clk, rst, memread, memwrite, address1, address2, writedata)
	begin
		if (rising_edge (clk)) then
			if (rst = '1') then
				ram (  0) <= "00000101"; -- addi $1,$0,5
				ram (  1) <= "00000000";
				ram (  2) <= "00000001";
				ram (  3) <= "00100000";
				ram (  4) <= "00001010"; -- addi $2,$0,10
				ram (  5) <= "00000000";
				ram (  6) <= "00000010";
				ram (  7) <= "00100000";
				ram (  8) <= "00101010"; -- slt $3,$1,$2
				ram (  9) <= "00011000";
				ram ( 10) <= "00100010";
				ram ( 11) <= "00000000";
				ram ( 12) <= "00101010"; -- slt $4,$2,$1
				ram ( 13) <= "00100000";
				ram ( 14) <= "01000001";
				ram ( 15) <= "00000000";
				ram ( 16) <= "00000101"; -- j B
				ram ( 17) <= "00000000";
				ram ( 18) <= "00000000";
				ram ( 19) <= "00001000";
				ram ( 20) <= "00000001"; -- bgezal $3,C
				ram ( 21) <= "00000000";
				ram ( 22) <= "01110001";
				ram ( 23) <= "00000100";
				ram ( 24) <= "00000000"; -- addi $5,$0,0
				ram ( 25) <= "00000000";
				ram ( 26) <= "00000101";
				ram ( 27) <= "00100000";
				ram ( 28) <= "11111111"; -- addi $7,$0,-1
				ram ( 29) <= "11111111";
				ram ( 30) <= "00000111";
				ram ( 31) <= "00100000";
				ram ( 32) <= "00000001"; -- bgezal $7,D
				ram ( 33) <= "00000000";
				ram ( 34) <= "11110001";
				ram ( 35) <= "00000100";
				ram ( 36) <= "00001011"; -- j Z
				ram ( 37) <= "00000000";
				ram ( 38) <= "00000000";
				ram ( 39) <= "00001000";
				ram ( 40) <= "00000001"; -- addi $6,$0,1
				ram ( 41) <= "00000000";
				ram ( 42) <= "00000110";
				ram ( 43) <= "00100000";
				ram ( 44) <= "00001011"; -- j Z
				ram ( 45) <= "00000000";
				ram ( 46) <= "00000000";
				ram ( 47) <= "00001000";
				for i in 48 to 255 loop
					ram (i) <= std_logic_vector (to_unsigned (0, 8));
				end loop;
			else
				if (memwrite = '1') then
					ram (selector2 + 0) <= writedata (7 downto 0);
					ram (selector2 + 1) <= writedata (15 downto 8);
					ram (selector2 + 2) <= writedata (23 downto 16);
					ram (selector2 + 3) <= writedata (31 downto 24);
				end if;
			end if;
		end if;
	end process;
	instruction <= ram (selector1 + 3) & ram (selector1 + 2) & ram (selector1 + 1) & ram (selector1 + 0);
	with memread select
		readdata <=	std_logic_vector (to_unsigned (0, 32)) when '0',
				ram (selector2 + 3) & ram (selector2 + 2) & ram (selector2 + 1) & ram (selector2 + 0) when others;
end behavior;
