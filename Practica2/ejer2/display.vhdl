library ieee;
use ieee.std_logic_1164.all;

entity display is
  port (
    clk : in std_logic;
    mi  : in std_logic_vector(6 downto 0);
    mo  : out std_logic_vector(6 downto 0)
  );
end entity;

architecture arqdisp of display is
begin
  process (clk)
  begin
    if rising_edge(clk) then
      mo <= mi;
    end if;
  end process;
end architecture;