library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
	port
	(
		data1		: in  std_logic_vector (31 downto 0);
		data2		: in  std_logic_vector (31 downto 0);
		shamt		: in  std_logic_vector ( 4 downto 0);
		aluinstr	: in  std_logic_vector ( 4 downto 0);
		result		: out std_logic_vector (31 downto 0);
		branch		: out std_logic
	);
end alu;

architecture behavior of alu is
begin
	process (aluinstr, data1, data2, shamt)
	begin
		case aluinstr is
			when "00001" =>		-- lui
				result <= data2 (15 downto 0) & "0000000000000000";
				branch <= '0';
			when "00010" =>		-- add
				result <= std_logic_vector (signed (data1) + signed (data2));
				branch <= '0';
			when "00011" =>		-- sub
				result <= std_logic_vector (signed (data1) - signed (data2));
				branch <= '0';
			when "00100" =>		-- and
				result <= data1 and data2;
				branch <= '0';
			when "00101" =>		-- or
				result <= data1 or data2;
				branch <= '0';
			when "00110" =>		-- nor
				result <= data1 nor data2;
				branch <= '0';
			when "00111" =>		-- xor
				result <= data1 xor data2;
				branch <= '0';
			when "01000" =>		-- sll
				result <= std_logic_vector (shift_left (unsigned (data2), to_integer (unsigned (shamt))));
				branch <= '0';
			when "01001" =>		-- srl
				result <= std_logic_vector (shift_right (unsigned (data2), to_integer (unsigned (shamt))));
				branch <= '0';
			when "01010" =>		-- bltz
				result <= "00000000000000000000000000000000";
				if (signed (data1) < to_signed (0, 32)) then
					branch <= '1';
				else
					branch <= '0';
				end if;
			when "01011" =>		-- bgez, bgezal (assignment 3)
				result <= "00000000000000000000000000000000";
				if (signed (data1) >= to_signed (0, 32)) then
					branch <= '1';
				else
					branch <= '0';
				end if;
			when "01100" =>  -- beq
				result <= "00000000000000000000000000000000";
				if (data1 = data2) then
					branch <= '1';
				else
					branch <= '0';
				end if;
			when "01101" =>  -- bne
				result <= "00000000000000000000000000000000";
				if (data1 /= data2) then
					branch <= '1';
				else
					branch <= '0';
				end if;
			when "01110" =>		-- blez
				result <= "00000000000000000000000000000000";
				if (signed (data1) <= to_signed (0, 32)) then
					branch <= '1';
				else
					branch <= '0';
				end if;
			when "01111" =>		-- bgtz
				result <= "00000000000000000000000000000000";
				if (signed (data1) > to_signed (0, 32)) then
					branch <= '1';
				else
					branch <= '0';
				end if;
			when "10000" => 	-- slt (assignment 3)
				if (signed (data1) < signed(data2)) then
					result <= "00000000000000000000000000000001";
				else
					result <= "00000000000000000000000000000000";
				end if;
			when others =>
				result <= "00000000000000000000000000000000";
				branch <= '1';
		end case;
	end process;
end behavior;



