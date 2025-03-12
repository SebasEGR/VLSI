library ieee;
use ieee.std_logic_1164.all;

entity contador is
port(clk: in std_logic;
	  ssg: out std_logic_vector(6 downto 0);
	  bandera:out std_logic);
end entity;

architecture arqcontador of contador is
signal clkl: std_logic;
signal a: integer range 0 to 9;
begin
	u1: entity work.divf(arqdivf) port map(clk, clkl);
	u2: entity work.cont(arqcont) port map(clkl, a, bandera);
	u3: entity work.ss7(arqss7) port map(a, ssg);
end architecture;