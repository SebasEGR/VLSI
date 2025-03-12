library ieee;
use ieee.std_logic_1164.all;

entity senal is
  port (
    clk  : in std_logic;       -- Entrada de reloj (clk) para sincronizar las operaciones
    duty : in integer;         -- Entrada que representa el ciclo de trabajo (PWM), en un valor de 0 a 1000
    snl  : out std_logic       -- Salida que generará la señal PWM (snl)
  );
end entity;

architecture arqsenal of senal is
  signal conteo : integer range 0 to 4000;  -- Ajustado para contar hasta 4 segundos
begin
  process (clk)
  begin
    if (rising_edge(clk)) then
      -- Si 'conteo' es menor o igual a 1000, la señal será '1' (encendido)
      if (conteo <= 1000) then
        snl <= '1'; 
      else
        snl <= '0';  -- Si 'conteo' es mayor que 1000, la señal será '0' (apagado)
      end if;
      
      -- Cuando 'conteo' llegue a 4000 (equivalente a 4 segundos), se reinicia a 0
      if (conteo = 4000) then
        conteo <= 0;  -- Reinicia el contador
      else
        conteo <= conteo + 1;  -- Incrementa el contador
      end if;
    end if;
  end process;
end architecture;
