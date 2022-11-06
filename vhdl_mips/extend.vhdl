library IEEE;
use IEEE.std_logic_1164.all;

entity extend is
	port
	(
		aluop		: in  std_logic_vector (2 downto 0);
		instruction	: in  std_logic_vector (15 downto 0);
		value		: out std_logic_vector (31 downto 0)
	);
end extend;

architecture behavior of extend is
	signal extension : std_logic_vector (15 downto 0);
begin
	process (aluop, instruction, extension)
	begin
		for i in 0 to 15 loop
			extension (i) <= instruction (15);
		end loop;
		case aluop is
			when "010"		=>			-- and
					value <= "0000000000000000" & instruction;
			when "011"		=>			-- or
					value <= "0000000000000000" & instruction;
			when "100"		=>			-- xor
					value <= "0000000000000000" & instruction;
			when others =>
					value <= extension & instruction;
		end case;
	end process;
end behavior;


