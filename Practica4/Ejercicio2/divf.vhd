library ieee;
use ieee.std_logic_1164.all;

-- Definición de la entidad 'divf' que es un divisor de frecuencia
entity divf is
  generic (num : integer := 25000000);  -- Parámetro genérico 'num' para definir la frecuencia de salida (por defecto es 25 millones)
  port (
    clk  : in std_logic;                -- Entrada de reloj de alta frecuencia
    clkl : buffer std_logic := '0'      -- Salida de reloj reducido ('clkl') con frecuencia menor
  );
end entity;

-- Arquitectura que define el comportamiento del divisor de frecuencia
architecture arqdivf of divf is
  -- Señal interna para mantener el contador
  signal conteo : integer range 0 to num;  -- Contador que cuenta hasta el valor de 'num' (por defecto 25000000)
begin
  -- Proceso que se ejecuta con cada flanco ascendente del reloj (clk)
  process (clk)
  begin
    if (rising_edge(clk)) then    -- Detecta el flanco ascendente de la señal 'clk'
      if (conteo = num) then      -- Si el contador alcanza el valor 'num'
        conteo <= 0;              -- Reinicia el contador a 0
        clkl   <= not clkl;       -- Invierte el valor de 'clkl' (cambia entre 0 y 1)
      else
        conteo <= conteo + 1;     -- Si el contador no ha alcanzado 'num', se incrementa en 1
      end if;
    end if;
  end process;
end architecture;
