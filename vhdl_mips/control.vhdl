library IEEE;
use IEEE.std_logic_1164.all;

entity control is
	port
	(
		instruction		: in  std_logic_vector (5 downto 0);
		funct			: in  std_logic_vector (5 downto 0);
		zerobranch		: in  std_logic_vector (4 downto 0);
		branch			: out std_logic_vector (1 downto 0);
		regdst			: out std_logic_vector (1 downto 0);
		memread			: out std_logic;
		memtoreg		: out std_logic_vector (1 downto 0);
		aluop			: out std_logic_vector (2 downto 0);
		memwrite		: out std_logic;
		alusrc			: out std_logic;
		regwrite		: out std_logic
	);
end control;

architecture behavior of control is
begin
	process (instruction, funct)
	begin
		case instruction is
			when "000000" =>		-- add, addu, and, nor, or, sll, srl, sub, subu, xor, jr, slt
				regdst <= "01";
				if (funct = "001000") then
					branch <= "10";
				else
					branch <= "00";
				end if;
				memread <= '0';
				memtoreg <= "00";
				aluop <= "000";
				memwrite <= '0';
				alusrc <= '0';
				regwrite <= '1';
			when "000001" =>		-- bgez, bltz, bgezal
				if (zerobranch = "10001" ) then
					regdst <= "10";
					regwrite <= '1';
					memtoreg <= "10";
				else
					regdst <= "00";
					regwrite <= '0';
					memtoreg <= "00";
				end if;
				branch <= "11";
				memread <= '0';
				memwrite <= '0';
				aluop <= "110";
				alusrc <= '0';
			when "000010" =>		-- j
				regdst <= "00";
				branch <= "01";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "000";
				memwrite <= '0';
				alusrc <= '0';
				regwrite <= '0';
			when "000100" =>		-- beq
				regdst <= "00";
				branch <= "11";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "111";
				memwrite <= '0';
				alusrc <= '0';
				regwrite <= '0';
			when "000101" =>		-- bne
				regdst <= "00";
				branch <= "11";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "111";
				memwrite <= '0';
				alusrc <= '0';
				regwrite <= '0';
			when "000110" =>		-- blez
				regdst <= "00";
				branch <= "11";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "111";
				memwrite <= '0';
				alusrc <= '0';
				regwrite <= '0';
			when "000111" =>		-- bgtz
				regdst <= "00";
				branch <= "11";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "111";
				memwrite <= '0';
				alusrc <= '0';
				regwrite <= '0';
			when "001000" =>		-- addi
				regdst <= "00";
				branch <= "00";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "001";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1';
			when "001001" =>		-- addiu
				regdst <= "00";
				branch <= "00";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "001";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1';
			when "001100" =>		-- andi
				regdst <= "00";
				branch <= "00";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "010";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1';
			when "001101" =>		-- ori
				regdst <= "00";
				branch <= "00";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "011";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1';
			when "001110" =>		-- xori
				regdst <= "00";
				branch <= "00";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "100";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1';
			when "001111" =>		-- lui
				regdst <= "00";
				branch <= "00";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "101";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1';
			when "100011" =>		-- lw
				regdst <= "00";
				branch <= "00";
				memread <= '1';
				memtoreg <= "01";
				aluop <= "001";
				memwrite <= '0';
				alusrc <= '1';
				regwrite <= '1';
			when "101011" =>		-- sw
				regdst <= "00";
				branch <= "00";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "001";
				memwrite <= '1';
				alusrc <= '1';
				regwrite <= '0';
			when others =>
				regdst <= "00";
				branch <= "00";
				memread <= '0';
				memtoreg <= "00";
				aluop <= "000";
				memwrite <= '0';
				alusrc <= '0';
				regwrite <= '0';
		end case;
	end process;
end behavior;




