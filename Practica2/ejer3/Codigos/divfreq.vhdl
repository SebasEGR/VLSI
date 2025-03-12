library ieee;
use ieee.std_logic_1164.all;

entity divfreq is
  port
  (
    clk  : in std_logic;
    clkl : buffer std_logic
  );
end entity;

architecture rtl of divfreq is
  signal contador : integer range 0 to 25000000;

begin
  process (clk)
  begin
    if (rising_edge(clk)) then
        if (contador = 25000000) then
        contador <= 0;
        clkl     <= not clkl;
      else
        contador <= contador + 1;
      end if;
    end if;
  end process;
end architecture;