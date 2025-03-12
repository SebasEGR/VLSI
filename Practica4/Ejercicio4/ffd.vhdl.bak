library ieee;
use ieee.std_logic_1164.all;

entity ffd is
  port (
    clk : in std_logic;
    q   : out integer;
    d   : in integer
  );
end entity;

architecture archffd of ffd is
begin
  process (clk)
  begin
    if (rising_edge(clk)) then
      q <= d;
    end if;
  end process;
end architecture;