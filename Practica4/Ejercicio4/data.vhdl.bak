library ieee;
use ieee.std_logic_1164.all;

entity data is
  port (
    clk   : in std_logic;
    reset : in std_logic;
    ret   : out integer
  );
end entity data;

architecture arqdata of data is
  subtype state is integer;
  signal present_state, next_state : integer;
  -- Estados
  constant e0 : state := 900;
  constant e1 : state := 800;
  constant e2 : state := 700;
  constant e3 : state := 600;
  constant e4 : state := 500;
  constant e5 : state := 400;
  constant e6 : state := 300;
  constant e7 : state := 200;
  constant e8 : state := 100;
begin
  process (clk)
  begin
    if rising_edge(clk) then
      if reset = '0' then
        present_state <= e0;
      else
        present_state <= next_state;
      end if;
    end if;
  end process;

  process (present_state)
  begin
    case present_state is
      when e0     => next_state <= e1;
      when e1     => next_state <= e2;
      when e2     => next_state <= e3;
      when e3     => next_state <= e4;
      when e4     => next_state <= e5;
      when e5     => next_state <= e6;
      when e6     => next_state <= e7;
      when e7     => next_state <= e8;
      when e8     => next_state <= e0;
      when others =>
        next_state <= e0;
    end case;
    ret <= present_state;
  end process;
end architecture;