library ieee;
use ieee.std_logic_1164.all;

-- Definición de la entidad 'senal', que genera una señal PWM
entity senal is
  port (
    clk  : in std_logic;       -- Entrada de reloj (clk) para sincronizar las operaciones
    duty : in integer;         -- Entrada que representa el ciclo de trabajo (PWM), en un valor de 0 a 1000
    snl  : out std_logic       -- Salida que generará la señal PWM (snl)
  );
end entity;

-- Arquitectura que define el comportamiento de la señal PWM
architecture arqsenal of senal is
  -- Señal interna 'conteo' que se usa para contar desde 0 hasta 1000
  signal conteo : integer range 0 to 1000;
begin
  -- Proceso que se ejecuta en cada flanco ascendente de 'clk'
  process (clk)
  begin
    if (rising_edge(clk)) then   -- En cada flanco ascendente de 'clk', se evalúa el siguiente comportamiento
      -- Si 'conteo' es menor o igual a 'duty', la señal 'snl' será '1'
      if (conteo <= duty) then
        snl <= '1';              -- Se pone la señal PWM en '1'
      else
        snl <= '0';              -- Si 'conteo' es mayor que 'duty', se pone la señal PWM en '0'
      end if;
      
      -- Cuando 'conteo' llega a 1000, se reinicia a 0
      if (conteo = 1000) then
        conteo <= 0;             -- Reinicia el contador para comenzar un nuevo ciclo
      else
        conteo <= conteo + 1;    -- Incrementa el contador
      end if;
    end if;
  end process;
end architecture;
