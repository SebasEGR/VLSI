library ieee;
use ieee.std_logic_1164.all;

entity divf is
  generic (num : integer := 25000000);
  port (
    clk  : in std_logic;
    clkl : buffer std_logic := '0'
  );
end entity;

architecture arqdivf of divf is
  signal conteo : integer range 0 to num;
begin
  process (clk)
  begin
    if (rising_edge(clk)) then
      if (conteo = num) then
        conteo <= 0;
        clkl   <= not clkl;
      else
        conteo <= conteo + 1;
      end if;
    end if;
  end process;
end architecture;