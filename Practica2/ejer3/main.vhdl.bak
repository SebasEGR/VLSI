library ieee;
use ieee.std_logic_1164.all;

entity main is
  port (
    clk, reset                   : in std_logic;
    hex0, hex1, hex2, hex3, hex4 : buffer std_logic_vector(6 downto 0)
  );
end entity;

architecture arqmain of main is
  signal clkl : std_logic;
  signal bcd  : std_logic_vector(3 downto 0) := "0000";
begin
  u1 : entity work.divfreq(rtl) port map(clk, clkl);
  u2 : entity work.conta(arqconta) port map(clkl, reset, bcd);
  u3 : entity work.ss7(arqss7) port map (bcd, hex0);
  u4 : entity work.display(arqdisp) port map(clkl, hex0, hex1);
  u5 : entity work.display(arqdisp) port map(clkl, hex1, hex2);
  u6 : entity work.display(arqdisp) port map(clkl, hex2, hex3);
  u7 : entity work.display(arqdisp) port map(clkl, hex3, hex4);
end architecture;